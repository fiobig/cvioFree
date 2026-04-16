import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cv_data.dart';
import '../services/persistence_service.dart';

class CVNotifier extends StateNotifier<CVData> {
  CVNotifier(this._persistence) : super(kEmptyCV()) {
    _load();
  }

  final PersistenceService _persistence;

  Future<void> _load() async {
    final saved = await _persistence.load();
    if (saved != null) {
      state = _migrate(saved);
    }
  }

  /// Handles any data migrations (e.g. missing sections added in future versions)
  CVData _migrate(CVData data) {
    // Ensure all default sections exist (add new ones at the end if missing)
    final existingIds = data.sections.map((s) => s.id).toSet();
    final missingSections = kDefaultSections
        .where((s) => !existingIds.contains(s.id))
        .toList();
    if (missingSections.isEmpty) return data;
    return data.copyWith(
      sections: [...data.sections, ...missingSections],
    );
  }

  Future<void> _persist() => _persistence.save(state);

  // ─── Personal Info ─────────────────────────────────────────────────────────

  void updateFirstName(String v) {
    state = state.copyWith(personalInfo: state.personalInfo.copyWith(firstName: v));
    _persist();
  }

  void updateLastName(String v) {
    state = state.copyWith(personalInfo: state.personalInfo.copyWith(lastName: v));
    _persist();
  }

  void updateEmail(String v) {
    state = state.copyWith(personalInfo: state.personalInfo.copyWith(email: v));
    _persist();
  }

  void updatePhone(String v) {
    state = state.copyWith(personalInfo: state.personalInfo.copyWith(phone: v));
    _persist();
  }

  void updateAddress(String v) {
    state = state.copyWith(personalInfo: state.personalInfo.copyWith(address: v));
    _persist();
  }

  void updateBirthDate(String v) {
    state = state.copyWith(personalInfo: state.personalInfo.copyWith(birthDate: v));
    _persist();
  }

  void updateNationality(String v) {
    state = state.copyWith(personalInfo: state.personalInfo.copyWith(nationality: v));
    _persist();
  }

  void updatePhoto(String? base64) {
    state = state.copyWith(personalInfo: state.personalInfo.copyWith(photoBase64: base64));
    _persist();
  }

  void updateLinkedin(String v) {
    state = state.copyWith(personalInfo: state.personalInfo.copyWith(linkedin: v));
    _persist();
  }

  void updateWebsite(String v) {
    state = state.copyWith(personalInfo: state.personalInfo.copyWith(website: v));
    _persist();
  }

  // ─── Top-level fields ──────────────────────────────────────────────────────

  void updateProfile(String v) {
    state = state.copyWith(profile: v);
    _persist();
  }

  void updateInterests(String v) {
    state = state.copyWith(interests: v);
    _persist();
  }

  // ─── Lists ────────────────────────────────────────────────────────────────

  void updateExperiences(List<Experience> v) {
    state = state.copyWith(experiences: v);
    _persist();
  }

  void updateEducation(List<Education> v) {
    state = state.copyWith(education: v);
    _persist();
  }

  void updateSkills(List<Skill> v) {
    state = state.copyWith(skills: v);
    _persist();
  }

  void updateLanguages(List<LanguageSkill> v) {
    state = state.copyWith(languages: v);
    _persist();
  }

  void updateProjects(List<Project> v) {
    state = state.copyWith(projects: v);
    _persist();
  }

  void updateCertifications(List<Certification> v) {
    state = state.copyWith(certifications: v);
    _persist();
  }

  void updateVolunteer(List<Volunteer> v) {
    state = state.copyWith(volunteer: v);
    _persist();
  }

  // ─── Settings ─────────────────────────────────────────────────────────────

  void setTemplate(TemplateName template) {
    state = state.copyWith(template: template);
    _persist();
  }

  void setLanguage(Language lang) {
    state = state.copyWith(currentLanguage: lang);
    _persist();
  }

  void setModernMode(bool enabled) {
    state = state.copyWith(modernMode: enabled);
    _persist();
  }

  void reorderSections(List<CVSection> sections) {
    state = state.copyWith(sections: sections);
    _persist();
  }

  void toggleSection(SectionType id) {
    final updated = state.sections
        .map((s) => s.id == id ? s.copyWith(enabled: !s.enabled) : s)
        .toList();
    state = state.copyWith(sections: updated);
    _persist();
  }

  // ─── Translations ─────────────────────────────────────────────────────────

  void updateTranslation(String fieldPath, Language lang, String value) {
    final existing = state.translations[fieldPath] ?? const TranslatedField();
    final updated = Map<String, TranslatedField>.from(state.translations);
    updated[fieldPath] = existing.withLanguage(lang, value);
    state = state.copyWith(translations: updated);
    _persist();
  }

  void setTranslations(Map<String, TranslatedField> translations) {
    state = state.copyWith(translations: translations);
    _persist();
  }

  // ─── Reset ────────────────────────────────────────────────────────────────

  Future<void> clearData() async {
    await _persistence.clear();
    state = kEmptyCV();
  }
}
