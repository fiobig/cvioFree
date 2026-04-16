// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cv_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TranslatedField _$TranslatedFieldFromJson(Map<String, dynamic> json) {
  return _TranslatedField.fromJson(json);
}

/// @nodoc
mixin _$TranslatedField {
  String get it => throw _privateConstructorUsedError;
  String get en => throw _privateConstructorUsedError;
  String get es => throw _privateConstructorUsedError;

  /// Serializes this TranslatedField to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TranslatedField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TranslatedFieldCopyWith<TranslatedField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslatedFieldCopyWith<$Res> {
  factory $TranslatedFieldCopyWith(
    TranslatedField value,
    $Res Function(TranslatedField) then,
  ) = _$TranslatedFieldCopyWithImpl<$Res, TranslatedField>;
  @useResult
  $Res call({String it, String en, String es});
}

/// @nodoc
class _$TranslatedFieldCopyWithImpl<$Res, $Val extends TranslatedField>
    implements $TranslatedFieldCopyWith<$Res> {
  _$TranslatedFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslatedField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? it = null, Object? en = null, Object? es = null}) {
    return _then(
      _value.copyWith(
            it: null == it
                ? _value.it
                : it // ignore: cast_nullable_to_non_nullable
                      as String,
            en: null == en
                ? _value.en
                : en // ignore: cast_nullable_to_non_nullable
                      as String,
            es: null == es
                ? _value.es
                : es // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TranslatedFieldImplCopyWith<$Res>
    implements $TranslatedFieldCopyWith<$Res> {
  factory _$$TranslatedFieldImplCopyWith(
    _$TranslatedFieldImpl value,
    $Res Function(_$TranslatedFieldImpl) then,
  ) = __$$TranslatedFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String it, String en, String es});
}

/// @nodoc
class __$$TranslatedFieldImplCopyWithImpl<$Res>
    extends _$TranslatedFieldCopyWithImpl<$Res, _$TranslatedFieldImpl>
    implements _$$TranslatedFieldImplCopyWith<$Res> {
  __$$TranslatedFieldImplCopyWithImpl(
    _$TranslatedFieldImpl _value,
    $Res Function(_$TranslatedFieldImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TranslatedField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? it = null, Object? en = null, Object? es = null}) {
    return _then(
      _$TranslatedFieldImpl(
        it: null == it
            ? _value.it
            : it // ignore: cast_nullable_to_non_nullable
                  as String,
        en: null == en
            ? _value.en
            : en // ignore: cast_nullable_to_non_nullable
                  as String,
        es: null == es
            ? _value.es
            : es // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TranslatedFieldImpl implements _TranslatedField {
  const _$TranslatedFieldImpl({this.it = '', this.en = '', this.es = ''});

  factory _$TranslatedFieldImpl.fromJson(Map<String, dynamic> json) =>
      _$$TranslatedFieldImplFromJson(json);

  @override
  @JsonKey()
  final String it;
  @override
  @JsonKey()
  final String en;
  @override
  @JsonKey()
  final String es;

  @override
  String toString() {
    return 'TranslatedField(it: $it, en: $en, es: $es)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslatedFieldImpl &&
            (identical(other.it, it) || other.it == it) &&
            (identical(other.en, en) || other.en == en) &&
            (identical(other.es, es) || other.es == es));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, it, en, es);

  /// Create a copy of TranslatedField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslatedFieldImplCopyWith<_$TranslatedFieldImpl> get copyWith =>
      __$$TranslatedFieldImplCopyWithImpl<_$TranslatedFieldImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TranslatedFieldImplToJson(this);
  }
}

abstract class _TranslatedField implements TranslatedField {
  const factory _TranslatedField({
    final String it,
    final String en,
    final String es,
  }) = _$TranslatedFieldImpl;

  factory _TranslatedField.fromJson(Map<String, dynamic> json) =
      _$TranslatedFieldImpl.fromJson;

  @override
  String get it;
  @override
  String get en;
  @override
  String get es;

  /// Create a copy of TranslatedField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranslatedFieldImplCopyWith<_$TranslatedFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CVSection _$CVSectionFromJson(Map<String, dynamic> json) {
  return _CVSection.fromJson(json);
}

/// @nodoc
mixin _$CVSection {
  SectionType get id => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  bool get isModern => throw _privateConstructorUsedError;

  /// Serializes this CVSection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CVSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CVSectionCopyWith<CVSection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CVSectionCopyWith<$Res> {
  factory $CVSectionCopyWith(CVSection value, $Res Function(CVSection) then) =
      _$CVSectionCopyWithImpl<$Res, CVSection>;
  @useResult
  $Res call({SectionType id, bool enabled, bool isModern});
}

/// @nodoc
class _$CVSectionCopyWithImpl<$Res, $Val extends CVSection>
    implements $CVSectionCopyWith<$Res> {
  _$CVSectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CVSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? enabled = null,
    Object? isModern = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as SectionType,
            enabled: null == enabled
                ? _value.enabled
                : enabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isModern: null == isModern
                ? _value.isModern
                : isModern // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CVSectionImplCopyWith<$Res>
    implements $CVSectionCopyWith<$Res> {
  factory _$$CVSectionImplCopyWith(
    _$CVSectionImpl value,
    $Res Function(_$CVSectionImpl) then,
  ) = __$$CVSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SectionType id, bool enabled, bool isModern});
}

/// @nodoc
class __$$CVSectionImplCopyWithImpl<$Res>
    extends _$CVSectionCopyWithImpl<$Res, _$CVSectionImpl>
    implements _$$CVSectionImplCopyWith<$Res> {
  __$$CVSectionImplCopyWithImpl(
    _$CVSectionImpl _value,
    $Res Function(_$CVSectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CVSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? enabled = null,
    Object? isModern = null,
  }) {
    return _then(
      _$CVSectionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as SectionType,
        enabled: null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isModern: null == isModern
            ? _value.isModern
            : isModern // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CVSectionImpl implements _CVSection {
  const _$CVSectionImpl({
    required this.id,
    this.enabled = true,
    this.isModern = false,
  });

  factory _$CVSectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CVSectionImplFromJson(json);

  @override
  final SectionType id;
  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final bool isModern;

  @override
  String toString() {
    return 'CVSection(id: $id, enabled: $enabled, isModern: $isModern)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CVSectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.isModern, isModern) ||
                other.isModern == isModern));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, enabled, isModern);

  /// Create a copy of CVSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CVSectionImplCopyWith<_$CVSectionImpl> get copyWith =>
      __$$CVSectionImplCopyWithImpl<_$CVSectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CVSectionImplToJson(this);
  }
}

abstract class _CVSection implements CVSection {
  const factory _CVSection({
    required final SectionType id,
    final bool enabled,
    final bool isModern,
  }) = _$CVSectionImpl;

  factory _CVSection.fromJson(Map<String, dynamic> json) =
      _$CVSectionImpl.fromJson;

  @override
  SectionType get id;
  @override
  bool get enabled;
  @override
  bool get isModern;

  /// Create a copy of CVSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CVSectionImplCopyWith<_$CVSectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PersonalInfo _$PersonalInfoFromJson(Map<String, dynamic> json) {
  return _PersonalInfo.fromJson(json);
}

/// @nodoc
mixin _$PersonalInfo {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get birthDate => throw _privateConstructorUsedError;
  String get nationality => throw _privateConstructorUsedError;
  String? get photoBase64 =>
      throw _privateConstructorUsedError; // base64 encoded, null if no photo
  String get linkedin => throw _privateConstructorUsedError;
  String get website => throw _privateConstructorUsedError;

  /// Serializes this PersonalInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonalInfoCopyWith<PersonalInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalInfoCopyWith<$Res> {
  factory $PersonalInfoCopyWith(
    PersonalInfo value,
    $Res Function(PersonalInfo) then,
  ) = _$PersonalInfoCopyWithImpl<$Res, PersonalInfo>;
  @useResult
  $Res call({
    String firstName,
    String lastName,
    String email,
    String phone,
    String address,
    String birthDate,
    String nationality,
    String? photoBase64,
    String linkedin,
    String website,
  });
}

/// @nodoc
class _$PersonalInfoCopyWithImpl<$Res, $Val extends PersonalInfo>
    implements $PersonalInfoCopyWith<$Res> {
  _$PersonalInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phone = null,
    Object? address = null,
    Object? birthDate = null,
    Object? nationality = null,
    Object? photoBase64 = freezed,
    Object? linkedin = null,
    Object? website = null,
  }) {
    return _then(
      _value.copyWith(
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            birthDate: null == birthDate
                ? _value.birthDate
                : birthDate // ignore: cast_nullable_to_non_nullable
                      as String,
            nationality: null == nationality
                ? _value.nationality
                : nationality // ignore: cast_nullable_to_non_nullable
                      as String,
            photoBase64: freezed == photoBase64
                ? _value.photoBase64
                : photoBase64 // ignore: cast_nullable_to_non_nullable
                      as String?,
            linkedin: null == linkedin
                ? _value.linkedin
                : linkedin // ignore: cast_nullable_to_non_nullable
                      as String,
            website: null == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PersonalInfoImplCopyWith<$Res>
    implements $PersonalInfoCopyWith<$Res> {
  factory _$$PersonalInfoImplCopyWith(
    _$PersonalInfoImpl value,
    $Res Function(_$PersonalInfoImpl) then,
  ) = __$$PersonalInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String firstName,
    String lastName,
    String email,
    String phone,
    String address,
    String birthDate,
    String nationality,
    String? photoBase64,
    String linkedin,
    String website,
  });
}

/// @nodoc
class __$$PersonalInfoImplCopyWithImpl<$Res>
    extends _$PersonalInfoCopyWithImpl<$Res, _$PersonalInfoImpl>
    implements _$$PersonalInfoImplCopyWith<$Res> {
  __$$PersonalInfoImplCopyWithImpl(
    _$PersonalInfoImpl _value,
    $Res Function(_$PersonalInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phone = null,
    Object? address = null,
    Object? birthDate = null,
    Object? nationality = null,
    Object? photoBase64 = freezed,
    Object? linkedin = null,
    Object? website = null,
  }) {
    return _then(
      _$PersonalInfoImpl(
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        birthDate: null == birthDate
            ? _value.birthDate
            : birthDate // ignore: cast_nullable_to_non_nullable
                  as String,
        nationality: null == nationality
            ? _value.nationality
            : nationality // ignore: cast_nullable_to_non_nullable
                  as String,
        photoBase64: freezed == photoBase64
            ? _value.photoBase64
            : photoBase64 // ignore: cast_nullable_to_non_nullable
                  as String?,
        linkedin: null == linkedin
            ? _value.linkedin
            : linkedin // ignore: cast_nullable_to_non_nullable
                  as String,
        website: null == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalInfoImpl extends _PersonalInfo {
  const _$PersonalInfoImpl({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.birthDate = '',
    this.nationality = '',
    this.photoBase64,
    this.linkedin = '',
    this.website = '',
  }) : super._();

  factory _$PersonalInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalInfoImplFromJson(json);

  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String lastName;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String birthDate;
  @override
  @JsonKey()
  final String nationality;
  @override
  final String? photoBase64;
  // base64 encoded, null if no photo
  @override
  @JsonKey()
  final String linkedin;
  @override
  @JsonKey()
  final String website;

  @override
  String toString() {
    return 'PersonalInfo(firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, address: $address, birthDate: $birthDate, nationality: $nationality, photoBase64: $photoBase64, linkedin: $linkedin, website: $website)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalInfoImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.photoBase64, photoBase64) ||
                other.photoBase64 == photoBase64) &&
            (identical(other.linkedin, linkedin) ||
                other.linkedin == linkedin) &&
            (identical(other.website, website) || other.website == website));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    firstName,
    lastName,
    email,
    phone,
    address,
    birthDate,
    nationality,
    photoBase64,
    linkedin,
    website,
  );

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalInfoImplCopyWith<_$PersonalInfoImpl> get copyWith =>
      __$$PersonalInfoImplCopyWithImpl<_$PersonalInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalInfoImplToJson(this);
  }
}

abstract class _PersonalInfo extends PersonalInfo {
  const factory _PersonalInfo({
    final String firstName,
    final String lastName,
    final String email,
    final String phone,
    final String address,
    final String birthDate,
    final String nationality,
    final String? photoBase64,
    final String linkedin,
    final String website,
  }) = _$PersonalInfoImpl;
  const _PersonalInfo._() : super._();

  factory _PersonalInfo.fromJson(Map<String, dynamic> json) =
      _$PersonalInfoImpl.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get phone;
  @override
  String get address;
  @override
  String get birthDate;
  @override
  String get nationality;
  @override
  String? get photoBase64; // base64 encoded, null if no photo
  @override
  String get linkedin;
  @override
  String get website;

  /// Create a copy of PersonalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonalInfoImplCopyWith<_$PersonalInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Experience _$ExperienceFromJson(Map<String, dynamic> json) {
  return _Experience.fromJson(json);
}

/// @nodoc
mixin _$Experience {
  String get id => throw _privateConstructorUsedError;
  String get jobTitle => throw _privateConstructorUsedError;
  String get company => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  bool get current => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this Experience to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExperienceCopyWith<Experience> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperienceCopyWith<$Res> {
  factory $ExperienceCopyWith(
    Experience value,
    $Res Function(Experience) then,
  ) = _$ExperienceCopyWithImpl<$Res, Experience>;
  @useResult
  $Res call({
    String id,
    String jobTitle,
    String company,
    String location,
    String startDate,
    String endDate,
    bool current,
    String description,
  });
}

/// @nodoc
class _$ExperienceCopyWithImpl<$Res, $Val extends Experience>
    implements $ExperienceCopyWith<$Res> {
  _$ExperienceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobTitle = null,
    Object? company = null,
    Object? location = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? current = null,
    Object? description = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            jobTitle: null == jobTitle
                ? _value.jobTitle
                : jobTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            company: null == company
                ? _value.company
                : company // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String,
            current: null == current
                ? _value.current
                : current // ignore: cast_nullable_to_non_nullable
                      as bool,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExperienceImplCopyWith<$Res>
    implements $ExperienceCopyWith<$Res> {
  factory _$$ExperienceImplCopyWith(
    _$ExperienceImpl value,
    $Res Function(_$ExperienceImpl) then,
  ) = __$$ExperienceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String jobTitle,
    String company,
    String location,
    String startDate,
    String endDate,
    bool current,
    String description,
  });
}

/// @nodoc
class __$$ExperienceImplCopyWithImpl<$Res>
    extends _$ExperienceCopyWithImpl<$Res, _$ExperienceImpl>
    implements _$$ExperienceImplCopyWith<$Res> {
  __$$ExperienceImplCopyWithImpl(
    _$ExperienceImpl _value,
    $Res Function(_$ExperienceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobTitle = null,
    Object? company = null,
    Object? location = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? current = null,
    Object? description = null,
  }) {
    return _then(
      _$ExperienceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        jobTitle: null == jobTitle
            ? _value.jobTitle
            : jobTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        company: null == company
            ? _value.company
            : company // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String,
        current: null == current
            ? _value.current
            : current // ignore: cast_nullable_to_non_nullable
                  as bool,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperienceImpl implements _Experience {
  const _$ExperienceImpl({
    required this.id,
    this.jobTitle = '',
    this.company = '',
    this.location = '',
    this.startDate = '',
    this.endDate = '',
    this.current = false,
    this.description = '',
  });

  factory _$ExperienceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperienceImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String jobTitle;
  @override
  @JsonKey()
  final String company;
  @override
  @JsonKey()
  final String location;
  @override
  @JsonKey()
  final String startDate;
  @override
  @JsonKey()
  final String endDate;
  @override
  @JsonKey()
  final bool current;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'Experience(id: $id, jobTitle: $jobTitle, company: $company, location: $location, startDate: $startDate, endDate: $endDate, current: $current, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    jobTitle,
    company,
    location,
    startDate,
    endDate,
    current,
    description,
  );

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperienceImplCopyWith<_$ExperienceImpl> get copyWith =>
      __$$ExperienceImplCopyWithImpl<_$ExperienceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperienceImplToJson(this);
  }
}

abstract class _Experience implements Experience {
  const factory _Experience({
    required final String id,
    final String jobTitle,
    final String company,
    final String location,
    final String startDate,
    final String endDate,
    final bool current,
    final String description,
  }) = _$ExperienceImpl;

  factory _Experience.fromJson(Map<String, dynamic> json) =
      _$ExperienceImpl.fromJson;

  @override
  String get id;
  @override
  String get jobTitle;
  @override
  String get company;
  @override
  String get location;
  @override
  String get startDate;
  @override
  String get endDate;
  @override
  bool get current;
  @override
  String get description;

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExperienceImplCopyWith<_$ExperienceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Education _$EducationFromJson(Map<String, dynamic> json) {
  return _Education.fromJson(json);
}

/// @nodoc
mixin _$Education {
  String get id => throw _privateConstructorUsedError;
  String get degree => throw _privateConstructorUsedError;
  String get institution => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this Education to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EducationCopyWith<Education> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EducationCopyWith<$Res> {
  factory $EducationCopyWith(Education value, $Res Function(Education) then) =
      _$EducationCopyWithImpl<$Res, Education>;
  @useResult
  $Res call({
    String id,
    String degree,
    String institution,
    String location,
    String startDate,
    String endDate,
    String description,
  });
}

/// @nodoc
class _$EducationCopyWithImpl<$Res, $Val extends Education>
    implements $EducationCopyWith<$Res> {
  _$EducationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? degree = null,
    Object? institution = null,
    Object? location = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? description = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            degree: null == degree
                ? _value.degree
                : degree // ignore: cast_nullable_to_non_nullable
                      as String,
            institution: null == institution
                ? _value.institution
                : institution // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EducationImplCopyWith<$Res>
    implements $EducationCopyWith<$Res> {
  factory _$$EducationImplCopyWith(
    _$EducationImpl value,
    $Res Function(_$EducationImpl) then,
  ) = __$$EducationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String degree,
    String institution,
    String location,
    String startDate,
    String endDate,
    String description,
  });
}

/// @nodoc
class __$$EducationImplCopyWithImpl<$Res>
    extends _$EducationCopyWithImpl<$Res, _$EducationImpl>
    implements _$$EducationImplCopyWith<$Res> {
  __$$EducationImplCopyWithImpl(
    _$EducationImpl _value,
    $Res Function(_$EducationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? degree = null,
    Object? institution = null,
    Object? location = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? description = null,
  }) {
    return _then(
      _$EducationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        degree: null == degree
            ? _value.degree
            : degree // ignore: cast_nullable_to_non_nullable
                  as String,
        institution: null == institution
            ? _value.institution
            : institution // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EducationImpl implements _Education {
  const _$EducationImpl({
    required this.id,
    this.degree = '',
    this.institution = '',
    this.location = '',
    this.startDate = '',
    this.endDate = '',
    this.description = '',
  });

  factory _$EducationImpl.fromJson(Map<String, dynamic> json) =>
      _$$EducationImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String degree;
  @override
  @JsonKey()
  final String institution;
  @override
  @JsonKey()
  final String location;
  @override
  @JsonKey()
  final String startDate;
  @override
  @JsonKey()
  final String endDate;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'Education(id: $id, degree: $degree, institution: $institution, location: $location, startDate: $startDate, endDate: $endDate, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EducationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            (identical(other.institution, institution) ||
                other.institution == institution) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    degree,
    institution,
    location,
    startDate,
    endDate,
    description,
  );

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EducationImplCopyWith<_$EducationImpl> get copyWith =>
      __$$EducationImplCopyWithImpl<_$EducationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EducationImplToJson(this);
  }
}

abstract class _Education implements Education {
  const factory _Education({
    required final String id,
    final String degree,
    final String institution,
    final String location,
    final String startDate,
    final String endDate,
    final String description,
  }) = _$EducationImpl;

  factory _Education.fromJson(Map<String, dynamic> json) =
      _$EducationImpl.fromJson;

  @override
  String get id;
  @override
  String get degree;
  @override
  String get institution;
  @override
  String get location;
  @override
  String get startDate;
  @override
  String get endDate;
  @override
  String get description;

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EducationImplCopyWith<_$EducationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return _Skill.fromJson(json);
}

/// @nodoc
mixin _$Skill {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;

  /// Serializes this Skill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkillCopyWith<Skill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillCopyWith<$Res> {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) then) =
      _$SkillCopyWithImpl<$Res, Skill>;
  @useResult
  $Res call({String id, String name, int level});
}

/// @nodoc
class _$SkillCopyWithImpl<$Res, $Val extends Skill>
    implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? level = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SkillImplCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$$SkillImplCopyWith(
    _$SkillImpl value,
    $Res Function(_$SkillImpl) then,
  ) = __$$SkillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, int level});
}

/// @nodoc
class __$$SkillImplCopyWithImpl<$Res>
    extends _$SkillCopyWithImpl<$Res, _$SkillImpl>
    implements _$$SkillImplCopyWith<$Res> {
  __$$SkillImplCopyWithImpl(
    _$SkillImpl _value,
    $Res Function(_$SkillImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? level = null}) {
    return _then(
      _$SkillImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillImpl implements _Skill {
  const _$SkillImpl({required this.id, this.name = '', this.level = 3});

  factory _$SkillImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int level;

  @override
  String toString() {
    return 'Skill(id: $id, name: $name, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, level);

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      __$$SkillImplCopyWithImpl<_$SkillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillImplToJson(this);
  }
}

abstract class _Skill implements Skill {
  const factory _Skill({
    required final String id,
    final String name,
    final int level,
  }) = _$SkillImpl;

  factory _Skill.fromJson(Map<String, dynamic> json) = _$SkillImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get level;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LanguageSkill _$LanguageSkillFromJson(Map<String, dynamic> json) {
  return _LanguageSkill.fromJson(json);
}

/// @nodoc
mixin _$LanguageSkill {
  String get id => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;

  /// Serializes this LanguageSkill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LanguageSkill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LanguageSkillCopyWith<LanguageSkill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageSkillCopyWith<$Res> {
  factory $LanguageSkillCopyWith(
    LanguageSkill value,
    $Res Function(LanguageSkill) then,
  ) = _$LanguageSkillCopyWithImpl<$Res, LanguageSkill>;
  @useResult
  $Res call({String id, String language, String level});
}

/// @nodoc
class _$LanguageSkillCopyWithImpl<$Res, $Val extends LanguageSkill>
    implements $LanguageSkillCopyWith<$Res> {
  _$LanguageSkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LanguageSkill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? language = null,
    Object? level = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LanguageSkillImplCopyWith<$Res>
    implements $LanguageSkillCopyWith<$Res> {
  factory _$$LanguageSkillImplCopyWith(
    _$LanguageSkillImpl value,
    $Res Function(_$LanguageSkillImpl) then,
  ) = __$$LanguageSkillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String language, String level});
}

/// @nodoc
class __$$LanguageSkillImplCopyWithImpl<$Res>
    extends _$LanguageSkillCopyWithImpl<$Res, _$LanguageSkillImpl>
    implements _$$LanguageSkillImplCopyWith<$Res> {
  __$$LanguageSkillImplCopyWithImpl(
    _$LanguageSkillImpl _value,
    $Res Function(_$LanguageSkillImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LanguageSkill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? language = null,
    Object? level = null,
  }) {
    return _then(
      _$LanguageSkillImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LanguageSkillImpl implements _LanguageSkill {
  const _$LanguageSkillImpl({
    required this.id,
    this.language = '',
    this.level = 'B2',
  });

  factory _$LanguageSkillImpl.fromJson(Map<String, dynamic> json) =>
      _$$LanguageSkillImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final String level;

  @override
  String toString() {
    return 'LanguageSkill(id: $id, language: $language, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageSkillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, language, level);

  /// Create a copy of LanguageSkill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageSkillImplCopyWith<_$LanguageSkillImpl> get copyWith =>
      __$$LanguageSkillImplCopyWithImpl<_$LanguageSkillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LanguageSkillImplToJson(this);
  }
}

abstract class _LanguageSkill implements LanguageSkill {
  const factory _LanguageSkill({
    required final String id,
    final String language,
    final String level,
  }) = _$LanguageSkillImpl;

  factory _LanguageSkill.fromJson(Map<String, dynamic> json) =
      _$LanguageSkillImpl.fromJson;

  @override
  String get id;
  @override
  String get language;
  @override
  String get level;

  /// Create a copy of LanguageSkill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LanguageSkillImplCopyWith<_$LanguageSkillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
mixin _$Project {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res, Project>;
  @useResult
  $Res call({String id, String name, String description, String url});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res, $Val extends Project>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? url = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProjectImplCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$$ProjectImplCopyWith(
    _$ProjectImpl value,
    $Res Function(_$ProjectImpl) then,
  ) = __$$ProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String description, String url});
}

/// @nodoc
class __$$ProjectImplCopyWithImpl<$Res>
    extends _$ProjectCopyWithImpl<$Res, _$ProjectImpl>
    implements _$$ProjectImplCopyWith<$Res> {
  __$$ProjectImplCopyWithImpl(
    _$ProjectImpl _value,
    $Res Function(_$ProjectImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? url = null,
  }) {
    return _then(
      _$ProjectImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectImpl implements _Project {
  const _$ProjectImpl({
    required this.id,
    this.name = '',
    this.description = '',
    this.url = '',
  });

  factory _$ProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String url;

  @override
  String toString() {
    return 'Project(id: $id, name: $name, description: $description, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, url);

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      __$$ProjectImplCopyWithImpl<_$ProjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectImplToJson(this);
  }
}

abstract class _Project implements Project {
  const factory _Project({
    required final String id,
    final String name,
    final String description,
    final String url,
  }) = _$ProjectImpl;

  factory _Project.fromJson(Map<String, dynamic> json) = _$ProjectImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get url;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Certification _$CertificationFromJson(Map<String, dynamic> json) {
  return _Certification.fromJson(json);
}

/// @nodoc
mixin _$Certification {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get issuer => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;

  /// Serializes this Certification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Certification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CertificationCopyWith<Certification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertificationCopyWith<$Res> {
  factory $CertificationCopyWith(
    Certification value,
    $Res Function(Certification) then,
  ) = _$CertificationCopyWithImpl<$Res, Certification>;
  @useResult
  $Res call({String id, String name, String issuer, String date});
}

/// @nodoc
class _$CertificationCopyWithImpl<$Res, $Val extends Certification>
    implements $CertificationCopyWith<$Res> {
  _$CertificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Certification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? issuer = null,
    Object? date = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            issuer: null == issuer
                ? _value.issuer
                : issuer // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CertificationImplCopyWith<$Res>
    implements $CertificationCopyWith<$Res> {
  factory _$$CertificationImplCopyWith(
    _$CertificationImpl value,
    $Res Function(_$CertificationImpl) then,
  ) = __$$CertificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String issuer, String date});
}

/// @nodoc
class __$$CertificationImplCopyWithImpl<$Res>
    extends _$CertificationCopyWithImpl<$Res, _$CertificationImpl>
    implements _$$CertificationImplCopyWith<$Res> {
  __$$CertificationImplCopyWithImpl(
    _$CertificationImpl _value,
    $Res Function(_$CertificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Certification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? issuer = null,
    Object? date = null,
  }) {
    return _then(
      _$CertificationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        issuer: null == issuer
            ? _value.issuer
            : issuer // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CertificationImpl implements _Certification {
  const _$CertificationImpl({
    required this.id,
    this.name = '',
    this.issuer = '',
    this.date = '',
  });

  factory _$CertificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CertificationImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String issuer;
  @override
  @JsonKey()
  final String date;

  @override
  String toString() {
    return 'Certification(id: $id, name: $name, issuer: $issuer, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.issuer, issuer) || other.issuer == issuer) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, issuer, date);

  /// Create a copy of Certification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CertificationImplCopyWith<_$CertificationImpl> get copyWith =>
      __$$CertificationImplCopyWithImpl<_$CertificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CertificationImplToJson(this);
  }
}

abstract class _Certification implements Certification {
  const factory _Certification({
    required final String id,
    final String name,
    final String issuer,
    final String date,
  }) = _$CertificationImpl;

  factory _Certification.fromJson(Map<String, dynamic> json) =
      _$CertificationImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get issuer;
  @override
  String get date;

  /// Create a copy of Certification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CertificationImplCopyWith<_$CertificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Volunteer _$VolunteerFromJson(Map<String, dynamic> json) {
  return _Volunteer.fromJson(json);
}

/// @nodoc
mixin _$Volunteer {
  String get id => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get organization => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this Volunteer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Volunteer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VolunteerCopyWith<Volunteer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VolunteerCopyWith<$Res> {
  factory $VolunteerCopyWith(Volunteer value, $Res Function(Volunteer) then) =
      _$VolunteerCopyWithImpl<$Res, Volunteer>;
  @useResult
  $Res call({
    String id,
    String role,
    String organization,
    String startDate,
    String endDate,
    String description,
  });
}

/// @nodoc
class _$VolunteerCopyWithImpl<$Res, $Val extends Volunteer>
    implements $VolunteerCopyWith<$Res> {
  _$VolunteerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Volunteer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? organization = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? description = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            organization: null == organization
                ? _value.organization
                : organization // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VolunteerImplCopyWith<$Res>
    implements $VolunteerCopyWith<$Res> {
  factory _$$VolunteerImplCopyWith(
    _$VolunteerImpl value,
    $Res Function(_$VolunteerImpl) then,
  ) = __$$VolunteerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String role,
    String organization,
    String startDate,
    String endDate,
    String description,
  });
}

/// @nodoc
class __$$VolunteerImplCopyWithImpl<$Res>
    extends _$VolunteerCopyWithImpl<$Res, _$VolunteerImpl>
    implements _$$VolunteerImplCopyWith<$Res> {
  __$$VolunteerImplCopyWithImpl(
    _$VolunteerImpl _value,
    $Res Function(_$VolunteerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Volunteer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? organization = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? description = null,
  }) {
    return _then(
      _$VolunteerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        organization: null == organization
            ? _value.organization
            : organization // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VolunteerImpl implements _Volunteer {
  const _$VolunteerImpl({
    required this.id,
    this.role = '',
    this.organization = '',
    this.startDate = '',
    this.endDate = '',
    this.description = '',
  });

  factory _$VolunteerImpl.fromJson(Map<String, dynamic> json) =>
      _$$VolunteerImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String role;
  @override
  @JsonKey()
  final String organization;
  @override
  @JsonKey()
  final String startDate;
  @override
  @JsonKey()
  final String endDate;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'Volunteer(id: $id, role: $role, organization: $organization, startDate: $startDate, endDate: $endDate, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VolunteerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.organization, organization) ||
                other.organization == organization) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    role,
    organization,
    startDate,
    endDate,
    description,
  );

  /// Create a copy of Volunteer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VolunteerImplCopyWith<_$VolunteerImpl> get copyWith =>
      __$$VolunteerImplCopyWithImpl<_$VolunteerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VolunteerImplToJson(this);
  }
}

abstract class _Volunteer implements Volunteer {
  const factory _Volunteer({
    required final String id,
    final String role,
    final String organization,
    final String startDate,
    final String endDate,
    final String description,
  }) = _$VolunteerImpl;

  factory _Volunteer.fromJson(Map<String, dynamic> json) =
      _$VolunteerImpl.fromJson;

  @override
  String get id;
  @override
  String get role;
  @override
  String get organization;
  @override
  String get startDate;
  @override
  String get endDate;
  @override
  String get description;

  /// Create a copy of Volunteer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VolunteerImplCopyWith<_$VolunteerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CVData _$CVDataFromJson(Map<String, dynamic> json) {
  return _CVData.fromJson(json);
}

/// @nodoc
mixin _$CVData {
  PersonalInfo get personalInfo => throw _privateConstructorUsedError;
  String get profile => throw _privateConstructorUsedError;
  List<Experience> get experiences => throw _privateConstructorUsedError;
  List<Education> get education => throw _privateConstructorUsedError;
  List<Skill> get skills => throw _privateConstructorUsedError;
  List<LanguageSkill> get languages => throw _privateConstructorUsedError;
  List<Project> get projects => throw _privateConstructorUsedError;
  List<Certification> get certifications => throw _privateConstructorUsedError;
  List<Volunteer> get volunteer => throw _privateConstructorUsedError;
  String get interests => throw _privateConstructorUsedError;
  List<CVSection> get sections => throw _privateConstructorUsedError;
  TemplateName get template => throw _privateConstructorUsedError;
  bool get modernMode => throw _privateConstructorUsedError;
  Language get currentLanguage => throw _privateConstructorUsedError;
  Map<String, TranslatedField> get translations =>
      throw _privateConstructorUsedError;

  /// Serializes this CVData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CVData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CVDataCopyWith<CVData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CVDataCopyWith<$Res> {
  factory $CVDataCopyWith(CVData value, $Res Function(CVData) then) =
      _$CVDataCopyWithImpl<$Res, CVData>;
  @useResult
  $Res call({
    PersonalInfo personalInfo,
    String profile,
    List<Experience> experiences,
    List<Education> education,
    List<Skill> skills,
    List<LanguageSkill> languages,
    List<Project> projects,
    List<Certification> certifications,
    List<Volunteer> volunteer,
    String interests,
    List<CVSection> sections,
    TemplateName template,
    bool modernMode,
    Language currentLanguage,
    Map<String, TranslatedField> translations,
  });

  $PersonalInfoCopyWith<$Res> get personalInfo;
}

/// @nodoc
class _$CVDataCopyWithImpl<$Res, $Val extends CVData>
    implements $CVDataCopyWith<$Res> {
  _$CVDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CVData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? personalInfo = null,
    Object? profile = null,
    Object? experiences = null,
    Object? education = null,
    Object? skills = null,
    Object? languages = null,
    Object? projects = null,
    Object? certifications = null,
    Object? volunteer = null,
    Object? interests = null,
    Object? sections = null,
    Object? template = null,
    Object? modernMode = null,
    Object? currentLanguage = null,
    Object? translations = null,
  }) {
    return _then(
      _value.copyWith(
            personalInfo: null == personalInfo
                ? _value.personalInfo
                : personalInfo // ignore: cast_nullable_to_non_nullable
                      as PersonalInfo,
            profile: null == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                      as String,
            experiences: null == experiences
                ? _value.experiences
                : experiences // ignore: cast_nullable_to_non_nullable
                      as List<Experience>,
            education: null == education
                ? _value.education
                : education // ignore: cast_nullable_to_non_nullable
                      as List<Education>,
            skills: null == skills
                ? _value.skills
                : skills // ignore: cast_nullable_to_non_nullable
                      as List<Skill>,
            languages: null == languages
                ? _value.languages
                : languages // ignore: cast_nullable_to_non_nullable
                      as List<LanguageSkill>,
            projects: null == projects
                ? _value.projects
                : projects // ignore: cast_nullable_to_non_nullable
                      as List<Project>,
            certifications: null == certifications
                ? _value.certifications
                : certifications // ignore: cast_nullable_to_non_nullable
                      as List<Certification>,
            volunteer: null == volunteer
                ? _value.volunteer
                : volunteer // ignore: cast_nullable_to_non_nullable
                      as List<Volunteer>,
            interests: null == interests
                ? _value.interests
                : interests // ignore: cast_nullable_to_non_nullable
                      as String,
            sections: null == sections
                ? _value.sections
                : sections // ignore: cast_nullable_to_non_nullable
                      as List<CVSection>,
            template: null == template
                ? _value.template
                : template // ignore: cast_nullable_to_non_nullable
                      as TemplateName,
            modernMode: null == modernMode
                ? _value.modernMode
                : modernMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentLanguage: null == currentLanguage
                ? _value.currentLanguage
                : currentLanguage // ignore: cast_nullable_to_non_nullable
                      as Language,
            translations: null == translations
                ? _value.translations
                : translations // ignore: cast_nullable_to_non_nullable
                      as Map<String, TranslatedField>,
          )
          as $Val,
    );
  }

  /// Create a copy of CVData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PersonalInfoCopyWith<$Res> get personalInfo {
    return $PersonalInfoCopyWith<$Res>(_value.personalInfo, (value) {
      return _then(_value.copyWith(personalInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CVDataImplCopyWith<$Res> implements $CVDataCopyWith<$Res> {
  factory _$$CVDataImplCopyWith(
    _$CVDataImpl value,
    $Res Function(_$CVDataImpl) then,
  ) = __$$CVDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PersonalInfo personalInfo,
    String profile,
    List<Experience> experiences,
    List<Education> education,
    List<Skill> skills,
    List<LanguageSkill> languages,
    List<Project> projects,
    List<Certification> certifications,
    List<Volunteer> volunteer,
    String interests,
    List<CVSection> sections,
    TemplateName template,
    bool modernMode,
    Language currentLanguage,
    Map<String, TranslatedField> translations,
  });

  @override
  $PersonalInfoCopyWith<$Res> get personalInfo;
}

/// @nodoc
class __$$CVDataImplCopyWithImpl<$Res>
    extends _$CVDataCopyWithImpl<$Res, _$CVDataImpl>
    implements _$$CVDataImplCopyWith<$Res> {
  __$$CVDataImplCopyWithImpl(
    _$CVDataImpl _value,
    $Res Function(_$CVDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CVData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? personalInfo = null,
    Object? profile = null,
    Object? experiences = null,
    Object? education = null,
    Object? skills = null,
    Object? languages = null,
    Object? projects = null,
    Object? certifications = null,
    Object? volunteer = null,
    Object? interests = null,
    Object? sections = null,
    Object? template = null,
    Object? modernMode = null,
    Object? currentLanguage = null,
    Object? translations = null,
  }) {
    return _then(
      _$CVDataImpl(
        personalInfo: null == personalInfo
            ? _value.personalInfo
            : personalInfo // ignore: cast_nullable_to_non_nullable
                  as PersonalInfo,
        profile: null == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as String,
        experiences: null == experiences
            ? _value._experiences
            : experiences // ignore: cast_nullable_to_non_nullable
                  as List<Experience>,
        education: null == education
            ? _value._education
            : education // ignore: cast_nullable_to_non_nullable
                  as List<Education>,
        skills: null == skills
            ? _value._skills
            : skills // ignore: cast_nullable_to_non_nullable
                  as List<Skill>,
        languages: null == languages
            ? _value._languages
            : languages // ignore: cast_nullable_to_non_nullable
                  as List<LanguageSkill>,
        projects: null == projects
            ? _value._projects
            : projects // ignore: cast_nullable_to_non_nullable
                  as List<Project>,
        certifications: null == certifications
            ? _value._certifications
            : certifications // ignore: cast_nullable_to_non_nullable
                  as List<Certification>,
        volunteer: null == volunteer
            ? _value._volunteer
            : volunteer // ignore: cast_nullable_to_non_nullable
                  as List<Volunteer>,
        interests: null == interests
            ? _value.interests
            : interests // ignore: cast_nullable_to_non_nullable
                  as String,
        sections: null == sections
            ? _value._sections
            : sections // ignore: cast_nullable_to_non_nullable
                  as List<CVSection>,
        template: null == template
            ? _value.template
            : template // ignore: cast_nullable_to_non_nullable
                  as TemplateName,
        modernMode: null == modernMode
            ? _value.modernMode
            : modernMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentLanguage: null == currentLanguage
            ? _value.currentLanguage
            : currentLanguage // ignore: cast_nullable_to_non_nullable
                  as Language,
        translations: null == translations
            ? _value._translations
            : translations // ignore: cast_nullable_to_non_nullable
                  as Map<String, TranslatedField>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CVDataImpl implements _CVData {
  const _$CVDataImpl({
    required this.personalInfo,
    this.profile = '',
    final List<Experience> experiences = const [],
    final List<Education> education = const [],
    final List<Skill> skills = const [],
    final List<LanguageSkill> languages = const [],
    final List<Project> projects = const [],
    final List<Certification> certifications = const [],
    final List<Volunteer> volunteer = const [],
    this.interests = '',
    required final List<CVSection> sections,
    this.template = TemplateName.european,
    this.modernMode = false,
    this.currentLanguage = Language.it,
    final Map<String, TranslatedField> translations = const {},
  }) : _experiences = experiences,
       _education = education,
       _skills = skills,
       _languages = languages,
       _projects = projects,
       _certifications = certifications,
       _volunteer = volunteer,
       _sections = sections,
       _translations = translations;

  factory _$CVDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CVDataImplFromJson(json);

  @override
  final PersonalInfo personalInfo;
  @override
  @JsonKey()
  final String profile;
  final List<Experience> _experiences;
  @override
  @JsonKey()
  List<Experience> get experiences {
    if (_experiences is EqualUnmodifiableListView) return _experiences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_experiences);
  }

  final List<Education> _education;
  @override
  @JsonKey()
  List<Education> get education {
    if (_education is EqualUnmodifiableListView) return _education;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_education);
  }

  final List<Skill> _skills;
  @override
  @JsonKey()
  List<Skill> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  final List<LanguageSkill> _languages;
  @override
  @JsonKey()
  List<LanguageSkill> get languages {
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languages);
  }

  final List<Project> _projects;
  @override
  @JsonKey()
  List<Project> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  final List<Certification> _certifications;
  @override
  @JsonKey()
  List<Certification> get certifications {
    if (_certifications is EqualUnmodifiableListView) return _certifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_certifications);
  }

  final List<Volunteer> _volunteer;
  @override
  @JsonKey()
  List<Volunteer> get volunteer {
    if (_volunteer is EqualUnmodifiableListView) return _volunteer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_volunteer);
  }

  @override
  @JsonKey()
  final String interests;
  final List<CVSection> _sections;
  @override
  List<CVSection> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  @JsonKey()
  final TemplateName template;
  @override
  @JsonKey()
  final bool modernMode;
  @override
  @JsonKey()
  final Language currentLanguage;
  final Map<String, TranslatedField> _translations;
  @override
  @JsonKey()
  Map<String, TranslatedField> get translations {
    if (_translations is EqualUnmodifiableMapView) return _translations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_translations);
  }

  @override
  String toString() {
    return 'CVData(personalInfo: $personalInfo, profile: $profile, experiences: $experiences, education: $education, skills: $skills, languages: $languages, projects: $projects, certifications: $certifications, volunteer: $volunteer, interests: $interests, sections: $sections, template: $template, modernMode: $modernMode, currentLanguage: $currentLanguage, translations: $translations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CVDataImpl &&
            (identical(other.personalInfo, personalInfo) ||
                other.personalInfo == personalInfo) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            const DeepCollectionEquality().equals(
              other._experiences,
              _experiences,
            ) &&
            const DeepCollectionEquality().equals(
              other._education,
              _education,
            ) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality().equals(
              other._languages,
              _languages,
            ) &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            const DeepCollectionEquality().equals(
              other._certifications,
              _certifications,
            ) &&
            const DeepCollectionEquality().equals(
              other._volunteer,
              _volunteer,
            ) &&
            (identical(other.interests, interests) ||
                other.interests == interests) &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            (identical(other.template, template) ||
                other.template == template) &&
            (identical(other.modernMode, modernMode) ||
                other.modernMode == modernMode) &&
            (identical(other.currentLanguage, currentLanguage) ||
                other.currentLanguage == currentLanguage) &&
            const DeepCollectionEquality().equals(
              other._translations,
              _translations,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    personalInfo,
    profile,
    const DeepCollectionEquality().hash(_experiences),
    const DeepCollectionEquality().hash(_education),
    const DeepCollectionEquality().hash(_skills),
    const DeepCollectionEquality().hash(_languages),
    const DeepCollectionEquality().hash(_projects),
    const DeepCollectionEquality().hash(_certifications),
    const DeepCollectionEquality().hash(_volunteer),
    interests,
    const DeepCollectionEquality().hash(_sections),
    template,
    modernMode,
    currentLanguage,
    const DeepCollectionEquality().hash(_translations),
  );

  /// Create a copy of CVData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CVDataImplCopyWith<_$CVDataImpl> get copyWith =>
      __$$CVDataImplCopyWithImpl<_$CVDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CVDataImplToJson(this);
  }
}

abstract class _CVData implements CVData {
  const factory _CVData({
    required final PersonalInfo personalInfo,
    final String profile,
    final List<Experience> experiences,
    final List<Education> education,
    final List<Skill> skills,
    final List<LanguageSkill> languages,
    final List<Project> projects,
    final List<Certification> certifications,
    final List<Volunteer> volunteer,
    final String interests,
    required final List<CVSection> sections,
    final TemplateName template,
    final bool modernMode,
    final Language currentLanguage,
    final Map<String, TranslatedField> translations,
  }) = _$CVDataImpl;

  factory _CVData.fromJson(Map<String, dynamic> json) = _$CVDataImpl.fromJson;

  @override
  PersonalInfo get personalInfo;
  @override
  String get profile;
  @override
  List<Experience> get experiences;
  @override
  List<Education> get education;
  @override
  List<Skill> get skills;
  @override
  List<LanguageSkill> get languages;
  @override
  List<Project> get projects;
  @override
  List<Certification> get certifications;
  @override
  List<Volunteer> get volunteer;
  @override
  String get interests;
  @override
  List<CVSection> get sections;
  @override
  TemplateName get template;
  @override
  bool get modernMode;
  @override
  Language get currentLanguage;
  @override
  Map<String, TranslatedField> get translations;

  /// Create a copy of CVData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CVDataImplCopyWith<_$CVDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
