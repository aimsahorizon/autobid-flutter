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
 DateTime? get mutualReviewStartedAt; bool get buyerMutualReviewApproved; bool get sellerMutualReviewApproved; List<EditRequest> get editRequests; DateTime? get mutualReviewCompletedAt; DateTime? get mutualConfirmationAt; DateTime? get adminReviewStartedAt; DateTime? get adminReviewCompletedAt; String? get adminReviewNotes; DateTime? get readyForPaymentAt; String? get cancellationReason; DateTime? get cancelledAt;
/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreTransactionCopyWith<PreTransaction> get copyWith => _$PreTransactionCopyWithImpl<PreTransaction>(this as PreTransaction, _$identity);

  /// Serializes this PreTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.carId, carId) || other.carId == carId)&&(identical(other.carTitle, carTitle) || other.carTitle == carTitle)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.finalBidAmount, finalBidAmount) || other.finalBidAmount == finalBidAmount)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.buyerConfirmation, buyerConfirmation) || other.buyerConfirmation == buyerConfirmation)&&(identical(other.sellerConfirmation, sellerConfirmation) || other.sellerConfirmation == sellerConfirmation)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.discussionStartedAt, discussionStartedAt) || other.discussionStartedAt == discussionStartedAt)&&(identical(other.buyerConfirmedAt, buyerConfirmedAt) || other.buyerConfirmedAt == buyerConfirmedAt)&&(identical(other.sellerConfirmedAt, sellerConfirmedAt) || other.sellerConfirmedAt == sellerConfirmedAt)&&(identical(other.mutualReviewStartedAt, mutualReviewStartedAt) || other.mutualReviewStartedAt == mutualReviewStartedAt)&&(identical(other.buyerMutualReviewApproved, buyerMutualReviewApproved) || other.buyerMutualReviewApproved == buyerMutualReviewApproved)&&(identical(other.sellerMutualReviewApproved, sellerMutualReviewApproved) || other.sellerMutualReviewApproved == sellerMutualReviewApproved)&&const DeepCollectionEquality().equals(other.editRequests, editRequests)&&(identical(other.mutualReviewCompletedAt, mutualReviewCompletedAt) || other.mutualReviewCompletedAt == mutualReviewCompletedAt)&&(identical(other.mutualConfirmationAt, mutualConfirmationAt) || other.mutualConfirmationAt == mutualConfirmationAt)&&(identical(other.adminReviewStartedAt, adminReviewStartedAt) || other.adminReviewStartedAt == adminReviewStartedAt)&&(identical(other.adminReviewCompletedAt, adminReviewCompletedAt) || other.adminReviewCompletedAt == adminReviewCompletedAt)&&(identical(other.adminReviewNotes, adminReviewNotes) || other.adminReviewNotes == adminReviewNotes)&&(identical(other.readyForPaymentAt, readyForPaymentAt) || other.readyForPaymentAt == readyForPaymentAt)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,auctionId,carId,carTitle,buyerId,sellerId,buyerName,sellerName,finalBidAmount,status,const DeepCollectionEquality().hash(messages),buyerConfirmation,sellerConfirmation,createdAt,discussionStartedAt,buyerConfirmedAt,sellerConfirmedAt,mutualReviewStartedAt,buyerMutualReviewApproved,sellerMutualReviewApproved,const DeepCollectionEquality().hash(editRequests),mutualReviewCompletedAt,mutualConfirmationAt,adminReviewStartedAt,adminReviewCompletedAt,adminReviewNotes,readyForPaymentAt,cancellationReason,cancelledAt]);

@override
String toString() {
  return 'PreTransaction(id: $id, auctionId: $auctionId, carId: $carId, carTitle: $carTitle, buyerId: $buyerId, sellerId: $sellerId, buyerName: $buyerName, sellerName: $sellerName, finalBidAmount: $finalBidAmount, status: $status, messages: $messages, buyerConfirmation: $buyerConfirmation, sellerConfirmation: $sellerConfirmation, createdAt: $createdAt, discussionStartedAt: $discussionStartedAt, buyerConfirmedAt: $buyerConfirmedAt, sellerConfirmedAt: $sellerConfirmedAt, mutualReviewStartedAt: $mutualReviewStartedAt, buyerMutualReviewApproved: $buyerMutualReviewApproved, sellerMutualReviewApproved: $sellerMutualReviewApproved, editRequests: $editRequests, mutualReviewCompletedAt: $mutualReviewCompletedAt, mutualConfirmationAt: $mutualConfirmationAt, adminReviewStartedAt: $adminReviewStartedAt, adminReviewCompletedAt: $adminReviewCompletedAt, adminReviewNotes: $adminReviewNotes, readyForPaymentAt: $readyForPaymentAt, cancellationReason: $cancellationReason, cancelledAt: $cancelledAt)';
}


}

/// @nodoc
abstract mixin class $PreTransactionCopyWith<$Res>  {
  factory $PreTransactionCopyWith(PreTransaction value, $Res Function(PreTransaction) _then) = _$PreTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String auctionId, String carId, String carTitle, String buyerId, String sellerId, String buyerName, String sellerName, double finalBidAmount, PreTransactionStatus status, List<PreTransactionMessage> messages, PreTransactionConfirmation? buyerConfirmation, PreTransactionConfirmation? sellerConfirmation, DateTime createdAt, DateTime? discussionStartedAt, DateTime? buyerConfirmedAt, DateTime? sellerConfirmedAt, DateTime? mutualReviewStartedAt, bool buyerMutualReviewApproved, bool sellerMutualReviewApproved, List<EditRequest> editRequests, DateTime? mutualReviewCompletedAt, DateTime? mutualConfirmationAt, DateTime? adminReviewStartedAt, DateTime? adminReviewCompletedAt, String? adminReviewNotes, DateTime? readyForPaymentAt, String? cancellationReason, DateTime? cancelledAt
});


$PreTransactionConfirmationCopyWith<$Res>? get buyerConfirmation;$PreTransactionConfirmationCopyWith<$Res>? get sellerConfirmation;

}
/// @nodoc
class _$PreTransactionCopyWithImpl<$Res>
    implements $PreTransactionCopyWith<$Res> {
  _$PreTransactionCopyWithImpl(this._self, this._then);

  final PreTransaction _self;
  final $Res Function(PreTransaction) _then;

/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? auctionId = null,Object? carId = null,Object? carTitle = null,Object? buyerId = null,Object? sellerId = null,Object? buyerName = null,Object? sellerName = null,Object? finalBidAmount = null,Object? status = null,Object? messages = null,Object? buyerConfirmation = freezed,Object? sellerConfirmation = freezed,Object? createdAt = null,Object? discussionStartedAt = freezed,Object? buyerConfirmedAt = freezed,Object? sellerConfirmedAt = freezed,Object? mutualReviewStartedAt = freezed,Object? buyerMutualReviewApproved = null,Object? sellerMutualReviewApproved = null,Object? editRequests = null,Object? mutualReviewCompletedAt = freezed,Object? mutualConfirmationAt = freezed,Object? adminReviewStartedAt = freezed,Object? adminReviewCompletedAt = freezed,Object? adminReviewNotes = freezed,Object? readyForPaymentAt = freezed,Object? cancellationReason = freezed,Object? cancelledAt = freezed,}) {
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
as DateTime?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String auctionId,  String carId,  String carTitle,  String buyerId,  String sellerId,  String buyerName,  String sellerName,  double finalBidAmount,  PreTransactionStatus status,  List<PreTransactionMessage> messages,  PreTransactionConfirmation? buyerConfirmation,  PreTransactionConfirmation? sellerConfirmation,  DateTime createdAt,  DateTime? discussionStartedAt,  DateTime? buyerConfirmedAt,  DateTime? sellerConfirmedAt,  DateTime? mutualReviewStartedAt,  bool buyerMutualReviewApproved,  bool sellerMutualReviewApproved,  List<EditRequest> editRequests,  DateTime? mutualReviewCompletedAt,  DateTime? mutualConfirmationAt,  DateTime? adminReviewStartedAt,  DateTime? adminReviewCompletedAt,  String? adminReviewNotes,  DateTime? readyForPaymentAt,  String? cancellationReason,  DateTime? cancelledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreTransaction() when $default != null:
return $default(_that.id,_that.auctionId,_that.carId,_that.carTitle,_that.buyerId,_that.sellerId,_that.buyerName,_that.sellerName,_that.finalBidAmount,_that.status,_that.messages,_that.buyerConfirmation,_that.sellerConfirmation,_that.createdAt,_that.discussionStartedAt,_that.buyerConfirmedAt,_that.sellerConfirmedAt,_that.mutualReviewStartedAt,_that.buyerMutualReviewApproved,_that.sellerMutualReviewApproved,_that.editRequests,_that.mutualReviewCompletedAt,_that.mutualConfirmationAt,_that.adminReviewStartedAt,_that.adminReviewCompletedAt,_that.adminReviewNotes,_that.readyForPaymentAt,_that.cancellationReason,_that.cancelledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String auctionId,  String carId,  String carTitle,  String buyerId,  String sellerId,  String buyerName,  String sellerName,  double finalBidAmount,  PreTransactionStatus status,  List<PreTransactionMessage> messages,  PreTransactionConfirmation? buyerConfirmation,  PreTransactionConfirmation? sellerConfirmation,  DateTime createdAt,  DateTime? discussionStartedAt,  DateTime? buyerConfirmedAt,  DateTime? sellerConfirmedAt,  DateTime? mutualReviewStartedAt,  bool buyerMutualReviewApproved,  bool sellerMutualReviewApproved,  List<EditRequest> editRequests,  DateTime? mutualReviewCompletedAt,  DateTime? mutualConfirmationAt,  DateTime? adminReviewStartedAt,  DateTime? adminReviewCompletedAt,  String? adminReviewNotes,  DateTime? readyForPaymentAt,  String? cancellationReason,  DateTime? cancelledAt)  $default,) {final _that = this;
switch (_that) {
case _PreTransaction():
return $default(_that.id,_that.auctionId,_that.carId,_that.carTitle,_that.buyerId,_that.sellerId,_that.buyerName,_that.sellerName,_that.finalBidAmount,_that.status,_that.messages,_that.buyerConfirmation,_that.sellerConfirmation,_that.createdAt,_that.discussionStartedAt,_that.buyerConfirmedAt,_that.sellerConfirmedAt,_that.mutualReviewStartedAt,_that.buyerMutualReviewApproved,_that.sellerMutualReviewApproved,_that.editRequests,_that.mutualReviewCompletedAt,_that.mutualConfirmationAt,_that.adminReviewStartedAt,_that.adminReviewCompletedAt,_that.adminReviewNotes,_that.readyForPaymentAt,_that.cancellationReason,_that.cancelledAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String auctionId,  String carId,  String carTitle,  String buyerId,  String sellerId,  String buyerName,  String sellerName,  double finalBidAmount,  PreTransactionStatus status,  List<PreTransactionMessage> messages,  PreTransactionConfirmation? buyerConfirmation,  PreTransactionConfirmation? sellerConfirmation,  DateTime createdAt,  DateTime? discussionStartedAt,  DateTime? buyerConfirmedAt,  DateTime? sellerConfirmedAt,  DateTime? mutualReviewStartedAt,  bool buyerMutualReviewApproved,  bool sellerMutualReviewApproved,  List<EditRequest> editRequests,  DateTime? mutualReviewCompletedAt,  DateTime? mutualConfirmationAt,  DateTime? adminReviewStartedAt,  DateTime? adminReviewCompletedAt,  String? adminReviewNotes,  DateTime? readyForPaymentAt,  String? cancellationReason,  DateTime? cancelledAt)?  $default,) {final _that = this;
switch (_that) {
case _PreTransaction() when $default != null:
return $default(_that.id,_that.auctionId,_that.carId,_that.carTitle,_that.buyerId,_that.sellerId,_that.buyerName,_that.sellerName,_that.finalBidAmount,_that.status,_that.messages,_that.buyerConfirmation,_that.sellerConfirmation,_that.createdAt,_that.discussionStartedAt,_that.buyerConfirmedAt,_that.sellerConfirmedAt,_that.mutualReviewStartedAt,_that.buyerMutualReviewApproved,_that.sellerMutualReviewApproved,_that.editRequests,_that.mutualReviewCompletedAt,_that.mutualConfirmationAt,_that.adminReviewStartedAt,_that.adminReviewCompletedAt,_that.adminReviewNotes,_that.readyForPaymentAt,_that.cancellationReason,_that.cancelledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreTransaction implements PreTransaction {
  const _PreTransaction({required this.id, required this.auctionId, required this.carId, required this.carTitle, required this.buyerId, required this.sellerId, required this.buyerName, required this.sellerName, required this.finalBidAmount, required this.status, final  List<PreTransactionMessage> messages = const [], this.buyerConfirmation, this.sellerConfirmation, required this.createdAt, this.discussionStartedAt, this.buyerConfirmedAt, this.sellerConfirmedAt, this.mutualReviewStartedAt, this.buyerMutualReviewApproved = false, this.sellerMutualReviewApproved = false, final  List<EditRequest> editRequests = const [], this.mutualReviewCompletedAt, this.mutualConfirmationAt, this.adminReviewStartedAt, this.adminReviewCompletedAt, this.adminReviewNotes, this.readyForPaymentAt, this.cancellationReason, this.cancelledAt}): _messages = messages,_editRequests = editRequests;
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
@override final  String? cancellationReason;
@override final  DateTime? cancelledAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.carId, carId) || other.carId == carId)&&(identical(other.carTitle, carTitle) || other.carTitle == carTitle)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.finalBidAmount, finalBidAmount) || other.finalBidAmount == finalBidAmount)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.buyerConfirmation, buyerConfirmation) || other.buyerConfirmation == buyerConfirmation)&&(identical(other.sellerConfirmation, sellerConfirmation) || other.sellerConfirmation == sellerConfirmation)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.discussionStartedAt, discussionStartedAt) || other.discussionStartedAt == discussionStartedAt)&&(identical(other.buyerConfirmedAt, buyerConfirmedAt) || other.buyerConfirmedAt == buyerConfirmedAt)&&(identical(other.sellerConfirmedAt, sellerConfirmedAt) || other.sellerConfirmedAt == sellerConfirmedAt)&&(identical(other.mutualReviewStartedAt, mutualReviewStartedAt) || other.mutualReviewStartedAt == mutualReviewStartedAt)&&(identical(other.buyerMutualReviewApproved, buyerMutualReviewApproved) || other.buyerMutualReviewApproved == buyerMutualReviewApproved)&&(identical(other.sellerMutualReviewApproved, sellerMutualReviewApproved) || other.sellerMutualReviewApproved == sellerMutualReviewApproved)&&const DeepCollectionEquality().equals(other._editRequests, _editRequests)&&(identical(other.mutualReviewCompletedAt, mutualReviewCompletedAt) || other.mutualReviewCompletedAt == mutualReviewCompletedAt)&&(identical(other.mutualConfirmationAt, mutualConfirmationAt) || other.mutualConfirmationAt == mutualConfirmationAt)&&(identical(other.adminReviewStartedAt, adminReviewStartedAt) || other.adminReviewStartedAt == adminReviewStartedAt)&&(identical(other.adminReviewCompletedAt, adminReviewCompletedAt) || other.adminReviewCompletedAt == adminReviewCompletedAt)&&(identical(other.adminReviewNotes, adminReviewNotes) || other.adminReviewNotes == adminReviewNotes)&&(identical(other.readyForPaymentAt, readyForPaymentAt) || other.readyForPaymentAt == readyForPaymentAt)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,auctionId,carId,carTitle,buyerId,sellerId,buyerName,sellerName,finalBidAmount,status,const DeepCollectionEquality().hash(_messages),buyerConfirmation,sellerConfirmation,createdAt,discussionStartedAt,buyerConfirmedAt,sellerConfirmedAt,mutualReviewStartedAt,buyerMutualReviewApproved,sellerMutualReviewApproved,const DeepCollectionEquality().hash(_editRequests),mutualReviewCompletedAt,mutualConfirmationAt,adminReviewStartedAt,adminReviewCompletedAt,adminReviewNotes,readyForPaymentAt,cancellationReason,cancelledAt]);

@override
String toString() {
  return 'PreTransaction(id: $id, auctionId: $auctionId, carId: $carId, carTitle: $carTitle, buyerId: $buyerId, sellerId: $sellerId, buyerName: $buyerName, sellerName: $sellerName, finalBidAmount: $finalBidAmount, status: $status, messages: $messages, buyerConfirmation: $buyerConfirmation, sellerConfirmation: $sellerConfirmation, createdAt: $createdAt, discussionStartedAt: $discussionStartedAt, buyerConfirmedAt: $buyerConfirmedAt, sellerConfirmedAt: $sellerConfirmedAt, mutualReviewStartedAt: $mutualReviewStartedAt, buyerMutualReviewApproved: $buyerMutualReviewApproved, sellerMutualReviewApproved: $sellerMutualReviewApproved, editRequests: $editRequests, mutualReviewCompletedAt: $mutualReviewCompletedAt, mutualConfirmationAt: $mutualConfirmationAt, adminReviewStartedAt: $adminReviewStartedAt, adminReviewCompletedAt: $adminReviewCompletedAt, adminReviewNotes: $adminReviewNotes, readyForPaymentAt: $readyForPaymentAt, cancellationReason: $cancellationReason, cancelledAt: $cancelledAt)';
}


}

/// @nodoc
abstract mixin class _$PreTransactionCopyWith<$Res> implements $PreTransactionCopyWith<$Res> {
  factory _$PreTransactionCopyWith(_PreTransaction value, $Res Function(_PreTransaction) _then) = __$PreTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String auctionId, String carId, String carTitle, String buyerId, String sellerId, String buyerName, String sellerName, double finalBidAmount, PreTransactionStatus status, List<PreTransactionMessage> messages, PreTransactionConfirmation? buyerConfirmation, PreTransactionConfirmation? sellerConfirmation, DateTime createdAt, DateTime? discussionStartedAt, DateTime? buyerConfirmedAt, DateTime? sellerConfirmedAt, DateTime? mutualReviewStartedAt, bool buyerMutualReviewApproved, bool sellerMutualReviewApproved, List<EditRequest> editRequests, DateTime? mutualReviewCompletedAt, DateTime? mutualConfirmationAt, DateTime? adminReviewStartedAt, DateTime? adminReviewCompletedAt, String? adminReviewNotes, DateTime? readyForPaymentAt, String? cancellationReason, DateTime? cancelledAt
});


@override $PreTransactionConfirmationCopyWith<$Res>? get buyerConfirmation;@override $PreTransactionConfirmationCopyWith<$Res>? get sellerConfirmation;

}
/// @nodoc
class __$PreTransactionCopyWithImpl<$Res>
    implements _$PreTransactionCopyWith<$Res> {
  __$PreTransactionCopyWithImpl(this._self, this._then);

  final _PreTransaction _self;
  final $Res Function(_PreTransaction) _then;

/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? auctionId = null,Object? carId = null,Object? carTitle = null,Object? buyerId = null,Object? sellerId = null,Object? buyerName = null,Object? sellerName = null,Object? finalBidAmount = null,Object? status = null,Object? messages = null,Object? buyerConfirmation = freezed,Object? sellerConfirmation = freezed,Object? createdAt = null,Object? discussionStartedAt = freezed,Object? buyerConfirmedAt = freezed,Object? sellerConfirmedAt = freezed,Object? mutualReviewStartedAt = freezed,Object? buyerMutualReviewApproved = null,Object? sellerMutualReviewApproved = null,Object? editRequests = null,Object? mutualReviewCompletedAt = freezed,Object? mutualConfirmationAt = freezed,Object? adminReviewStartedAt = freezed,Object? adminReviewCompletedAt = freezed,Object? adminReviewNotes = freezed,Object? readyForPaymentAt = freezed,Object? cancellationReason = freezed,Object? cancelledAt = freezed,}) {
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
as DateTime?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
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
}
}

// dart format on
