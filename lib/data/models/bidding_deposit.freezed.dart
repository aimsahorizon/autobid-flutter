// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bidding_deposit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BiddingDeposit {

 String get id; String get userId; double get amount;// Always ₱10,000 for now
 DepositStatus get status; DateTime get createdAt; DateTime? get paidAt; DateTime? get creditedAt; DateTime? get refundedAt; String? get transactionId;// Payment gateway transaction ID
 String? get paymentMethod;// GCash, PayMaya, etc.
 String? get paymentReference; String? get auctionIdCredited;// Which auction won that used this deposit
 double? get amountCredited;// How much was applied to buyer's premium
 double? get amountRefunded; String? get refundTransactionId; DateTime? get expiresAt;// Optional: deposit validity period
 String? get notes;// REVISED Model - Winner Choice
 DepositDisposition? get winnerDisposition;// Winner's choice: credit or refund
 bool? get isWinner;
/// Create a copy of BiddingDeposit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiddingDepositCopyWith<BiddingDeposit> get copyWith => _$BiddingDepositCopyWithImpl<BiddingDeposit>(this as BiddingDeposit, _$identity);

  /// Serializes this BiddingDeposit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiddingDeposit&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.creditedAt, creditedAt) || other.creditedAt == creditedAt)&&(identical(other.refundedAt, refundedAt) || other.refundedAt == refundedAt)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.auctionIdCredited, auctionIdCredited) || other.auctionIdCredited == auctionIdCredited)&&(identical(other.amountCredited, amountCredited) || other.amountCredited == amountCredited)&&(identical(other.amountRefunded, amountRefunded) || other.amountRefunded == amountRefunded)&&(identical(other.refundTransactionId, refundTransactionId) || other.refundTransactionId == refundTransactionId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.winnerDisposition, winnerDisposition) || other.winnerDisposition == winnerDisposition)&&(identical(other.isWinner, isWinner) || other.isWinner == isWinner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,amount,status,createdAt,paidAt,creditedAt,refundedAt,transactionId,paymentMethod,paymentReference,auctionIdCredited,amountCredited,amountRefunded,refundTransactionId,expiresAt,notes,winnerDisposition,isWinner]);

@override
String toString() {
  return 'BiddingDeposit(id: $id, userId: $userId, amount: $amount, status: $status, createdAt: $createdAt, paidAt: $paidAt, creditedAt: $creditedAt, refundedAt: $refundedAt, transactionId: $transactionId, paymentMethod: $paymentMethod, paymentReference: $paymentReference, auctionIdCredited: $auctionIdCredited, amountCredited: $amountCredited, amountRefunded: $amountRefunded, refundTransactionId: $refundTransactionId, expiresAt: $expiresAt, notes: $notes, winnerDisposition: $winnerDisposition, isWinner: $isWinner)';
}


}

/// @nodoc
abstract mixin class $BiddingDepositCopyWith<$Res>  {
  factory $BiddingDepositCopyWith(BiddingDeposit value, $Res Function(BiddingDeposit) _then) = _$BiddingDepositCopyWithImpl;
@useResult
$Res call({
 String id, String userId, double amount, DepositStatus status, DateTime createdAt, DateTime? paidAt, DateTime? creditedAt, DateTime? refundedAt, String? transactionId, String? paymentMethod, String? paymentReference, String? auctionIdCredited, double? amountCredited, double? amountRefunded, String? refundTransactionId, DateTime? expiresAt, String? notes, DepositDisposition? winnerDisposition, bool? isWinner
});




}
/// @nodoc
class _$BiddingDepositCopyWithImpl<$Res>
    implements $BiddingDepositCopyWith<$Res> {
  _$BiddingDepositCopyWithImpl(this._self, this._then);

  final BiddingDeposit _self;
  final $Res Function(BiddingDeposit) _then;

/// Create a copy of BiddingDeposit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? amount = null,Object? status = null,Object? createdAt = null,Object? paidAt = freezed,Object? creditedAt = freezed,Object? refundedAt = freezed,Object? transactionId = freezed,Object? paymentMethod = freezed,Object? paymentReference = freezed,Object? auctionIdCredited = freezed,Object? amountCredited = freezed,Object? amountRefunded = freezed,Object? refundTransactionId = freezed,Object? expiresAt = freezed,Object? notes = freezed,Object? winnerDisposition = freezed,Object? isWinner = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DepositStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,creditedAt: freezed == creditedAt ? _self.creditedAt : creditedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,refundedAt: freezed == refundedAt ? _self.refundedAt : refundedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,auctionIdCredited: freezed == auctionIdCredited ? _self.auctionIdCredited : auctionIdCredited // ignore: cast_nullable_to_non_nullable
as String?,amountCredited: freezed == amountCredited ? _self.amountCredited : amountCredited // ignore: cast_nullable_to_non_nullable
as double?,amountRefunded: freezed == amountRefunded ? _self.amountRefunded : amountRefunded // ignore: cast_nullable_to_non_nullable
as double?,refundTransactionId: freezed == refundTransactionId ? _self.refundTransactionId : refundTransactionId // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,winnerDisposition: freezed == winnerDisposition ? _self.winnerDisposition : winnerDisposition // ignore: cast_nullable_to_non_nullable
as DepositDisposition?,isWinner: freezed == isWinner ? _self.isWinner : isWinner // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [BiddingDeposit].
extension BiddingDepositPatterns on BiddingDeposit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BiddingDeposit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BiddingDeposit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BiddingDeposit value)  $default,){
final _that = this;
switch (_that) {
case _BiddingDeposit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BiddingDeposit value)?  $default,){
final _that = this;
switch (_that) {
case _BiddingDeposit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  double amount,  DepositStatus status,  DateTime createdAt,  DateTime? paidAt,  DateTime? creditedAt,  DateTime? refundedAt,  String? transactionId,  String? paymentMethod,  String? paymentReference,  String? auctionIdCredited,  double? amountCredited,  double? amountRefunded,  String? refundTransactionId,  DateTime? expiresAt,  String? notes,  DepositDisposition? winnerDisposition,  bool? isWinner)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiddingDeposit() when $default != null:
return $default(_that.id,_that.userId,_that.amount,_that.status,_that.createdAt,_that.paidAt,_that.creditedAt,_that.refundedAt,_that.transactionId,_that.paymentMethod,_that.paymentReference,_that.auctionIdCredited,_that.amountCredited,_that.amountRefunded,_that.refundTransactionId,_that.expiresAt,_that.notes,_that.winnerDisposition,_that.isWinner);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  double amount,  DepositStatus status,  DateTime createdAt,  DateTime? paidAt,  DateTime? creditedAt,  DateTime? refundedAt,  String? transactionId,  String? paymentMethod,  String? paymentReference,  String? auctionIdCredited,  double? amountCredited,  double? amountRefunded,  String? refundTransactionId,  DateTime? expiresAt,  String? notes,  DepositDisposition? winnerDisposition,  bool? isWinner)  $default,) {final _that = this;
switch (_that) {
case _BiddingDeposit():
return $default(_that.id,_that.userId,_that.amount,_that.status,_that.createdAt,_that.paidAt,_that.creditedAt,_that.refundedAt,_that.transactionId,_that.paymentMethod,_that.paymentReference,_that.auctionIdCredited,_that.amountCredited,_that.amountRefunded,_that.refundTransactionId,_that.expiresAt,_that.notes,_that.winnerDisposition,_that.isWinner);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  double amount,  DepositStatus status,  DateTime createdAt,  DateTime? paidAt,  DateTime? creditedAt,  DateTime? refundedAt,  String? transactionId,  String? paymentMethod,  String? paymentReference,  String? auctionIdCredited,  double? amountCredited,  double? amountRefunded,  String? refundTransactionId,  DateTime? expiresAt,  String? notes,  DepositDisposition? winnerDisposition,  bool? isWinner)?  $default,) {final _that = this;
switch (_that) {
case _BiddingDeposit() when $default != null:
return $default(_that.id,_that.userId,_that.amount,_that.status,_that.createdAt,_that.paidAt,_that.creditedAt,_that.refundedAt,_that.transactionId,_that.paymentMethod,_that.paymentReference,_that.auctionIdCredited,_that.amountCredited,_that.amountRefunded,_that.refundTransactionId,_that.expiresAt,_that.notes,_that.winnerDisposition,_that.isWinner);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BiddingDeposit implements BiddingDeposit {
  const _BiddingDeposit({required this.id, required this.userId, required this.amount, required this.status, required this.createdAt, this.paidAt, this.creditedAt, this.refundedAt, this.transactionId, this.paymentMethod, this.paymentReference, this.auctionIdCredited, this.amountCredited, this.amountRefunded, this.refundTransactionId, this.expiresAt, this.notes, this.winnerDisposition, this.isWinner});
  factory _BiddingDeposit.fromJson(Map<String, dynamic> json) => _$BiddingDepositFromJson(json);

@override final  String id;
@override final  String userId;
@override final  double amount;
// Always ₱10,000 for now
@override final  DepositStatus status;
@override final  DateTime createdAt;
@override final  DateTime? paidAt;
@override final  DateTime? creditedAt;
@override final  DateTime? refundedAt;
@override final  String? transactionId;
// Payment gateway transaction ID
@override final  String? paymentMethod;
// GCash, PayMaya, etc.
@override final  String? paymentReference;
@override final  String? auctionIdCredited;
// Which auction won that used this deposit
@override final  double? amountCredited;
// How much was applied to buyer's premium
@override final  double? amountRefunded;
@override final  String? refundTransactionId;
@override final  DateTime? expiresAt;
// Optional: deposit validity period
@override final  String? notes;
// REVISED Model - Winner Choice
@override final  DepositDisposition? winnerDisposition;
// Winner's choice: credit or refund
@override final  bool? isWinner;

/// Create a copy of BiddingDeposit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BiddingDepositCopyWith<_BiddingDeposit> get copyWith => __$BiddingDepositCopyWithImpl<_BiddingDeposit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BiddingDepositToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiddingDeposit&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.creditedAt, creditedAt) || other.creditedAt == creditedAt)&&(identical(other.refundedAt, refundedAt) || other.refundedAt == refundedAt)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.auctionIdCredited, auctionIdCredited) || other.auctionIdCredited == auctionIdCredited)&&(identical(other.amountCredited, amountCredited) || other.amountCredited == amountCredited)&&(identical(other.amountRefunded, amountRefunded) || other.amountRefunded == amountRefunded)&&(identical(other.refundTransactionId, refundTransactionId) || other.refundTransactionId == refundTransactionId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.winnerDisposition, winnerDisposition) || other.winnerDisposition == winnerDisposition)&&(identical(other.isWinner, isWinner) || other.isWinner == isWinner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,amount,status,createdAt,paidAt,creditedAt,refundedAt,transactionId,paymentMethod,paymentReference,auctionIdCredited,amountCredited,amountRefunded,refundTransactionId,expiresAt,notes,winnerDisposition,isWinner]);

@override
String toString() {
  return 'BiddingDeposit(id: $id, userId: $userId, amount: $amount, status: $status, createdAt: $createdAt, paidAt: $paidAt, creditedAt: $creditedAt, refundedAt: $refundedAt, transactionId: $transactionId, paymentMethod: $paymentMethod, paymentReference: $paymentReference, auctionIdCredited: $auctionIdCredited, amountCredited: $amountCredited, amountRefunded: $amountRefunded, refundTransactionId: $refundTransactionId, expiresAt: $expiresAt, notes: $notes, winnerDisposition: $winnerDisposition, isWinner: $isWinner)';
}


}

/// @nodoc
abstract mixin class _$BiddingDepositCopyWith<$Res> implements $BiddingDepositCopyWith<$Res> {
  factory _$BiddingDepositCopyWith(_BiddingDeposit value, $Res Function(_BiddingDeposit) _then) = __$BiddingDepositCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, double amount, DepositStatus status, DateTime createdAt, DateTime? paidAt, DateTime? creditedAt, DateTime? refundedAt, String? transactionId, String? paymentMethod, String? paymentReference, String? auctionIdCredited, double? amountCredited, double? amountRefunded, String? refundTransactionId, DateTime? expiresAt, String? notes, DepositDisposition? winnerDisposition, bool? isWinner
});




}
/// @nodoc
class __$BiddingDepositCopyWithImpl<$Res>
    implements _$BiddingDepositCopyWith<$Res> {
  __$BiddingDepositCopyWithImpl(this._self, this._then);

  final _BiddingDeposit _self;
  final $Res Function(_BiddingDeposit) _then;

/// Create a copy of BiddingDeposit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? amount = null,Object? status = null,Object? createdAt = null,Object? paidAt = freezed,Object? creditedAt = freezed,Object? refundedAt = freezed,Object? transactionId = freezed,Object? paymentMethod = freezed,Object? paymentReference = freezed,Object? auctionIdCredited = freezed,Object? amountCredited = freezed,Object? amountRefunded = freezed,Object? refundTransactionId = freezed,Object? expiresAt = freezed,Object? notes = freezed,Object? winnerDisposition = freezed,Object? isWinner = freezed,}) {
  return _then(_BiddingDeposit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DepositStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,creditedAt: freezed == creditedAt ? _self.creditedAt : creditedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,refundedAt: freezed == refundedAt ? _self.refundedAt : refundedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,auctionIdCredited: freezed == auctionIdCredited ? _self.auctionIdCredited : auctionIdCredited // ignore: cast_nullable_to_non_nullable
as String?,amountCredited: freezed == amountCredited ? _self.amountCredited : amountCredited // ignore: cast_nullable_to_non_nullable
as double?,amountRefunded: freezed == amountRefunded ? _self.amountRefunded : amountRefunded // ignore: cast_nullable_to_non_nullable
as double?,refundTransactionId: freezed == refundTransactionId ? _self.refundTransactionId : refundTransactionId // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,winnerDisposition: freezed == winnerDisposition ? _self.winnerDisposition : winnerDisposition // ignore: cast_nullable_to_non_nullable
as DepositDisposition?,isWinner: freezed == isWinner ? _self.isWinner : isWinner // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
