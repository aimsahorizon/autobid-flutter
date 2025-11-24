// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'digital_agreement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DigitalAgreement {

 String get id; String get auctionId; String get preTransactionId;// ===== BUYER DETAILS =====
 String get buyerId; String get buyerName;/// Buyer's digital signature (base64 encoded signature data or hash)
 String? get buyerSignature; DateTime? get buyerSignedAt;// ===== SELLER DETAILS =====
 String get sellerId; String get sellerName;/// Seller's digital signature (base64 encoded signature data or hash)
 String? get sellerSignature; DateTime? get sellerSignedAt;// ===== VEHICLE DETAILS =====
 String get vehicleMake; String get vehicleModel; String get vehicleYear; String get vinNumber; String get licensePlate; String? get vehicleColor;// ===== FINANCIAL TERMS =====
 double get finalBidPrice; double get additionalFees; double get totalAmount;// finalBidPrice + additionalFees
// ===== PAYMENT & DELIVERY TERMS =====
 String get paymentTerms;// e.g., "Full payment within 3 days"
 String get deliveryMethod;// e.g., "Seller-arranged delivery"
/// Acknowledgment that ownership transfers upon delivery and payment
 bool get transferAcknowledgment;// ===== RA 8792 LEGAL CONSENT =====
/// Legal consent text displayed to both parties
/// "This digital agreement is legally binding under the Electronic Commerce
/// Act of 2000 (RA 8792), Sections 6-10. Electronic signatures have the
/// same legal effect as handwritten signatures."
 String get legalConsentText;// ===== DISPUTE RESOLUTION =====
/// Dispute resolution clause
/// Default: "Any disputes arising from this agreement shall be resolved
/// through the AutoBID dispute resolution process in accordance with
/// Philippine law."
 String get disputeClause;// ===== DOCUMENT INTEGRITY =====
/// SHA-256 hash of agreement content for audit integrity
/// Ensures agreement cannot be tampered with after signing
 String get documentHash;// ===== METADATA =====
/// Timestamp when agreement was generated
 DateTime get agreementGeneratedAt;/// Current status of agreement
 DigitalAgreementStatus get status;
/// Create a copy of DigitalAgreement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DigitalAgreementCopyWith<DigitalAgreement> get copyWith => _$DigitalAgreementCopyWithImpl<DigitalAgreement>(this as DigitalAgreement, _$identity);

  /// Serializes this DigitalAgreement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DigitalAgreement&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.preTransactionId, preTransactionId) || other.preTransactionId == preTransactionId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.buyerSignature, buyerSignature) || other.buyerSignature == buyerSignature)&&(identical(other.buyerSignedAt, buyerSignedAt) || other.buyerSignedAt == buyerSignedAt)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.sellerSignature, sellerSignature) || other.sellerSignature == sellerSignature)&&(identical(other.sellerSignedAt, sellerSignedAt) || other.sellerSignedAt == sellerSignedAt)&&(identical(other.vehicleMake, vehicleMake) || other.vehicleMake == vehicleMake)&&(identical(other.vehicleModel, vehicleModel) || other.vehicleModel == vehicleModel)&&(identical(other.vehicleYear, vehicleYear) || other.vehicleYear == vehicleYear)&&(identical(other.vinNumber, vinNumber) || other.vinNumber == vinNumber)&&(identical(other.licensePlate, licensePlate) || other.licensePlate == licensePlate)&&(identical(other.vehicleColor, vehicleColor) || other.vehicleColor == vehicleColor)&&(identical(other.finalBidPrice, finalBidPrice) || other.finalBidPrice == finalBidPrice)&&(identical(other.additionalFees, additionalFees) || other.additionalFees == additionalFees)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentTerms, paymentTerms) || other.paymentTerms == paymentTerms)&&(identical(other.deliveryMethod, deliveryMethod) || other.deliveryMethod == deliveryMethod)&&(identical(other.transferAcknowledgment, transferAcknowledgment) || other.transferAcknowledgment == transferAcknowledgment)&&(identical(other.legalConsentText, legalConsentText) || other.legalConsentText == legalConsentText)&&(identical(other.disputeClause, disputeClause) || other.disputeClause == disputeClause)&&(identical(other.documentHash, documentHash) || other.documentHash == documentHash)&&(identical(other.agreementGeneratedAt, agreementGeneratedAt) || other.agreementGeneratedAt == agreementGeneratedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,auctionId,preTransactionId,buyerId,buyerName,buyerSignature,buyerSignedAt,sellerId,sellerName,sellerSignature,sellerSignedAt,vehicleMake,vehicleModel,vehicleYear,vinNumber,licensePlate,vehicleColor,finalBidPrice,additionalFees,totalAmount,paymentTerms,deliveryMethod,transferAcknowledgment,legalConsentText,disputeClause,documentHash,agreementGeneratedAt,status]);

@override
String toString() {
  return 'DigitalAgreement(id: $id, auctionId: $auctionId, preTransactionId: $preTransactionId, buyerId: $buyerId, buyerName: $buyerName, buyerSignature: $buyerSignature, buyerSignedAt: $buyerSignedAt, sellerId: $sellerId, sellerName: $sellerName, sellerSignature: $sellerSignature, sellerSignedAt: $sellerSignedAt, vehicleMake: $vehicleMake, vehicleModel: $vehicleModel, vehicleYear: $vehicleYear, vinNumber: $vinNumber, licensePlate: $licensePlate, vehicleColor: $vehicleColor, finalBidPrice: $finalBidPrice, additionalFees: $additionalFees, totalAmount: $totalAmount, paymentTerms: $paymentTerms, deliveryMethod: $deliveryMethod, transferAcknowledgment: $transferAcknowledgment, legalConsentText: $legalConsentText, disputeClause: $disputeClause, documentHash: $documentHash, agreementGeneratedAt: $agreementGeneratedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $DigitalAgreementCopyWith<$Res>  {
  factory $DigitalAgreementCopyWith(DigitalAgreement value, $Res Function(DigitalAgreement) _then) = _$DigitalAgreementCopyWithImpl;
@useResult
$Res call({
 String id, String auctionId, String preTransactionId, String buyerId, String buyerName, String? buyerSignature, DateTime? buyerSignedAt, String sellerId, String sellerName, String? sellerSignature, DateTime? sellerSignedAt, String vehicleMake, String vehicleModel, String vehicleYear, String vinNumber, String licensePlate, String? vehicleColor, double finalBidPrice, double additionalFees, double totalAmount, String paymentTerms, String deliveryMethod, bool transferAcknowledgment, String legalConsentText, String disputeClause, String documentHash, DateTime agreementGeneratedAt, DigitalAgreementStatus status
});




}
/// @nodoc
class _$DigitalAgreementCopyWithImpl<$Res>
    implements $DigitalAgreementCopyWith<$Res> {
  _$DigitalAgreementCopyWithImpl(this._self, this._then);

  final DigitalAgreement _self;
  final $Res Function(DigitalAgreement) _then;

/// Create a copy of DigitalAgreement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? auctionId = null,Object? preTransactionId = null,Object? buyerId = null,Object? buyerName = null,Object? buyerSignature = freezed,Object? buyerSignedAt = freezed,Object? sellerId = null,Object? sellerName = null,Object? sellerSignature = freezed,Object? sellerSignedAt = freezed,Object? vehicleMake = null,Object? vehicleModel = null,Object? vehicleYear = null,Object? vinNumber = null,Object? licensePlate = null,Object? vehicleColor = freezed,Object? finalBidPrice = null,Object? additionalFees = null,Object? totalAmount = null,Object? paymentTerms = null,Object? deliveryMethod = null,Object? transferAcknowledgment = null,Object? legalConsentText = null,Object? disputeClause = null,Object? documentHash = null,Object? agreementGeneratedAt = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,preTransactionId: null == preTransactionId ? _self.preTransactionId : preTransactionId // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,buyerName: null == buyerName ? _self.buyerName : buyerName // ignore: cast_nullable_to_non_nullable
as String,buyerSignature: freezed == buyerSignature ? _self.buyerSignature : buyerSignature // ignore: cast_nullable_to_non_nullable
as String?,buyerSignedAt: freezed == buyerSignedAt ? _self.buyerSignedAt : buyerSignedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,sellerSignature: freezed == sellerSignature ? _self.sellerSignature : sellerSignature // ignore: cast_nullable_to_non_nullable
as String?,sellerSignedAt: freezed == sellerSignedAt ? _self.sellerSignedAt : sellerSignedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,vehicleMake: null == vehicleMake ? _self.vehicleMake : vehicleMake // ignore: cast_nullable_to_non_nullable
as String,vehicleModel: null == vehicleModel ? _self.vehicleModel : vehicleModel // ignore: cast_nullable_to_non_nullable
as String,vehicleYear: null == vehicleYear ? _self.vehicleYear : vehicleYear // ignore: cast_nullable_to_non_nullable
as String,vinNumber: null == vinNumber ? _self.vinNumber : vinNumber // ignore: cast_nullable_to_non_nullable
as String,licensePlate: null == licensePlate ? _self.licensePlate : licensePlate // ignore: cast_nullable_to_non_nullable
as String,vehicleColor: freezed == vehicleColor ? _self.vehicleColor : vehicleColor // ignore: cast_nullable_to_non_nullable
as String?,finalBidPrice: null == finalBidPrice ? _self.finalBidPrice : finalBidPrice // ignore: cast_nullable_to_non_nullable
as double,additionalFees: null == additionalFees ? _self.additionalFees : additionalFees // ignore: cast_nullable_to_non_nullable
as double,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paymentTerms: null == paymentTerms ? _self.paymentTerms : paymentTerms // ignore: cast_nullable_to_non_nullable
as String,deliveryMethod: null == deliveryMethod ? _self.deliveryMethod : deliveryMethod // ignore: cast_nullable_to_non_nullable
as String,transferAcknowledgment: null == transferAcknowledgment ? _self.transferAcknowledgment : transferAcknowledgment // ignore: cast_nullable_to_non_nullable
as bool,legalConsentText: null == legalConsentText ? _self.legalConsentText : legalConsentText // ignore: cast_nullable_to_non_nullable
as String,disputeClause: null == disputeClause ? _self.disputeClause : disputeClause // ignore: cast_nullable_to_non_nullable
as String,documentHash: null == documentHash ? _self.documentHash : documentHash // ignore: cast_nullable_to_non_nullable
as String,agreementGeneratedAt: null == agreementGeneratedAt ? _self.agreementGeneratedAt : agreementGeneratedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DigitalAgreementStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [DigitalAgreement].
extension DigitalAgreementPatterns on DigitalAgreement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DigitalAgreement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DigitalAgreement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DigitalAgreement value)  $default,){
final _that = this;
switch (_that) {
case _DigitalAgreement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DigitalAgreement value)?  $default,){
final _that = this;
switch (_that) {
case _DigitalAgreement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String auctionId,  String preTransactionId,  String buyerId,  String buyerName,  String? buyerSignature,  DateTime? buyerSignedAt,  String sellerId,  String sellerName,  String? sellerSignature,  DateTime? sellerSignedAt,  String vehicleMake,  String vehicleModel,  String vehicleYear,  String vinNumber,  String licensePlate,  String? vehicleColor,  double finalBidPrice,  double additionalFees,  double totalAmount,  String paymentTerms,  String deliveryMethod,  bool transferAcknowledgment,  String legalConsentText,  String disputeClause,  String documentHash,  DateTime agreementGeneratedAt,  DigitalAgreementStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DigitalAgreement() when $default != null:
return $default(_that.id,_that.auctionId,_that.preTransactionId,_that.buyerId,_that.buyerName,_that.buyerSignature,_that.buyerSignedAt,_that.sellerId,_that.sellerName,_that.sellerSignature,_that.sellerSignedAt,_that.vehicleMake,_that.vehicleModel,_that.vehicleYear,_that.vinNumber,_that.licensePlate,_that.vehicleColor,_that.finalBidPrice,_that.additionalFees,_that.totalAmount,_that.paymentTerms,_that.deliveryMethod,_that.transferAcknowledgment,_that.legalConsentText,_that.disputeClause,_that.documentHash,_that.agreementGeneratedAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String auctionId,  String preTransactionId,  String buyerId,  String buyerName,  String? buyerSignature,  DateTime? buyerSignedAt,  String sellerId,  String sellerName,  String? sellerSignature,  DateTime? sellerSignedAt,  String vehicleMake,  String vehicleModel,  String vehicleYear,  String vinNumber,  String licensePlate,  String? vehicleColor,  double finalBidPrice,  double additionalFees,  double totalAmount,  String paymentTerms,  String deliveryMethod,  bool transferAcknowledgment,  String legalConsentText,  String disputeClause,  String documentHash,  DateTime agreementGeneratedAt,  DigitalAgreementStatus status)  $default,) {final _that = this;
switch (_that) {
case _DigitalAgreement():
return $default(_that.id,_that.auctionId,_that.preTransactionId,_that.buyerId,_that.buyerName,_that.buyerSignature,_that.buyerSignedAt,_that.sellerId,_that.sellerName,_that.sellerSignature,_that.sellerSignedAt,_that.vehicleMake,_that.vehicleModel,_that.vehicleYear,_that.vinNumber,_that.licensePlate,_that.vehicleColor,_that.finalBidPrice,_that.additionalFees,_that.totalAmount,_that.paymentTerms,_that.deliveryMethod,_that.transferAcknowledgment,_that.legalConsentText,_that.disputeClause,_that.documentHash,_that.agreementGeneratedAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String auctionId,  String preTransactionId,  String buyerId,  String buyerName,  String? buyerSignature,  DateTime? buyerSignedAt,  String sellerId,  String sellerName,  String? sellerSignature,  DateTime? sellerSignedAt,  String vehicleMake,  String vehicleModel,  String vehicleYear,  String vinNumber,  String licensePlate,  String? vehicleColor,  double finalBidPrice,  double additionalFees,  double totalAmount,  String paymentTerms,  String deliveryMethod,  bool transferAcknowledgment,  String legalConsentText,  String disputeClause,  String documentHash,  DateTime agreementGeneratedAt,  DigitalAgreementStatus status)?  $default,) {final _that = this;
switch (_that) {
case _DigitalAgreement() when $default != null:
return $default(_that.id,_that.auctionId,_that.preTransactionId,_that.buyerId,_that.buyerName,_that.buyerSignature,_that.buyerSignedAt,_that.sellerId,_that.sellerName,_that.sellerSignature,_that.sellerSignedAt,_that.vehicleMake,_that.vehicleModel,_that.vehicleYear,_that.vinNumber,_that.licensePlate,_that.vehicleColor,_that.finalBidPrice,_that.additionalFees,_that.totalAmount,_that.paymentTerms,_that.deliveryMethod,_that.transferAcknowledgment,_that.legalConsentText,_that.disputeClause,_that.documentHash,_that.agreementGeneratedAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DigitalAgreement implements DigitalAgreement {
  const _DigitalAgreement({required this.id, required this.auctionId, required this.preTransactionId, required this.buyerId, required this.buyerName, this.buyerSignature, this.buyerSignedAt, required this.sellerId, required this.sellerName, this.sellerSignature, this.sellerSignedAt, required this.vehicleMake, required this.vehicleModel, required this.vehicleYear, required this.vinNumber, required this.licensePlate, this.vehicleColor, required this.finalBidPrice, this.additionalFees = 0.0, this.totalAmount = 0.0, required this.paymentTerms, required this.deliveryMethod, this.transferAcknowledgment = true, required this.legalConsentText, required this.disputeClause, required this.documentHash, required this.agreementGeneratedAt, this.status = DigitalAgreementStatus.draft});
  factory _DigitalAgreement.fromJson(Map<String, dynamic> json) => _$DigitalAgreementFromJson(json);

@override final  String id;
@override final  String auctionId;
@override final  String preTransactionId;
// ===== BUYER DETAILS =====
@override final  String buyerId;
@override final  String buyerName;
/// Buyer's digital signature (base64 encoded signature data or hash)
@override final  String? buyerSignature;
@override final  DateTime? buyerSignedAt;
// ===== SELLER DETAILS =====
@override final  String sellerId;
@override final  String sellerName;
/// Seller's digital signature (base64 encoded signature data or hash)
@override final  String? sellerSignature;
@override final  DateTime? sellerSignedAt;
// ===== VEHICLE DETAILS =====
@override final  String vehicleMake;
@override final  String vehicleModel;
@override final  String vehicleYear;
@override final  String vinNumber;
@override final  String licensePlate;
@override final  String? vehicleColor;
// ===== FINANCIAL TERMS =====
@override final  double finalBidPrice;
@override@JsonKey() final  double additionalFees;
@override@JsonKey() final  double totalAmount;
// finalBidPrice + additionalFees
// ===== PAYMENT & DELIVERY TERMS =====
@override final  String paymentTerms;
// e.g., "Full payment within 3 days"
@override final  String deliveryMethod;
// e.g., "Seller-arranged delivery"
/// Acknowledgment that ownership transfers upon delivery and payment
@override@JsonKey() final  bool transferAcknowledgment;
// ===== RA 8792 LEGAL CONSENT =====
/// Legal consent text displayed to both parties
/// "This digital agreement is legally binding under the Electronic Commerce
/// Act of 2000 (RA 8792), Sections 6-10. Electronic signatures have the
/// same legal effect as handwritten signatures."
@override final  String legalConsentText;
// ===== DISPUTE RESOLUTION =====
/// Dispute resolution clause
/// Default: "Any disputes arising from this agreement shall be resolved
/// through the AutoBID dispute resolution process in accordance with
/// Philippine law."
@override final  String disputeClause;
// ===== DOCUMENT INTEGRITY =====
/// SHA-256 hash of agreement content for audit integrity
/// Ensures agreement cannot be tampered with after signing
@override final  String documentHash;
// ===== METADATA =====
/// Timestamp when agreement was generated
@override final  DateTime agreementGeneratedAt;
/// Current status of agreement
@override@JsonKey() final  DigitalAgreementStatus status;

/// Create a copy of DigitalAgreement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DigitalAgreementCopyWith<_DigitalAgreement> get copyWith => __$DigitalAgreementCopyWithImpl<_DigitalAgreement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DigitalAgreementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DigitalAgreement&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.preTransactionId, preTransactionId) || other.preTransactionId == preTransactionId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.buyerSignature, buyerSignature) || other.buyerSignature == buyerSignature)&&(identical(other.buyerSignedAt, buyerSignedAt) || other.buyerSignedAt == buyerSignedAt)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.sellerSignature, sellerSignature) || other.sellerSignature == sellerSignature)&&(identical(other.sellerSignedAt, sellerSignedAt) || other.sellerSignedAt == sellerSignedAt)&&(identical(other.vehicleMake, vehicleMake) || other.vehicleMake == vehicleMake)&&(identical(other.vehicleModel, vehicleModel) || other.vehicleModel == vehicleModel)&&(identical(other.vehicleYear, vehicleYear) || other.vehicleYear == vehicleYear)&&(identical(other.vinNumber, vinNumber) || other.vinNumber == vinNumber)&&(identical(other.licensePlate, licensePlate) || other.licensePlate == licensePlate)&&(identical(other.vehicleColor, vehicleColor) || other.vehicleColor == vehicleColor)&&(identical(other.finalBidPrice, finalBidPrice) || other.finalBidPrice == finalBidPrice)&&(identical(other.additionalFees, additionalFees) || other.additionalFees == additionalFees)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentTerms, paymentTerms) || other.paymentTerms == paymentTerms)&&(identical(other.deliveryMethod, deliveryMethod) || other.deliveryMethod == deliveryMethod)&&(identical(other.transferAcknowledgment, transferAcknowledgment) || other.transferAcknowledgment == transferAcknowledgment)&&(identical(other.legalConsentText, legalConsentText) || other.legalConsentText == legalConsentText)&&(identical(other.disputeClause, disputeClause) || other.disputeClause == disputeClause)&&(identical(other.documentHash, documentHash) || other.documentHash == documentHash)&&(identical(other.agreementGeneratedAt, agreementGeneratedAt) || other.agreementGeneratedAt == agreementGeneratedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,auctionId,preTransactionId,buyerId,buyerName,buyerSignature,buyerSignedAt,sellerId,sellerName,sellerSignature,sellerSignedAt,vehicleMake,vehicleModel,vehicleYear,vinNumber,licensePlate,vehicleColor,finalBidPrice,additionalFees,totalAmount,paymentTerms,deliveryMethod,transferAcknowledgment,legalConsentText,disputeClause,documentHash,agreementGeneratedAt,status]);

@override
String toString() {
  return 'DigitalAgreement(id: $id, auctionId: $auctionId, preTransactionId: $preTransactionId, buyerId: $buyerId, buyerName: $buyerName, buyerSignature: $buyerSignature, buyerSignedAt: $buyerSignedAt, sellerId: $sellerId, sellerName: $sellerName, sellerSignature: $sellerSignature, sellerSignedAt: $sellerSignedAt, vehicleMake: $vehicleMake, vehicleModel: $vehicleModel, vehicleYear: $vehicleYear, vinNumber: $vinNumber, licensePlate: $licensePlate, vehicleColor: $vehicleColor, finalBidPrice: $finalBidPrice, additionalFees: $additionalFees, totalAmount: $totalAmount, paymentTerms: $paymentTerms, deliveryMethod: $deliveryMethod, transferAcknowledgment: $transferAcknowledgment, legalConsentText: $legalConsentText, disputeClause: $disputeClause, documentHash: $documentHash, agreementGeneratedAt: $agreementGeneratedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$DigitalAgreementCopyWith<$Res> implements $DigitalAgreementCopyWith<$Res> {
  factory _$DigitalAgreementCopyWith(_DigitalAgreement value, $Res Function(_DigitalAgreement) _then) = __$DigitalAgreementCopyWithImpl;
@override @useResult
$Res call({
 String id, String auctionId, String preTransactionId, String buyerId, String buyerName, String? buyerSignature, DateTime? buyerSignedAt, String sellerId, String sellerName, String? sellerSignature, DateTime? sellerSignedAt, String vehicleMake, String vehicleModel, String vehicleYear, String vinNumber, String licensePlate, String? vehicleColor, double finalBidPrice, double additionalFees, double totalAmount, String paymentTerms, String deliveryMethod, bool transferAcknowledgment, String legalConsentText, String disputeClause, String documentHash, DateTime agreementGeneratedAt, DigitalAgreementStatus status
});




}
/// @nodoc
class __$DigitalAgreementCopyWithImpl<$Res>
    implements _$DigitalAgreementCopyWith<$Res> {
  __$DigitalAgreementCopyWithImpl(this._self, this._then);

  final _DigitalAgreement _self;
  final $Res Function(_DigitalAgreement) _then;

/// Create a copy of DigitalAgreement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? auctionId = null,Object? preTransactionId = null,Object? buyerId = null,Object? buyerName = null,Object? buyerSignature = freezed,Object? buyerSignedAt = freezed,Object? sellerId = null,Object? sellerName = null,Object? sellerSignature = freezed,Object? sellerSignedAt = freezed,Object? vehicleMake = null,Object? vehicleModel = null,Object? vehicleYear = null,Object? vinNumber = null,Object? licensePlate = null,Object? vehicleColor = freezed,Object? finalBidPrice = null,Object? additionalFees = null,Object? totalAmount = null,Object? paymentTerms = null,Object? deliveryMethod = null,Object? transferAcknowledgment = null,Object? legalConsentText = null,Object? disputeClause = null,Object? documentHash = null,Object? agreementGeneratedAt = null,Object? status = null,}) {
  return _then(_DigitalAgreement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,preTransactionId: null == preTransactionId ? _self.preTransactionId : preTransactionId // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,buyerName: null == buyerName ? _self.buyerName : buyerName // ignore: cast_nullable_to_non_nullable
as String,buyerSignature: freezed == buyerSignature ? _self.buyerSignature : buyerSignature // ignore: cast_nullable_to_non_nullable
as String?,buyerSignedAt: freezed == buyerSignedAt ? _self.buyerSignedAt : buyerSignedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,sellerSignature: freezed == sellerSignature ? _self.sellerSignature : sellerSignature // ignore: cast_nullable_to_non_nullable
as String?,sellerSignedAt: freezed == sellerSignedAt ? _self.sellerSignedAt : sellerSignedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,vehicleMake: null == vehicleMake ? _self.vehicleMake : vehicleMake // ignore: cast_nullable_to_non_nullable
as String,vehicleModel: null == vehicleModel ? _self.vehicleModel : vehicleModel // ignore: cast_nullable_to_non_nullable
as String,vehicleYear: null == vehicleYear ? _self.vehicleYear : vehicleYear // ignore: cast_nullable_to_non_nullable
as String,vinNumber: null == vinNumber ? _self.vinNumber : vinNumber // ignore: cast_nullable_to_non_nullable
as String,licensePlate: null == licensePlate ? _self.licensePlate : licensePlate // ignore: cast_nullable_to_non_nullable
as String,vehicleColor: freezed == vehicleColor ? _self.vehicleColor : vehicleColor // ignore: cast_nullable_to_non_nullable
as String?,finalBidPrice: null == finalBidPrice ? _self.finalBidPrice : finalBidPrice // ignore: cast_nullable_to_non_nullable
as double,additionalFees: null == additionalFees ? _self.additionalFees : additionalFees // ignore: cast_nullable_to_non_nullable
as double,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paymentTerms: null == paymentTerms ? _self.paymentTerms : paymentTerms // ignore: cast_nullable_to_non_nullable
as String,deliveryMethod: null == deliveryMethod ? _self.deliveryMethod : deliveryMethod // ignore: cast_nullable_to_non_nullable
as String,transferAcknowledgment: null == transferAcknowledgment ? _self.transferAcknowledgment : transferAcknowledgment // ignore: cast_nullable_to_non_nullable
as bool,legalConsentText: null == legalConsentText ? _self.legalConsentText : legalConsentText // ignore: cast_nullable_to_non_nullable
as String,disputeClause: null == disputeClause ? _self.disputeClause : disputeClause // ignore: cast_nullable_to_non_nullable
as String,documentHash: null == documentHash ? _self.documentHash : documentHash // ignore: cast_nullable_to_non_nullable
as String,agreementGeneratedAt: null == agreementGeneratedAt ? _self.agreementGeneratedAt : agreementGeneratedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DigitalAgreementStatus,
  ));
}


}

// dart format on
