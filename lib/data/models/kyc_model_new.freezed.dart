// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyc_model_new.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhilippineAddress {

 String get street; String get barangay; String get city; String get province; String get zipCode;
/// Create a copy of PhilippineAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhilippineAddressCopyWith<PhilippineAddress> get copyWith => _$PhilippineAddressCopyWithImpl<PhilippineAddress>(this as PhilippineAddress, _$identity);

  /// Serializes this PhilippineAddress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhilippineAddress&&(identical(other.street, street) || other.street == street)&&(identical(other.barangay, barangay) || other.barangay == barangay)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,street,barangay,city,province,zipCode);

@override
String toString() {
  return 'PhilippineAddress(street: $street, barangay: $barangay, city: $city, province: $province, zipCode: $zipCode)';
}


}

/// @nodoc
abstract mixin class $PhilippineAddressCopyWith<$Res>  {
  factory $PhilippineAddressCopyWith(PhilippineAddress value, $Res Function(PhilippineAddress) _then) = _$PhilippineAddressCopyWithImpl;
@useResult
$Res call({
 String street, String barangay, String city, String province, String zipCode
});




}
/// @nodoc
class _$PhilippineAddressCopyWithImpl<$Res>
    implements $PhilippineAddressCopyWith<$Res> {
  _$PhilippineAddressCopyWithImpl(this._self, this._then);

  final PhilippineAddress _self;
  final $Res Function(PhilippineAddress) _then;

/// Create a copy of PhilippineAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? street = null,Object? barangay = null,Object? city = null,Object? province = null,Object? zipCode = null,}) {
  return _then(_self.copyWith(
street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,barangay: null == barangay ? _self.barangay : barangay // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,zipCode: null == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PhilippineAddress].
extension PhilippineAddressPatterns on PhilippineAddress {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhilippineAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhilippineAddress() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhilippineAddress value)  $default,){
final _that = this;
switch (_that) {
case _PhilippineAddress():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhilippineAddress value)?  $default,){
final _that = this;
switch (_that) {
case _PhilippineAddress() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String street,  String barangay,  String city,  String province,  String zipCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhilippineAddress() when $default != null:
return $default(_that.street,_that.barangay,_that.city,_that.province,_that.zipCode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String street,  String barangay,  String city,  String province,  String zipCode)  $default,) {final _that = this;
switch (_that) {
case _PhilippineAddress():
return $default(_that.street,_that.barangay,_that.city,_that.province,_that.zipCode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String street,  String barangay,  String city,  String province,  String zipCode)?  $default,) {final _that = this;
switch (_that) {
case _PhilippineAddress() when $default != null:
return $default(_that.street,_that.barangay,_that.city,_that.province,_that.zipCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhilippineAddress implements PhilippineAddress {
  const _PhilippineAddress({required this.street, required this.barangay, required this.city, required this.province, required this.zipCode});
  factory _PhilippineAddress.fromJson(Map<String, dynamic> json) => _$PhilippineAddressFromJson(json);

@override final  String street;
@override final  String barangay;
@override final  String city;
@override final  String province;
@override final  String zipCode;

/// Create a copy of PhilippineAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhilippineAddressCopyWith<_PhilippineAddress> get copyWith => __$PhilippineAddressCopyWithImpl<_PhilippineAddress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhilippineAddressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhilippineAddress&&(identical(other.street, street) || other.street == street)&&(identical(other.barangay, barangay) || other.barangay == barangay)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,street,barangay,city,province,zipCode);

@override
String toString() {
  return 'PhilippineAddress(street: $street, barangay: $barangay, city: $city, province: $province, zipCode: $zipCode)';
}


}

/// @nodoc
abstract mixin class _$PhilippineAddressCopyWith<$Res> implements $PhilippineAddressCopyWith<$Res> {
  factory _$PhilippineAddressCopyWith(_PhilippineAddress value, $Res Function(_PhilippineAddress) _then) = __$PhilippineAddressCopyWithImpl;
@override @useResult
$Res call({
 String street, String barangay, String city, String province, String zipCode
});




}
/// @nodoc
class __$PhilippineAddressCopyWithImpl<$Res>
    implements _$PhilippineAddressCopyWith<$Res> {
  __$PhilippineAddressCopyWithImpl(this._self, this._then);

  final _PhilippineAddress _self;
  final $Res Function(_PhilippineAddress) _then;

/// Create a copy of PhilippineAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? street = null,Object? barangay = null,Object? city = null,Object? province = null,Object? zipCode = null,}) {
  return _then(_PhilippineAddress(
street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,barangay: null == barangay ? _self.barangay : barangay // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,zipCode: null == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$KycModelNew {

 String get id; String get userId;// Primary ID (Philippine National ID - Fixed)
 String get primaryIdType; String get primaryIdNumber; String get primaryIdFrontImage; String get primaryIdBackImage;// Secondary ID
 SecondaryIdType get secondaryIdType; String get secondaryIdNumber; String get secondaryIdImage;// Selfie
 String get selfieImage;// Personal Information
 DateTime get dateOfBirth; PhilippineAddress get address;// Verification
 KycVerificationStatus get verificationStatus; DateTime get submittedAt; DateTime? get verifiedAt; String? get rejectionReason;
/// Create a copy of KycModelNew
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KycModelNewCopyWith<KycModelNew> get copyWith => _$KycModelNewCopyWithImpl<KycModelNew>(this as KycModelNew, _$identity);

  /// Serializes this KycModelNew to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KycModelNew&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.primaryIdType, primaryIdType) || other.primaryIdType == primaryIdType)&&(identical(other.primaryIdNumber, primaryIdNumber) || other.primaryIdNumber == primaryIdNumber)&&(identical(other.primaryIdFrontImage, primaryIdFrontImage) || other.primaryIdFrontImage == primaryIdFrontImage)&&(identical(other.primaryIdBackImage, primaryIdBackImage) || other.primaryIdBackImage == primaryIdBackImage)&&(identical(other.secondaryIdType, secondaryIdType) || other.secondaryIdType == secondaryIdType)&&(identical(other.secondaryIdNumber, secondaryIdNumber) || other.secondaryIdNumber == secondaryIdNumber)&&(identical(other.secondaryIdImage, secondaryIdImage) || other.secondaryIdImage == secondaryIdImage)&&(identical(other.selfieImage, selfieImage) || other.selfieImage == selfieImage)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.address, address) || other.address == address)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,primaryIdType,primaryIdNumber,primaryIdFrontImage,primaryIdBackImage,secondaryIdType,secondaryIdNumber,secondaryIdImage,selfieImage,dateOfBirth,address,verificationStatus,submittedAt,verifiedAt,rejectionReason);

@override
String toString() {
  return 'KycModelNew(id: $id, userId: $userId, primaryIdType: $primaryIdType, primaryIdNumber: $primaryIdNumber, primaryIdFrontImage: $primaryIdFrontImage, primaryIdBackImage: $primaryIdBackImage, secondaryIdType: $secondaryIdType, secondaryIdNumber: $secondaryIdNumber, secondaryIdImage: $secondaryIdImage, selfieImage: $selfieImage, dateOfBirth: $dateOfBirth, address: $address, verificationStatus: $verificationStatus, submittedAt: $submittedAt, verifiedAt: $verifiedAt, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class $KycModelNewCopyWith<$Res>  {
  factory $KycModelNewCopyWith(KycModelNew value, $Res Function(KycModelNew) _then) = _$KycModelNewCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String primaryIdType, String primaryIdNumber, String primaryIdFrontImage, String primaryIdBackImage, SecondaryIdType secondaryIdType, String secondaryIdNumber, String secondaryIdImage, String selfieImage, DateTime dateOfBirth, PhilippineAddress address, KycVerificationStatus verificationStatus, DateTime submittedAt, DateTime? verifiedAt, String? rejectionReason
});


$PhilippineAddressCopyWith<$Res> get address;

}
/// @nodoc
class _$KycModelNewCopyWithImpl<$Res>
    implements $KycModelNewCopyWith<$Res> {
  _$KycModelNewCopyWithImpl(this._self, this._then);

  final KycModelNew _self;
  final $Res Function(KycModelNew) _then;

/// Create a copy of KycModelNew
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? primaryIdType = null,Object? primaryIdNumber = null,Object? primaryIdFrontImage = null,Object? primaryIdBackImage = null,Object? secondaryIdType = null,Object? secondaryIdNumber = null,Object? secondaryIdImage = null,Object? selfieImage = null,Object? dateOfBirth = null,Object? address = null,Object? verificationStatus = null,Object? submittedAt = null,Object? verifiedAt = freezed,Object? rejectionReason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,primaryIdType: null == primaryIdType ? _self.primaryIdType : primaryIdType // ignore: cast_nullable_to_non_nullable
as String,primaryIdNumber: null == primaryIdNumber ? _self.primaryIdNumber : primaryIdNumber // ignore: cast_nullable_to_non_nullable
as String,primaryIdFrontImage: null == primaryIdFrontImage ? _self.primaryIdFrontImage : primaryIdFrontImage // ignore: cast_nullable_to_non_nullable
as String,primaryIdBackImage: null == primaryIdBackImage ? _self.primaryIdBackImage : primaryIdBackImage // ignore: cast_nullable_to_non_nullable
as String,secondaryIdType: null == secondaryIdType ? _self.secondaryIdType : secondaryIdType // ignore: cast_nullable_to_non_nullable
as SecondaryIdType,secondaryIdNumber: null == secondaryIdNumber ? _self.secondaryIdNumber : secondaryIdNumber // ignore: cast_nullable_to_non_nullable
as String,secondaryIdImage: null == secondaryIdImage ? _self.secondaryIdImage : secondaryIdImage // ignore: cast_nullable_to_non_nullable
as String,selfieImage: null == selfieImage ? _self.selfieImage : selfieImage // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as PhilippineAddress,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as KycVerificationStatus,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of KycModelNew
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhilippineAddressCopyWith<$Res> get address {
  
  return $PhilippineAddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [KycModelNew].
extension KycModelNewPatterns on KycModelNew {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KycModelNew value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KycModelNew() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KycModelNew value)  $default,){
final _that = this;
switch (_that) {
case _KycModelNew():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KycModelNew value)?  $default,){
final _that = this;
switch (_that) {
case _KycModelNew() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String primaryIdType,  String primaryIdNumber,  String primaryIdFrontImage,  String primaryIdBackImage,  SecondaryIdType secondaryIdType,  String secondaryIdNumber,  String secondaryIdImage,  String selfieImage,  DateTime dateOfBirth,  PhilippineAddress address,  KycVerificationStatus verificationStatus,  DateTime submittedAt,  DateTime? verifiedAt,  String? rejectionReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KycModelNew() when $default != null:
return $default(_that.id,_that.userId,_that.primaryIdType,_that.primaryIdNumber,_that.primaryIdFrontImage,_that.primaryIdBackImage,_that.secondaryIdType,_that.secondaryIdNumber,_that.secondaryIdImage,_that.selfieImage,_that.dateOfBirth,_that.address,_that.verificationStatus,_that.submittedAt,_that.verifiedAt,_that.rejectionReason);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String primaryIdType,  String primaryIdNumber,  String primaryIdFrontImage,  String primaryIdBackImage,  SecondaryIdType secondaryIdType,  String secondaryIdNumber,  String secondaryIdImage,  String selfieImage,  DateTime dateOfBirth,  PhilippineAddress address,  KycVerificationStatus verificationStatus,  DateTime submittedAt,  DateTime? verifiedAt,  String? rejectionReason)  $default,) {final _that = this;
switch (_that) {
case _KycModelNew():
return $default(_that.id,_that.userId,_that.primaryIdType,_that.primaryIdNumber,_that.primaryIdFrontImage,_that.primaryIdBackImage,_that.secondaryIdType,_that.secondaryIdNumber,_that.secondaryIdImage,_that.selfieImage,_that.dateOfBirth,_that.address,_that.verificationStatus,_that.submittedAt,_that.verifiedAt,_that.rejectionReason);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String primaryIdType,  String primaryIdNumber,  String primaryIdFrontImage,  String primaryIdBackImage,  SecondaryIdType secondaryIdType,  String secondaryIdNumber,  String secondaryIdImage,  String selfieImage,  DateTime dateOfBirth,  PhilippineAddress address,  KycVerificationStatus verificationStatus,  DateTime submittedAt,  DateTime? verifiedAt,  String? rejectionReason)?  $default,) {final _that = this;
switch (_that) {
case _KycModelNew() when $default != null:
return $default(_that.id,_that.userId,_that.primaryIdType,_that.primaryIdNumber,_that.primaryIdFrontImage,_that.primaryIdBackImage,_that.secondaryIdType,_that.secondaryIdNumber,_that.secondaryIdImage,_that.selfieImage,_that.dateOfBirth,_that.address,_that.verificationStatus,_that.submittedAt,_that.verifiedAt,_that.rejectionReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KycModelNew implements KycModelNew {
  const _KycModelNew({required this.id, required this.userId, this.primaryIdType = 'Philippine National ID', required this.primaryIdNumber, required this.primaryIdFrontImage, required this.primaryIdBackImage, required this.secondaryIdType, required this.secondaryIdNumber, required this.secondaryIdImage, required this.selfieImage, required this.dateOfBirth, required this.address, required this.verificationStatus, required this.submittedAt, this.verifiedAt, this.rejectionReason});
  factory _KycModelNew.fromJson(Map<String, dynamic> json) => _$KycModelNewFromJson(json);

@override final  String id;
@override final  String userId;
// Primary ID (Philippine National ID - Fixed)
@override@JsonKey() final  String primaryIdType;
@override final  String primaryIdNumber;
@override final  String primaryIdFrontImage;
@override final  String primaryIdBackImage;
// Secondary ID
@override final  SecondaryIdType secondaryIdType;
@override final  String secondaryIdNumber;
@override final  String secondaryIdImage;
// Selfie
@override final  String selfieImage;
// Personal Information
@override final  DateTime dateOfBirth;
@override final  PhilippineAddress address;
// Verification
@override final  KycVerificationStatus verificationStatus;
@override final  DateTime submittedAt;
@override final  DateTime? verifiedAt;
@override final  String? rejectionReason;

/// Create a copy of KycModelNew
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KycModelNewCopyWith<_KycModelNew> get copyWith => __$KycModelNewCopyWithImpl<_KycModelNew>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KycModelNewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KycModelNew&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.primaryIdType, primaryIdType) || other.primaryIdType == primaryIdType)&&(identical(other.primaryIdNumber, primaryIdNumber) || other.primaryIdNumber == primaryIdNumber)&&(identical(other.primaryIdFrontImage, primaryIdFrontImage) || other.primaryIdFrontImage == primaryIdFrontImage)&&(identical(other.primaryIdBackImage, primaryIdBackImage) || other.primaryIdBackImage == primaryIdBackImage)&&(identical(other.secondaryIdType, secondaryIdType) || other.secondaryIdType == secondaryIdType)&&(identical(other.secondaryIdNumber, secondaryIdNumber) || other.secondaryIdNumber == secondaryIdNumber)&&(identical(other.secondaryIdImage, secondaryIdImage) || other.secondaryIdImage == secondaryIdImage)&&(identical(other.selfieImage, selfieImage) || other.selfieImage == selfieImage)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.address, address) || other.address == address)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,primaryIdType,primaryIdNumber,primaryIdFrontImage,primaryIdBackImage,secondaryIdType,secondaryIdNumber,secondaryIdImage,selfieImage,dateOfBirth,address,verificationStatus,submittedAt,verifiedAt,rejectionReason);

@override
String toString() {
  return 'KycModelNew(id: $id, userId: $userId, primaryIdType: $primaryIdType, primaryIdNumber: $primaryIdNumber, primaryIdFrontImage: $primaryIdFrontImage, primaryIdBackImage: $primaryIdBackImage, secondaryIdType: $secondaryIdType, secondaryIdNumber: $secondaryIdNumber, secondaryIdImage: $secondaryIdImage, selfieImage: $selfieImage, dateOfBirth: $dateOfBirth, address: $address, verificationStatus: $verificationStatus, submittedAt: $submittedAt, verifiedAt: $verifiedAt, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class _$KycModelNewCopyWith<$Res> implements $KycModelNewCopyWith<$Res> {
  factory _$KycModelNewCopyWith(_KycModelNew value, $Res Function(_KycModelNew) _then) = __$KycModelNewCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String primaryIdType, String primaryIdNumber, String primaryIdFrontImage, String primaryIdBackImage, SecondaryIdType secondaryIdType, String secondaryIdNumber, String secondaryIdImage, String selfieImage, DateTime dateOfBirth, PhilippineAddress address, KycVerificationStatus verificationStatus, DateTime submittedAt, DateTime? verifiedAt, String? rejectionReason
});


@override $PhilippineAddressCopyWith<$Res> get address;

}
/// @nodoc
class __$KycModelNewCopyWithImpl<$Res>
    implements _$KycModelNewCopyWith<$Res> {
  __$KycModelNewCopyWithImpl(this._self, this._then);

  final _KycModelNew _self;
  final $Res Function(_KycModelNew) _then;

/// Create a copy of KycModelNew
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? primaryIdType = null,Object? primaryIdNumber = null,Object? primaryIdFrontImage = null,Object? primaryIdBackImage = null,Object? secondaryIdType = null,Object? secondaryIdNumber = null,Object? secondaryIdImage = null,Object? selfieImage = null,Object? dateOfBirth = null,Object? address = null,Object? verificationStatus = null,Object? submittedAt = null,Object? verifiedAt = freezed,Object? rejectionReason = freezed,}) {
  return _then(_KycModelNew(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,primaryIdType: null == primaryIdType ? _self.primaryIdType : primaryIdType // ignore: cast_nullable_to_non_nullable
as String,primaryIdNumber: null == primaryIdNumber ? _self.primaryIdNumber : primaryIdNumber // ignore: cast_nullable_to_non_nullable
as String,primaryIdFrontImage: null == primaryIdFrontImage ? _self.primaryIdFrontImage : primaryIdFrontImage // ignore: cast_nullable_to_non_nullable
as String,primaryIdBackImage: null == primaryIdBackImage ? _self.primaryIdBackImage : primaryIdBackImage // ignore: cast_nullable_to_non_nullable
as String,secondaryIdType: null == secondaryIdType ? _self.secondaryIdType : secondaryIdType // ignore: cast_nullable_to_non_nullable
as SecondaryIdType,secondaryIdNumber: null == secondaryIdNumber ? _self.secondaryIdNumber : secondaryIdNumber // ignore: cast_nullable_to_non_nullable
as String,secondaryIdImage: null == secondaryIdImage ? _self.secondaryIdImage : secondaryIdImage // ignore: cast_nullable_to_non_nullable
as String,selfieImage: null == selfieImage ? _self.selfieImage : selfieImage // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as PhilippineAddress,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as KycVerificationStatus,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of KycModelNew
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhilippineAddressCopyWith<$Res> get address {
  
  return $PhilippineAddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}

// dart format on
