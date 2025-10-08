// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_evidence_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransferEvidence {

 String get id; String get transactionId; String get buyerId; DateTime get submittedAt;// Documents
 String? get deedOfSaleUrl; String? get crOrTransferUrl; String? get officialReceiptUrl;// Vehicle photos
 List<String> get vehiclePhotoUrls; String? get odometerPhotoUrl; String? get vinPhotoUrl; int? get odometerReading;// Condition photos
 List<String> get conditionPhotoUrls; List<String>? get damagePhotoUrls;// Delivery receipt
 String? get deliveryReceiptUrl; String? get buyerNotes; bool get buyerSignature;// Validation
 ValidationStatus get status; DateTime? get validatedAt; String? get validatedBy; String? get rejectionReason;
/// Create a copy of TransferEvidence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferEvidenceCopyWith<TransferEvidence> get copyWith => _$TransferEvidenceCopyWithImpl<TransferEvidence>(this as TransferEvidence, _$identity);

  /// Serializes this TransferEvidence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferEvidence&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.deedOfSaleUrl, deedOfSaleUrl) || other.deedOfSaleUrl == deedOfSaleUrl)&&(identical(other.crOrTransferUrl, crOrTransferUrl) || other.crOrTransferUrl == crOrTransferUrl)&&(identical(other.officialReceiptUrl, officialReceiptUrl) || other.officialReceiptUrl == officialReceiptUrl)&&const DeepCollectionEquality().equals(other.vehiclePhotoUrls, vehiclePhotoUrls)&&(identical(other.odometerPhotoUrl, odometerPhotoUrl) || other.odometerPhotoUrl == odometerPhotoUrl)&&(identical(other.vinPhotoUrl, vinPhotoUrl) || other.vinPhotoUrl == vinPhotoUrl)&&(identical(other.odometerReading, odometerReading) || other.odometerReading == odometerReading)&&const DeepCollectionEquality().equals(other.conditionPhotoUrls, conditionPhotoUrls)&&const DeepCollectionEquality().equals(other.damagePhotoUrls, damagePhotoUrls)&&(identical(other.deliveryReceiptUrl, deliveryReceiptUrl) || other.deliveryReceiptUrl == deliveryReceiptUrl)&&(identical(other.buyerNotes, buyerNotes) || other.buyerNotes == buyerNotes)&&(identical(other.buyerSignature, buyerSignature) || other.buyerSignature == buyerSignature)&&(identical(other.status, status) || other.status == status)&&(identical(other.validatedAt, validatedAt) || other.validatedAt == validatedAt)&&(identical(other.validatedBy, validatedBy) || other.validatedBy == validatedBy)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,transactionId,buyerId,submittedAt,deedOfSaleUrl,crOrTransferUrl,officialReceiptUrl,const DeepCollectionEquality().hash(vehiclePhotoUrls),odometerPhotoUrl,vinPhotoUrl,odometerReading,const DeepCollectionEquality().hash(conditionPhotoUrls),const DeepCollectionEquality().hash(damagePhotoUrls),deliveryReceiptUrl,buyerNotes,buyerSignature,status,validatedAt,validatedBy,rejectionReason]);

@override
String toString() {
  return 'TransferEvidence(id: $id, transactionId: $transactionId, buyerId: $buyerId, submittedAt: $submittedAt, deedOfSaleUrl: $deedOfSaleUrl, crOrTransferUrl: $crOrTransferUrl, officialReceiptUrl: $officialReceiptUrl, vehiclePhotoUrls: $vehiclePhotoUrls, odometerPhotoUrl: $odometerPhotoUrl, vinPhotoUrl: $vinPhotoUrl, odometerReading: $odometerReading, conditionPhotoUrls: $conditionPhotoUrls, damagePhotoUrls: $damagePhotoUrls, deliveryReceiptUrl: $deliveryReceiptUrl, buyerNotes: $buyerNotes, buyerSignature: $buyerSignature, status: $status, validatedAt: $validatedAt, validatedBy: $validatedBy, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class $TransferEvidenceCopyWith<$Res>  {
  factory $TransferEvidenceCopyWith(TransferEvidence value, $Res Function(TransferEvidence) _then) = _$TransferEvidenceCopyWithImpl;
@useResult
$Res call({
 String id, String transactionId, String buyerId, DateTime submittedAt, String? deedOfSaleUrl, String? crOrTransferUrl, String? officialReceiptUrl, List<String> vehiclePhotoUrls, String? odometerPhotoUrl, String? vinPhotoUrl, int? odometerReading, List<String> conditionPhotoUrls, List<String>? damagePhotoUrls, String? deliveryReceiptUrl, String? buyerNotes, bool buyerSignature, ValidationStatus status, DateTime? validatedAt, String? validatedBy, String? rejectionReason
});




}
/// @nodoc
class _$TransferEvidenceCopyWithImpl<$Res>
    implements $TransferEvidenceCopyWith<$Res> {
  _$TransferEvidenceCopyWithImpl(this._self, this._then);

  final TransferEvidence _self;
  final $Res Function(TransferEvidence) _then;

/// Create a copy of TransferEvidence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? transactionId = null,Object? buyerId = null,Object? submittedAt = null,Object? deedOfSaleUrl = freezed,Object? crOrTransferUrl = freezed,Object? officialReceiptUrl = freezed,Object? vehiclePhotoUrls = null,Object? odometerPhotoUrl = freezed,Object? vinPhotoUrl = freezed,Object? odometerReading = freezed,Object? conditionPhotoUrls = null,Object? damagePhotoUrls = freezed,Object? deliveryReceiptUrl = freezed,Object? buyerNotes = freezed,Object? buyerSignature = null,Object? status = null,Object? validatedAt = freezed,Object? validatedBy = freezed,Object? rejectionReason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deedOfSaleUrl: freezed == deedOfSaleUrl ? _self.deedOfSaleUrl : deedOfSaleUrl // ignore: cast_nullable_to_non_nullable
as String?,crOrTransferUrl: freezed == crOrTransferUrl ? _self.crOrTransferUrl : crOrTransferUrl // ignore: cast_nullable_to_non_nullable
as String?,officialReceiptUrl: freezed == officialReceiptUrl ? _self.officialReceiptUrl : officialReceiptUrl // ignore: cast_nullable_to_non_nullable
as String?,vehiclePhotoUrls: null == vehiclePhotoUrls ? _self.vehiclePhotoUrls : vehiclePhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,odometerPhotoUrl: freezed == odometerPhotoUrl ? _self.odometerPhotoUrl : odometerPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,vinPhotoUrl: freezed == vinPhotoUrl ? _self.vinPhotoUrl : vinPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,odometerReading: freezed == odometerReading ? _self.odometerReading : odometerReading // ignore: cast_nullable_to_non_nullable
as int?,conditionPhotoUrls: null == conditionPhotoUrls ? _self.conditionPhotoUrls : conditionPhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,damagePhotoUrls: freezed == damagePhotoUrls ? _self.damagePhotoUrls : damagePhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,deliveryReceiptUrl: freezed == deliveryReceiptUrl ? _self.deliveryReceiptUrl : deliveryReceiptUrl // ignore: cast_nullable_to_non_nullable
as String?,buyerNotes: freezed == buyerNotes ? _self.buyerNotes : buyerNotes // ignore: cast_nullable_to_non_nullable
as String?,buyerSignature: null == buyerSignature ? _self.buyerSignature : buyerSignature // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ValidationStatus,validatedAt: freezed == validatedAt ? _self.validatedAt : validatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,validatedBy: freezed == validatedBy ? _self.validatedBy : validatedBy // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferEvidence].
extension TransferEvidencePatterns on TransferEvidence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferEvidence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferEvidence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferEvidence value)  $default,){
final _that = this;
switch (_that) {
case _TransferEvidence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferEvidence value)?  $default,){
final _that = this;
switch (_that) {
case _TransferEvidence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String transactionId,  String buyerId,  DateTime submittedAt,  String? deedOfSaleUrl,  String? crOrTransferUrl,  String? officialReceiptUrl,  List<String> vehiclePhotoUrls,  String? odometerPhotoUrl,  String? vinPhotoUrl,  int? odometerReading,  List<String> conditionPhotoUrls,  List<String>? damagePhotoUrls,  String? deliveryReceiptUrl,  String? buyerNotes,  bool buyerSignature,  ValidationStatus status,  DateTime? validatedAt,  String? validatedBy,  String? rejectionReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferEvidence() when $default != null:
return $default(_that.id,_that.transactionId,_that.buyerId,_that.submittedAt,_that.deedOfSaleUrl,_that.crOrTransferUrl,_that.officialReceiptUrl,_that.vehiclePhotoUrls,_that.odometerPhotoUrl,_that.vinPhotoUrl,_that.odometerReading,_that.conditionPhotoUrls,_that.damagePhotoUrls,_that.deliveryReceiptUrl,_that.buyerNotes,_that.buyerSignature,_that.status,_that.validatedAt,_that.validatedBy,_that.rejectionReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String transactionId,  String buyerId,  DateTime submittedAt,  String? deedOfSaleUrl,  String? crOrTransferUrl,  String? officialReceiptUrl,  List<String> vehiclePhotoUrls,  String? odometerPhotoUrl,  String? vinPhotoUrl,  int? odometerReading,  List<String> conditionPhotoUrls,  List<String>? damagePhotoUrls,  String? deliveryReceiptUrl,  String? buyerNotes,  bool buyerSignature,  ValidationStatus status,  DateTime? validatedAt,  String? validatedBy,  String? rejectionReason)  $default,) {final _that = this;
switch (_that) {
case _TransferEvidence():
return $default(_that.id,_that.transactionId,_that.buyerId,_that.submittedAt,_that.deedOfSaleUrl,_that.crOrTransferUrl,_that.officialReceiptUrl,_that.vehiclePhotoUrls,_that.odometerPhotoUrl,_that.vinPhotoUrl,_that.odometerReading,_that.conditionPhotoUrls,_that.damagePhotoUrls,_that.deliveryReceiptUrl,_that.buyerNotes,_that.buyerSignature,_that.status,_that.validatedAt,_that.validatedBy,_that.rejectionReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String transactionId,  String buyerId,  DateTime submittedAt,  String? deedOfSaleUrl,  String? crOrTransferUrl,  String? officialReceiptUrl,  List<String> vehiclePhotoUrls,  String? odometerPhotoUrl,  String? vinPhotoUrl,  int? odometerReading,  List<String> conditionPhotoUrls,  List<String>? damagePhotoUrls,  String? deliveryReceiptUrl,  String? buyerNotes,  bool buyerSignature,  ValidationStatus status,  DateTime? validatedAt,  String? validatedBy,  String? rejectionReason)?  $default,) {final _that = this;
switch (_that) {
case _TransferEvidence() when $default != null:
return $default(_that.id,_that.transactionId,_that.buyerId,_that.submittedAt,_that.deedOfSaleUrl,_that.crOrTransferUrl,_that.officialReceiptUrl,_that.vehiclePhotoUrls,_that.odometerPhotoUrl,_that.vinPhotoUrl,_that.odometerReading,_that.conditionPhotoUrls,_that.damagePhotoUrls,_that.deliveryReceiptUrl,_that.buyerNotes,_that.buyerSignature,_that.status,_that.validatedAt,_that.validatedBy,_that.rejectionReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferEvidence implements TransferEvidence {
  const _TransferEvidence({required this.id, required this.transactionId, required this.buyerId, required this.submittedAt, this.deedOfSaleUrl, this.crOrTransferUrl, this.officialReceiptUrl, required final  List<String> vehiclePhotoUrls, this.odometerPhotoUrl, this.vinPhotoUrl, this.odometerReading, required final  List<String> conditionPhotoUrls, final  List<String>? damagePhotoUrls, this.deliveryReceiptUrl, this.buyerNotes, this.buyerSignature = false, required this.status, this.validatedAt, this.validatedBy, this.rejectionReason}): _vehiclePhotoUrls = vehiclePhotoUrls,_conditionPhotoUrls = conditionPhotoUrls,_damagePhotoUrls = damagePhotoUrls;
  factory _TransferEvidence.fromJson(Map<String, dynamic> json) => _$TransferEvidenceFromJson(json);

@override final  String id;
@override final  String transactionId;
@override final  String buyerId;
@override final  DateTime submittedAt;
// Documents
@override final  String? deedOfSaleUrl;
@override final  String? crOrTransferUrl;
@override final  String? officialReceiptUrl;
// Vehicle photos
 final  List<String> _vehiclePhotoUrls;
// Vehicle photos
@override List<String> get vehiclePhotoUrls {
  if (_vehiclePhotoUrls is EqualUnmodifiableListView) return _vehiclePhotoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vehiclePhotoUrls);
}

@override final  String? odometerPhotoUrl;
@override final  String? vinPhotoUrl;
@override final  int? odometerReading;
// Condition photos
 final  List<String> _conditionPhotoUrls;
// Condition photos
@override List<String> get conditionPhotoUrls {
  if (_conditionPhotoUrls is EqualUnmodifiableListView) return _conditionPhotoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conditionPhotoUrls);
}

 final  List<String>? _damagePhotoUrls;
@override List<String>? get damagePhotoUrls {
  final value = _damagePhotoUrls;
  if (value == null) return null;
  if (_damagePhotoUrls is EqualUnmodifiableListView) return _damagePhotoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// Delivery receipt
@override final  String? deliveryReceiptUrl;
@override final  String? buyerNotes;
@override@JsonKey() final  bool buyerSignature;
// Validation
@override final  ValidationStatus status;
@override final  DateTime? validatedAt;
@override final  String? validatedBy;
@override final  String? rejectionReason;

/// Create a copy of TransferEvidence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferEvidenceCopyWith<_TransferEvidence> get copyWith => __$TransferEvidenceCopyWithImpl<_TransferEvidence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferEvidenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferEvidence&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.deedOfSaleUrl, deedOfSaleUrl) || other.deedOfSaleUrl == deedOfSaleUrl)&&(identical(other.crOrTransferUrl, crOrTransferUrl) || other.crOrTransferUrl == crOrTransferUrl)&&(identical(other.officialReceiptUrl, officialReceiptUrl) || other.officialReceiptUrl == officialReceiptUrl)&&const DeepCollectionEquality().equals(other._vehiclePhotoUrls, _vehiclePhotoUrls)&&(identical(other.odometerPhotoUrl, odometerPhotoUrl) || other.odometerPhotoUrl == odometerPhotoUrl)&&(identical(other.vinPhotoUrl, vinPhotoUrl) || other.vinPhotoUrl == vinPhotoUrl)&&(identical(other.odometerReading, odometerReading) || other.odometerReading == odometerReading)&&const DeepCollectionEquality().equals(other._conditionPhotoUrls, _conditionPhotoUrls)&&const DeepCollectionEquality().equals(other._damagePhotoUrls, _damagePhotoUrls)&&(identical(other.deliveryReceiptUrl, deliveryReceiptUrl) || other.deliveryReceiptUrl == deliveryReceiptUrl)&&(identical(other.buyerNotes, buyerNotes) || other.buyerNotes == buyerNotes)&&(identical(other.buyerSignature, buyerSignature) || other.buyerSignature == buyerSignature)&&(identical(other.status, status) || other.status == status)&&(identical(other.validatedAt, validatedAt) || other.validatedAt == validatedAt)&&(identical(other.validatedBy, validatedBy) || other.validatedBy == validatedBy)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,transactionId,buyerId,submittedAt,deedOfSaleUrl,crOrTransferUrl,officialReceiptUrl,const DeepCollectionEquality().hash(_vehiclePhotoUrls),odometerPhotoUrl,vinPhotoUrl,odometerReading,const DeepCollectionEquality().hash(_conditionPhotoUrls),const DeepCollectionEquality().hash(_damagePhotoUrls),deliveryReceiptUrl,buyerNotes,buyerSignature,status,validatedAt,validatedBy,rejectionReason]);

@override
String toString() {
  return 'TransferEvidence(id: $id, transactionId: $transactionId, buyerId: $buyerId, submittedAt: $submittedAt, deedOfSaleUrl: $deedOfSaleUrl, crOrTransferUrl: $crOrTransferUrl, officialReceiptUrl: $officialReceiptUrl, vehiclePhotoUrls: $vehiclePhotoUrls, odometerPhotoUrl: $odometerPhotoUrl, vinPhotoUrl: $vinPhotoUrl, odometerReading: $odometerReading, conditionPhotoUrls: $conditionPhotoUrls, damagePhotoUrls: $damagePhotoUrls, deliveryReceiptUrl: $deliveryReceiptUrl, buyerNotes: $buyerNotes, buyerSignature: $buyerSignature, status: $status, validatedAt: $validatedAt, validatedBy: $validatedBy, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class _$TransferEvidenceCopyWith<$Res> implements $TransferEvidenceCopyWith<$Res> {
  factory _$TransferEvidenceCopyWith(_TransferEvidence value, $Res Function(_TransferEvidence) _then) = __$TransferEvidenceCopyWithImpl;
@override @useResult
$Res call({
 String id, String transactionId, String buyerId, DateTime submittedAt, String? deedOfSaleUrl, String? crOrTransferUrl, String? officialReceiptUrl, List<String> vehiclePhotoUrls, String? odometerPhotoUrl, String? vinPhotoUrl, int? odometerReading, List<String> conditionPhotoUrls, List<String>? damagePhotoUrls, String? deliveryReceiptUrl, String? buyerNotes, bool buyerSignature, ValidationStatus status, DateTime? validatedAt, String? validatedBy, String? rejectionReason
});




}
/// @nodoc
class __$TransferEvidenceCopyWithImpl<$Res>
    implements _$TransferEvidenceCopyWith<$Res> {
  __$TransferEvidenceCopyWithImpl(this._self, this._then);

  final _TransferEvidence _self;
  final $Res Function(_TransferEvidence) _then;

/// Create a copy of TransferEvidence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? transactionId = null,Object? buyerId = null,Object? submittedAt = null,Object? deedOfSaleUrl = freezed,Object? crOrTransferUrl = freezed,Object? officialReceiptUrl = freezed,Object? vehiclePhotoUrls = null,Object? odometerPhotoUrl = freezed,Object? vinPhotoUrl = freezed,Object? odometerReading = freezed,Object? conditionPhotoUrls = null,Object? damagePhotoUrls = freezed,Object? deliveryReceiptUrl = freezed,Object? buyerNotes = freezed,Object? buyerSignature = null,Object? status = null,Object? validatedAt = freezed,Object? validatedBy = freezed,Object? rejectionReason = freezed,}) {
  return _then(_TransferEvidence(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deedOfSaleUrl: freezed == deedOfSaleUrl ? _self.deedOfSaleUrl : deedOfSaleUrl // ignore: cast_nullable_to_non_nullable
as String?,crOrTransferUrl: freezed == crOrTransferUrl ? _self.crOrTransferUrl : crOrTransferUrl // ignore: cast_nullable_to_non_nullable
as String?,officialReceiptUrl: freezed == officialReceiptUrl ? _self.officialReceiptUrl : officialReceiptUrl // ignore: cast_nullable_to_non_nullable
as String?,vehiclePhotoUrls: null == vehiclePhotoUrls ? _self._vehiclePhotoUrls : vehiclePhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,odometerPhotoUrl: freezed == odometerPhotoUrl ? _self.odometerPhotoUrl : odometerPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,vinPhotoUrl: freezed == vinPhotoUrl ? _self.vinPhotoUrl : vinPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,odometerReading: freezed == odometerReading ? _self.odometerReading : odometerReading // ignore: cast_nullable_to_non_nullable
as int?,conditionPhotoUrls: null == conditionPhotoUrls ? _self._conditionPhotoUrls : conditionPhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,damagePhotoUrls: freezed == damagePhotoUrls ? _self._damagePhotoUrls : damagePhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,deliveryReceiptUrl: freezed == deliveryReceiptUrl ? _self.deliveryReceiptUrl : deliveryReceiptUrl // ignore: cast_nullable_to_non_nullable
as String?,buyerNotes: freezed == buyerNotes ? _self.buyerNotes : buyerNotes // ignore: cast_nullable_to_non_nullable
as String?,buyerSignature: null == buyerSignature ? _self.buyerSignature : buyerSignature // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ValidationStatus,validatedAt: freezed == validatedAt ? _self.validatedAt : validatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,validatedBy: freezed == validatedBy ? _self.validatedBy : validatedBy // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
