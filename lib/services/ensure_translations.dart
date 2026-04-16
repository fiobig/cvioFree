import '../models/cv_data.dart';
import 'translation_service.dart';

/// Ensures all translatable CV fields have translations for all 3 languages.
/// Returns a new CVData with the translations map fully populated.
/// Does NOT mutate the live store — caller updates the store after this returns.
Future<CVData> ensureAllTranslations(
  CVData cvData,
  TranslationService service,
) async {
  final lang = cvData.currentLanguage;
  final updates = <String, TranslatedField>{};

  // Helper: collect a field for translation
  Future<void> ensureField(String path, String value) async {
    if (value.trim().isEmpty) return;

    final existing = cvData.translations[path];

    // Save current language value
    final current = updates[path] ?? existing ?? const TranslatedField();
    updates[path] = current.withLanguage(lang, value);

    // Translate to the other two languages
    for (final targetLang in Language.values) {
      if (targetLang == lang) continue;

      final existingTranslation = existing?.forLanguage(targetLang) ?? '';
      final needsTranslation = existingTranslation.isEmpty ||
          existingTranslation == value; // identical = failed translation

      if (needsTranslation) {
        final translated = await service.translateText(value, lang, targetLang);
        final prev = updates[path] ?? existing ?? const TranslatedField();
        updates[path] = prev.withLanguage(targetLang, translated);
      } else {
        final prev = updates[path] ?? existing ?? const TranslatedField();
        if (prev.forLanguage(targetLang).isEmpty) {
          updates[path] = prev.withLanguage(targetLang, existingTranslation);
        }
      }
    }
  }

  // Profile
  await ensureField('profile', cvData.profile);

  // Interests
  await ensureField('interests', cvData.interests);

  // Experiences
  for (final exp in cvData.experiences) {
    await ensureField('exp.${exp.id}.jobTitle', exp.jobTitle);
    await ensureField('exp.${exp.id}.company', exp.company);
    await ensureField('exp.${exp.id}.location', exp.location);
    await ensureField('exp.${exp.id}.description', exp.description);
  }

  // Education
  for (final edu in cvData.education) {
    await ensureField('edu.${edu.id}.degree', edu.degree);
    await ensureField('edu.${edu.id}.institution', edu.institution);
    await ensureField('edu.${edu.id}.location', edu.location);
    await ensureField('edu.${edu.id}.description', edu.description);
  }

  // Skills
  for (final skill in cvData.skills) {
    await ensureField('skill.${skill.id}.name', skill.name);
  }

  // Projects
  for (final proj in cvData.projects) {
    await ensureField('proj.${proj.id}.name', proj.name);
    await ensureField('proj.${proj.id}.description', proj.description);
  }

  // Certifications
  for (final cert in cvData.certifications) {
    await ensureField('cert.${cert.id}.name', cert.name);
    await ensureField('cert.${cert.id}.issuer', cert.issuer);
  }

  // Volunteer
  for (final vol in cvData.volunteer) {
    await ensureField('vol.${vol.id}.role', vol.role);
    await ensureField('vol.${vol.id}.organization', vol.organization);
    await ensureField('vol.${vol.id}.description', vol.description);
  }

  // Merge updates into existing translations
  final merged = Map<String, TranslatedField>.from(cvData.translations);
  merged.addAll(updates);

  return cvData.copyWith(translations: merged);
}
