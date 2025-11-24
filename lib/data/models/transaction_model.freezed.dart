// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Transaction {

 String get id; String get auctionId; String get carId; String get buyerId; String get sellerId; String get buyerName; String get sellerName; String get carTitle; double get amount; double get platformFee; double get totalAmount; EscrowStatus get escrowStatus; PaymentMethodType? get paymentMethod; String? get paymentReference; String? get paymentProof; DateTime get createdAt; DateTime? get paidAt; DateTime? get releasedAt; DateTime? get completedAt; List<TransactionTimeline> get timeline;// Transfer validation
 String? get transferEvidenceId; DateTime? get evidenceSubmittedAt; DateTime? get validationCompletedAt;// Dispute/Refund
 String? get disputeId; DateTime? get disputedAt; DateTime? get refundedAt;// ===== EXTENDED: Detailed Fee Breakdown =====
// These fields provide transparency on platform fees:
// - Listing fee: Fixed fee charged when auction was created
// - Transaction fee: Percentage-based fee on final sale price
// - Fee rate & tier: Which pricing tier was applied
/// Listing fee charged to seller when auction was created (PHP 300-500)
/// Separate from transaction fee, covers listing operational costs
 double get listingFee;/// Transaction fee rate applied (e.g., 0.05 = 5%, 0.04 = 4%, 0.03 = 3%)
/// Varies by price tier: Economy (5%), Mid-Range (4%), Premium (3%)
 double get transactionFeeRate;/// Calculated transaction fee amount (salePrice * transactionFeeRate)
/// This is the escrow handling fee deducted from seller's proceeds
 double get transactionFee;/// Price tier used for fee calculation
/// Determines which transaction fee rate applies
 PriceTier? get priceTier;/// Amount seller receives after all fees deducted
/// Formula: amount - listingFee - transactionFee
 double get sellerPayout;// ===== GEMINI Revenue Model: Buyer's Premium =====
// Buyer pays a premium on top of the winning bid
// Premium = 3.5% of finalBid (min ₱3,000, max ₱60,000)
// Rounded up to nearest ₱10
// Discounted by subscription tier (ProBasic: 0.5%, ProPlus: 1.0%)
/// Buyer's premium amount charged to winner
/// Formula: See RevenueCalculator.calculateBuyersPremium()
 double get buyersPremium;/// Buyer's premium rate applied (after tier discount)
/// Base: 3.5%, ProBasic: 3.0%, ProPlus: 2.5%
 double get buyersPremiumRate;/// Buyer's subscription tier at time of transaction
 SubscriptionTierType get buyerTier;/// Amount of bidding deposit credited toward premium
/// Max ₱10,000 (standard deposit amount)
 double get depositCredited;/// Amount of deposit refunded to buyer
/// If deposit > premium, excess is refunded
 double get depositRefunded;/// Total amount buyer must pay (amount + buyersPremium - depositCredited)
 double get buyerTotalDue;
/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionCopyWith<Transaction> get copyWith => _$TransactionCopyWithImpl<Transaction>(this as Transaction, _$identity);

  /// Serializes this Transaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transaction&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.carId, carId) || other.carId == carId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.carTitle, carTitle) || other.carTitle == carTitle)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.platformFee, platformFee) || other.platformFee == platformFee)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.escrowStatus, escrowStatus) || other.escrowStatus == escrowStatus)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.paymentProof, paymentProof) || other.paymentProof == paymentProof)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.releasedAt, releasedAt) || other.releasedAt == releasedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other.timeline, timeline)&&(identical(other.transferEvidenceId, transferEvidenceId) || other.transferEvidenceId == transferEvidenceId)&&(identical(other.evidenceSubmittedAt, evidenceSubmittedAt) || other.evidenceSubmittedAt == evidenceSubmittedAt)&&(identical(other.validationCompletedAt, validationCompletedAt) || other.validationCompletedAt == validationCompletedAt)&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.disputedAt, disputedAt) || other.disputedAt == disputedAt)&&(identical(other.refundedAt, refundedAt) || other.refundedAt == refundedAt)&&(identical(other.listingFee, listingFee) || other.listingFee == listingFee)&&(identical(other.transactionFeeRate, transactionFeeRate) || other.transactionFeeRate == transactionFeeRate)&&(identical(other.transactionFee, transactionFee) || other.transactionFee == transactionFee)&&(identical(other.priceTier, priceTier) || other.priceTier == priceTier)&&(identical(other.sellerPayout, sellerPayout) || other.sellerPayout == sellerPayout)&&(identical(other.buyersPremium, buyersPremium) || other.buyersPremium == buyersPremium)&&(identical(other.buyersPremiumRate, buyersPremiumRate) || other.buyersPremiumRate == buyersPremiumRate)&&(identical(other.buyerTier, buyerTier) || other.buyerTier == buyerTier)&&(identical(other.depositCredited, depositCredited) || other.depositCredited == depositCredited)&&(identical(other.depositRefunded, depositRefunded) || other.depositRefunded == depositRefunded)&&(identical(other.buyerTotalDue, buyerTotalDue) || other.buyerTotalDue == buyerTotalDue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,auctionId,carId,buyerId,sellerId,buyerName,sellerName,carTitle,amount,platformFee,totalAmount,escrowStatus,paymentMethod,paymentReference,paymentProof,createdAt,paidAt,releasedAt,completedAt,const DeepCollectionEquality().hash(timeline),transferEvidenceId,evidenceSubmittedAt,validationCompletedAt,disputeId,disputedAt,refundedAt,listingFee,transactionFeeRate,transactionFee,priceTier,sellerPayout,buyersPremium,buyersPremiumRate,buyerTier,depositCredited,depositRefunded,buyerTotalDue]);

@override
String toString() {
  return 'Transaction(id: $id, auctionId: $auctionId, carId: $carId, buyerId: $buyerId, sellerId: $sellerId, buyerName: $buyerName, sellerName: $sellerName, carTitle: $carTitle, amount: $amount, platformFee: $platformFee, totalAmount: $totalAmount, escrowStatus: $escrowStatus, paymentMethod: $paymentMethod, paymentReference: $paymentReference, paymentProof: $paymentProof, createdAt: $createdAt, paidAt: $paidAt, releasedAt: $releasedAt, completedAt: $completedAt, timeline: $timeline, transferEvidenceId: $transferEvidenceId, evidenceSubmittedAt: $evidenceSubmittedAt, validationCompletedAt: $validationCompletedAt, disputeId: $disputeId, disputedAt: $disputedAt, refundedAt: $refundedAt, listingFee: $listingFee, transactionFeeRate: $transactionFeeRate, transactionFee: $transactionFee, priceTier: $priceTier, sellerPayout: $sellerPayout, buyersPremium: $buyersPremium, buyersPremiumRate: $buyersPremiumRate, buyerTier: $buyerTier, depositCredited: $depositCredited, depositRefunded: $depositRefunded, buyerTotalDue: $buyerTotalDue)';
}


}

/// @nodoc
abstract mixin class $TransactionCopyWith<$Res>  {
  factory $TransactionCopyWith(Transaction value, $Res Function(Transaction) _then) = _$TransactionCopyWithImpl;
@useResult
$Res call({
 String id, String auctionId, String carId, String buyerId, String sellerId, String buyerName, String sellerName, String carTitle, double amount, double platformFee, double totalAmount, EscrowStatus escrowStatus, PaymentMethodType? paymentMethod, String? paymentReference, String? paymentProof, DateTime createdAt, DateTime? paidAt, DateTime? releasedAt, DateTime? completedAt, List<TransactionTimeline> timeline, String? transferEvidenceId, DateTime? evidenceSubmittedAt, DateTime? validationCompletedAt, String? disputeId, DateTime? disputedAt, DateTime? refundedAt, double listingFee, double transactionFeeRate, double transactionFee, PriceTier? priceTier, double sellerPayout, double buyersPremium, double buyersPremiumRate, SubscriptionTierType buyerTier, double depositCredited, double depositRefunded, double buyerTotalDue
});




}
/// @nodoc
class _$TransactionCopyWithImpl<$Res>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._self, this._then);

  final Transaction _self;
  final $Res Function(Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? auctionId = null,Object? carId = null,Object? buyerId = null,Object? sellerId = null,Object? buyerName = null,Object? sellerName = null,Object? carTitle = null,Object? amount = null,Object? platformFee = null,Object? totalAmount = null,Object? escrowStatus = null,Object? paymentMethod = freezed,Object? paymentReference = freezed,Object? paymentProof = freezed,Object? createdAt = null,Object? paidAt = freezed,Object? releasedAt = freezed,Object? completedAt = freezed,Object? timeline = null,Object? transferEvidenceId = freezed,Object? evidenceSubmittedAt = freezed,Object? validationCompletedAt = freezed,Object? disputeId = freezed,Object? disputedAt = freezed,Object? refundedAt = freezed,Object? listingFee = null,Object? transactionFeeRate = null,Object? transactionFee = null,Object? priceTier = freezed,Object? sellerPayout = null,Object? buyersPremium = null,Object? buyersPremiumRate = null,Object? buyerTier = null,Object? depositCredited = null,Object? depositRefunded = null,Object? buyerTotalDue = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,carId: null == carId ? _self.carId : carId // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,buyerName: null == buyerName ? _self.buyerName : buyerName // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,carTitle: null == carTitle ? _self.carTitle : carTitle // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,platformFee: null == platformFee ? _self.platformFee : platformFee // ignore: cast_nullable_to_non_nullable
as double,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,escrowStatus: null == escrowStatus ? _self.escrowStatus : escrowStatus // ignore: cast_nullable_to_non_nullable
as EscrowStatus,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethodType?,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,paymentProof: freezed == paymentProof ? _self.paymentProof : paymentProof // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,releasedAt: freezed == releasedAt ? _self.releasedAt : releasedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TransactionTimeline>,transferEvidenceId: freezed == transferEvidenceId ? _self.transferEvidenceId : transferEvidenceId // ignore: cast_nullable_to_non_nullable
as String?,evidenceSubmittedAt: freezed == evidenceSubmittedAt ? _self.evidenceSubmittedAt : evidenceSubmittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,validationCompletedAt: freezed == validationCompletedAt ? _self.validationCompletedAt : validationCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,disputeId: freezed == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String?,disputedAt: freezed == disputedAt ? _self.disputedAt : disputedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,refundedAt: freezed == refundedAt ? _self.refundedAt : refundedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,listingFee: null == listingFee ? _self.listingFee : listingFee // ignore: cast_nullable_to_non_nullable
as double,transactionFeeRate: null == transactionFeeRate ? _self.transactionFeeRate : transactionFeeRate // ignore: cast_nullable_to_non_nullable
as double,transactionFee: null == transactionFee ? _self.transactionFee : transactionFee // ignore: cast_nullable_to_non_nullable
as double,priceTier: freezed == priceTier ? _self.priceTier : priceTier // ignore: cast_nullable_to_non_nullable
as PriceTier?,sellerPayout: null == sellerPayout ? _self.sellerPayout : sellerPayout // ignore: cast_nullable_to_non_nullable
as double,buyersPremium: null == buyersPremium ? _self.buyersPremium : buyersPremium // ignore: cast_nullable_to_non_nullable
as double,buyersPremiumRate: null == buyersPremiumRate ? _self.buyersPremiumRate : buyersPremiumRate // ignore: cast_nullable_to_non_nullable
as double,buyerTier: null == buyerTier ? _self.buyerTier : buyerTier // ignore: cast_nullable_to_non_nullable
as SubscriptionTierType,depositCredited: null == depositCredited ? _self.depositCredited : depositCredited // ignore: cast_nullable_to_non_nullable
as double,depositRefunded: null == depositRefunded ? _self.depositRefunded : depositRefunded // ignore: cast_nullable_to_non_nullable
as double,buyerTotalDue: null == buyerTotalDue ? _self.buyerTotalDue : buyerTotalDue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Transaction].
extension TransactionPatterns on Transaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transaction value)  $default,){
final _that = this;
switch (_that) {
case _Transaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transaction value)?  $default,){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String auctionId,  String carId,  String buyerId,  String sellerId,  String buyerName,  String sellerName,  String carTitle,  double amount,  double platformFee,  double totalAmount,  EscrowStatus escrowStatus,  PaymentMethodType? paymentMethod,  String? paymentReference,  String? paymentProof,  DateTime createdAt,  DateTime? paidAt,  DateTime? releasedAt,  DateTime? completedAt,  List<TransactionTimeline> timeline,  String? transferEvidenceId,  DateTime? evidenceSubmittedAt,  DateTime? validationCompletedAt,  String? disputeId,  DateTime? disputedAt,  DateTime? refundedAt,  double listingFee,  double transactionFeeRate,  double transactionFee,  PriceTier? priceTier,  double sellerPayout,  double buyersPremium,  double buyersPremiumRate,  SubscriptionTierType buyerTier,  double depositCredited,  double depositRefunded,  double buyerTotalDue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.id,_that.auctionId,_that.carId,_that.buyerId,_that.sellerId,_that.buyerName,_that.sellerName,_that.carTitle,_that.amount,_that.platformFee,_that.totalAmount,_that.escrowStatus,_that.paymentMethod,_that.paymentReference,_that.paymentProof,_that.createdAt,_that.paidAt,_that.releasedAt,_that.completedAt,_that.timeline,_that.transferEvidenceId,_that.evidenceSubmittedAt,_that.validationCompletedAt,_that.disputeId,_that.disputedAt,_that.refundedAt,_that.listingFee,_that.transactionFeeRate,_that.transactionFee,_that.priceTier,_that.sellerPayout,_that.buyersPremium,_that.buyersPremiumRate,_that.buyerTier,_that.depositCredited,_that.depositRefunded,_that.buyerTotalDue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String auctionId,  String carId,  String buyerId,  String sellerId,  String buyerName,  String sellerName,  String carTitle,  double amount,  double platformFee,  double totalAmount,  EscrowStatus escrowStatus,  PaymentMethodType? paymentMethod,  String? paymentReference,  String? paymentProof,  DateTime createdAt,  DateTime? paidAt,  DateTime? releasedAt,  DateTime? completedAt,  List<TransactionTimeline> timeline,  String? transferEvidenceId,  DateTime? evidenceSubmittedAt,  DateTime? validationCompletedAt,  String? disputeId,  DateTime? disputedAt,  DateTime? refundedAt,  double listingFee,  double transactionFeeRate,  double transactionFee,  PriceTier? priceTier,  double sellerPayout,  double buyersPremium,  double buyersPremiumRate,  SubscriptionTierType buyerTier,  double depositCredited,  double depositRefunded,  double buyerTotalDue)  $default,) {final _that = this;
switch (_that) {
case _Transaction():
return $default(_that.id,_that.auctionId,_that.carId,_that.buyerId,_that.sellerId,_that.buyerName,_that.sellerName,_that.carTitle,_that.amount,_that.platformFee,_that.totalAmount,_that.escrowStatus,_that.paymentMethod,_that.paymentReference,_that.paymentProof,_that.createdAt,_that.paidAt,_that.releasedAt,_that.completedAt,_that.timeline,_that.transferEvidenceId,_that.evidenceSubmittedAt,_that.validationCompletedAt,_that.disputeId,_that.disputedAt,_that.refundedAt,_that.listingFee,_that.transactionFeeRate,_that.transactionFee,_that.priceTier,_that.sellerPayout,_that.buyersPremium,_that.buyersPremiumRate,_that.buyerTier,_that.depositCredited,_that.depositRefunded,_that.buyerTotalDue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String auctionId,  String carId,  String buyerId,  String sellerId,  String buyerName,  String sellerName,  String carTitle,  double amount,  double platformFee,  double totalAmount,  EscrowStatus escrowStatus,  PaymentMethodType? paymentMethod,  String? paymentReference,  String? paymentProof,  DateTime createdAt,  DateTime? paidAt,  DateTime? releasedAt,  DateTime? completedAt,  List<TransactionTimeline> timeline,  String? transferEvidenceId,  DateTime? evidenceSubmittedAt,  DateTime? validationCompletedAt,  String? disputeId,  DateTime? disputedAt,  DateTime? refundedAt,  double listingFee,  double transactionFeeRate,  double transactionFee,  PriceTier? priceTier,  double sellerPayout,  double buyersPremium,  double buyersPremiumRate,  SubscriptionTierType buyerTier,  double depositCredited,  double depositRefunded,  double buyerTotalDue)?  $default,) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.id,_that.auctionId,_that.carId,_that.buyerId,_that.sellerId,_that.buyerName,_that.sellerName,_that.carTitle,_that.amount,_that.platformFee,_that.totalAmount,_that.escrowStatus,_that.paymentMethod,_that.paymentReference,_that.paymentProof,_that.createdAt,_that.paidAt,_that.releasedAt,_that.completedAt,_that.timeline,_that.transferEvidenceId,_that.evidenceSubmittedAt,_that.validationCompletedAt,_that.disputeId,_that.disputedAt,_that.refundedAt,_that.listingFee,_that.transactionFeeRate,_that.transactionFee,_that.priceTier,_that.sellerPayout,_that.buyersPremium,_that.buyersPremiumRate,_that.buyerTier,_that.depositCredited,_that.depositRefunded,_that.buyerTotalDue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Transaction implements Transaction {
  const _Transaction({required this.id, required this.auctionId, required this.carId, required this.buyerId, required this.sellerId, required this.buyerName, required this.sellerName, required this.carTitle, required this.amount, required this.platformFee, required this.totalAmount, required this.escrowStatus, this.paymentMethod, this.paymentReference, this.paymentProof, required this.createdAt, this.paidAt, this.releasedAt, this.completedAt, final  List<TransactionTimeline> timeline = const [], this.transferEvidenceId, this.evidenceSubmittedAt, this.validationCompletedAt, this.disputeId, this.disputedAt, this.refundedAt, this.listingFee = 0.0, this.transactionFeeRate = 0.0, this.transactionFee = 0.0, this.priceTier, this.sellerPayout = 0.0, this.buyersPremium = 0.0, this.buyersPremiumRate = 0.035, this.buyerTier = SubscriptionTierType.free, this.depositCredited = 0.0, this.depositRefunded = 0.0, this.buyerTotalDue = 0.0}): _timeline = timeline;
  factory _Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

@override final  String id;
@override final  String auctionId;
@override final  String carId;
@override final  String buyerId;
@override final  String sellerId;
@override final  String buyerName;
@override final  String sellerName;
@override final  String carTitle;
@override final  double amount;
@override final  double platformFee;
@override final  double totalAmount;
@override final  EscrowStatus escrowStatus;
@override final  PaymentMethodType? paymentMethod;
@override final  String? paymentReference;
@override final  String? paymentProof;
@override final  DateTime createdAt;
@override final  DateTime? paidAt;
@override final  DateTime? releasedAt;
@override final  DateTime? completedAt;
 final  List<TransactionTimeline> _timeline;
@override@JsonKey() List<TransactionTimeline> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}

// Transfer validation
@override final  String? transferEvidenceId;
@override final  DateTime? evidenceSubmittedAt;
@override final  DateTime? validationCompletedAt;
// Dispute/Refund
@override final  String? disputeId;
@override final  DateTime? disputedAt;
@override final  DateTime? refundedAt;
// ===== EXTENDED: Detailed Fee Breakdown =====
// These fields provide transparency on platform fees:
// - Listing fee: Fixed fee charged when auction was created
// - Transaction fee: Percentage-based fee on final sale price
// - Fee rate & tier: Which pricing tier was applied
/// Listing fee charged to seller when auction was created (PHP 300-500)
/// Separate from transaction fee, covers listing operational costs
@override@JsonKey() final  double listingFee;
/// Transaction fee rate applied (e.g., 0.05 = 5%, 0.04 = 4%, 0.03 = 3%)
/// Varies by price tier: Economy (5%), Mid-Range (4%), Premium (3%)
@override@JsonKey() final  double transactionFeeRate;
/// Calculated transaction fee amount (salePrice * transactionFeeRate)
/// This is the escrow handling fee deducted from seller's proceeds
@override@JsonKey() final  double transactionFee;
/// Price tier used for fee calculation
/// Determines which transaction fee rate applies
@override final  PriceTier? priceTier;
/// Amount seller receives after all fees deducted
/// Formula: amount - listingFee - transactionFee
@override@JsonKey() final  double sellerPayout;
// ===== GEMINI Revenue Model: Buyer's Premium =====
// Buyer pays a premium on top of the winning bid
// Premium = 3.5% of finalBid (min ₱3,000, max ₱60,000)
// Rounded up to nearest ₱10
// Discounted by subscription tier (ProBasic: 0.5%, ProPlus: 1.0%)
/// Buyer's premium amount charged to winner
/// Formula: See RevenueCalculator.calculateBuyersPremium()
@override@JsonKey() final  double buyersPremium;
/// Buyer's premium rate applied (after tier discount)
/// Base: 3.5%, ProBasic: 3.0%, ProPlus: 2.5%
@override@JsonKey() final  double buyersPremiumRate;
/// Buyer's subscription tier at time of transaction
@override@JsonKey() final  SubscriptionTierType buyerTier;
/// Amount of bidding deposit credited toward premium
/// Max ₱10,000 (standard deposit amount)
@override@JsonKey() final  double depositCredited;
/// Amount of deposit refunded to buyer
/// If deposit > premium, excess is refunded
@override@JsonKey() final  double depositRefunded;
/// Total amount buyer must pay (amount + buyersPremium - depositCredited)
@override@JsonKey() final  double buyerTotalDue;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionCopyWith<_Transaction> get copyWith => __$TransactionCopyWithImpl<_Transaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transaction&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.carId, carId) || other.carId == carId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.carTitle, carTitle) || other.carTitle == carTitle)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.platformFee, platformFee) || other.platformFee == platformFee)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.escrowStatus, escrowStatus) || other.escrowStatus == escrowStatus)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.paymentProof, paymentProof) || other.paymentProof == paymentProof)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.releasedAt, releasedAt) || other.releasedAt == releasedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other._timeline, _timeline)&&(identical(other.transferEvidenceId, transferEvidenceId) || other.transferEvidenceId == transferEvidenceId)&&(identical(other.evidenceSubmittedAt, evidenceSubmittedAt) || other.evidenceSubmittedAt == evidenceSubmittedAt)&&(identical(other.validationCompletedAt, validationCompletedAt) || other.validationCompletedAt == validationCompletedAt)&&(identical(other.disputeId, disputeId) || other.disputeId == disputeId)&&(identical(other.disputedAt, disputedAt) || other.disputedAt == disputedAt)&&(identical(other.refundedAt, refundedAt) || other.refundedAt == refundedAt)&&(identical(other.listingFee, listingFee) || other.listingFee == listingFee)&&(identical(other.transactionFeeRate, transactionFeeRate) || other.transactionFeeRate == transactionFeeRate)&&(identical(other.transactionFee, transactionFee) || other.transactionFee == transactionFee)&&(identical(other.priceTier, priceTier) || other.priceTier == priceTier)&&(identical(other.sellerPayout, sellerPayout) || other.sellerPayout == sellerPayout)&&(identical(other.buyersPremium, buyersPremium) || other.buyersPremium == buyersPremium)&&(identical(other.buyersPremiumRate, buyersPremiumRate) || other.buyersPremiumRate == buyersPremiumRate)&&(identical(other.buyerTier, buyerTier) || other.buyerTier == buyerTier)&&(identical(other.depositCredited, depositCredited) || other.depositCredited == depositCredited)&&(identical(other.depositRefunded, depositRefunded) || other.depositRefunded == depositRefunded)&&(identical(other.buyerTotalDue, buyerTotalDue) || other.buyerTotalDue == buyerTotalDue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,auctionId,carId,buyerId,sellerId,buyerName,sellerName,carTitle,amount,platformFee,totalAmount,escrowStatus,paymentMethod,paymentReference,paymentProof,createdAt,paidAt,releasedAt,completedAt,const DeepCollectionEquality().hash(_timeline),transferEvidenceId,evidenceSubmittedAt,validationCompletedAt,disputeId,disputedAt,refundedAt,listingFee,transactionFeeRate,transactionFee,priceTier,sellerPayout,buyersPremium,buyersPremiumRate,buyerTier,depositCredited,depositRefunded,buyerTotalDue]);

@override
String toString() {
  return 'Transaction(id: $id, auctionId: $auctionId, carId: $carId, buyerId: $buyerId, sellerId: $sellerId, buyerName: $buyerName, sellerName: $sellerName, carTitle: $carTitle, amount: $amount, platformFee: $platformFee, totalAmount: $totalAmount, escrowStatus: $escrowStatus, paymentMethod: $paymentMethod, paymentReference: $paymentReference, paymentProof: $paymentProof, createdAt: $createdAt, paidAt: $paidAt, releasedAt: $releasedAt, completedAt: $completedAt, timeline: $timeline, transferEvidenceId: $transferEvidenceId, evidenceSubmittedAt: $evidenceSubmittedAt, validationCompletedAt: $validationCompletedAt, disputeId: $disputeId, disputedAt: $disputedAt, refundedAt: $refundedAt, listingFee: $listingFee, transactionFeeRate: $transactionFeeRate, transactionFee: $transactionFee, priceTier: $priceTier, sellerPayout: $sellerPayout, buyersPremium: $buyersPremium, buyersPremiumRate: $buyersPremiumRate, buyerTier: $buyerTier, depositCredited: $depositCredited, depositRefunded: $depositRefunded, buyerTotalDue: $buyerTotalDue)';
}


}

/// @nodoc
abstract mixin class _$TransactionCopyWith<$Res> implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(_Transaction value, $Res Function(_Transaction) _then) = __$TransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String auctionId, String carId, String buyerId, String sellerId, String buyerName, String sellerName, String carTitle, double amount, double platformFee, double totalAmount, EscrowStatus escrowStatus, PaymentMethodType? paymentMethod, String? paymentReference, String? paymentProof, DateTime createdAt, DateTime? paidAt, DateTime? releasedAt, DateTime? completedAt, List<TransactionTimeline> timeline, String? transferEvidenceId, DateTime? evidenceSubmittedAt, DateTime? validationCompletedAt, String? disputeId, DateTime? disputedAt, DateTime? refundedAt, double listingFee, double transactionFeeRate, double transactionFee, PriceTier? priceTier, double sellerPayout, double buyersPremium, double buyersPremiumRate, SubscriptionTierType buyerTier, double depositCredited, double depositRefunded, double buyerTotalDue
});




}
/// @nodoc
class __$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(this._self, this._then);

  final _Transaction _self;
  final $Res Function(_Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? auctionId = null,Object? carId = null,Object? buyerId = null,Object? sellerId = null,Object? buyerName = null,Object? sellerName = null,Object? carTitle = null,Object? amount = null,Object? platformFee = null,Object? totalAmount = null,Object? escrowStatus = null,Object? paymentMethod = freezed,Object? paymentReference = freezed,Object? paymentProof = freezed,Object? createdAt = null,Object? paidAt = freezed,Object? releasedAt = freezed,Object? completedAt = freezed,Object? timeline = null,Object? transferEvidenceId = freezed,Object? evidenceSubmittedAt = freezed,Object? validationCompletedAt = freezed,Object? disputeId = freezed,Object? disputedAt = freezed,Object? refundedAt = freezed,Object? listingFee = null,Object? transactionFeeRate = null,Object? transactionFee = null,Object? priceTier = freezed,Object? sellerPayout = null,Object? buyersPremium = null,Object? buyersPremiumRate = null,Object? buyerTier = null,Object? depositCredited = null,Object? depositRefunded = null,Object? buyerTotalDue = null,}) {
  return _then(_Transaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,carId: null == carId ? _self.carId : carId // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,buyerName: null == buyerName ? _self.buyerName : buyerName // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,carTitle: null == carTitle ? _self.carTitle : carTitle // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,platformFee: null == platformFee ? _self.platformFee : platformFee // ignore: cast_nullable_to_non_nullable
as double,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,escrowStatus: null == escrowStatus ? _self.escrowStatus : escrowStatus // ignore: cast_nullable_to_non_nullable
as EscrowStatus,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethodType?,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,paymentProof: freezed == paymentProof ? _self.paymentProof : paymentProof // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,releasedAt: freezed == releasedAt ? _self.releasedAt : releasedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TransactionTimeline>,transferEvidenceId: freezed == transferEvidenceId ? _self.transferEvidenceId : transferEvidenceId // ignore: cast_nullable_to_non_nullable
as String?,evidenceSubmittedAt: freezed == evidenceSubmittedAt ? _self.evidenceSubmittedAt : evidenceSubmittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,validationCompletedAt: freezed == validationCompletedAt ? _self.validationCompletedAt : validationCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,disputeId: freezed == disputeId ? _self.disputeId : disputeId // ignore: cast_nullable_to_non_nullable
as String?,disputedAt: freezed == disputedAt ? _self.disputedAt : disputedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,refundedAt: freezed == refundedAt ? _self.refundedAt : refundedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,listingFee: null == listingFee ? _self.listingFee : listingFee // ignore: cast_nullable_to_non_nullable
as double,transactionFeeRate: null == transactionFeeRate ? _self.transactionFeeRate : transactionFeeRate // ignore: cast_nullable_to_non_nullable
as double,transactionFee: null == transactionFee ? _self.transactionFee : transactionFee // ignore: cast_nullable_to_non_nullable
as double,priceTier: freezed == priceTier ? _self.priceTier : priceTier // ignore: cast_nullable_to_non_nullable
as PriceTier?,sellerPayout: null == sellerPayout ? _self.sellerPayout : sellerPayout // ignore: cast_nullable_to_non_nullable
as double,buyersPremium: null == buyersPremium ? _self.buyersPremium : buyersPremium // ignore: cast_nullable_to_non_nullable
as double,buyersPremiumRate: null == buyersPremiumRate ? _self.buyersPremiumRate : buyersPremiumRate // ignore: cast_nullable_to_non_nullable
as double,buyerTier: null == buyerTier ? _self.buyerTier : buyerTier // ignore: cast_nullable_to_non_nullable
as SubscriptionTierType,depositCredited: null == depositCredited ? _self.depositCredited : depositCredited // ignore: cast_nullable_to_non_nullable
as double,depositRefunded: null == depositRefunded ? _self.depositRefunded : depositRefunded // ignore: cast_nullable_to_non_nullable
as double,buyerTotalDue: null == buyerTotalDue ? _self.buyerTotalDue : buyerTotalDue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
