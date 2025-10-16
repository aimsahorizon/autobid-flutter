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
mixin _$PreTransaction {

 String get id; String get auctionId; String get carId; String get carTitle; String get buyerId; String get sellerId; String get buyerName; String get sellerName; double get finalBidAmount; PreTransactionStatus get status; List<PreTransactionMessage> get messages; PreTransactionConfirmation? get buyerConfirmation; PreTransactionConfirmation? get sellerConfirmation; DateTime get createdAt; DateTime? get discussionStartedAt; DateTime? get buyerConfirmedAt; DateTime? get sellerConfirmedAt; DateTime? get mutualConfirmationAt; DateTime? get readyForPaymentAt; String? get cancellationReason; DateTime? get cancelledAt;
/// Create a copy of PreTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreTransactionCopyWith<PreTransaction> get copyWith => _$PreTransactionCopyWithImpl<PreTransaction>(this as PreTransaction, _$identity);

  /// Serializes this PreTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.carId, carId) || other.carId == carId)&&(identical(other.carTitle, carTitle) || other.carTitle == carTitle)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.finalBidAmount, finalBidAmount) || other.finalBidAmount == finalBidAmount)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.buyerConfirmation, buyerConfirmation) || other.buyerConfirmation == buyerConfirmation)&&(identical(other.sellerConfirmation, sellerConfirmation) || other.sellerConfirmation == sellerConfirmation)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.discussionStartedAt, discussionStartedAt) || other.discussionStartedAt == discussionStartedAt)&&(identical(other.buyerConfirmedAt, buyerConfirmedAt) || other.buyerConfirmedAt == buyerConfirmedAt)&&(identical(other.sellerConfirmedAt, sellerConfirmedAt) || other.sellerConfirmedAt == sellerConfirmedAt)&&(identical(other.mutualConfirmationAt, mutualConfirmationAt) || other.mutualConfirmationAt == mutualConfirmationAt)&&(identical(other.readyForPaymentAt, readyForPaymentAt) || other.readyForPaymentAt == readyForPaymentAt)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,auctionId,carId,carTitle,buyerId,sellerId,buyerName,sellerName,finalBidAmount,status,const DeepCollectionEquality().hash(messages),buyerConfirmation,sellerConfirmation,createdAt,discussionStartedAt,buyerConfirmedAt,sellerConfirmedAt,mutualConfirmationAt,readyForPaymentAt,cancellationReason,cancelledAt]);

@override
String toString() {
  return 'PreTransaction(id: $id, auctionId: $auctionId, carId: $carId, carTitle: $carTitle, buyerId: $buyerId, sellerId: $sellerId, buyerName: $buyerName, sellerName: $sellerName, finalBidAmount: $finalBidAmount, status: $status, messages: $messages, buyerConfirmation: $buyerConfirmation, sellerConfirmation: $sellerConfirmation, createdAt: $createdAt, discussionStartedAt: $discussionStartedAt, buyerConfirmedAt: $buyerConfirmedAt, sellerConfirmedAt: $sellerConfirmedAt, mutualConfirmationAt: $mutualConfirmationAt, readyForPaymentAt: $readyForPaymentAt, cancellationReason: $cancellationReason, cancelledAt: $cancelledAt)';
}


}

/// @nodoc
abstract mixin class $PreTransactionCopyWith<$Res>  {
  factory $PreTransactionCopyWith(PreTransaction value, $Res Function(PreTransaction) _then) = _$PreTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String auctionId, String carId, String carTitle, String buyerId, String sellerId, String buyerName, String sellerName, double finalBidAmount, PreTransactionStatus status, List<PreTransactionMessage> messages, PreTransactionConfirmation? buyerConfirmation, PreTransactionConfirmation? sellerConfirmation, DateTime createdAt, DateTime? discussionStartedAt, DateTime? buyerConfirmedAt, DateTime? sellerConfirmedAt, DateTime? mutualConfirmationAt, DateTime? readyForPaymentAt, String? cancellationReason, DateTime? cancelledAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? auctionId = null,Object? carId = null,Object? carTitle = null,Object? buyerId = null,Object? sellerId = null,Object? buyerName = null,Object? sellerName = null,Object? finalBidAmount = null,Object? status = null,Object? messages = null,Object? buyerConfirmation = freezed,Object? sellerConfirmation = freezed,Object? createdAt = null,Object? discussionStartedAt = freezed,Object? buyerConfirmedAt = freezed,Object? sellerConfirmedAt = freezed,Object? mutualConfirmationAt = freezed,Object? readyForPaymentAt = freezed,Object? cancellationReason = freezed,Object? cancelledAt = freezed,}) {
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
as DateTime?,mutualConfirmationAt: freezed == mutualConfirmationAt ? _self.mutualConfirmationAt : mutualConfirmationAt // ignore: cast_nullable_to_non_nullable
as DateTime?,readyForPaymentAt: freezed == readyForPaymentAt ? _self.readyForPaymentAt : readyForPaymentAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String auctionId,  String carId,  String carTitle,  String buyerId,  String sellerId,  String buyerName,  String sellerName,  double finalBidAmount,  PreTransactionStatus status,  List<PreTransactionMessage> messages,  PreTransactionConfirmation? buyerConfirmation,  PreTransactionConfirmation? sellerConfirmation,  DateTime createdAt,  DateTime? discussionStartedAt,  DateTime? buyerConfirmedAt,  DateTime? sellerConfirmedAt,  DateTime? mutualConfirmationAt,  DateTime? readyForPaymentAt,  String? cancellationReason,  DateTime? cancelledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreTransaction() when $default != null:
return $default(_that.id,_that.auctionId,_that.carId,_that.carTitle,_that.buyerId,_that.sellerId,_that.buyerName,_that.sellerName,_that.finalBidAmount,_that.status,_that.messages,_that.buyerConfirmation,_that.sellerConfirmation,_that.createdAt,_that.discussionStartedAt,_that.buyerConfirmedAt,_that.sellerConfirmedAt,_that.mutualConfirmationAt,_that.readyForPaymentAt,_that.cancellationReason,_that.cancelledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String auctionId,  String carId,  String carTitle,  String buyerId,  String sellerId,  String buyerName,  String sellerName,  double finalBidAmount,  PreTransactionStatus status,  List<PreTransactionMessage> messages,  PreTransactionConfirmation? buyerConfirmation,  PreTransactionConfirmation? sellerConfirmation,  DateTime createdAt,  DateTime? discussionStartedAt,  DateTime? buyerConfirmedAt,  DateTime? sellerConfirmedAt,  DateTime? mutualConfirmationAt,  DateTime? readyForPaymentAt,  String? cancellationReason,  DateTime? cancelledAt)  $default,) {final _that = this;
switch (_that) {
case _PreTransaction():
return $default(_that.id,_that.auctionId,_that.carId,_that.carTitle,_that.buyerId,_that.sellerId,_that.buyerName,_that.sellerName,_that.finalBidAmount,_that.status,_that.messages,_that.buyerConfirmation,_that.sellerConfirmation,_that.createdAt,_that.discussionStartedAt,_that.buyerConfirmedAt,_that.sellerConfirmedAt,_that.mutualConfirmationAt,_that.readyForPaymentAt,_that.cancellationReason,_that.cancelledAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String auctionId,  String carId,  String carTitle,  String buyerId,  String sellerId,  String buyerName,  String sellerName,  double finalBidAmount,  PreTransactionStatus status,  List<PreTransactionMessage> messages,  PreTransactionConfirmation? buyerConfirmation,  PreTransactionConfirmation? sellerConfirmation,  DateTime createdAt,  DateTime? discussionStartedAt,  DateTime? buyerConfirmedAt,  DateTime? sellerConfirmedAt,  DateTime? mutualConfirmationAt,  DateTime? readyForPaymentAt,  String? cancellationReason,  DateTime? cancelledAt)?  $default,) {final _that = this;
switch (_that) {
case _PreTransaction() when $default != null:
return $default(_that.id,_that.auctionId,_that.carId,_that.carTitle,_that.buyerId,_that.sellerId,_that.buyerName,_that.sellerName,_that.finalBidAmount,_that.status,_that.messages,_that.buyerConfirmation,_that.sellerConfirmation,_that.createdAt,_that.discussionStartedAt,_that.buyerConfirmedAt,_that.sellerConfirmedAt,_that.mutualConfirmationAt,_that.readyForPaymentAt,_that.cancellationReason,_that.cancelledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreTransaction implements PreTransaction {
  const _PreTransaction({required this.id, required this.auctionId, required this.carId, required this.carTitle, required this.buyerId, required this.sellerId, required this.buyerName, required this.sellerName, required this.finalBidAmount, required this.status, final  List<PreTransactionMessage> messages = const [], this.buyerConfirmation, this.sellerConfirmation, required this.createdAt, this.discussionStartedAt, this.buyerConfirmedAt, this.sellerConfirmedAt, this.mutualConfirmationAt, this.readyForPaymentAt, this.cancellationReason, this.cancelledAt}): _messages = messages;
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
@override final  DateTime? mutualConfirmationAt;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.carId, carId) || other.carId == carId)&&(identical(other.carTitle, carTitle) || other.carTitle == carTitle)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.finalBidAmount, finalBidAmount) || other.finalBidAmount == finalBidAmount)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.buyerConfirmation, buyerConfirmation) || other.buyerConfirmation == buyerConfirmation)&&(identical(other.sellerConfirmation, sellerConfirmation) || other.sellerConfirmation == sellerConfirmation)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.discussionStartedAt, discussionStartedAt) || other.discussionStartedAt == discussionStartedAt)&&(identical(other.buyerConfirmedAt, buyerConfirmedAt) || other.buyerConfirmedAt == buyerConfirmedAt)&&(identical(other.sellerConfirmedAt, sellerConfirmedAt) || other.sellerConfirmedAt == sellerConfirmedAt)&&(identical(other.mutualConfirmationAt, mutualConfirmationAt) || other.mutualConfirmationAt == mutualConfirmationAt)&&(identical(other.readyForPaymentAt, readyForPaymentAt) || other.readyForPaymentAt == readyForPaymentAt)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,auctionId,carId,carTitle,buyerId,sellerId,buyerName,sellerName,finalBidAmount,status,const DeepCollectionEquality().hash(_messages),buyerConfirmation,sellerConfirmation,createdAt,discussionStartedAt,buyerConfirmedAt,sellerConfirmedAt,mutualConfirmationAt,readyForPaymentAt,cancellationReason,cancelledAt]);

@override
String toString() {
  return 'PreTransaction(id: $id, auctionId: $auctionId, carId: $carId, carTitle: $carTitle, buyerId: $buyerId, sellerId: $sellerId, buyerName: $buyerName, sellerName: $sellerName, finalBidAmount: $finalBidAmount, status: $status, messages: $messages, buyerConfirmation: $buyerConfirmation, sellerConfirmation: $sellerConfirmation, createdAt: $createdAt, discussionStartedAt: $discussionStartedAt, buyerConfirmedAt: $buyerConfirmedAt, sellerConfirmedAt: $sellerConfirmedAt, mutualConfirmationAt: $mutualConfirmationAt, readyForPaymentAt: $readyForPaymentAt, cancellationReason: $cancellationReason, cancelledAt: $cancelledAt)';
}


}

/// @nodoc
abstract mixin class _$PreTransactionCopyWith<$Res> implements $PreTransactionCopyWith<$Res> {
  factory _$PreTransactionCopyWith(_PreTransaction value, $Res Function(_PreTransaction) _then) = __$PreTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String auctionId, String carId, String carTitle, String buyerId, String sellerId, String buyerName, String sellerName, double finalBidAmount, PreTransactionStatus status, List<PreTransactionMessage> messages, PreTransactionConfirmation? buyerConfirmation, PreTransactionConfirmation? sellerConfirmation, DateTime createdAt, DateTime? discussionStartedAt, DateTime? buyerConfirmedAt, DateTime? sellerConfirmedAt, DateTime? mutualConfirmationAt, DateTime? readyForPaymentAt, String? cancellationReason, DateTime? cancelledAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? auctionId = null,Object? carId = null,Object? carTitle = null,Object? buyerId = null,Object? sellerId = null,Object? buyerName = null,Object? sellerName = null,Object? finalBidAmount = null,Object? status = null,Object? messages = null,Object? buyerConfirmation = freezed,Object? sellerConfirmation = freezed,Object? createdAt = null,Object? discussionStartedAt = freezed,Object? buyerConfirmedAt = freezed,Object? sellerConfirmedAt = freezed,Object? mutualConfirmationAt = freezed,Object? readyForPaymentAt = freezed,Object? cancellationReason = freezed,Object? cancelledAt = freezed,}) {
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
as DateTime?,mutualConfirmationAt: freezed == mutualConfirmationAt ? _self.mutualConfirmationAt : mutualConfirmationAt // ignore: cast_nullable_to_non_nullable
as DateTime?,readyForPaymentAt: freezed == readyForPaymentAt ? _self.readyForPaymentAt : readyForPaymentAt // ignore: cast_nullable_to_non_nullable
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
