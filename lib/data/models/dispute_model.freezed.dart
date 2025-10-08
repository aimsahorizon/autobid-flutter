// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dispute_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DisputeModel {

 String get id; String get transactionId; String get initiatorId; RefundReason get reason; String get description; List<String> get evidencePhotos; String? get evidenceVideo; DateTime get createdAt; String? get sellerResponse; List<String>? get sellerCounterEvidence; DateTime? get sellerRespondedAt; String? get adminDecision;// 'approved' or 'rejected'
 String? get adminNotes; DateTime? get resolvedAt;
/// Create a copy of DisputeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisputeModelCopyWith<DisputeModel> get copyWith => _$DisputeModelCopyWithImpl<DisputeModel>(this as DisputeModel, _$identity);

  /// Serializes this DisputeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisputeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.initiatorId, initiatorId) || other.initiatorId == initiatorId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.evidencePhotos, evidencePhotos)&&(identical(other.evidenceVideo, evidenceVideo) || other.evidenceVideo == evidenceVideo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.sellerResponse, sellerResponse) || other.sellerResponse == sellerResponse)&&const DeepCollectionEquality().equals(other.sellerCounterEvidence, sellerCounterEvidence)&&(identical(other.sellerRespondedAt, sellerRespondedAt) || other.sellerRespondedAt == sellerRespondedAt)&&(identical(other.adminDecision, adminDecision) || other.adminDecision == adminDecision)&&(identical(other.adminNotes, adminNotes) || other.adminNotes == adminNotes)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,transactionId,initiatorId,reason,description,const DeepCollectionEquality().hash(evidencePhotos),evidenceVideo,createdAt,sellerResponse,const DeepCollectionEquality().hash(sellerCounterEvidence),sellerRespondedAt,adminDecision,adminNotes,resolvedAt);

@override
String toString() {
  return 'DisputeModel(id: $id, transactionId: $transactionId, initiatorId: $initiatorId, reason: $reason, description: $description, evidencePhotos: $evidencePhotos, evidenceVideo: $evidenceVideo, createdAt: $createdAt, sellerResponse: $sellerResponse, sellerCounterEvidence: $sellerCounterEvidence, sellerRespondedAt: $sellerRespondedAt, adminDecision: $adminDecision, adminNotes: $adminNotes, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class $DisputeModelCopyWith<$Res>  {
  factory $DisputeModelCopyWith(DisputeModel value, $Res Function(DisputeModel) _then) = _$DisputeModelCopyWithImpl;
@useResult
$Res call({
 String id, String transactionId, String initiatorId, RefundReason reason, String description, List<String> evidencePhotos, String? evidenceVideo, DateTime createdAt, String? sellerResponse, List<String>? sellerCounterEvidence, DateTime? sellerRespondedAt, String? adminDecision, String? adminNotes, DateTime? resolvedAt
});




}
/// @nodoc
class _$DisputeModelCopyWithImpl<$Res>
    implements $DisputeModelCopyWith<$Res> {
  _$DisputeModelCopyWithImpl(this._self, this._then);

  final DisputeModel _self;
  final $Res Function(DisputeModel) _then;

/// Create a copy of DisputeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? transactionId = null,Object? initiatorId = null,Object? reason = null,Object? description = null,Object? evidencePhotos = null,Object? evidenceVideo = freezed,Object? createdAt = null,Object? sellerResponse = freezed,Object? sellerCounterEvidence = freezed,Object? sellerRespondedAt = freezed,Object? adminDecision = freezed,Object? adminNotes = freezed,Object? resolvedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,initiatorId: null == initiatorId ? _self.initiatorId : initiatorId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RefundReason,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,evidencePhotos: null == evidencePhotos ? _self.evidencePhotos : evidencePhotos // ignore: cast_nullable_to_non_nullable
as List<String>,evidenceVideo: freezed == evidenceVideo ? _self.evidenceVideo : evidenceVideo // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sellerResponse: freezed == sellerResponse ? _self.sellerResponse : sellerResponse // ignore: cast_nullable_to_non_nullable
as String?,sellerCounterEvidence: freezed == sellerCounterEvidence ? _self.sellerCounterEvidence : sellerCounterEvidence // ignore: cast_nullable_to_non_nullable
as List<String>?,sellerRespondedAt: freezed == sellerRespondedAt ? _self.sellerRespondedAt : sellerRespondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminDecision: freezed == adminDecision ? _self.adminDecision : adminDecision // ignore: cast_nullable_to_non_nullable
as String?,adminNotes: freezed == adminNotes ? _self.adminNotes : adminNotes // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DisputeModel].
extension DisputeModelPatterns on DisputeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DisputeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DisputeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DisputeModel value)  $default,){
final _that = this;
switch (_that) {
case _DisputeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DisputeModel value)?  $default,){
final _that = this;
switch (_that) {
case _DisputeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String transactionId,  String initiatorId,  RefundReason reason,  String description,  List<String> evidencePhotos,  String? evidenceVideo,  DateTime createdAt,  String? sellerResponse,  List<String>? sellerCounterEvidence,  DateTime? sellerRespondedAt,  String? adminDecision,  String? adminNotes,  DateTime? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DisputeModel() when $default != null:
return $default(_that.id,_that.transactionId,_that.initiatorId,_that.reason,_that.description,_that.evidencePhotos,_that.evidenceVideo,_that.createdAt,_that.sellerResponse,_that.sellerCounterEvidence,_that.sellerRespondedAt,_that.adminDecision,_that.adminNotes,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String transactionId,  String initiatorId,  RefundReason reason,  String description,  List<String> evidencePhotos,  String? evidenceVideo,  DateTime createdAt,  String? sellerResponse,  List<String>? sellerCounterEvidence,  DateTime? sellerRespondedAt,  String? adminDecision,  String? adminNotes,  DateTime? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _DisputeModel():
return $default(_that.id,_that.transactionId,_that.initiatorId,_that.reason,_that.description,_that.evidencePhotos,_that.evidenceVideo,_that.createdAt,_that.sellerResponse,_that.sellerCounterEvidence,_that.sellerRespondedAt,_that.adminDecision,_that.adminNotes,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String transactionId,  String initiatorId,  RefundReason reason,  String description,  List<String> evidencePhotos,  String? evidenceVideo,  DateTime createdAt,  String? sellerResponse,  List<String>? sellerCounterEvidence,  DateTime? sellerRespondedAt,  String? adminDecision,  String? adminNotes,  DateTime? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _DisputeModel() when $default != null:
return $default(_that.id,_that.transactionId,_that.initiatorId,_that.reason,_that.description,_that.evidencePhotos,_that.evidenceVideo,_that.createdAt,_that.sellerResponse,_that.sellerCounterEvidence,_that.sellerRespondedAt,_that.adminDecision,_that.adminNotes,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DisputeModel implements DisputeModel {
  const _DisputeModel({required this.id, required this.transactionId, required this.initiatorId, required this.reason, required this.description, required final  List<String> evidencePhotos, this.evidenceVideo, required this.createdAt, this.sellerResponse, final  List<String>? sellerCounterEvidence, this.sellerRespondedAt, this.adminDecision, this.adminNotes, this.resolvedAt}): _evidencePhotos = evidencePhotos,_sellerCounterEvidence = sellerCounterEvidence;
  factory _DisputeModel.fromJson(Map<String, dynamic> json) => _$DisputeModelFromJson(json);

@override final  String id;
@override final  String transactionId;
@override final  String initiatorId;
@override final  RefundReason reason;
@override final  String description;
 final  List<String> _evidencePhotos;
@override List<String> get evidencePhotos {
  if (_evidencePhotos is EqualUnmodifiableListView) return _evidencePhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_evidencePhotos);
}

@override final  String? evidenceVideo;
@override final  DateTime createdAt;
@override final  String? sellerResponse;
 final  List<String>? _sellerCounterEvidence;
@override List<String>? get sellerCounterEvidence {
  final value = _sellerCounterEvidence;
  if (value == null) return null;
  if (_sellerCounterEvidence is EqualUnmodifiableListView) return _sellerCounterEvidence;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DateTime? sellerRespondedAt;
@override final  String? adminDecision;
// 'approved' or 'rejected'
@override final  String? adminNotes;
@override final  DateTime? resolvedAt;

/// Create a copy of DisputeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisputeModelCopyWith<_DisputeModel> get copyWith => __$DisputeModelCopyWithImpl<_DisputeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DisputeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisputeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.initiatorId, initiatorId) || other.initiatorId == initiatorId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._evidencePhotos, _evidencePhotos)&&(identical(other.evidenceVideo, evidenceVideo) || other.evidenceVideo == evidenceVideo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.sellerResponse, sellerResponse) || other.sellerResponse == sellerResponse)&&const DeepCollectionEquality().equals(other._sellerCounterEvidence, _sellerCounterEvidence)&&(identical(other.sellerRespondedAt, sellerRespondedAt) || other.sellerRespondedAt == sellerRespondedAt)&&(identical(other.adminDecision, adminDecision) || other.adminDecision == adminDecision)&&(identical(other.adminNotes, adminNotes) || other.adminNotes == adminNotes)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,transactionId,initiatorId,reason,description,const DeepCollectionEquality().hash(_evidencePhotos),evidenceVideo,createdAt,sellerResponse,const DeepCollectionEquality().hash(_sellerCounterEvidence),sellerRespondedAt,adminDecision,adminNotes,resolvedAt);

@override
String toString() {
  return 'DisputeModel(id: $id, transactionId: $transactionId, initiatorId: $initiatorId, reason: $reason, description: $description, evidencePhotos: $evidencePhotos, evidenceVideo: $evidenceVideo, createdAt: $createdAt, sellerResponse: $sellerResponse, sellerCounterEvidence: $sellerCounterEvidence, sellerRespondedAt: $sellerRespondedAt, adminDecision: $adminDecision, adminNotes: $adminNotes, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$DisputeModelCopyWith<$Res> implements $DisputeModelCopyWith<$Res> {
  factory _$DisputeModelCopyWith(_DisputeModel value, $Res Function(_DisputeModel) _then) = __$DisputeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String transactionId, String initiatorId, RefundReason reason, String description, List<String> evidencePhotos, String? evidenceVideo, DateTime createdAt, String? sellerResponse, List<String>? sellerCounterEvidence, DateTime? sellerRespondedAt, String? adminDecision, String? adminNotes, DateTime? resolvedAt
});




}
/// @nodoc
class __$DisputeModelCopyWithImpl<$Res>
    implements _$DisputeModelCopyWith<$Res> {
  __$DisputeModelCopyWithImpl(this._self, this._then);

  final _DisputeModel _self;
  final $Res Function(_DisputeModel) _then;

/// Create a copy of DisputeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? transactionId = null,Object? initiatorId = null,Object? reason = null,Object? description = null,Object? evidencePhotos = null,Object? evidenceVideo = freezed,Object? createdAt = null,Object? sellerResponse = freezed,Object? sellerCounterEvidence = freezed,Object? sellerRespondedAt = freezed,Object? adminDecision = freezed,Object? adminNotes = freezed,Object? resolvedAt = freezed,}) {
  return _then(_DisputeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,initiatorId: null == initiatorId ? _self.initiatorId : initiatorId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RefundReason,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,evidencePhotos: null == evidencePhotos ? _self._evidencePhotos : evidencePhotos // ignore: cast_nullable_to_non_nullable
as List<String>,evidenceVideo: freezed == evidenceVideo ? _self.evidenceVideo : evidenceVideo // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sellerResponse: freezed == sellerResponse ? _self.sellerResponse : sellerResponse // ignore: cast_nullable_to_non_nullable
as String?,sellerCounterEvidence: freezed == sellerCounterEvidence ? _self._sellerCounterEvidence : sellerCounterEvidence // ignore: cast_nullable_to_non_nullable
as List<String>?,sellerRespondedAt: freezed == sellerRespondedAt ? _self.sellerRespondedAt : sellerRespondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminDecision: freezed == adminDecision ? _self.adminDecision : adminDecision // ignore: cast_nullable_to_non_nullable
as String?,adminNotes: freezed == adminNotes ? _self.adminNotes : adminNotes // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
