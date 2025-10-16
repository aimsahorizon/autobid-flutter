// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_transaction_confirmation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PreTransactionConfirmation {

 String get id; String get userId; String get userName; bool get vehicleDetailsConfirmed; String? get deliveryDate; String? get deliveryLocation; List<String> get uploadedDocuments; bool get termsAgreed; DateTime get confirmedAt; String? get notes;
/// Create a copy of PreTransactionConfirmation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreTransactionConfirmationCopyWith<PreTransactionConfirmation> get copyWith => _$PreTransactionConfirmationCopyWithImpl<PreTransactionConfirmation>(this as PreTransactionConfirmation, _$identity);

  /// Serializes this PreTransactionConfirmation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreTransactionConfirmation&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.vehicleDetailsConfirmed, vehicleDetailsConfirmed) || other.vehicleDetailsConfirmed == vehicleDetailsConfirmed)&&(identical(other.deliveryDate, deliveryDate) || other.deliveryDate == deliveryDate)&&(identical(other.deliveryLocation, deliveryLocation) || other.deliveryLocation == deliveryLocation)&&const DeepCollectionEquality().equals(other.uploadedDocuments, uploadedDocuments)&&(identical(other.termsAgreed, termsAgreed) || other.termsAgreed == termsAgreed)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,vehicleDetailsConfirmed,deliveryDate,deliveryLocation,const DeepCollectionEquality().hash(uploadedDocuments),termsAgreed,confirmedAt,notes);

@override
String toString() {
  return 'PreTransactionConfirmation(id: $id, userId: $userId, userName: $userName, vehicleDetailsConfirmed: $vehicleDetailsConfirmed, deliveryDate: $deliveryDate, deliveryLocation: $deliveryLocation, uploadedDocuments: $uploadedDocuments, termsAgreed: $termsAgreed, confirmedAt: $confirmedAt, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $PreTransactionConfirmationCopyWith<$Res>  {
  factory $PreTransactionConfirmationCopyWith(PreTransactionConfirmation value, $Res Function(PreTransactionConfirmation) _then) = _$PreTransactionConfirmationCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String userName, bool vehicleDetailsConfirmed, String? deliveryDate, String? deliveryLocation, List<String> uploadedDocuments, bool termsAgreed, DateTime confirmedAt, String? notes
});




}
/// @nodoc
class _$PreTransactionConfirmationCopyWithImpl<$Res>
    implements $PreTransactionConfirmationCopyWith<$Res> {
  _$PreTransactionConfirmationCopyWithImpl(this._self, this._then);

  final PreTransactionConfirmation _self;
  final $Res Function(PreTransactionConfirmation) _then;

/// Create a copy of PreTransactionConfirmation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? userName = null,Object? vehicleDetailsConfirmed = null,Object? deliveryDate = freezed,Object? deliveryLocation = freezed,Object? uploadedDocuments = null,Object? termsAgreed = null,Object? confirmedAt = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,vehicleDetailsConfirmed: null == vehicleDetailsConfirmed ? _self.vehicleDetailsConfirmed : vehicleDetailsConfirmed // ignore: cast_nullable_to_non_nullable
as bool,deliveryDate: freezed == deliveryDate ? _self.deliveryDate : deliveryDate // ignore: cast_nullable_to_non_nullable
as String?,deliveryLocation: freezed == deliveryLocation ? _self.deliveryLocation : deliveryLocation // ignore: cast_nullable_to_non_nullable
as String?,uploadedDocuments: null == uploadedDocuments ? _self.uploadedDocuments : uploadedDocuments // ignore: cast_nullable_to_non_nullable
as List<String>,termsAgreed: null == termsAgreed ? _self.termsAgreed : termsAgreed // ignore: cast_nullable_to_non_nullable
as bool,confirmedAt: null == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PreTransactionConfirmation].
extension PreTransactionConfirmationPatterns on PreTransactionConfirmation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreTransactionConfirmation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreTransactionConfirmation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreTransactionConfirmation value)  $default,){
final _that = this;
switch (_that) {
case _PreTransactionConfirmation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreTransactionConfirmation value)?  $default,){
final _that = this;
switch (_that) {
case _PreTransactionConfirmation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String userName,  bool vehicleDetailsConfirmed,  String? deliveryDate,  String? deliveryLocation,  List<String> uploadedDocuments,  bool termsAgreed,  DateTime confirmedAt,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreTransactionConfirmation() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.vehicleDetailsConfirmed,_that.deliveryDate,_that.deliveryLocation,_that.uploadedDocuments,_that.termsAgreed,_that.confirmedAt,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String userName,  bool vehicleDetailsConfirmed,  String? deliveryDate,  String? deliveryLocation,  List<String> uploadedDocuments,  bool termsAgreed,  DateTime confirmedAt,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _PreTransactionConfirmation():
return $default(_that.id,_that.userId,_that.userName,_that.vehicleDetailsConfirmed,_that.deliveryDate,_that.deliveryLocation,_that.uploadedDocuments,_that.termsAgreed,_that.confirmedAt,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String userName,  bool vehicleDetailsConfirmed,  String? deliveryDate,  String? deliveryLocation,  List<String> uploadedDocuments,  bool termsAgreed,  DateTime confirmedAt,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _PreTransactionConfirmation() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.vehicleDetailsConfirmed,_that.deliveryDate,_that.deliveryLocation,_that.uploadedDocuments,_that.termsAgreed,_that.confirmedAt,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreTransactionConfirmation implements PreTransactionConfirmation {
  const _PreTransactionConfirmation({required this.id, required this.userId, required this.userName, required this.vehicleDetailsConfirmed, this.deliveryDate, this.deliveryLocation, final  List<String> uploadedDocuments = const [], required this.termsAgreed, required this.confirmedAt, this.notes}): _uploadedDocuments = uploadedDocuments;
  factory _PreTransactionConfirmation.fromJson(Map<String, dynamic> json) => _$PreTransactionConfirmationFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String userName;
@override final  bool vehicleDetailsConfirmed;
@override final  String? deliveryDate;
@override final  String? deliveryLocation;
 final  List<String> _uploadedDocuments;
@override@JsonKey() List<String> get uploadedDocuments {
  if (_uploadedDocuments is EqualUnmodifiableListView) return _uploadedDocuments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uploadedDocuments);
}

@override final  bool termsAgreed;
@override final  DateTime confirmedAt;
@override final  String? notes;

/// Create a copy of PreTransactionConfirmation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreTransactionConfirmationCopyWith<_PreTransactionConfirmation> get copyWith => __$PreTransactionConfirmationCopyWithImpl<_PreTransactionConfirmation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PreTransactionConfirmationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreTransactionConfirmation&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.vehicleDetailsConfirmed, vehicleDetailsConfirmed) || other.vehicleDetailsConfirmed == vehicleDetailsConfirmed)&&(identical(other.deliveryDate, deliveryDate) || other.deliveryDate == deliveryDate)&&(identical(other.deliveryLocation, deliveryLocation) || other.deliveryLocation == deliveryLocation)&&const DeepCollectionEquality().equals(other._uploadedDocuments, _uploadedDocuments)&&(identical(other.termsAgreed, termsAgreed) || other.termsAgreed == termsAgreed)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,vehicleDetailsConfirmed,deliveryDate,deliveryLocation,const DeepCollectionEquality().hash(_uploadedDocuments),termsAgreed,confirmedAt,notes);

@override
String toString() {
  return 'PreTransactionConfirmation(id: $id, userId: $userId, userName: $userName, vehicleDetailsConfirmed: $vehicleDetailsConfirmed, deliveryDate: $deliveryDate, deliveryLocation: $deliveryLocation, uploadedDocuments: $uploadedDocuments, termsAgreed: $termsAgreed, confirmedAt: $confirmedAt, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$PreTransactionConfirmationCopyWith<$Res> implements $PreTransactionConfirmationCopyWith<$Res> {
  factory _$PreTransactionConfirmationCopyWith(_PreTransactionConfirmation value, $Res Function(_PreTransactionConfirmation) _then) = __$PreTransactionConfirmationCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String userName, bool vehicleDetailsConfirmed, String? deliveryDate, String? deliveryLocation, List<String> uploadedDocuments, bool termsAgreed, DateTime confirmedAt, String? notes
});




}
/// @nodoc
class __$PreTransactionConfirmationCopyWithImpl<$Res>
    implements _$PreTransactionConfirmationCopyWith<$Res> {
  __$PreTransactionConfirmationCopyWithImpl(this._self, this._then);

  final _PreTransactionConfirmation _self;
  final $Res Function(_PreTransactionConfirmation) _then;

/// Create a copy of PreTransactionConfirmation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? userName = null,Object? vehicleDetailsConfirmed = null,Object? deliveryDate = freezed,Object? deliveryLocation = freezed,Object? uploadedDocuments = null,Object? termsAgreed = null,Object? confirmedAt = null,Object? notes = freezed,}) {
  return _then(_PreTransactionConfirmation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,vehicleDetailsConfirmed: null == vehicleDetailsConfirmed ? _self.vehicleDetailsConfirmed : vehicleDetailsConfirmed // ignore: cast_nullable_to_non_nullable
as bool,deliveryDate: freezed == deliveryDate ? _self.deliveryDate : deliveryDate // ignore: cast_nullable_to_non_nullable
as String?,deliveryLocation: freezed == deliveryLocation ? _self.deliveryLocation : deliveryLocation // ignore: cast_nullable_to_non_nullable
as String?,uploadedDocuments: null == uploadedDocuments ? _self._uploadedDocuments : uploadedDocuments // ignore: cast_nullable_to_non_nullable
as List<String>,termsAgreed: null == termsAgreed ? _self.termsAgreed : termsAgreed // ignore: cast_nullable_to_non_nullable
as bool,confirmedAt: null == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
