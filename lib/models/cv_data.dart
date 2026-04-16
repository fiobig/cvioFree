import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cv_data.freezed.dart';
part 'cv_data.g.dart';

// ─── Enums ───────────────────────────────────────────────────────────────────

enum Language { it, en, es }

extension LanguageExtension on Language {
  String get flag {
    switch (this) {
      case Language.it:
        return '🇮🇹';
      case Language.en:
        return '🇬🇧';
      case Language.es:
        return '🇪🇸';
    }
  }

  String get label {
    switch (this) {
      case Language.it:
        return 'Italiano';
      case Language.en:
        return 'English';
      case Language.es:
        return 'Español';
    }
  }

  String get code {
    switch (this) {
      case Language.it:
        return 'it';
      case Language.en:
        return 'en';
      case Language.es:
        return 'es';
    }
  }
}

enum TemplateName { european, modern, classic, minimal, sidebar, executive }

extension TemplateNamePro on TemplateName {
  bool get isPremium =>
      this == TemplateName.minimal ||
      this == TemplateName.sidebar ||
      this == TemplateName.executive;
}

enum SectionType {
  personalInfo,
  profile,
  experience,
  education,
  skills,
  languages,
  projects,
  certifications,
  volunteer,
  interests,
}

// ─── TranslatedField ─────────────────────────────────────────────────────────

@freezed
class TranslatedField with _$TranslatedField {
  const factory TranslatedField({
    @Default('') String it,
    @Default('') String en,
    @Default('') String es,
  }) = _TranslatedField;

  factory TranslatedField.fromJson(Map<String, dynamic> json) =>
      _$TranslatedFieldFromJson(json);
}

extension TranslatedFieldExtension on TranslatedField {
  String forLanguage(Language lang) {
    switch (lang) {
      case Language.it:
        return it;
      case Language.en:
        return en;
      case Language.es:
        return es;
    }
  }

  TranslatedField withLanguage(Language lang, String value) {
    switch (lang) {
      case Language.it:
        return copyWith(it: value);
      case Language.en:
        return copyWith(en: value);
      case Language.es:
        return copyWith(es: value);
    }
  }
}

// ─── CVSection ───────────────────────────────────────────────────────────────

@freezed
class CVSection with _$CVSection {
  const factory CVSection({
    required SectionType id,
    @Default(true) bool enabled,
    @Default(false) bool isModern,
  }) = _CVSection;

  factory CVSection.fromJson(Map<String, dynamic> json) =>
      _$CVSectionFromJson(json);
}

// ─── PersonalInfo ─────────────────────────────────────────────────────────────

// Photo is stored as base64 string for JSON serialisation
// Use PersonalInfo.photoBytes getter for rendering
@freezed
class PersonalInfo with _$PersonalInfo {
  const PersonalInfo._();

  const factory PersonalInfo({
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String address,
    @Default('') String birthDate,
    @Default('') String nationality,
    String? photoBase64, // base64 encoded, null if no photo
    @Default('') String linkedin,
    @Default('') String website,
  }) = _PersonalInfo;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoFromJson(json);

  Uint8List? get photoBytes {
    if (photoBase64 == null || photoBase64!.isEmpty) return null;
    try {
      // Handle data URI prefix if present
      final data = photoBase64!.contains(',')
          ? photoBase64!.split(',').last
          : photoBase64!;
      return Uri.parse('data:image/jpeg;base64,$data').data?.contentAsBytes();
    } catch (_) {
      return null;
    }
  }
}

// ─── Experience ──────────────────────────────────────────────────────────────

@freezed
class Experience with _$Experience {
  const factory Experience({
    required String id,
    @Default('') String jobTitle,
    @Default('') String company,
    @Default('') String location,
    @Default('') String startDate,
    @Default('') String endDate,
    @Default(false) bool current,
    @Default('') String description,
  }) = _Experience;

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
}

// ─── Education ───────────────────────────────────────────────────────────────

@freezed
class Education with _$Education {
  const factory Education({
    required String id,
    @Default('') String degree,
    @Default('') String institution,
    @Default('') String location,
    @Default('') String startDate,
    @Default('') String endDate,
    @Default('') String description,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}

// ─── Skill ───────────────────────────────────────────────────────────────────

@freezed
class Skill with _$Skill {
  const factory Skill({
    required String id,
    @Default('') String name,
    @Default(3) int level, // 1-5
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}

// ─── LanguageSkill ───────────────────────────────────────────────────────────

@freezed
class LanguageSkill with _$LanguageSkill {
  const factory LanguageSkill({
    required String id,
    @Default('') String language,
    @Default('B2') String level, // CEFR: A1-C2
  }) = _LanguageSkill;

  factory LanguageSkill.fromJson(Map<String, dynamic> json) =>
      _$LanguageSkillFromJson(json);
}

// ─── Project ─────────────────────────────────────────────────────────────────

@freezed
class Project with _$Project {
  const factory Project({
    required String id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String url,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

// ─── Certification ───────────────────────────────────────────────────────────

@freezed
class Certification with _$Certification {
  const factory Certification({
    required String id,
    @Default('') String name,
    @Default('') String issuer,
    @Default('') String date,
  }) = _Certification;

  factory Certification.fromJson(Map<String, dynamic> json) =>
      _$CertificationFromJson(json);
}

// ─── Volunteer ───────────────────────────────────────────────────────────────

@freezed
class Volunteer with _$Volunteer {
  const factory Volunteer({
    required String id,
    @Default('') String role,
    @Default('') String organization,
    @Default('') String startDate,
    @Default('') String endDate,
    @Default('') String description,
  }) = _Volunteer;

  factory Volunteer.fromJson(Map<String, dynamic> json) =>
      _$VolunteerFromJson(json);
}

// ─── CVData ──────────────────────────────────────────────────────────────────

@freezed
class CVData with _$CVData {
  const factory CVData({
    required PersonalInfo personalInfo,
    @Default('') String profile,
    @Default([]) List<Experience> experiences,
    @Default([]) List<Education> education,
    @Default([]) List<Skill> skills,
    @Default([]) List<LanguageSkill> languages,
    @Default([]) List<Project> projects,
    @Default([]) List<Certification> certifications,
    @Default([]) List<Volunteer> volunteer,
    @Default('') String interests,
    required List<CVSection> sections,
    @Default(TemplateName.european) TemplateName template,
    @Default(false) bool modernMode,
    @Default(Language.it) Language currentLanguage,
    @Default({}) Map<String, TranslatedField> translations,
  }) = _CVData;

  factory CVData.fromJson(Map<String, dynamic> json) => _$CVDataFromJson(json);
}

// ─── Default data ─────────────────────────────────────────────────────────────

const List<CVSection> kDefaultSections = [
  CVSection(id: SectionType.personalInfo, enabled: true, isModern: false),
  CVSection(id: SectionType.profile, enabled: true, isModern: false),
  CVSection(id: SectionType.experience, enabled: true, isModern: false),
  CVSection(id: SectionType.education, enabled: true, isModern: false),
  CVSection(id: SectionType.skills, enabled: true, isModern: false),
  CVSection(id: SectionType.languages, enabled: true, isModern: false),
  CVSection(id: SectionType.projects, enabled: true, isModern: true),
  CVSection(id: SectionType.certifications, enabled: true, isModern: true),
  CVSection(id: SectionType.volunteer, enabled: true, isModern: true),
  CVSection(id: SectionType.interests, enabled: true, isModern: true),
];

CVData kEmptyCV() => CVData(
      personalInfo: const PersonalInfo(),
      sections: List.from(kDefaultSections),
    );

// ─── Helper ──────────────────────────────────────────────────────────────────

String getTranslated(
  Map<String, TranslatedField> translations,
  String path,
  Language lang,
  String fallback,
) {
  final field = translations[path];
  if (field == null) return fallback;
  final value = field.forLanguage(lang);
  return value.isNotEmpty ? value : fallback;
}
