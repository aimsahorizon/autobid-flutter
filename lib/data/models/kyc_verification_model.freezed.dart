// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyc_verification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KycVerification {

 String get id; String get userId; String get userName;// ===== GOVERNMENT ID VERIFICATION =====
/// Type of government-issued ID submitted
 GovernmentIdType get governmentIdType;/// ID number (encrypted in production, plain for mock)
 String get governmentIdNumber;/// URL to uploaded government ID photo (front and back)
 String get governmentIdPhotoUrl;/// URL to selfie photo holding ID
 String get selfiePhotoUrl;// ===== RA 8792 LEGAL COMPLIANCE =====
/// User consent that this verification is legally binding under RA 8792
/// "I agree that this verification and identity confirmation are legally
/// binding under the Electronic Commerce Act of 2000 (RA 8792)."
 bool get ra8792ConsentGiven;// ===== VERIFICATION METADATA =====
/// Timestamp when verification was completed (null if pending)
 DateTime? get verifiedAt;/// Current verification status
 KycVerificationStatus get status;/// Rejection reason if status is rejected
 String? get rejectionReason;/// Timestamp when verification was submitted
 DateTime get submittedAt;
/// Create a copy of KycVerification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KycVerificationCopyWith<KycVerification> get copyWith => _$KycVerificationCopyWithImpl<KycVerification>(this as KycVerification, _$identity);

  /// Serializes this KycVerification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KycVerification&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.governmentIdType, governmentIdType) || other.governmentIdType == governmentIdType)&&(identical(other.governmentIdNumber, governmentIdNumber) || other.governmentIdNumber == governmentIdNumber)&&(identical(other.governmentIdPhotoUrl, governmentIdPhotoUrl) || other.governmentIdPhotoUrl == governmentIdPhotoUrl)&&(identical(other.selfiePhotoUrl, selfiePhotoUrl) || other.selfiePhotoUrl == selfiePhotoUrl)&&(identical(other.ra8792ConsentGiven, ra8792ConsentGiven) || other.ra8792ConsentGiven == ra8792ConsentGiven)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,governmentIdType,governmentIdNumber,governmentIdPhotoUrl,selfiePhotoUrl,ra8792ConsentGiven,verifiedAt,status,rejectionReason,submittedAt);

@override
String toString() {
  return 'KycVerification(id: $id, userId: $userId, userName: $userName, governmentIdType: $governmentIdType, governmentIdNumber: $governmentIdNumber, governmentIdPhotoUrl: $governmentIdPhotoUrl, selfiePhotoUrl: $selfiePhotoUrl, ra8792ConsentGiven: $ra8792ConsentGiven, verifiedAt: $verifiedAt, status: $status, rejectionReason: $rejectionReason, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class $KycVerificationCopyWith<$Res>  {
  factory $KycVerificationCopyWith(KycVerification value, $Res Function(KycVerification) _then) = _$KycVerificationCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String userName, GovernmentIdType governmentIdType, String governmentIdNumber, String governmentIdPhotoUrl, String selfiePhotoUrl, bool ra8792ConsentGiven, DateTime? verifiedAt, KycVerificationStatus status, String? rejectionReason, DateTime submittedAt
});




}
/// @nodoc
class _$KycVerificationCopyWithImpl<$Res>
    implements $KycVerificationCopyWith<$Res> {
  _$KycVerificationCopyWithImpl(this._self, this._then);

  final KycVerification _self;
  final $Res Function(KycVerification) _then;

/// Create a copy of KycVerification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? userName = null,Object? governmentIdType = null,Object? governmentIdNumber = null,Object? governmentIdPhotoUrl = null,Object? selfiePhotoUrl = null,Object? ra8792ConsentGiven = null,Object? verifiedAt = freezed,Object? status = null,Object? rejectionReason = freezed,Object? submittedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,governmentIdType: null == governmentIdType ? _self.governmentIdType : governmentIdType // ignore: cast_nullable_to_non_nullable
as GovernmentIdType,governmentIdNumber: null == governmentIdNumber ? _self.governmentIdNumber : governmentIdNumber // ignore: cast_nullable_to_non_nullable
as String,governmentIdPhotoUrl: null == governmentIdPhotoUrl ? _self.governmentIdPhotoUrl : governmentIdPhotoUrl // ignore: cast_nullable_to_non_nullable
as String,selfiePhotoUrl: null == selfiePhotoUrl ? _self.selfiePhotoUrl : selfiePhotoUrl // ignore: cast_nullable_to_non_nullable
as String,ra8792ConsentGiven: null == ra8792ConsentGiven ? _self.ra8792ConsentGiven : ra8792ConsentGiven // ignore: cast_nullable_to_non_nullable
as bool,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as KycVerificationStatus,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [KycVerification].
extension KycVerificationPatterns on KycVerification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KycVerification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KycVerification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KycVerification value)  $default,){
final _that = this;
switch (_that) {
case _KycVerification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KycVerification value)?  $default,){
final _that = this;
switch (_that) {
case _KycVerification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String userName,  GovernmentIdType governmentIdType,  String governmentIdNumber,  String governmentIdPhotoUrl,  String selfiePhotoUrl,  bool ra8792ConsentGiven,  DateTime? verifiedAt,  KycVerificationStatus status,  String? rejectionReason,  DateTime submittedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KycVerification() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.governmentIdType,_that.governmentIdNumber,_that.governmentIdPhotoUrl,_that.selfiePhotoUrl,_that.ra8792ConsentGiven,_that.verifiedAt,_that.status,_that.rejectionReason,_that.submittedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String userName,  GovernmentIdType governmentIdType,  String governmentIdNumber,  String governmentIdPhotoUrl,  String selfiePhotoUrl,  bool ra8792ConsentGiven,  DateTime? verifiedAt,  KycVerificationStatus status,  String? rejectionReason,  DateTime submittedAt)  $default,) {final _that = this;
switch (_that) {
case _KycVerification():
return $default(_that.id,_that.userId,_that.userName,_that.governmentIdType,_that.governmentIdNumber,_that.governmentIdPhotoUrl,_that.selfiePhotoUrl,_that.ra8792ConsentGiven,_that.verifiedAt,_that.status,_that.rejectionReason,_that.submittedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String userName,  GovernmentIdType governmentIdType,  String governmentIdNumber,  String governmentIdPhotoUrl,  String selfiePhotoUrl,  bool ra8792ConsentGiven,  DateTime? verifiedAt,  KycVerificationStatus status,  String? rejectionReason,  DateTime submittedAt)?  $default,) {final _that = this;
switch (_that) {
case _KycVerification() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.governmentIdType,_that.governmentIdNumber,_that.governmentIdPhotoUrl,_that.selfiePhotoUrl,_that.ra8792ConsentGiven,_that.verifiedAt,_that.status,_that.rejectionReason,_that.submittedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KycVerification implements KycVerification {
  const _KycVerification({required this.id, required this.userId, required this.userName, required this.governmentIdType, required this.governmentIdNumber, required this.governmentIdPhotoUrl, required this.selfiePhotoUrl, this.ra8792ConsentGiven = false, this.verifiedAt, this.status = KycVerificationStatus.pending, this.rejectionReason, required this.submittedAt});
  factory _KycVerification.fromJson(Map<String, dynamic> json) => _$KycVerificationFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String userName;
// ===== GOVERNMENT ID VERIFICATION =====
/// Type of government-issued ID submitted
@override final  GovernmentIdType governmentIdType;
/// ID number (encrypted in production, plain for mock)
@override final  String governmentIdNumber;
/// URL to uploaded government ID photo (front and back)
@override final  String governmentIdPhotoUrl;
/// URL to selfie photo holding ID
@override final  String selfiePhotoUrl;
// ===== RA 8792 LEGAL COMPLIANCE =====
/// User consent that this verification is legally binding under RA 8792
/// "I agree that this verification and identity confirmation are legally
/// binding under the Electronic Commerce Act of 2000 (RA 8792)."
@override@JsonKey() final  bool ra8792ConsentGiven;
// ===== VERIFICATION METADATA =====
/// Timestamp when verification was completed (null if pending)
@override final  DateTime? verifiedAt;
/// Current verification status
@override@JsonKey() final  KycVerificationStatus status;
/// Rejection reason if status is rejected
@override final  String? rejectionReason;
/// Timestamp when verification was submitted
@override final  DateTime submittedAt;

/// Create a copy of KycVerification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KycVerificationCopyWith<_KycVerification> get copyWith => __$KycVerificationCopyWithImpl<_KycVerification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KycVerificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KycVerification&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.governmentIdType, governmentIdType) || other.governmentIdType == governmentIdType)&&(identical(other.governmentIdNumber, governmentIdNumber) || other.governmentIdNumber == governmentIdNumber)&&(identical(other.governmentIdPhotoUrl, governmentIdPhotoUrl) || other.governmentIdPhotoUrl == governmentIdPhotoUrl)&&(identical(other.selfiePhotoUrl, selfiePhotoUrl) || other.selfiePhotoUrl == selfiePhotoUrl)&&(identical(other.ra8792ConsentGiven, ra8792ConsentGiven) || other.ra8792ConsentGiven == ra8792ConsentGiven)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,governmentIdType,governmentIdNumber,governmentIdPhotoUrl,selfiePhotoUrl,ra8792ConsentGiven,verifiedAt,status,rejectionReason,submittedAt);

@override
String toString() {
  return 'KycVerification(id: $id, userId: $userId, userName: $userName, governmentIdType: $governmentIdType, governmentIdNumber: $governmentIdNumber, governmentIdPhotoUrl: $governmentIdPhotoUrl, selfiePhotoUrl: $selfiePhotoUrl, ra8792ConsentGiven: $ra8792ConsentGiven, verifiedAt: $verifiedAt, status: $status, rejectionReason: $rejectionReason, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class _$KycVerificationCopyWith<$Res> implements $KycVerificationCopyWith<$Res> {
  factory _$KycVerificationCopyWith(_KycVerification value, $Res Function(_KycVerification) _then) = __$KycVerificationCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String userName, GovernmentIdType governmentIdType, String governmentIdNumber, String governmentIdPhotoUrl, String selfiePhotoUrl, bool ra8792ConsentGiven, DateTime? verifiedAt, KycVerificationStatus status, String? rejectionReason, DateTime submittedAt
});




}
/// @nodoc
class __$KycVerificationCopyWithImpl<$Res>
    implements _$KycVerificationCopyWith<$Res> {
  __$KycVerificationCopyWithImpl(this._self, this._then);

  final _KycVerification _self;
  final $Res Function(_KycVerification) _then;

/// Create a copy of KycVerification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? userName = null,Object? governmentIdType = null,Object? governmentIdNumber = null,Object? governmentIdPhotoUrl = null,Object? selfiePhotoUrl = null,Object? ra8792ConsentGiven = null,Object? verifiedAt = freezed,Object? status = null,Object? rejectionReason = freezed,Object? submittedAt = null,}) {
  return _then(_KycVerification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,governmentIdType: null == governmentIdType ? _self.governmentIdType : governmentIdType // ignore: cast_nullable_to_non_nullable
as GovernmentIdType,governmentIdNumber: null == governmentIdNumber ? _self.governmentIdNumber : governmentIdNumber // ignore: cast_nullable_to_non_nullable
as String,governmentIdPhotoUrl: null == governmentIdPhotoUrl ? _self.governmentIdPhotoUrl : governmentIdPhotoUrl // ignore: cast_nullable_to_non_nullable
as String,selfiePhotoUrl: null == selfiePhotoUrl ? _self.selfiePhotoUrl : selfiePhotoUrl // ignore: cast_nullable_to_non_nullable
as String,ra8792ConsentGiven: null == ra8792ConsentGiven ? _self.ra8792ConsentGiven : ra8792ConsentGiven // ignore: cast_nullable_to_non_nullable
as bool,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as KycVerificationStatus,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
