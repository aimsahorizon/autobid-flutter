// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyc_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KycModel {

 String get id; String get userId; IdType get idType; String get idNumber; String get idImageUrl; String? get secondaryIdImageUrl; String get selfieUrl; KycVerificationStatus get verificationStatus; DateTime get submittedAt; DateTime? get verifiedAt; String? get rejectionReason;
/// Create a copy of KycModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KycModelCopyWith<KycModel> get copyWith => _$KycModelCopyWithImpl<KycModel>(this as KycModel, _$identity);

  /// Serializes this KycModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KycModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.idType, idType) || other.idType == idType)&&(identical(other.idNumber, idNumber) || other.idNumber == idNumber)&&(identical(other.idImageUrl, idImageUrl) || other.idImageUrl == idImageUrl)&&(identical(other.secondaryIdImageUrl, secondaryIdImageUrl) || other.secondaryIdImageUrl == secondaryIdImageUrl)&&(identical(other.selfieUrl, selfieUrl) || other.selfieUrl == selfieUrl)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,idType,idNumber,idImageUrl,secondaryIdImageUrl,selfieUrl,verificationStatus,submittedAt,verifiedAt,rejectionReason);

@override
String toString() {
  return 'KycModel(id: $id, userId: $userId, idType: $idType, idNumber: $idNumber, idImageUrl: $idImageUrl, secondaryIdImageUrl: $secondaryIdImageUrl, selfieUrl: $selfieUrl, verificationStatus: $verificationStatus, submittedAt: $submittedAt, verifiedAt: $verifiedAt, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class $KycModelCopyWith<$Res>  {
  factory $KycModelCopyWith(KycModel value, $Res Function(KycModel) _then) = _$KycModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, IdType idType, String idNumber, String idImageUrl, String? secondaryIdImageUrl, String selfieUrl, KycVerificationStatus verificationStatus, DateTime submittedAt, DateTime? verifiedAt, String? rejectionReason
});




}
/// @nodoc
class _$KycModelCopyWithImpl<$Res>
    implements $KycModelCopyWith<$Res> {
  _$KycModelCopyWithImpl(this._self, this._then);

  final KycModel _self;
  final $Res Function(KycModel) _then;

/// Create a copy of KycModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? idType = null,Object? idNumber = null,Object? idImageUrl = null,Object? secondaryIdImageUrl = freezed,Object? selfieUrl = null,Object? verificationStatus = null,Object? submittedAt = null,Object? verifiedAt = freezed,Object? rejectionReason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,idType: null == idType ? _self.idType : idType // ignore: cast_nullable_to_non_nullable
as IdType,idNumber: null == idNumber ? _self.idNumber : idNumber // ignore: cast_nullable_to_non_nullable
as String,idImageUrl: null == idImageUrl ? _self.idImageUrl : idImageUrl // ignore: cast_nullable_to_non_nullable
as String,secondaryIdImageUrl: freezed == secondaryIdImageUrl ? _self.secondaryIdImageUrl : secondaryIdImageUrl // ignore: cast_nullable_to_non_nullable
as String?,selfieUrl: null == selfieUrl ? _self.selfieUrl : selfieUrl // ignore: cast_nullable_to_non_nullable
as String,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as KycVerificationStatus,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [KycModel].
extension KycModelPatterns on KycModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KycModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KycModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KycModel value)  $default,){
final _that = this;
switch (_that) {
case _KycModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KycModel value)?  $default,){
final _that = this;
switch (_that) {
case _KycModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  IdType idType,  String idNumber,  String idImageUrl,  String? secondaryIdImageUrl,  String selfieUrl,  KycVerificationStatus verificationStatus,  DateTime submittedAt,  DateTime? verifiedAt,  String? rejectionReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KycModel() when $default != null:
return $default(_that.id,_that.userId,_that.idType,_that.idNumber,_that.idImageUrl,_that.secondaryIdImageUrl,_that.selfieUrl,_that.verificationStatus,_that.submittedAt,_that.verifiedAt,_that.rejectionReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  IdType idType,  String idNumber,  String idImageUrl,  String? secondaryIdImageUrl,  String selfieUrl,  KycVerificationStatus verificationStatus,  DateTime submittedAt,  DateTime? verifiedAt,  String? rejectionReason)  $default,) {final _that = this;
switch (_that) {
case _KycModel():
return $default(_that.id,_that.userId,_that.idType,_that.idNumber,_that.idImageUrl,_that.secondaryIdImageUrl,_that.selfieUrl,_that.verificationStatus,_that.submittedAt,_that.verifiedAt,_that.rejectionReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  IdType idType,  String idNumber,  String idImageUrl,  String? secondaryIdImageUrl,  String selfieUrl,  KycVerificationStatus verificationStatus,  DateTime submittedAt,  DateTime? verifiedAt,  String? rejectionReason)?  $default,) {final _that = this;
switch (_that) {
case _KycModel() when $default != null:
return $default(_that.id,_that.userId,_that.idType,_that.idNumber,_that.idImageUrl,_that.secondaryIdImageUrl,_that.selfieUrl,_that.verificationStatus,_that.submittedAt,_that.verifiedAt,_that.rejectionReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KycModel implements KycModel {
  const _KycModel({required this.id, required this.userId, required this.idType, required this.idNumber, required this.idImageUrl, this.secondaryIdImageUrl, required this.selfieUrl, required this.verificationStatus, required this.submittedAt, this.verifiedAt, this.rejectionReason});
  factory _KycModel.fromJson(Map<String, dynamic> json) => _$KycModelFromJson(json);

@override final  String id;
@override final  String userId;
@override final  IdType idType;
@override final  String idNumber;
@override final  String idImageUrl;
@override final  String? secondaryIdImageUrl;
@override final  String selfieUrl;
@override final  KycVerificationStatus verificationStatus;
@override final  DateTime submittedAt;
@override final  DateTime? verifiedAt;
@override final  String? rejectionReason;

/// Create a copy of KycModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KycModelCopyWith<_KycModel> get copyWith => __$KycModelCopyWithImpl<_KycModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KycModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KycModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.idType, idType) || other.idType == idType)&&(identical(other.idNumber, idNumber) || other.idNumber == idNumber)&&(identical(other.idImageUrl, idImageUrl) || other.idImageUrl == idImageUrl)&&(identical(other.secondaryIdImageUrl, secondaryIdImageUrl) || other.secondaryIdImageUrl == secondaryIdImageUrl)&&(identical(other.selfieUrl, selfieUrl) || other.selfieUrl == selfieUrl)&&(identical(other.verificationStatus, verificationStatus) || other.verificationStatus == verificationStatus)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,idType,idNumber,idImageUrl,secondaryIdImageUrl,selfieUrl,verificationStatus,submittedAt,verifiedAt,rejectionReason);

@override
String toString() {
  return 'KycModel(id: $id, userId: $userId, idType: $idType, idNumber: $idNumber, idImageUrl: $idImageUrl, secondaryIdImageUrl: $secondaryIdImageUrl, selfieUrl: $selfieUrl, verificationStatus: $verificationStatus, submittedAt: $submittedAt, verifiedAt: $verifiedAt, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class _$KycModelCopyWith<$Res> implements $KycModelCopyWith<$Res> {
  factory _$KycModelCopyWith(_KycModel value, $Res Function(_KycModel) _then) = __$KycModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, IdType idType, String idNumber, String idImageUrl, String? secondaryIdImageUrl, String selfieUrl, KycVerificationStatus verificationStatus, DateTime submittedAt, DateTime? verifiedAt, String? rejectionReason
});




}
/// @nodoc
class __$KycModelCopyWithImpl<$Res>
    implements _$KycModelCopyWith<$Res> {
  __$KycModelCopyWithImpl(this._self, this._then);

  final _KycModel _self;
  final $Res Function(_KycModel) _then;

/// Create a copy of KycModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? idType = null,Object? idNumber = null,Object? idImageUrl = null,Object? secondaryIdImageUrl = freezed,Object? selfieUrl = null,Object? verificationStatus = null,Object? submittedAt = null,Object? verifiedAt = freezed,Object? rejectionReason = freezed,}) {
  return _then(_KycModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,idType: null == idType ? _self.idType : idType // ignore: cast_nullable_to_non_nullable
as IdType,idNumber: null == idNumber ? _self.idNumber : idNumber // ignore: cast_nullable_to_non_nullable
as String,idImageUrl: null == idImageUrl ? _self.idImageUrl : idImageUrl // ignore: cast_nullable_to_non_nullable
as String,secondaryIdImageUrl: freezed == secondaryIdImageUrl ? _self.secondaryIdImageUrl : secondaryIdImageUrl // ignore: cast_nullable_to_non_nullable
as String?,selfieUrl: null == selfieUrl ? _self.selfieUrl : selfieUrl // ignore: cast_nullable_to_non_nullable
as String,verificationStatus: null == verificationStatus ? _self.verificationStatus : verificationStatus // ignore: cast_nullable_to_non_nullable
as KycVerificationStatus,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
