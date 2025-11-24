// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditRequest {

 String get id; String get requestedBy;// 'buyer' or 'seller'
 String get requestedFrom;// 'buyer' or 'seller'
 String get field; String get currentValue; String get requestedValue; String get reason; DateTime get requestedAt; bool get resolved; DateTime? get resolvedAt;
/// Create a copy of EditRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditRequestCopyWith<EditRequest> get copyWith => _$EditRequestCopyWithImpl<EditRequest>(this as EditRequest, _$identity);

  /// Serializes this EditRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy)&&(identical(other.requestedFrom, requestedFrom) || other.requestedFrom == requestedFrom)&&(identical(other.field, field) || other.field == field)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.requestedValue, requestedValue) || other.requestedValue == requestedValue)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.resolved, resolved) || other.resolved == resolved)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,requestedBy,requestedFrom,field,currentValue,requestedValue,reason,requestedAt,resolved,resolvedAt);

@override
String toString() {
  return 'EditRequest(id: $id, requestedBy: $requestedBy, requestedFrom: $requestedFrom, field: $field, currentValue: $currentValue, requestedValue: $requestedValue, reason: $reason, requestedAt: $requestedAt, resolved: $resolved, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class $EditRequestCopyWith<$Res>  {
  factory $EditRequestCopyWith(EditRequest value, $Res Function(EditRequest) _then) = _$EditRequestCopyWithImpl;
@useResult
$Res call({
 String id, String requestedBy, String requestedFrom, String field, String currentValue, String requestedValue, String reason, DateTime requestedAt, bool resolved, DateTime? resolvedAt
});




}
/// @nodoc
class _$EditRequestCopyWithImpl<$Res>
    implements $EditRequestCopyWith<$Res> {
  _$EditRequestCopyWithImpl(this._self, this._then);

  final EditRequest _self;
  final $Res Function(EditRequest) _then;

/// Create a copy of EditRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? requestedBy = null,Object? requestedFrom = null,Object? field = null,Object? currentValue = null,Object? requestedValue = null,Object? reason = null,Object? requestedAt = null,Object? resolved = null,Object? resolvedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestedBy: null == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as String,requestedFrom: null == requestedFrom ? _self.requestedFrom : requestedFrom // ignore: cast_nullable_to_non_nullable
as String,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as String,requestedValue: null == requestedValue ? _self.requestedValue : requestedValue // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolved: null == resolved ? _self.resolved : resolved // ignore: cast_nullable_to_non_nullable
as bool,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EditRequest].
extension EditRequestPatterns on EditRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditRequest value)  $default,){
final _that = this;
switch (_that) {
case _EditRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditRequest value)?  $default,){
final _that = this;
switch (_that) {
case _EditRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String requestedBy,  String requestedFrom,  String field,  String currentValue,  String requestedValue,  String reason,  DateTime requestedAt,  bool resolved,  DateTime? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditRequest() when $default != null:
return $default(_that.id,_that.requestedBy,_that.requestedFrom,_that.field,_that.currentValue,_that.requestedValue,_that.reason,_that.requestedAt,_that.resolved,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String requestedBy,  String requestedFrom,  String field,  String currentValue,  String requestedValue,  String reason,  DateTime requestedAt,  bool resolved,  DateTime? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _EditRequest():
return $default(_that.id,_that.requestedBy,_that.requestedFrom,_that.field,_that.currentValue,_that.requestedValue,_that.reason,_that.requestedAt,_that.resolved,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String requestedBy,  String requestedFrom,  String field,  String currentValue,  String requestedValue,  String reason,  DateTime requestedAt,  bool resolved,  DateTime? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _EditRequest() when $default != null:
return $default(_that.id,_that.requestedBy,_that.requestedFrom,_that.field,_that.currentValue,_that.requestedValue,_that.reason,_that.requestedAt,_that.resolved,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EditRequest implements EditRequest {
  const _EditRequest({required this.id, required this.requestedBy, required this.requestedFrom, required this.field, required this.currentValue, required this.requestedValue, required this.reason, required this.requestedAt, this.resolved = false, this.resolvedAt});
  factory _EditRequest.fromJson(Map<String, dynamic> json) => _$EditRequestFromJson(json);

@override final  String id;
@override final  String requestedBy;
// 'buyer' or 'seller'
@override final  String requestedFrom;
// 'buyer' or 'seller'
@override final  String field;
@override final  String currentValue;
@override final  String requestedValue;
@override final  String reason;
@override final  DateTime requestedAt;
@override@JsonKey() final  bool resolved;
@override final  DateTime? resolvedAt;

/// Create a copy of EditRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditRequestCopyWith<_EditRequest> get copyWith => __$EditRequestCopyWithImpl<_EditRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EditRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy)&&(identical(other.requestedFrom, requestedFrom) || other.requestedFrom == requestedFrom)&&(identical(other.field, field) || other.field == field)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.requestedValue, requestedValue) || other.requestedValue == requestedValue)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.resolved, resolved) || other.resolved == resolved)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,requestedBy,requestedFrom,field,currentValue,requestedValue,reason,requestedAt,resolved,resolvedAt);

@override
String toString() {
  return 'EditRequest(id: $id, requestedBy: $requestedBy, requestedFrom: $requestedFrom, field: $field, currentValue: $currentValue, requestedValue: $requestedValue, reason: $reason, requestedAt: $requestedAt, resolved: $resolved, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$EditRequestCopyWith<$Res> implements $EditRequestCopyWith<$Res> {
  factory _$EditRequestCopyWith(_EditRequest value, $Res Function(_EditRequest) _then) = __$EditRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String requestedBy, String requestedFrom, String field, String currentValue, String requestedValue, String reason, DateTime requestedAt, bool resolved, DateTime? resolvedAt
});




}
/// @nodoc
class __$EditRequestCopyWithImpl<$Res>
    implements _$EditRequestCopyWith<$Res> {
  __$EditRequestCopyWithImpl(this._self, this._then);

  final _EditRequest _self;
  final $Res Function(_EditRequest) _then;

/// Create a copy of EditRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? requestedBy = null,Object? requestedFrom = null,Object? field = null,Object? currentValue = null,Object? requestedValue = null,Object? reason = null,Object? requestedAt = null,Object? resolved = null,Object? resolvedAt = freezed,}) {
  return _then(_EditRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestedBy: null == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as String,requestedFrom: null == requestedFrom ? _self.requestedFrom : requestedFrom // ignore: cast_nullable_to_non_nullable
as String,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as String,requestedValue: null == requestedValue ? _self.requestedValue : requestedValue // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolved: null == resolved ? _self.resolved : resolved // ignore: cast_nullable_to_non_nullable
as bool,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PreTransaction {

 String get id; String get auctionId; String get carId; String get carTitle; String get buyerId; String get sellerId; String get buyerName; String get sellerName; double get finalBidAmount; PreTransactionStatus get status; List<PreTransactionMessage> get messages; PreTransactionConfirmation? get buyerConfirmation; PreTransactionConfirmation? get sellerConfirmation; DateTime get createdAt; DateTime? get discussionStartedAt; DateTime? get buyerConfirmedAt; DateTime? get sellerConfirmedAt;// ===== COMBINED REVIEW PHASE =====
 DateTime? get mutualReviewStartedAt; bool get buyerMutualReviewApproved; bool get sellerMutualReviewApproved; List<EditRequest> get editRequests; DateTime? get mutualReviewCompletedAt; DateTime? get mutualConfirmationAt; DateTime? get adminReviewStartedAt; DateTime? get adminReviewCompletedAt; String? get adminReviewNotes; DateTime? get readyForPaymentAt;// New checkpoint timestamps (no escrow)
 DateTime? get preparingStartedAt; DateTime? get shippingStartedAt; DateTime? get deliveredAt; DateTime? get paymentSuccessAt; DateTime? get transactionCompletedAt; String? get cancellationReason; DateTime? get cancelledAt;// ===== RA 8792 COMPLIANT FIELDS =====
/// KYC verification for buyer (identity verification)
 KycVerification? get buyerVerification;/// KYC verification for seller (identity verification)
 KycVerification? get sellerVerification;/// Digital sale agreement (legally binding under RA 8792)
 DigitalAgreement? get digitalAgreement;/// Payment confirmation (electronic receipt under RA 8792)
 PaymentConfirmation? get paymentConfirmation;/// Handover confirmation (vehicle transfer documentation)
 HandoverConfirmation? get handoverConfirmation;/// Audit log entries (immutable record protected under RA 8792)
 List<AuditLogEntry> get auditLog;
/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreTransactionCopyWith<PreTransaction> get copyWith => _$PreTransactionCopyWithImpl<PreTransaction>(this as PreTransaction, _$identity);

  /// Serializes this PreTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.carId, carId) || other.carId == carId)&&(identical(other.carTitle, carTitle) || other.carTitle == carTitle)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.finalBidAmount, finalBidAmount) || other.finalBidAmount == finalBidAmount)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.buyerConfirmation, buyerConfirmation) || other.buyerConfirmation == buyerConfirmation)&&(identical(other.sellerConfirmation, sellerConfirmation) || other.sellerConfirmation == sellerConfirmation)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.discussionStartedAt, discussionStartedAt) || other.discussionStartedAt == discussionStartedAt)&&(identical(other.buyerConfirmedAt, buyerConfirmedAt) || other.buyerConfirmedAt == buyerConfirmedAt)&&(identical(other.sellerConfirmedAt, sellerConfirmedAt) || other.sellerConfirmedAt == sellerConfirmedAt)&&(identical(other.mutualReviewStartedAt, mutualReviewStartedAt) || other.mutualReviewStartedAt == mutualReviewStartedAt)&&(identical(other.buyerMutualReviewApproved, buyerMutualReviewApproved) || other.buyerMutualReviewApproved == buyerMutualReviewApproved)&&(identical(other.sellerMutualReviewApproved, sellerMutualReviewApproved) || other.sellerMutualReviewApproved == sellerMutualReviewApproved)&&const DeepCollectionEquality().equals(other.editRequests, editRequests)&&(identical(other.mutualReviewCompletedAt, mutualReviewCompletedAt) || other.mutualReviewCompletedAt == mutualReviewCompletedAt)&&(identical(other.mutualConfirmationAt, mutualConfirmationAt) || other.mutualConfirmationAt == mutualConfirmationAt)&&(identical(other.adminReviewStartedAt, adminReviewStartedAt) || other.adminReviewStartedAt == adminReviewStartedAt)&&(identical(other.adminReviewCompletedAt, adminReviewCompletedAt) || other.adminReviewCompletedAt == adminReviewCompletedAt)&&(identical(other.adminReviewNotes, adminReviewNotes) || other.adminReviewNotes == adminReviewNotes)&&(identical(other.readyForPaymentAt, readyForPaymentAt) || other.readyForPaymentAt == readyForPaymentAt)&&(identical(other.preparingStartedAt, preparingStartedAt) || other.preparingStartedAt == preparingStartedAt)&&(identical(other.shippingStartedAt, shippingStartedAt) || other.shippingStartedAt == shippingStartedAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.paymentSuccessAt, paymentSuccessAt) || other.paymentSuccessAt == paymentSuccessAt)&&(identical(other.transactionCompletedAt, transactionCompletedAt) || other.transactionCompletedAt == transactionCompletedAt)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.buyerVerification, buyerVerification) || other.buyerVerification == buyerVerification)&&(identical(other.sellerVerification, sellerVerification) || other.sellerVerification == sellerVerification)&&(identical(other.digitalAgreement, digitalAgreement) || other.digitalAgreement == digitalAgreement)&&(identical(other.paymentConfirmation, paymentConfirmation) || other.paymentConfirmation == paymentConfirmation)&&(identical(other.handoverConfirmation, handoverConfirmation) || other.handoverConfirmation == handoverConfirmation)&&const DeepCollectionEquality().equals(other.auditLog, auditLog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,auctionId,carId,carTitle,buyerId,sellerId,buyerName,sellerName,finalBidAmount,status,const DeepCollectionEquality().hash(messages),buyerConfirmation,sellerConfirmation,createdAt,discussionStartedAt,buyerConfirmedAt,sellerConfirmedAt,mutualReviewStartedAt,buyerMutualReviewApproved,sellerMutualReviewApproved,const DeepCollectionEquality().hash(editRequests),mutualReviewCompletedAt,mutualConfirmationAt,adminReviewStartedAt,adminReviewCompletedAt,adminReviewNotes,readyForPaymentAt,preparingStartedAt,shippingStartedAt,deliveredAt,paymentSuccessAt,transactionCompletedAt,cancellationReason,cancelledAt,buyerVerification,sellerVerification,digitalAgreement,paymentConfirmation,handoverConfirmation,const DeepCollectionEquality().hash(auditLog)]);

@override
String toString() {
  return 'PreTransaction(id: $id, auctionId: $auctionId, carId: $carId, carTitle: $carTitle, buyerId: $buyerId, sellerId: $sellerId, buyerName: $buyerName, sellerName: $sellerName, finalBidAmount: $finalBidAmount, status: $status, messages: $messages, buyerConfirmation: $buyerConfirmation, sellerConfirmation: $sellerConfirmation, createdAt: $createdAt, discussionStartedAt: $discussionStartedAt, buyerConfirmedAt: $buyerConfirmedAt, sellerConfirmedAt: $sellerConfirmedAt, mutualReviewStartedAt: $mutualReviewStartedAt, buyerMutualReviewApproved: $buyerMutualReviewApproved, sellerMutualReviewApproved: $sellerMutualReviewApproved, editRequests: $editRequests, mutualReviewCompletedAt: $mutualReviewCompletedAt, mutualConfirmationAt: $mutualConfirmationAt, adminReviewStartedAt: $adminReviewStartedAt, adminReviewCompletedAt: $adminReviewCompletedAt, adminReviewNotes: $adminReviewNotes, readyForPaymentAt: $readyForPaymentAt, preparingStartedAt: $preparingStartedAt, shippingStartedAt: $shippingStartedAt, deliveredAt: $deliveredAt, paymentSuccessAt: $paymentSuccessAt, transactionCompletedAt: $transactionCompletedAt, cancellationReason: $cancellationReason, cancelledAt: $cancelledAt, buyerVerification: $buyerVerification, sellerVerification: $sellerVerification, digitalAgreement: $digitalAgreement, paymentConfirmation: $paymentConfirmation, handoverConfirmation: $handoverConfirmation, auditLog: $auditLog)';
}


}

/// @nodoc
abstract mixin class $PreTransactionCopyWith<$Res>  {
  factory $PreTransactionCopyWith(PreTransaction value, $Res Function(PreTransaction) _then) = _$PreTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String auctionId, String carId, String carTitle, String buyerId, String sellerId, String buyerName, String sellerName, double finalBidAmount, PreTransactionStatus status, List<PreTransactionMessage> messages, PreTransactionConfirmation? buyerConfirmation, PreTransactionConfirmation? sellerConfirmation, DateTime createdAt, DateTime? discussionStartedAt, DateTime? buyerConfirmedAt, DateTime? sellerConfirmedAt, DateTime? mutualReviewStartedAt, bool buyerMutualReviewApproved, bool sellerMutualReviewApproved, List<EditRequest> editRequests, DateTime? mutualReviewCompletedAt, DateTime? mutualConfirmationAt, DateTime? adminReviewStartedAt, DateTime? adminReviewCompletedAt, String? adminReviewNotes, DateTime? readyForPaymentAt, DateTime? preparingStartedAt, DateTime? shippingStartedAt, DateTime? deliveredAt, DateTime? paymentSuccessAt, DateTime? transactionCompletedAt, String? cancellationReason, DateTime? cancelledAt, KycVerification? buyerVerification, KycVerification? sellerVerification, DigitalAgreement? digitalAgreement, PaymentConfirmation? paymentConfirmation, HandoverConfirmation? handoverConfirmation, List<AuditLogEntry> auditLog
});


$PreTransactionConfirmationCopyWith<$Res>? get buyerConfirmation;$PreTransactionConfirmationCopyWith<$Res>? get sellerConfirmation;$KycVerificationCopyWith<$Res>? get buyerVerification;$KycVerificationCopyWith<$Res>? get sellerVerification;$DigitalAgreementCopyWith<$Res>? get digitalAgreement;$PaymentConfirmationCopyWith<$Res>? get paymentConfirmation;$HandoverConfirmationCopyWith<$Res>? get handoverConfirmation;

}
/// @nodoc
class _$PreTransactionCopyWithImpl<$Res>
    implements $PreTransactionCopyWith<$Res> {
  _$PreTransactionCopyWithImpl(this._self, this._then);

  final PreTransaction _self;
  final $Res Function(PreTransaction) _then;

/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? auctionId = null,Object? carId = null,Object? carTitle = null,Object? buyerId = null,Object? sellerId = null,Object? buyerName = null,Object? sellerName = null,Object? finalBidAmount = null,Object? status = null,Object? messages = null,Object? buyerConfirmation = freezed,Object? sellerConfirmation = freezed,Object? createdAt = null,Object? discussionStartedAt = freezed,Object? buyerConfirmedAt = freezed,Object? sellerConfirmedAt = freezed,Object? mutualReviewStartedAt = freezed,Object? buyerMutualReviewApproved = null,Object? sellerMutualReviewApproved = null,Object? editRequests = null,Object? mutualReviewCompletedAt = freezed,Object? mutualConfirmationAt = freezed,Object? adminReviewStartedAt = freezed,Object? adminReviewCompletedAt = freezed,Object? adminReviewNotes = freezed,Object? readyForPaymentAt = freezed,Object? preparingStartedAt = freezed,Object? shippingStartedAt = freezed,Object? deliveredAt = freezed,Object? paymentSuccessAt = freezed,Object? transactionCompletedAt = freezed,Object? cancellationReason = freezed,Object? cancelledAt = freezed,Object? buyerVerification = freezed,Object? sellerVerification = freezed,Object? digitalAgreement = freezed,Object? paymentConfirmation = freezed,Object? handoverConfirmation = freezed,Object? auditLog = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,carId: null == carId ? _self.carId : carId // ignore: cast_nullable_to_non_nullable
as String,carTitle: null == carTitle ? _self.carTitle : carTitle // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,buyerName: null == buyerName ? _self.buyerName : buyerName // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,finalBidAmount: null == finalBidAmount ? _self.finalBidAmount : finalBidAmount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PreTransactionStatus,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<PreTransactionMessage>,buyerConfirmation: freezed == buyerConfirmation ? _self.buyerConfirmation : buyerConfirmation // ignore: cast_nullable_to_non_nullable
as PreTransactionConfirmation?,sellerConfirmation: freezed == sellerConfirmation ? _self.sellerConfirmation : sellerConfirmation // ignore: cast_nullable_to_non_nullable
as PreTransactionConfirmation?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,discussionStartedAt: freezed == discussionStartedAt ? _self.discussionStartedAt : discussionStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,buyerConfirmedAt: freezed == buyerConfirmedAt ? _self.buyerConfirmedAt : buyerConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sellerConfirmedAt: freezed == sellerConfirmedAt ? _self.sellerConfirmedAt : sellerConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,mutualReviewStartedAt: freezed == mutualReviewStartedAt ? _self.mutualReviewStartedAt : mutualReviewStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,buyerMutualReviewApproved: null == buyerMutualReviewApproved ? _self.buyerMutualReviewApproved : buyerMutualReviewApproved // ignore: cast_nullable_to_non_nullable
as bool,sellerMutualReviewApproved: null == sellerMutualReviewApproved ? _self.sellerMutualReviewApproved : sellerMutualReviewApproved // ignore: cast_nullable_to_non_nullable
as bool,editRequests: null == editRequests ? _self.editRequests : editRequests // ignore: cast_nullable_to_non_nullable
as List<EditRequest>,mutualReviewCompletedAt: freezed == mutualReviewCompletedAt ? _self.mutualReviewCompletedAt : mutualReviewCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,mutualConfirmationAt: freezed == mutualConfirmationAt ? _self.mutualConfirmationAt : mutualConfirmationAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminReviewStartedAt: freezed == adminReviewStartedAt ? _self.adminReviewStartedAt : adminReviewStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminReviewCompletedAt: freezed == adminReviewCompletedAt ? _self.adminReviewCompletedAt : adminReviewCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminReviewNotes: freezed == adminReviewNotes ? _self.adminReviewNotes : adminReviewNotes // ignore: cast_nullable_to_non_nullable
as String?,readyForPaymentAt: freezed == readyForPaymentAt ? _self.readyForPaymentAt : readyForPaymentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,preparingStartedAt: freezed == preparingStartedAt ? _self.preparingStartedAt : preparingStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,shippingStartedAt: freezed == shippingStartedAt ? _self.shippingStartedAt : shippingStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,paymentSuccessAt: freezed == paymentSuccessAt ? _self.paymentSuccessAt : paymentSuccessAt // ignore: cast_nullable_to_non_nullable
as DateTime?,transactionCompletedAt: freezed == transactionCompletedAt ? _self.transactionCompletedAt : transactionCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,buyerVerification: freezed == buyerVerification ? _self.buyerVerification : buyerVerification // ignore: cast_nullable_to_non_nullable
as KycVerification?,sellerVerification: freezed == sellerVerification ? _self.sellerVerification : sellerVerification // ignore: cast_nullable_to_non_nullable
as KycVerification?,digitalAgreement: freezed == digitalAgreement ? _self.digitalAgreement : digitalAgreement // ignore: cast_nullable_to_non_nullable
as DigitalAgreement?,paymentConfirmation: freezed == paymentConfirmation ? _self.paymentConfirmation : paymentConfirmation // ignore: cast_nullable_to_non_nullable
as PaymentConfirmation?,handoverConfirmation: freezed == handoverConfirmation ? _self.handoverConfirmation : handoverConfirmation // ignore: cast_nullable_to_non_nullable
as HandoverConfirmation?,auditLog: null == auditLog ? _self.auditLog : auditLog // ignore: cast_nullable_to_non_nullable
as List<AuditLogEntry>,
  ));
}
/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PreTransactionConfirmationCopyWith<$Res>? get buyerConfirmation {
    if (_self.buyerConfirmation == null) {
    return null;
  }

  return $PreTransactionConfirmationCopyWith<$Res>(_self.buyerConfirmation!, (value) {
    return _then(_self.copyWith(buyerConfirmation: value));
  });
}/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PreTransactionConfirmationCopyWith<$Res>? get sellerConfirmation {
    if (_self.sellerConfirmation == null) {
    return null;
  }

  return $PreTransactionConfirmationCopyWith<$Res>(_self.sellerConfirmation!, (value) {
    return _then(_self.copyWith(sellerConfirmation: value));
  });
}/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KycVerificationCopyWith<$Res>? get buyerVerification {
    if (_self.buyerVerification == null) {
    return null;
  }

  return $KycVerificationCopyWith<$Res>(_self.buyerVerification!, (value) {
    return _then(_self.copyWith(buyerVerification: value));
  });
}/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KycVerificationCopyWith<$Res>? get sellerVerification {
    if (_self.sellerVerification == null) {
    return null;
  }

  return $KycVerificationCopyWith<$Res>(_self.sellerVerification!, (value) {
    return _then(_self.copyWith(sellerVerification: value));
  });
}/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DigitalAgreementCopyWith<$Res>? get digitalAgreement {
    if (_self.digitalAgreement == null) {
    return null;
  }

  return $DigitalAgreementCopyWith<$Res>(_self.digitalAgreement!, (value) {
    return _then(_self.copyWith(digitalAgreement: value));
  });
}/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentConfirmationCopyWith<$Res>? get paymentConfirmation {
    if (_self.paymentConfirmation == null) {
    return null;
  }

  return $PaymentConfirmationCopyWith<$Res>(_self.paymentConfirmation!, (value) {
    return _then(_self.copyWith(paymentConfirmation: value));
  });
}/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HandoverConfirmationCopyWith<$Res>? get handoverConfirmation {
    if (_self.handoverConfirmation == null) {
    return null;
  }

  return $HandoverConfirmationCopyWith<$Res>(_self.handoverConfirmation!, (value) {
    return _then(_self.copyWith(handoverConfirmation: value));
  });
}
}


/// Adds pattern-matching-related methods to [PreTransaction].
extension PreTransactionPatterns on PreTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreTransaction value)  $default,){
final _that = this;
switch (_that) {
case _PreTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _PreTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String auctionId,  String carId,  String carTitle,  String buyerId,  String sellerId,  String buyerName,  String sellerName,  double finalBidAmount,  PreTransactionStatus status,  List<PreTransactionMessage> messages,  PreTransactionConfirmation? buyerConfirmation,  PreTransactionConfirmation? sellerConfirmation,  DateTime createdAt,  DateTime? discussionStartedAt,  DateTime? buyerConfirmedAt,  DateTime? sellerConfirmedAt,  DateTime? mutualReviewStartedAt,  bool buyerMutualReviewApproved,  bool sellerMutualReviewApproved,  List<EditRequest> editRequests,  DateTime? mutualReviewCompletedAt,  DateTime? mutualConfirmationAt,  DateTime? adminReviewStartedAt,  DateTime? adminReviewCompletedAt,  String? adminReviewNotes,  DateTime? readyForPaymentAt,  DateTime? preparingStartedAt,  DateTime? shippingStartedAt,  DateTime? deliveredAt,  DateTime? paymentSuccessAt,  DateTime? transactionCompletedAt,  String? cancellationReason,  DateTime? cancelledAt,  KycVerification? buyerVerification,  KycVerification? sellerVerification,  DigitalAgreement? digitalAgreement,  PaymentConfirmation? paymentConfirmation,  HandoverConfirmation? handoverConfirmation,  List<AuditLogEntry> auditLog)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreTransaction() when $default != null:
return $default(_that.id,_that.auctionId,_that.carId,_that.carTitle,_that.buyerId,_that.sellerId,_that.buyerName,_that.sellerName,_that.finalBidAmount,_that.status,_that.messages,_that.buyerConfirmation,_that.sellerConfirmation,_that.createdAt,_that.discussionStartedAt,_that.buyerConfirmedAt,_that.sellerConfirmedAt,_that.mutualReviewStartedAt,_that.buyerMutualReviewApproved,_that.sellerMutualReviewApproved,_that.editRequests,_that.mutualReviewCompletedAt,_that.mutualConfirmationAt,_that.adminReviewStartedAt,_that.adminReviewCompletedAt,_that.adminReviewNotes,_that.readyForPaymentAt,_that.preparingStartedAt,_that.shippingStartedAt,_that.deliveredAt,_that.paymentSuccessAt,_that.transactionCompletedAt,_that.cancellationReason,_that.cancelledAt,_that.buyerVerification,_that.sellerVerification,_that.digitalAgreement,_that.paymentConfirmation,_that.handoverConfirmation,_that.auditLog);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String auctionId,  String carId,  String carTitle,  String buyerId,  String sellerId,  String buyerName,  String sellerName,  double finalBidAmount,  PreTransactionStatus status,  List<PreTransactionMessage> messages,  PreTransactionConfirmation? buyerConfirmation,  PreTransactionConfirmation? sellerConfirmation,  DateTime createdAt,  DateTime? discussionStartedAt,  DateTime? buyerConfirmedAt,  DateTime? sellerConfirmedAt,  DateTime? mutualReviewStartedAt,  bool buyerMutualReviewApproved,  bool sellerMutualReviewApproved,  List<EditRequest> editRequests,  DateTime? mutualReviewCompletedAt,  DateTime? mutualConfirmationAt,  DateTime? adminReviewStartedAt,  DateTime? adminReviewCompletedAt,  String? adminReviewNotes,  DateTime? readyForPaymentAt,  DateTime? preparingStartedAt,  DateTime? shippingStartedAt,  DateTime? deliveredAt,  DateTime? paymentSuccessAt,  DateTime? transactionCompletedAt,  String? cancellationReason,  DateTime? cancelledAt,  KycVerification? buyerVerification,  KycVerification? sellerVerification,  DigitalAgreement? digitalAgreement,  PaymentConfirmation? paymentConfirmation,  HandoverConfirmation? handoverConfirmation,  List<AuditLogEntry> auditLog)  $default,) {final _that = this;
switch (_that) {
case _PreTransaction():
return $default(_that.id,_that.auctionId,_that.carId,_that.carTitle,_that.buyerId,_that.sellerId,_that.buyerName,_that.sellerName,_that.finalBidAmount,_that.status,_that.messages,_that.buyerConfirmation,_that.sellerConfirmation,_that.createdAt,_that.discussionStartedAt,_that.buyerConfirmedAt,_that.sellerConfirmedAt,_that.mutualReviewStartedAt,_that.buyerMutualReviewApproved,_that.sellerMutualReviewApproved,_that.editRequests,_that.mutualReviewCompletedAt,_that.mutualConfirmationAt,_that.adminReviewStartedAt,_that.adminReviewCompletedAt,_that.adminReviewNotes,_that.readyForPaymentAt,_that.preparingStartedAt,_that.shippingStartedAt,_that.deliveredAt,_that.paymentSuccessAt,_that.transactionCompletedAt,_that.cancellationReason,_that.cancelledAt,_that.buyerVerification,_that.sellerVerification,_that.digitalAgreement,_that.paymentConfirmation,_that.handoverConfirmation,_that.auditLog);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String auctionId,  String carId,  String carTitle,  String buyerId,  String sellerId,  String buyerName,  String sellerName,  double finalBidAmount,  PreTransactionStatus status,  List<PreTransactionMessage> messages,  PreTransactionConfirmation? buyerConfirmation,  PreTransactionConfirmation? sellerConfirmation,  DateTime createdAt,  DateTime? discussionStartedAt,  DateTime? buyerConfirmedAt,  DateTime? sellerConfirmedAt,  DateTime? mutualReviewStartedAt,  bool buyerMutualReviewApproved,  bool sellerMutualReviewApproved,  List<EditRequest> editRequests,  DateTime? mutualReviewCompletedAt,  DateTime? mutualConfirmationAt,  DateTime? adminReviewStartedAt,  DateTime? adminReviewCompletedAt,  String? adminReviewNotes,  DateTime? readyForPaymentAt,  DateTime? preparingStartedAt,  DateTime? shippingStartedAt,  DateTime? deliveredAt,  DateTime? paymentSuccessAt,  DateTime? transactionCompletedAt,  String? cancellationReason,  DateTime? cancelledAt,  KycVerification? buyerVerification,  KycVerification? sellerVerification,  DigitalAgreement? digitalAgreement,  PaymentConfirmation? paymentConfirmation,  HandoverConfirmation? handoverConfirmation,  List<AuditLogEntry> auditLog)?  $default,) {final _that = this;
switch (_that) {
case _PreTransaction() when $default != null:
return $default(_that.id,_that.auctionId,_that.carId,_that.carTitle,_that.buyerId,_that.sellerId,_that.buyerName,_that.sellerName,_that.finalBidAmount,_that.status,_that.messages,_that.buyerConfirmation,_that.sellerConfirmation,_that.createdAt,_that.discussionStartedAt,_that.buyerConfirmedAt,_that.sellerConfirmedAt,_that.mutualReviewStartedAt,_that.buyerMutualReviewApproved,_that.sellerMutualReviewApproved,_that.editRequests,_that.mutualReviewCompletedAt,_that.mutualConfirmationAt,_that.adminReviewStartedAt,_that.adminReviewCompletedAt,_that.adminReviewNotes,_that.readyForPaymentAt,_that.preparingStartedAt,_that.shippingStartedAt,_that.deliveredAt,_that.paymentSuccessAt,_that.transactionCompletedAt,_that.cancellationReason,_that.cancelledAt,_that.buyerVerification,_that.sellerVerification,_that.digitalAgreement,_that.paymentConfirmation,_that.handoverConfirmation,_that.auditLog);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreTransaction implements PreTransaction {
  const _PreTransaction({required this.id, required this.auctionId, required this.carId, required this.carTitle, required this.buyerId, required this.sellerId, required this.buyerName, required this.sellerName, required this.finalBidAmount, required this.status, final  List<PreTransactionMessage> messages = const [], this.buyerConfirmation, this.sellerConfirmation, required this.createdAt, this.discussionStartedAt, this.buyerConfirmedAt, this.sellerConfirmedAt, this.mutualReviewStartedAt, this.buyerMutualReviewApproved = false, this.sellerMutualReviewApproved = false, final  List<EditRequest> editRequests = const [], this.mutualReviewCompletedAt, this.mutualConfirmationAt, this.adminReviewStartedAt, this.adminReviewCompletedAt, this.adminReviewNotes, this.readyForPaymentAt, this.preparingStartedAt, this.shippingStartedAt, this.deliveredAt, this.paymentSuccessAt, this.transactionCompletedAt, this.cancellationReason, this.cancelledAt, this.buyerVerification, this.sellerVerification, this.digitalAgreement, this.paymentConfirmation, this.handoverConfirmation, final  List<AuditLogEntry> auditLog = const []}): _messages = messages,_editRequests = editRequests,_auditLog = auditLog;
  factory _PreTransaction.fromJson(Map<String, dynamic> json) => _$PreTransactionFromJson(json);

@override final  String id;
@override final  String auctionId;
@override final  String carId;
@override final  String carTitle;
@override final  String buyerId;
@override final  String sellerId;
@override final  String buyerName;
@override final  String sellerName;
@override final  double finalBidAmount;
@override final  PreTransactionStatus status;
 final  List<PreTransactionMessage> _messages;
@override@JsonKey() List<PreTransactionMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  PreTransactionConfirmation? buyerConfirmation;
@override final  PreTransactionConfirmation? sellerConfirmation;
@override final  DateTime createdAt;
@override final  DateTime? discussionStartedAt;
@override final  DateTime? buyerConfirmedAt;
@override final  DateTime? sellerConfirmedAt;
// ===== COMBINED REVIEW PHASE =====
@override final  DateTime? mutualReviewStartedAt;
@override@JsonKey() final  bool buyerMutualReviewApproved;
@override@JsonKey() final  bool sellerMutualReviewApproved;
 final  List<EditRequest> _editRequests;
@override@JsonKey() List<EditRequest> get editRequests {
  if (_editRequests is EqualUnmodifiableListView) return _editRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_editRequests);
}

@override final  DateTime? mutualReviewCompletedAt;
@override final  DateTime? mutualConfirmationAt;
@override final  DateTime? adminReviewStartedAt;
@override final  DateTime? adminReviewCompletedAt;
@override final  String? adminReviewNotes;
@override final  DateTime? readyForPaymentAt;
// New checkpoint timestamps (no escrow)
@override final  DateTime? preparingStartedAt;
@override final  DateTime? shippingStartedAt;
@override final  DateTime? deliveredAt;
@override final  DateTime? paymentSuccessAt;
@override final  DateTime? transactionCompletedAt;
@override final  String? cancellationReason;
@override final  DateTime? cancelledAt;
// ===== RA 8792 COMPLIANT FIELDS =====
/// KYC verification for buyer (identity verification)
@override final  KycVerification? buyerVerification;
/// KYC verification for seller (identity verification)
@override final  KycVerification? sellerVerification;
/// Digital sale agreement (legally binding under RA 8792)
@override final  DigitalAgreement? digitalAgreement;
/// Payment confirmation (electronic receipt under RA 8792)
@override final  PaymentConfirmation? paymentConfirmation;
/// Handover confirmation (vehicle transfer documentation)
@override final  HandoverConfirmation? handoverConfirmation;
/// Audit log entries (immutable record protected under RA 8792)
 final  List<AuditLogEntry> _auditLog;
/// Audit log entries (immutable record protected under RA 8792)
@override@JsonKey() List<AuditLogEntry> get auditLog {
  if (_auditLog is EqualUnmodifiableListView) return _auditLog;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_auditLog);
}


/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreTransactionCopyWith<_PreTransaction> get copyWith => __$PreTransactionCopyWithImpl<_PreTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PreTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.carId, carId) || other.carId == carId)&&(identical(other.carTitle, carTitle) || other.carTitle == carTitle)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.finalBidAmount, finalBidAmount) || other.finalBidAmount == finalBidAmount)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.buyerConfirmation, buyerConfirmation) || other.buyerConfirmation == buyerConfirmation)&&(identical(other.sellerConfirmation, sellerConfirmation) || other.sellerConfirmation == sellerConfirmation)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.discussionStartedAt, discussionStartedAt) || other.discussionStartedAt == discussionStartedAt)&&(identical(other.buyerConfirmedAt, buyerConfirmedAt) || other.buyerConfirmedAt == buyerConfirmedAt)&&(identical(other.sellerConfirmedAt, sellerConfirmedAt) || other.sellerConfirmedAt == sellerConfirmedAt)&&(identical(other.mutualReviewStartedAt, mutualReviewStartedAt) || other.mutualReviewStartedAt == mutualReviewStartedAt)&&(identical(other.buyerMutualReviewApproved, buyerMutualReviewApproved) || other.buyerMutualReviewApproved == buyerMutualReviewApproved)&&(identical(other.sellerMutualReviewApproved, sellerMutualReviewApproved) || other.sellerMutualReviewApproved == sellerMutualReviewApproved)&&const DeepCollectionEquality().equals(other._editRequests, _editRequests)&&(identical(other.mutualReviewCompletedAt, mutualReviewCompletedAt) || other.mutualReviewCompletedAt == mutualReviewCompletedAt)&&(identical(other.mutualConfirmationAt, mutualConfirmationAt) || other.mutualConfirmationAt == mutualConfirmationAt)&&(identical(other.adminReviewStartedAt, adminReviewStartedAt) || other.adminReviewStartedAt == adminReviewStartedAt)&&(identical(other.adminReviewCompletedAt, adminReviewCompletedAt) || other.adminReviewCompletedAt == adminReviewCompletedAt)&&(identical(other.adminReviewNotes, adminReviewNotes) || other.adminReviewNotes == adminReviewNotes)&&(identical(other.readyForPaymentAt, readyForPaymentAt) || other.readyForPaymentAt == readyForPaymentAt)&&(identical(other.preparingStartedAt, preparingStartedAt) || other.preparingStartedAt == preparingStartedAt)&&(identical(other.shippingStartedAt, shippingStartedAt) || other.shippingStartedAt == shippingStartedAt)&&(identical(other.deliveredAt, deliveredAt) || other.deliveredAt == deliveredAt)&&(identical(other.paymentSuccessAt, paymentSuccessAt) || other.paymentSuccessAt == paymentSuccessAt)&&(identical(other.transactionCompletedAt, transactionCompletedAt) || other.transactionCompletedAt == transactionCompletedAt)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.buyerVerification, buyerVerification) || other.buyerVerification == buyerVerification)&&(identical(other.sellerVerification, sellerVerification) || other.sellerVerification == sellerVerification)&&(identical(other.digitalAgreement, digitalAgreement) || other.digitalAgreement == digitalAgreement)&&(identical(other.paymentConfirmation, paymentConfirmation) || other.paymentConfirmation == paymentConfirmation)&&(identical(other.handoverConfirmation, handoverConfirmation) || other.handoverConfirmation == handoverConfirmation)&&const DeepCollectionEquality().equals(other._auditLog, _auditLog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,auctionId,carId,carTitle,buyerId,sellerId,buyerName,sellerName,finalBidAmount,status,const DeepCollectionEquality().hash(_messages),buyerConfirmation,sellerConfirmation,createdAt,discussionStartedAt,buyerConfirmedAt,sellerConfirmedAt,mutualReviewStartedAt,buyerMutualReviewApproved,sellerMutualReviewApproved,const DeepCollectionEquality().hash(_editRequests),mutualReviewCompletedAt,mutualConfirmationAt,adminReviewStartedAt,adminReviewCompletedAt,adminReviewNotes,readyForPaymentAt,preparingStartedAt,shippingStartedAt,deliveredAt,paymentSuccessAt,transactionCompletedAt,cancellationReason,cancelledAt,buyerVerification,sellerVerification,digitalAgreement,paymentConfirmation,handoverConfirmation,const DeepCollectionEquality().hash(_auditLog)]);

@override
String toString() {
  return 'PreTransaction(id: $id, auctionId: $auctionId, carId: $carId, carTitle: $carTitle, buyerId: $buyerId, sellerId: $sellerId, buyerName: $buyerName, sellerName: $sellerName, finalBidAmount: $finalBidAmount, status: $status, messages: $messages, buyerConfirmation: $buyerConfirmation, sellerConfirmation: $sellerConfirmation, createdAt: $createdAt, discussionStartedAt: $discussionStartedAt, buyerConfirmedAt: $buyerConfirmedAt, sellerConfirmedAt: $sellerConfirmedAt, mutualReviewStartedAt: $mutualReviewStartedAt, buyerMutualReviewApproved: $buyerMutualReviewApproved, sellerMutualReviewApproved: $sellerMutualReviewApproved, editRequests: $editRequests, mutualReviewCompletedAt: $mutualReviewCompletedAt, mutualConfirmationAt: $mutualConfirmationAt, adminReviewStartedAt: $adminReviewStartedAt, adminReviewCompletedAt: $adminReviewCompletedAt, adminReviewNotes: $adminReviewNotes, readyForPaymentAt: $readyForPaymentAt, preparingStartedAt: $preparingStartedAt, shippingStartedAt: $shippingStartedAt, deliveredAt: $deliveredAt, paymentSuccessAt: $paymentSuccessAt, transactionCompletedAt: $transactionCompletedAt, cancellationReason: $cancellationReason, cancelledAt: $cancelledAt, buyerVerification: $buyerVerification, sellerVerification: $sellerVerification, digitalAgreement: $digitalAgreement, paymentConfirmation: $paymentConfirmation, handoverConfirmation: $handoverConfirmation, auditLog: $auditLog)';
}


}

/// @nodoc
abstract mixin class _$PreTransactionCopyWith<$Res> implements $PreTransactionCopyWith<$Res> {
  factory _$PreTransactionCopyWith(_PreTransaction value, $Res Function(_PreTransaction) _then) = __$PreTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String auctionId, String carId, String carTitle, String buyerId, String sellerId, String buyerName, String sellerName, double finalBidAmount, PreTransactionStatus status, List<PreTransactionMessage> messages, PreTransactionConfirmation? buyerConfirmation, PreTransactionConfirmation? sellerConfirmation, DateTime createdAt, DateTime? discussionStartedAt, DateTime? buyerConfirmedAt, DateTime? sellerConfirmedAt, DateTime? mutualReviewStartedAt, bool buyerMutualReviewApproved, bool sellerMutualReviewApproved, List<EditRequest> editRequests, DateTime? mutualReviewCompletedAt, DateTime? mutualConfirmationAt, DateTime? adminReviewStartedAt, DateTime? adminReviewCompletedAt, String? adminReviewNotes, DateTime? readyForPaymentAt, DateTime? preparingStartedAt, DateTime? shippingStartedAt, DateTime? deliveredAt, DateTime? paymentSuccessAt, DateTime? transactionCompletedAt, String? cancellationReason, DateTime? cancelledAt, KycVerification? buyerVerification, KycVerification? sellerVerification, DigitalAgreement? digitalAgreement, PaymentConfirmation? paymentConfirmation, HandoverConfirmation? handoverConfirmation, List<AuditLogEntry> auditLog
});


@override $PreTransactionConfirmationCopyWith<$Res>? get buyerConfirmation;@override $PreTransactionConfirmationCopyWith<$Res>? get sellerConfirmation;@override $KycVerificationCopyWith<$Res>? get buyerVerification;@override $KycVerificationCopyWith<$Res>? get sellerVerification;@override $DigitalAgreementCopyWith<$Res>? get digitalAgreement;@override $PaymentConfirmationCopyWith<$Res>? get paymentConfirmation;@override $HandoverConfirmationCopyWith<$Res>? get handoverConfirmation;

}
/// @nodoc
class __$PreTransactionCopyWithImpl<$Res>
    implements _$PreTransactionCopyWith<$Res> {
  __$PreTransactionCopyWithImpl(this._self, this._then);

  final _PreTransaction _self;
  final $Res Function(_PreTransaction) _then;

/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? auctionId = null,Object? carId = null,Object? carTitle = null,Object? buyerId = null,Object? sellerId = null,Object? buyerName = null,Object? sellerName = null,Object? finalBidAmount = null,Object? status = null,Object? messages = null,Object? buyerConfirmation = freezed,Object? sellerConfirmation = freezed,Object? createdAt = null,Object? discussionStartedAt = freezed,Object? buyerConfirmedAt = freezed,Object? sellerConfirmedAt = freezed,Object? mutualReviewStartedAt = freezed,Object? buyerMutualReviewApproved = null,Object? sellerMutualReviewApproved = null,Object? editRequests = null,Object? mutualReviewCompletedAt = freezed,Object? mutualConfirmationAt = freezed,Object? adminReviewStartedAt = freezed,Object? adminReviewCompletedAt = freezed,Object? adminReviewNotes = freezed,Object? readyForPaymentAt = freezed,Object? preparingStartedAt = freezed,Object? shippingStartedAt = freezed,Object? deliveredAt = freezed,Object? paymentSuccessAt = freezed,Object? transactionCompletedAt = freezed,Object? cancellationReason = freezed,Object? cancelledAt = freezed,Object? buyerVerification = freezed,Object? sellerVerification = freezed,Object? digitalAgreement = freezed,Object? paymentConfirmation = freezed,Object? handoverConfirmation = freezed,Object? auditLog = null,}) {
  return _then(_PreTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,carId: null == carId ? _self.carId : carId // ignore: cast_nullable_to_non_nullable
as String,carTitle: null == carTitle ? _self.carTitle : carTitle // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,buyerName: null == buyerName ? _self.buyerName : buyerName // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,finalBidAmount: null == finalBidAmount ? _self.finalBidAmount : finalBidAmount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PreTransactionStatus,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<PreTransactionMessage>,buyerConfirmation: freezed == buyerConfirmation ? _self.buyerConfirmation : buyerConfirmation // ignore: cast_nullable_to_non_nullable
as PreTransactionConfirmation?,sellerConfirmation: freezed == sellerConfirmation ? _self.sellerConfirmation : sellerConfirmation // ignore: cast_nullable_to_non_nullable
as PreTransactionConfirmation?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,discussionStartedAt: freezed == discussionStartedAt ? _self.discussionStartedAt : discussionStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,buyerConfirmedAt: freezed == buyerConfirmedAt ? _self.buyerConfirmedAt : buyerConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sellerConfirmedAt: freezed == sellerConfirmedAt ? _self.sellerConfirmedAt : sellerConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,mutualReviewStartedAt: freezed == mutualReviewStartedAt ? _self.mutualReviewStartedAt : mutualReviewStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,buyerMutualReviewApproved: null == buyerMutualReviewApproved ? _self.buyerMutualReviewApproved : buyerMutualReviewApproved // ignore: cast_nullable_to_non_nullable
as bool,sellerMutualReviewApproved: null == sellerMutualReviewApproved ? _self.sellerMutualReviewApproved : sellerMutualReviewApproved // ignore: cast_nullable_to_non_nullable
as bool,editRequests: null == editRequests ? _self._editRequests : editRequests // ignore: cast_nullable_to_non_nullable
as List<EditRequest>,mutualReviewCompletedAt: freezed == mutualReviewCompletedAt ? _self.mutualReviewCompletedAt : mutualReviewCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,mutualConfirmationAt: freezed == mutualConfirmationAt ? _self.mutualConfirmationAt : mutualConfirmationAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminReviewStartedAt: freezed == adminReviewStartedAt ? _self.adminReviewStartedAt : adminReviewStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminReviewCompletedAt: freezed == adminReviewCompletedAt ? _self.adminReviewCompletedAt : adminReviewCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminReviewNotes: freezed == adminReviewNotes ? _self.adminReviewNotes : adminReviewNotes // ignore: cast_nullable_to_non_nullable
as String?,readyForPaymentAt: freezed == readyForPaymentAt ? _self.readyForPaymentAt : readyForPaymentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,preparingStartedAt: freezed == preparingStartedAt ? _self.preparingStartedAt : preparingStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,shippingStartedAt: freezed == shippingStartedAt ? _self.shippingStartedAt : shippingStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deliveredAt: freezed == deliveredAt ? _self.deliveredAt : deliveredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,paymentSuccessAt: freezed == paymentSuccessAt ? _self.paymentSuccessAt : paymentSuccessAt // ignore: cast_nullable_to_non_nullable
as DateTime?,transactionCompletedAt: freezed == transactionCompletedAt ? _self.transactionCompletedAt : transactionCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,buyerVerification: freezed == buyerVerification ? _self.buyerVerification : buyerVerification // ignore: cast_nullable_to_non_nullable
as KycVerification?,sellerVerification: freezed == sellerVerification ? _self.sellerVerification : sellerVerification // ignore: cast_nullable_to_non_nullable
as KycVerification?,digitalAgreement: freezed == digitalAgreement ? _self.digitalAgreement : digitalAgreement // ignore: cast_nullable_to_non_nullable
as DigitalAgreement?,paymentConfirmation: freezed == paymentConfirmation ? _self.paymentConfirmation : paymentConfirmation // ignore: cast_nullable_to_non_nullable
as PaymentConfirmation?,handoverConfirmation: freezed == handoverConfirmation ? _self.handoverConfirmation : handoverConfirmation // ignore: cast_nullable_to_non_nullable
as HandoverConfirmation?,auditLog: null == auditLog ? _self._auditLog : auditLog // ignore: cast_nullable_to_non_nullable
as List<AuditLogEntry>,
  ));
}

/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PreTransactionConfirmationCopyWith<$Res>? get buyerConfirmation {
    if (_self.buyerConfirmation == null) {
    return null;
  }

  return $PreTransactionConfirmationCopyWith<$Res>(_self.buyerConfirmation!, (value) {
    return _then(_self.copyWith(buyerConfirmation: value));
  });
}/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PreTransactionConfirmationCopyWith<$Res>? get sellerConfirmation {
    if (_self.sellerConfirmation == null) {
    return null;
  }

  return $PreTransactionConfirmationCopyWith<$Res>(_self.sellerConfirmation!, (value) {
    return _then(_self.copyWith(sellerConfirmation: value));
  });
}/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KycVerificationCopyWith<$Res>? get buyerVerification {
    if (_self.buyerVerification == null) {
    return null;
  }

  return $KycVerificationCopyWith<$Res>(_self.buyerVerification!, (value) {
    return _then(_self.copyWith(buyerVerification: value));
  });
}/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KycVerificationCopyWith<$Res>? get sellerVerification {
    if (_self.sellerVerification == null) {
    return null;
  }

  return $KycVerificationCopyWith<$Res>(_self.sellerVerification!, (value) {
    return _then(_self.copyWith(sellerVerification: value));
  });
}/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DigitalAgreementCopyWith<$Res>? get digitalAgreement {
    if (_self.digitalAgreement == null) {
    return null;
  }

  return $DigitalAgreementCopyWith<$Res>(_self.digitalAgreement!, (value) {
    return _then(_self.copyWith(digitalAgreement: value));
  });
}/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentConfirmationCopyWith<$Res>? get paymentConfirmation {
    if (_self.paymentConfirmation == null) {
    return null;
  }

  return $PaymentConfirmationCopyWith<$Res>(_self.paymentConfirmation!, (value) {
    return _then(_self.copyWith(paymentConfirmation: value));
  });
}/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HandoverConfirmationCopyWith<$Res>? get handoverConfirmation {
    if (_self.handoverConfirmation == null) {
    return null;
  }

  return $HandoverConfirmationCopyWith<$Res>(_self.handoverConfirmation!, (value) {
    return _then(_self.copyWith(handoverConfirmation: value));
  });
}
}

// dart format on
