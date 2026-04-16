// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TranslatedFieldImpl _$$TranslatedFieldImplFromJson(
  Map<String, dynamic> json,
) => _$TranslatedFieldImpl(
  it: json['it'] as String? ?? '',
  en: json['en'] as String? ?? '',
  es: json['es'] as String? ?? '',
);

Map<String, dynamic> _$$TranslatedFieldImplToJson(
  _$TranslatedFieldImpl instance,
) => <String, dynamic>{'it': instance.it, 'en': instance.en, 'es': instance.es};

_$CVSectionImpl _$$CVSectionImplFromJson(Map<String, dynamic> json) =>
    _$CVSectionImpl(
      id: $enumDecode(_$SectionTypeEnumMap, json['id']),
      enabled: json['enabled'] as bool? ?? true,
      isModern: json['isModern'] as bool? ?? false,
    );

Map<String, dynamic> _$$CVSectionImplToJson(_$CVSectionImpl instance) =>
    <String, dynamic>{
      'id': _$SectionTypeEnumMap[instance.id]!,
      'enabled': instance.enabled,
      'isModern': instance.isModern,
    };

const _$SectionTypeEnumMap = {
  SectionType.personalInfo: 'personalInfo',
  SectionType.profile: 'profile',
  SectionType.experience: 'experience',
  SectionType.education: 'education',
  SectionType.skills: 'skills',
  SectionType.languages: 'languages',
  SectionType.projects: 'projects',
  SectionType.certifications: 'certifications',
  SectionType.volunteer: 'volunteer',
  SectionType.interests: 'interests',
};

_$PersonalInfoImpl _$$PersonalInfoImplFromJson(Map<String, dynamic> json) =>
    _$PersonalInfoImpl(
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      address: json['address'] as String? ?? '',
      birthDate: json['birthDate'] as String? ?? '',
      nationality: json['nationality'] as String? ?? '',
      photoBase64: json['photoBase64'] as String?,
      linkedin: json['linkedin'] as String? ?? '',
      website: json['website'] as String? ?? '',
    );

Map<String, dynamic> _$$PersonalInfoImplToJson(_$PersonalInfoImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'birthDate': instance.birthDate,
      'nationality': instance.nationality,
      'photoBase64': instance.photoBase64,
      'linkedin': instance.linkedin,
      'website': instance.website,
    };

_$ExperienceImpl _$$ExperienceImplFromJson(Map<String, dynamic> json) =>
    _$ExperienceImpl(
      id: json['id'] as String,
      jobTitle: json['jobTitle'] as String? ?? '',
      company: json['company'] as String? ?? '',
      location: json['location'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      current: json['current'] as bool? ?? false,
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$ExperienceImplToJson(_$ExperienceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobTitle': instance.jobTitle,
      'company': instance.company,
      'location': instance.location,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'current': instance.current,
      'description': instance.description,
    };

_$EducationImpl _$$EducationImplFromJson(Map<String, dynamic> json) =>
    _$EducationImpl(
      id: json['id'] as String,
      degree: json['degree'] as String? ?? '',
      institution: json['institution'] as String? ?? '',
      location: json['location'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$EducationImplToJson(_$EducationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'degree': instance.degree,
      'institution': instance.institution,
      'location': instance.location,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'description': instance.description,
    };

_$SkillImpl _$$SkillImplFromJson(Map<String, dynamic> json) => _$SkillImpl(
  id: json['id'] as String,
  name: json['name'] as String? ?? '',
  level: (json['level'] as num?)?.toInt() ?? 3,
);

Map<String, dynamic> _$$SkillImplToJson(_$SkillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'level': instance.level,
    };

_$LanguageSkillImpl _$$LanguageSkillImplFromJson(Map<String, dynamic> json) =>
    _$LanguageSkillImpl(
      id: json['id'] as String,
      language: json['language'] as String? ?? '',
      level: json['level'] as String? ?? 'B2',
    );

Map<String, dynamic> _$$LanguageSkillImplToJson(_$LanguageSkillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'language': instance.language,
      'level': instance.level,
    };

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
    };

_$CertificationImpl _$$CertificationImplFromJson(Map<String, dynamic> json) =>
    _$CertificationImpl(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      issuer: json['issuer'] as String? ?? '',
      date: json['date'] as String? ?? '',
    );

Map<String, dynamic> _$$CertificationImplToJson(_$CertificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'issuer': instance.issuer,
      'date': instance.date,
    };

_$VolunteerImpl _$$VolunteerImplFromJson(Map<String, dynamic> json) =>
    _$VolunteerImpl(
      id: json['id'] as String,
      role: json['role'] as String? ?? '',
      organization: json['organization'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$VolunteerImplToJson(_$VolunteerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'organization': instance.organization,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'description': instance.description,
    };

_$CVDataImpl _$$CVDataImplFromJson(Map<String, dynamic> json) => _$CVDataImpl(
  personalInfo: PersonalInfo.fromJson(
    json['personalInfo'] as Map<String, dynamic>,
  ),
  profile: json['profile'] as String? ?? '',
  experiences:
      (json['experiences'] as List<dynamic>?)
          ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  education:
      (json['education'] as List<dynamic>?)
          ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  skills:
      (json['skills'] as List<dynamic>?)
          ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  languages:
      (json['languages'] as List<dynamic>?)
          ?.map((e) => LanguageSkill.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  projects:
      (json['projects'] as List<dynamic>?)
          ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  certifications:
      (json['certifications'] as List<dynamic>?)
          ?.map((e) => Certification.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  volunteer:
      (json['volunteer'] as List<dynamic>?)
          ?.map((e) => Volunteer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  interests: json['interests'] as String? ?? '',
  sections: (json['sections'] as List<dynamic>)
      .map((e) => CVSection.fromJson(e as Map<String, dynamic>))
      .toList(),
  template:
      $enumDecodeNullable(_$TemplateNameEnumMap, json['template']) ??
      TemplateName.european,
  modernMode: json['modernMode'] as bool? ?? false,
  currentLanguage:
      $enumDecodeNullable(_$LanguageEnumMap, json['currentLanguage']) ??
      Language.it,
  translations:
      (json['translations'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, TranslatedField.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
);

Map<String, dynamic> _$$CVDataImplToJson(_$CVDataImpl instance) =>
    <String, dynamic>{
      'personalInfo': instance.personalInfo,
      'profile': instance.profile,
      'experiences': instance.experiences,
      'education': instance.education,
      'skills': instance.skills,
      'languages': instance.languages,
      'projects': instance.projects,
      'certifications': instance.certifications,
      'volunteer': instance.volunteer,
      'interests': instance.interests,
      'sections': instance.sections,
      'template': _$TemplateNameEnumMap[instance.template]!,
      'modernMode': instance.modernMode,
      'currentLanguage': _$LanguageEnumMap[instance.currentLanguage]!,
      'translations': instance.translations,
    };

const _$TemplateNameEnumMap = {
  TemplateName.european: 'european',
  TemplateName.modern: 'modern',
  TemplateName.classic: 'classic',
  TemplateName.minimal: 'minimal',
  TemplateName.sidebar: 'sidebar',
  TemplateName.executive: 'executive',
};

const _$LanguageEnumMap = {
  Language.it: 'it',
  Language.en: 'en',
  Language.es: 'es',
};
