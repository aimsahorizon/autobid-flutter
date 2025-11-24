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

 String get id; String get userId; String get userName;// ===== VEHICLE IDENTITY VERIFICATION =====
/// Confirms VIN, license plate, make, model, year, color match listing
 bool get vehicleIdentityConfirmed; String? get vinNumber; String? get licensePlate;// ===== CONDITION & ISSUES =====
/// Confirms vehicle condition and known issues are accurately represented
 bool get conditionAccuratelyRepresented; List<String> get knownIssues;// ===== PRICING CONFIRMATION =====
/// Final bid price confirmed and accepted
 double get finalBidPrice; double get additionalFees;// ===== PAYMENT TIMELINE =====
/// Number of days agreed for payment (e.g., 3 days)
 int get paymentTimelineDays;/// Buyer acknowledges late payment penalties
 bool get latePaymentPenaltyAcknowledged;// ===== SHIPPING & DELIVERY =====
/// Shipping/delivery method agreed
 ShippingMethod? get shippingMethod;/// Who pays for shipping
 ShippingCostResponsibility? get shippingCostResponsibility;/// Who is responsible for insurance
 InsuranceResponsibility? get insuranceResponsibility;/// Estimated delivery timeframe in days
 int get estimatedDeliveryDays;/// Required shipping evidence types agreed
 List<String> get requiredShippingEvidence;/// Seller agrees to submit all required shipping evidence
 bool get shippingEvidenceCommitment;/// Seller acknowledges insurance responsibility during transit
 bool get transitInsuranceAcknowledged;// ===== INSPECTION & ACCEPTANCE =====
/// Vehicle inspection period (hours)
 int get vehicleInspectionPeriodHours;/// Inspection method agreed
 InspectionMethod? get inspectionMethod;/// Acceptance criteria description
 String? get acceptanceCriteria;/// Procedure for handling discrepancies
 String? get discrepancyProcedure;/// Buyer confirmation duration limit (hours)
 int get buyerConfirmationLimitHours;/// Seller will review buyer inspection evidence
 bool get sellerInspectionReviewCommitment;/// Optional inspection notes
 String? get inspectionNotes;// ===== LEGAL & OWNERSHIP =====
/// Seller confirms legal ownership documents available
 bool get sellerOwnershipConfirmed;/// Buyer acknowledges receipt of title/registration upon delivery
 bool get titleTransferAcknowledged;/// No outstanding loans/liens on vehicle
 bool get noOutstandingLiensAcknowledged;/// Transfer of ownership process acknowledged
 bool get ownershipTransferProcessAcknowledged;/// Special transfer instructions or legal considerations
 String? get specialTransferInstructions;// ===== SELLER CONFIRMATIONS (TRANSACTION_FLOW.md lines 54-58) =====
/// All known issues, damages, accidents disclosed accurately
 bool get allIssuesDisclosedAccurately;/// Condition as represented in listing (scratches, dents, etc.)
 bool get conditionAsRepresented;/// Supporting documents uploaded for verification
 List<String> get supportingDocumentsUrls;// ===== DISPUTE & PROTECTION =====
/// Discussions/messages logged for dispute resolution
 bool get discussionsLoggedAcknowledged;/// Agrees to platform dispute resolution process
 bool get disputeResolutionProcessAgreed;/// Acknowledges fraud/collusion policies
 bool get fraudPoliciesAcknowledged;/// Additional protections requested or agreed
 String? get additionalProtections;/// Seller-requested protection measures
 String? get sellerProtectionMeasures;// ===== FINAL CONFIRMATIONS (TRANSACTION_FLOW.md lines 84-85) =====
/// Seller confirms all information is accurate and complete
 bool get informationAccuracyConfirmed;/// Platform terms commitment (payment, shipping, inspection)
 bool get termsAgreed;// ===== DELIVERY DETAILS (Existing) =====
 String? get deliveryDate; String? get deliveryLocation; List<String> get uploadedDocuments;// ===== METADATA =====
 DateTime get confirmedAt; String? get notes;
/// Create a copy of PreTransactionConfirmation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreTransactionConfirmationCopyWith<PreTransactionConfirmation> get copyWith => _$PreTransactionConfirmationCopyWithImpl<PreTransactionConfirmation>(this as PreTransactionConfirmation, _$identity);

  /// Serializes this PreTransactionConfirmation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreTransactionConfirmation&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.vehicleIdentityConfirmed, vehicleIdentityConfirmed) || other.vehicleIdentityConfirmed == vehicleIdentityConfirmed)&&(identical(other.vinNumber, vinNumber) || other.vinNumber == vinNumber)&&(identical(other.licensePlate, licensePlate) || other.licensePlate == licensePlate)&&(identical(other.conditionAccuratelyRepresented, conditionAccuratelyRepresented) || other.conditionAccuratelyRepresented == conditionAccuratelyRepresented)&&const DeepCollectionEquality().equals(other.knownIssues, knownIssues)&&(identical(other.finalBidPrice, finalBidPrice) || other.finalBidPrice == finalBidPrice)&&(identical(other.additionalFees, additionalFees) || other.additionalFees == additionalFees)&&(identical(other.paymentTimelineDays, paymentTimelineDays) || other.paymentTimelineDays == paymentTimelineDays)&&(identical(other.latePaymentPenaltyAcknowledged, latePaymentPenaltyAcknowledged) || other.latePaymentPenaltyAcknowledged == latePaymentPenaltyAcknowledged)&&(identical(other.shippingMethod, shippingMethod) || other.shippingMethod == shippingMethod)&&(identical(other.shippingCostResponsibility, shippingCostResponsibility) || other.shippingCostResponsibility == shippingCostResponsibility)&&(identical(other.insuranceResponsibility, insuranceResponsibility) || other.insuranceResponsibility == insuranceResponsibility)&&(identical(other.estimatedDeliveryDays, estimatedDeliveryDays) || other.estimatedDeliveryDays == estimatedDeliveryDays)&&const DeepCollectionEquality().equals(other.requiredShippingEvidence, requiredShippingEvidence)&&(identical(other.shippingEvidenceCommitment, shippingEvidenceCommitment) || other.shippingEvidenceCommitment == shippingEvidenceCommitment)&&(identical(other.transitInsuranceAcknowledged, transitInsuranceAcknowledged) || other.transitInsuranceAcknowledged == transitInsuranceAcknowledged)&&(identical(other.vehicleInspectionPeriodHours, vehicleInspectionPeriodHours) || other.vehicleInspectionPeriodHours == vehicleInspectionPeriodHours)&&(identical(other.inspectionMethod, inspectionMethod) || other.inspectionMethod == inspectionMethod)&&(identical(other.acceptanceCriteria, acceptanceCriteria) || other.acceptanceCriteria == acceptanceCriteria)&&(identical(other.discrepancyProcedure, discrepancyProcedure) || other.discrepancyProcedure == discrepancyProcedure)&&(identical(other.buyerConfirmationLimitHours, buyerConfirmationLimitHours) || other.buyerConfirmationLimitHours == buyerConfirmationLimitHours)&&(identical(other.sellerInspectionReviewCommitment, sellerInspectionReviewCommitment) || other.sellerInspectionReviewCommitment == sellerInspectionReviewCommitment)&&(identical(other.inspectionNotes, inspectionNotes) || other.inspectionNotes == inspectionNotes)&&(identical(other.sellerOwnershipConfirmed, sellerOwnershipConfirmed) || other.sellerOwnershipConfirmed == sellerOwnershipConfirmed)&&(identical(other.titleTransferAcknowledged, titleTransferAcknowledged) || other.titleTransferAcknowledged == titleTransferAcknowledged)&&(identical(other.noOutstandingLiensAcknowledged, noOutstandingLiensAcknowledged) || other.noOutstandingLiensAcknowledged == noOutstandingLiensAcknowledged)&&(identical(other.ownershipTransferProcessAcknowledged, ownershipTransferProcessAcknowledged) || other.ownershipTransferProcessAcknowledged == ownershipTransferProcessAcknowledged)&&(identical(other.specialTransferInstructions, specialTransferInstructions) || other.specialTransferInstructions == specialTransferInstructions)&&(identical(other.allIssuesDisclosedAccurately, allIssuesDisclosedAccurately) || other.allIssuesDisclosedAccurately == allIssuesDisclosedAccurately)&&(identical(other.conditionAsRepresented, conditionAsRepresented) || other.conditionAsRepresented == conditionAsRepresented)&&const DeepCollectionEquality().equals(other.supportingDocumentsUrls, supportingDocumentsUrls)&&(identical(other.discussionsLoggedAcknowledged, discussionsLoggedAcknowledged) || other.discussionsLoggedAcknowledged == discussionsLoggedAcknowledged)&&(identical(other.disputeResolutionProcessAgreed, disputeResolutionProcessAgreed) || other.disputeResolutionProcessAgreed == disputeResolutionProcessAgreed)&&(identical(other.fraudPoliciesAcknowledged, fraudPoliciesAcknowledged) || other.fraudPoliciesAcknowledged == fraudPoliciesAcknowledged)&&(identical(other.additionalProtections, additionalProtections) || other.additionalProtections == additionalProtections)&&(identical(other.sellerProtectionMeasures, sellerProtectionMeasures) || other.sellerProtectionMeasures == sellerProtectionMeasures)&&(identical(other.informationAccuracyConfirmed, informationAccuracyConfirmed) || other.informationAccuracyConfirmed == informationAccuracyConfirmed)&&(identical(other.termsAgreed, termsAgreed) || other.termsAgreed == termsAgreed)&&(identical(other.deliveryDate, deliveryDate) || other.deliveryDate == deliveryDate)&&(identical(other.deliveryLocation, deliveryLocation) || other.deliveryLocation == deliveryLocation)&&const DeepCollectionEquality().equals(other.uploadedDocuments, uploadedDocuments)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,userName,vehicleIdentityConfirmed,vinNumber,licensePlate,conditionAccuratelyRepresented,const DeepCollectionEquality().hash(knownIssues),finalBidPrice,additionalFees,paymentTimelineDays,latePaymentPenaltyAcknowledged,shippingMethod,shippingCostResponsibility,insuranceResponsibility,estimatedDeliveryDays,const DeepCollectionEquality().hash(requiredShippingEvidence),shippingEvidenceCommitment,transitInsuranceAcknowledged,vehicleInspectionPeriodHours,inspectionMethod,acceptanceCriteria,discrepancyProcedure,buyerConfirmationLimitHours,sellerInspectionReviewCommitment,inspectionNotes,sellerOwnershipConfirmed,titleTransferAcknowledged,noOutstandingLiensAcknowledged,ownershipTransferProcessAcknowledged,specialTransferInstructions,allIssuesDisclosedAccurately,conditionAsRepresented,const DeepCollectionEquality().hash(supportingDocumentsUrls),discussionsLoggedAcknowledged,disputeResolutionProcessAgreed,fraudPoliciesAcknowledged,additionalProtections,sellerProtectionMeasures,informationAccuracyConfirmed,termsAgreed,deliveryDate,deliveryLocation,const DeepCollectionEquality().hash(uploadedDocuments),confirmedAt,notes]);

@override
String toString() {
  return 'PreTransactionConfirmation(id: $id, userId: $userId, userName: $userName, vehicleIdentityConfirmed: $vehicleIdentityConfirmed, vinNumber: $vinNumber, licensePlate: $licensePlate, conditionAccuratelyRepresented: $conditionAccuratelyRepresented, knownIssues: $knownIssues, finalBidPrice: $finalBidPrice, additionalFees: $additionalFees, paymentTimelineDays: $paymentTimelineDays, latePaymentPenaltyAcknowledged: $latePaymentPenaltyAcknowledged, shippingMethod: $shippingMethod, shippingCostResponsibility: $shippingCostResponsibility, insuranceResponsibility: $insuranceResponsibility, estimatedDeliveryDays: $estimatedDeliveryDays, requiredShippingEvidence: $requiredShippingEvidence, shippingEvidenceCommitment: $shippingEvidenceCommitment, transitInsuranceAcknowledged: $transitInsuranceAcknowledged, vehicleInspectionPeriodHours: $vehicleInspectionPeriodHours, inspectionMethod: $inspectionMethod, acceptanceCriteria: $acceptanceCriteria, discrepancyProcedure: $discrepancyProcedure, buyerConfirmationLimitHours: $buyerConfirmationLimitHours, sellerInspectionReviewCommitment: $sellerInspectionReviewCommitment, inspectionNotes: $inspectionNotes, sellerOwnershipConfirmed: $sellerOwnershipConfirmed, titleTransferAcknowledged: $titleTransferAcknowledged, noOutstandingLiensAcknowledged: $noOutstandingLiensAcknowledged, ownershipTransferProcessAcknowledged: $ownershipTransferProcessAcknowledged, specialTransferInstructions: $specialTransferInstructions, allIssuesDisclosedAccurately: $allIssuesDisclosedAccurately, conditionAsRepresented: $conditionAsRepresented, supportingDocumentsUrls: $supportingDocumentsUrls, discussionsLoggedAcknowledged: $discussionsLoggedAcknowledged, disputeResolutionProcessAgreed: $disputeResolutionProcessAgreed, fraudPoliciesAcknowledged: $fraudPoliciesAcknowledged, additionalProtections: $additionalProtections, sellerProtectionMeasures: $sellerProtectionMeasures, informationAccuracyConfirmed: $informationAccuracyConfirmed, termsAgreed: $termsAgreed, deliveryDate: $deliveryDate, deliveryLocation: $deliveryLocation, uploadedDocuments: $uploadedDocuments, confirmedAt: $confirmedAt, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $PreTransactionConfirmationCopyWith<$Res>  {
  factory $PreTransactionConfirmationCopyWith(PreTransactionConfirmation value, $Res Function(PreTransactionConfirmation) _then) = _$PreTransactionConfirmationCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String userName, bool vehicleIdentityConfirmed, String? vinNumber, String? licensePlate, bool conditionAccuratelyRepresented, List<String> knownIssues, double finalBidPrice, double additionalFees, int paymentTimelineDays, bool latePaymentPenaltyAcknowledged, ShippingMethod? shippingMethod, ShippingCostResponsibility? shippingCostResponsibility, InsuranceResponsibility? insuranceResponsibility, int estimatedDeliveryDays, List<String> requiredShippingEvidence, bool shippingEvidenceCommitment, bool transitInsuranceAcknowledged, int vehicleInspectionPeriodHours, InspectionMethod? inspectionMethod, String? acceptanceCriteria, String? discrepancyProcedure, int buyerConfirmationLimitHours, bool sellerInspectionReviewCommitment, String? inspectionNotes, bool sellerOwnershipConfirmed, bool titleTransferAcknowledged, bool noOutstandingLiensAcknowledged, bool ownershipTransferProcessAcknowledged, String? specialTransferInstructions, bool allIssuesDisclosedAccurately, bool conditionAsRepresented, List<String> supportingDocumentsUrls, bool discussionsLoggedAcknowledged, bool disputeResolutionProcessAgreed, bool fraudPoliciesAcknowledged, String? additionalProtections, String? sellerProtectionMeasures, bool informationAccuracyConfirmed, bool termsAgreed, String? deliveryDate, String? deliveryLocation, List<String> uploadedDocuments, DateTime confirmedAt, String? notes
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? userName = null,Object? vehicleIdentityConfirmed = null,Object? vinNumber = freezed,Object? licensePlate = freezed,Object? conditionAccuratelyRepresented = null,Object? knownIssues = null,Object? finalBidPrice = null,Object? additionalFees = null,Object? paymentTimelineDays = null,Object? latePaymentPenaltyAcknowledged = null,Object? shippingMethod = freezed,Object? shippingCostResponsibility = freezed,Object? insuranceResponsibility = freezed,Object? estimatedDeliveryDays = null,Object? requiredShippingEvidence = null,Object? shippingEvidenceCommitment = null,Object? transitInsuranceAcknowledged = null,Object? vehicleInspectionPeriodHours = null,Object? inspectionMethod = freezed,Object? acceptanceCriteria = freezed,Object? discrepancyProcedure = freezed,Object? buyerConfirmationLimitHours = null,Object? sellerInspectionReviewCommitment = null,Object? inspectionNotes = freezed,Object? sellerOwnershipConfirmed = null,Object? titleTransferAcknowledged = null,Object? noOutstandingLiensAcknowledged = null,Object? ownershipTransferProcessAcknowledged = null,Object? specialTransferInstructions = freezed,Object? allIssuesDisclosedAccurately = null,Object? conditionAsRepresented = null,Object? supportingDocumentsUrls = null,Object? discussionsLoggedAcknowledged = null,Object? disputeResolutionProcessAgreed = null,Object? fraudPoliciesAcknowledged = null,Object? additionalProtections = freezed,Object? sellerProtectionMeasures = freezed,Object? informationAccuracyConfirmed = null,Object? termsAgreed = null,Object? deliveryDate = freezed,Object? deliveryLocation = freezed,Object? uploadedDocuments = null,Object? confirmedAt = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,vehicleIdentityConfirmed: null == vehicleIdentityConfirmed ? _self.vehicleIdentityConfirmed : vehicleIdentityConfirmed // ignore: cast_nullable_to_non_nullable
as bool,vinNumber: freezed == vinNumber ? _self.vinNumber : vinNumber // ignore: cast_nullable_to_non_nullable
as String?,licensePlate: freezed == licensePlate ? _self.licensePlate : licensePlate // ignore: cast_nullable_to_non_nullable
as String?,conditionAccuratelyRepresented: null == conditionAccuratelyRepresented ? _self.conditionAccuratelyRepresented : conditionAccuratelyRepresented // ignore: cast_nullable_to_non_nullable
as bool,knownIssues: null == knownIssues ? _self.knownIssues : knownIssues // ignore: cast_nullable_to_non_nullable
as List<String>,finalBidPrice: null == finalBidPrice ? _self.finalBidPrice : finalBidPrice // ignore: cast_nullable_to_non_nullable
as double,additionalFees: null == additionalFees ? _self.additionalFees : additionalFees // ignore: cast_nullable_to_non_nullable
as double,paymentTimelineDays: null == paymentTimelineDays ? _self.paymentTimelineDays : paymentTimelineDays // ignore: cast_nullable_to_non_nullable
as int,latePaymentPenaltyAcknowledged: null == latePaymentPenaltyAcknowledged ? _self.latePaymentPenaltyAcknowledged : latePaymentPenaltyAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,shippingMethod: freezed == shippingMethod ? _self.shippingMethod : shippingMethod // ignore: cast_nullable_to_non_nullable
as ShippingMethod?,shippingCostResponsibility: freezed == shippingCostResponsibility ? _self.shippingCostResponsibility : shippingCostResponsibility // ignore: cast_nullable_to_non_nullable
as ShippingCostResponsibility?,insuranceResponsibility: freezed == insuranceResponsibility ? _self.insuranceResponsibility : insuranceResponsibility // ignore: cast_nullable_to_non_nullable
as InsuranceResponsibility?,estimatedDeliveryDays: null == estimatedDeliveryDays ? _self.estimatedDeliveryDays : estimatedDeliveryDays // ignore: cast_nullable_to_non_nullable
as int,requiredShippingEvidence: null == requiredShippingEvidence ? _self.requiredShippingEvidence : requiredShippingEvidence // ignore: cast_nullable_to_non_nullable
as List<String>,shippingEvidenceCommitment: null == shippingEvidenceCommitment ? _self.shippingEvidenceCommitment : shippingEvidenceCommitment // ignore: cast_nullable_to_non_nullable
as bool,transitInsuranceAcknowledged: null == transitInsuranceAcknowledged ? _self.transitInsuranceAcknowledged : transitInsuranceAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,vehicleInspectionPeriodHours: null == vehicleInspectionPeriodHours ? _self.vehicleInspectionPeriodHours : vehicleInspectionPeriodHours // ignore: cast_nullable_to_non_nullable
as int,inspectionMethod: freezed == inspectionMethod ? _self.inspectionMethod : inspectionMethod // ignore: cast_nullable_to_non_nullable
as InspectionMethod?,acceptanceCriteria: freezed == acceptanceCriteria ? _self.acceptanceCriteria : acceptanceCriteria // ignore: cast_nullable_to_non_nullable
as String?,discrepancyProcedure: freezed == discrepancyProcedure ? _self.discrepancyProcedure : discrepancyProcedure // ignore: cast_nullable_to_non_nullable
as String?,buyerConfirmationLimitHours: null == buyerConfirmationLimitHours ? _self.buyerConfirmationLimitHours : buyerConfirmationLimitHours // ignore: cast_nullable_to_non_nullable
as int,sellerInspectionReviewCommitment: null == sellerInspectionReviewCommitment ? _self.sellerInspectionReviewCommitment : sellerInspectionReviewCommitment // ignore: cast_nullable_to_non_nullable
as bool,inspectionNotes: freezed == inspectionNotes ? _self.inspectionNotes : inspectionNotes // ignore: cast_nullable_to_non_nullable
as String?,sellerOwnershipConfirmed: null == sellerOwnershipConfirmed ? _self.sellerOwnershipConfirmed : sellerOwnershipConfirmed // ignore: cast_nullable_to_non_nullable
as bool,titleTransferAcknowledged: null == titleTransferAcknowledged ? _self.titleTransferAcknowledged : titleTransferAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,noOutstandingLiensAcknowledged: null == noOutstandingLiensAcknowledged ? _self.noOutstandingLiensAcknowledged : noOutstandingLiensAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,ownershipTransferProcessAcknowledged: null == ownershipTransferProcessAcknowledged ? _self.ownershipTransferProcessAcknowledged : ownershipTransferProcessAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,specialTransferInstructions: freezed == specialTransferInstructions ? _self.specialTransferInstructions : specialTransferInstructions // ignore: cast_nullable_to_non_nullable
as String?,allIssuesDisclosedAccurately: null == allIssuesDisclosedAccurately ? _self.allIssuesDisclosedAccurately : allIssuesDisclosedAccurately // ignore: cast_nullable_to_non_nullable
as bool,conditionAsRepresented: null == conditionAsRepresented ? _self.conditionAsRepresented : conditionAsRepresented // ignore: cast_nullable_to_non_nullable
as bool,supportingDocumentsUrls: null == supportingDocumentsUrls ? _self.supportingDocumentsUrls : supportingDocumentsUrls // ignore: cast_nullable_to_non_nullable
as List<String>,discussionsLoggedAcknowledged: null == discussionsLoggedAcknowledged ? _self.discussionsLoggedAcknowledged : discussionsLoggedAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,disputeResolutionProcessAgreed: null == disputeResolutionProcessAgreed ? _self.disputeResolutionProcessAgreed : disputeResolutionProcessAgreed // ignore: cast_nullable_to_non_nullable
as bool,fraudPoliciesAcknowledged: null == fraudPoliciesAcknowledged ? _self.fraudPoliciesAcknowledged : fraudPoliciesAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,additionalProtections: freezed == additionalProtections ? _self.additionalProtections : additionalProtections // ignore: cast_nullable_to_non_nullable
as String?,sellerProtectionMeasures: freezed == sellerProtectionMeasures ? _self.sellerProtectionMeasures : sellerProtectionMeasures // ignore: cast_nullable_to_non_nullable
as String?,informationAccuracyConfirmed: null == informationAccuracyConfirmed ? _self.informationAccuracyConfirmed : informationAccuracyConfirmed // ignore: cast_nullable_to_non_nullable
as bool,termsAgreed: null == termsAgreed ? _self.termsAgreed : termsAgreed // ignore: cast_nullable_to_non_nullable
as bool,deliveryDate: freezed == deliveryDate ? _self.deliveryDate : deliveryDate // ignore: cast_nullable_to_non_nullable
as String?,deliveryLocation: freezed == deliveryLocation ? _self.deliveryLocation : deliveryLocation // ignore: cast_nullable_to_non_nullable
as String?,uploadedDocuments: null == uploadedDocuments ? _self.uploadedDocuments : uploadedDocuments // ignore: cast_nullable_to_non_nullable
as List<String>,confirmedAt: null == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String userName,  bool vehicleIdentityConfirmed,  String? vinNumber,  String? licensePlate,  bool conditionAccuratelyRepresented,  List<String> knownIssues,  double finalBidPrice,  double additionalFees,  int paymentTimelineDays,  bool latePaymentPenaltyAcknowledged,  ShippingMethod? shippingMethod,  ShippingCostResponsibility? shippingCostResponsibility,  InsuranceResponsibility? insuranceResponsibility,  int estimatedDeliveryDays,  List<String> requiredShippingEvidence,  bool shippingEvidenceCommitment,  bool transitInsuranceAcknowledged,  int vehicleInspectionPeriodHours,  InspectionMethod? inspectionMethod,  String? acceptanceCriteria,  String? discrepancyProcedure,  int buyerConfirmationLimitHours,  bool sellerInspectionReviewCommitment,  String? inspectionNotes,  bool sellerOwnershipConfirmed,  bool titleTransferAcknowledged,  bool noOutstandingLiensAcknowledged,  bool ownershipTransferProcessAcknowledged,  String? specialTransferInstructions,  bool allIssuesDisclosedAccurately,  bool conditionAsRepresented,  List<String> supportingDocumentsUrls,  bool discussionsLoggedAcknowledged,  bool disputeResolutionProcessAgreed,  bool fraudPoliciesAcknowledged,  String? additionalProtections,  String? sellerProtectionMeasures,  bool informationAccuracyConfirmed,  bool termsAgreed,  String? deliveryDate,  String? deliveryLocation,  List<String> uploadedDocuments,  DateTime confirmedAt,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreTransactionConfirmation() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.vehicleIdentityConfirmed,_that.vinNumber,_that.licensePlate,_that.conditionAccuratelyRepresented,_that.knownIssues,_that.finalBidPrice,_that.additionalFees,_that.paymentTimelineDays,_that.latePaymentPenaltyAcknowledged,_that.shippingMethod,_that.shippingCostResponsibility,_that.insuranceResponsibility,_that.estimatedDeliveryDays,_that.requiredShippingEvidence,_that.shippingEvidenceCommitment,_that.transitInsuranceAcknowledged,_that.vehicleInspectionPeriodHours,_that.inspectionMethod,_that.acceptanceCriteria,_that.discrepancyProcedure,_that.buyerConfirmationLimitHours,_that.sellerInspectionReviewCommitment,_that.inspectionNotes,_that.sellerOwnershipConfirmed,_that.titleTransferAcknowledged,_that.noOutstandingLiensAcknowledged,_that.ownershipTransferProcessAcknowledged,_that.specialTransferInstructions,_that.allIssuesDisclosedAccurately,_that.conditionAsRepresented,_that.supportingDocumentsUrls,_that.discussionsLoggedAcknowledged,_that.disputeResolutionProcessAgreed,_that.fraudPoliciesAcknowledged,_that.additionalProtections,_that.sellerProtectionMeasures,_that.informationAccuracyConfirmed,_that.termsAgreed,_that.deliveryDate,_that.deliveryLocation,_that.uploadedDocuments,_that.confirmedAt,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String userName,  bool vehicleIdentityConfirmed,  String? vinNumber,  String? licensePlate,  bool conditionAccuratelyRepresented,  List<String> knownIssues,  double finalBidPrice,  double additionalFees,  int paymentTimelineDays,  bool latePaymentPenaltyAcknowledged,  ShippingMethod? shippingMethod,  ShippingCostResponsibility? shippingCostResponsibility,  InsuranceResponsibility? insuranceResponsibility,  int estimatedDeliveryDays,  List<String> requiredShippingEvidence,  bool shippingEvidenceCommitment,  bool transitInsuranceAcknowledged,  int vehicleInspectionPeriodHours,  InspectionMethod? inspectionMethod,  String? acceptanceCriteria,  String? discrepancyProcedure,  int buyerConfirmationLimitHours,  bool sellerInspectionReviewCommitment,  String? inspectionNotes,  bool sellerOwnershipConfirmed,  bool titleTransferAcknowledged,  bool noOutstandingLiensAcknowledged,  bool ownershipTransferProcessAcknowledged,  String? specialTransferInstructions,  bool allIssuesDisclosedAccurately,  bool conditionAsRepresented,  List<String> supportingDocumentsUrls,  bool discussionsLoggedAcknowledged,  bool disputeResolutionProcessAgreed,  bool fraudPoliciesAcknowledged,  String? additionalProtections,  String? sellerProtectionMeasures,  bool informationAccuracyConfirmed,  bool termsAgreed,  String? deliveryDate,  String? deliveryLocation,  List<String> uploadedDocuments,  DateTime confirmedAt,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _PreTransactionConfirmation():
return $default(_that.id,_that.userId,_that.userName,_that.vehicleIdentityConfirmed,_that.vinNumber,_that.licensePlate,_that.conditionAccuratelyRepresented,_that.knownIssues,_that.finalBidPrice,_that.additionalFees,_that.paymentTimelineDays,_that.latePaymentPenaltyAcknowledged,_that.shippingMethod,_that.shippingCostResponsibility,_that.insuranceResponsibility,_that.estimatedDeliveryDays,_that.requiredShippingEvidence,_that.shippingEvidenceCommitment,_that.transitInsuranceAcknowledged,_that.vehicleInspectionPeriodHours,_that.inspectionMethod,_that.acceptanceCriteria,_that.discrepancyProcedure,_that.buyerConfirmationLimitHours,_that.sellerInspectionReviewCommitment,_that.inspectionNotes,_that.sellerOwnershipConfirmed,_that.titleTransferAcknowledged,_that.noOutstandingLiensAcknowledged,_that.ownershipTransferProcessAcknowledged,_that.specialTransferInstructions,_that.allIssuesDisclosedAccurately,_that.conditionAsRepresented,_that.supportingDocumentsUrls,_that.discussionsLoggedAcknowledged,_that.disputeResolutionProcessAgreed,_that.fraudPoliciesAcknowledged,_that.additionalProtections,_that.sellerProtectionMeasures,_that.informationAccuracyConfirmed,_that.termsAgreed,_that.deliveryDate,_that.deliveryLocation,_that.uploadedDocuments,_that.confirmedAt,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String userName,  bool vehicleIdentityConfirmed,  String? vinNumber,  String? licensePlate,  bool conditionAccuratelyRepresented,  List<String> knownIssues,  double finalBidPrice,  double additionalFees,  int paymentTimelineDays,  bool latePaymentPenaltyAcknowledged,  ShippingMethod? shippingMethod,  ShippingCostResponsibility? shippingCostResponsibility,  InsuranceResponsibility? insuranceResponsibility,  int estimatedDeliveryDays,  List<String> requiredShippingEvidence,  bool shippingEvidenceCommitment,  bool transitInsuranceAcknowledged,  int vehicleInspectionPeriodHours,  InspectionMethod? inspectionMethod,  String? acceptanceCriteria,  String? discrepancyProcedure,  int buyerConfirmationLimitHours,  bool sellerInspectionReviewCommitment,  String? inspectionNotes,  bool sellerOwnershipConfirmed,  bool titleTransferAcknowledged,  bool noOutstandingLiensAcknowledged,  bool ownershipTransferProcessAcknowledged,  String? specialTransferInstructions,  bool allIssuesDisclosedAccurately,  bool conditionAsRepresented,  List<String> supportingDocumentsUrls,  bool discussionsLoggedAcknowledged,  bool disputeResolutionProcessAgreed,  bool fraudPoliciesAcknowledged,  String? additionalProtections,  String? sellerProtectionMeasures,  bool informationAccuracyConfirmed,  bool termsAgreed,  String? deliveryDate,  String? deliveryLocation,  List<String> uploadedDocuments,  DateTime confirmedAt,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _PreTransactionConfirmation() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.vehicleIdentityConfirmed,_that.vinNumber,_that.licensePlate,_that.conditionAccuratelyRepresented,_that.knownIssues,_that.finalBidPrice,_that.additionalFees,_that.paymentTimelineDays,_that.latePaymentPenaltyAcknowledged,_that.shippingMethod,_that.shippingCostResponsibility,_that.insuranceResponsibility,_that.estimatedDeliveryDays,_that.requiredShippingEvidence,_that.shippingEvidenceCommitment,_that.transitInsuranceAcknowledged,_that.vehicleInspectionPeriodHours,_that.inspectionMethod,_that.acceptanceCriteria,_that.discrepancyProcedure,_that.buyerConfirmationLimitHours,_that.sellerInspectionReviewCommitment,_that.inspectionNotes,_that.sellerOwnershipConfirmed,_that.titleTransferAcknowledged,_that.noOutstandingLiensAcknowledged,_that.ownershipTransferProcessAcknowledged,_that.specialTransferInstructions,_that.allIssuesDisclosedAccurately,_that.conditionAsRepresented,_that.supportingDocumentsUrls,_that.discussionsLoggedAcknowledged,_that.disputeResolutionProcessAgreed,_that.fraudPoliciesAcknowledged,_that.additionalProtections,_that.sellerProtectionMeasures,_that.informationAccuracyConfirmed,_that.termsAgreed,_that.deliveryDate,_that.deliveryLocation,_that.uploadedDocuments,_that.confirmedAt,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreTransactionConfirmation implements PreTransactionConfirmation {
  const _PreTransactionConfirmation({required this.id, required this.userId, required this.userName, required this.vehicleIdentityConfirmed, this.vinNumber, this.licensePlate, required this.conditionAccuratelyRepresented, final  List<String> knownIssues = const [], required this.finalBidPrice, this.additionalFees = 0.0, this.paymentTimelineDays = 3, this.latePaymentPenaltyAcknowledged = false, this.shippingMethod, this.shippingCostResponsibility, this.insuranceResponsibility, this.estimatedDeliveryDays = 3, final  List<String> requiredShippingEvidence = const ['VIN Photo', '360° Video', 'Shipping Receipt', 'GPS Check-in'], this.shippingEvidenceCommitment = false, this.transitInsuranceAcknowledged = false, this.vehicleInspectionPeriodHours = 48, this.inspectionMethod, this.acceptanceCriteria, this.discrepancyProcedure, this.buyerConfirmationLimitHours = 24, this.sellerInspectionReviewCommitment = false, this.inspectionNotes, this.sellerOwnershipConfirmed = false, this.titleTransferAcknowledged = false, this.noOutstandingLiensAcknowledged = false, this.ownershipTransferProcessAcknowledged = false, this.specialTransferInstructions, this.allIssuesDisclosedAccurately = false, this.conditionAsRepresented = false, final  List<String> supportingDocumentsUrls = const [], this.discussionsLoggedAcknowledged = false, this.disputeResolutionProcessAgreed = false, this.fraudPoliciesAcknowledged = false, this.additionalProtections, this.sellerProtectionMeasures, this.informationAccuracyConfirmed = false, required this.termsAgreed, this.deliveryDate, this.deliveryLocation, final  List<String> uploadedDocuments = const [], required this.confirmedAt, this.notes}): _knownIssues = knownIssues,_requiredShippingEvidence = requiredShippingEvidence,_supportingDocumentsUrls = supportingDocumentsUrls,_uploadedDocuments = uploadedDocuments;
  factory _PreTransactionConfirmation.fromJson(Map<String, dynamic> json) => _$PreTransactionConfirmationFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String userName;
// ===== VEHICLE IDENTITY VERIFICATION =====
/// Confirms VIN, license plate, make, model, year, color match listing
@override final  bool vehicleIdentityConfirmed;
@override final  String? vinNumber;
@override final  String? licensePlate;
// ===== CONDITION & ISSUES =====
/// Confirms vehicle condition and known issues are accurately represented
@override final  bool conditionAccuratelyRepresented;
 final  List<String> _knownIssues;
@override@JsonKey() List<String> get knownIssues {
  if (_knownIssues is EqualUnmodifiableListView) return _knownIssues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_knownIssues);
}

// ===== PRICING CONFIRMATION =====
/// Final bid price confirmed and accepted
@override final  double finalBidPrice;
@override@JsonKey() final  double additionalFees;
// ===== PAYMENT TIMELINE =====
/// Number of days agreed for payment (e.g., 3 days)
@override@JsonKey() final  int paymentTimelineDays;
/// Buyer acknowledges late payment penalties
@override@JsonKey() final  bool latePaymentPenaltyAcknowledged;
// ===== SHIPPING & DELIVERY =====
/// Shipping/delivery method agreed
@override final  ShippingMethod? shippingMethod;
/// Who pays for shipping
@override final  ShippingCostResponsibility? shippingCostResponsibility;
/// Who is responsible for insurance
@override final  InsuranceResponsibility? insuranceResponsibility;
/// Estimated delivery timeframe in days
@override@JsonKey() final  int estimatedDeliveryDays;
/// Required shipping evidence types agreed
 final  List<String> _requiredShippingEvidence;
/// Required shipping evidence types agreed
@override@JsonKey() List<String> get requiredShippingEvidence {
  if (_requiredShippingEvidence is EqualUnmodifiableListView) return _requiredShippingEvidence;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requiredShippingEvidence);
}

/// Seller agrees to submit all required shipping evidence
@override@JsonKey() final  bool shippingEvidenceCommitment;
/// Seller acknowledges insurance responsibility during transit
@override@JsonKey() final  bool transitInsuranceAcknowledged;
// ===== INSPECTION & ACCEPTANCE =====
/// Vehicle inspection period (hours)
@override@JsonKey() final  int vehicleInspectionPeriodHours;
/// Inspection method agreed
@override final  InspectionMethod? inspectionMethod;
/// Acceptance criteria description
@override final  String? acceptanceCriteria;
/// Procedure for handling discrepancies
@override final  String? discrepancyProcedure;
/// Buyer confirmation duration limit (hours)
@override@JsonKey() final  int buyerConfirmationLimitHours;
/// Seller will review buyer inspection evidence
@override@JsonKey() final  bool sellerInspectionReviewCommitment;
/// Optional inspection notes
@override final  String? inspectionNotes;
// ===== LEGAL & OWNERSHIP =====
/// Seller confirms legal ownership documents available
@override@JsonKey() final  bool sellerOwnershipConfirmed;
/// Buyer acknowledges receipt of title/registration upon delivery
@override@JsonKey() final  bool titleTransferAcknowledged;
/// No outstanding loans/liens on vehicle
@override@JsonKey() final  bool noOutstandingLiensAcknowledged;
/// Transfer of ownership process acknowledged
@override@JsonKey() final  bool ownershipTransferProcessAcknowledged;
/// Special transfer instructions or legal considerations
@override final  String? specialTransferInstructions;
// ===== SELLER CONFIRMATIONS (TRANSACTION_FLOW.md lines 54-58) =====
/// All known issues, damages, accidents disclosed accurately
@override@JsonKey() final  bool allIssuesDisclosedAccurately;
/// Condition as represented in listing (scratches, dents, etc.)
@override@JsonKey() final  bool conditionAsRepresented;
/// Supporting documents uploaded for verification
 final  List<String> _supportingDocumentsUrls;
/// Supporting documents uploaded for verification
@override@JsonKey() List<String> get supportingDocumentsUrls {
  if (_supportingDocumentsUrls is EqualUnmodifiableListView) return _supportingDocumentsUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supportingDocumentsUrls);
}

// ===== DISPUTE & PROTECTION =====
/// Discussions/messages logged for dispute resolution
@override@JsonKey() final  bool discussionsLoggedAcknowledged;
/// Agrees to platform dispute resolution process
@override@JsonKey() final  bool disputeResolutionProcessAgreed;
/// Acknowledges fraud/collusion policies
@override@JsonKey() final  bool fraudPoliciesAcknowledged;
/// Additional protections requested or agreed
@override final  String? additionalProtections;
/// Seller-requested protection measures
@override final  String? sellerProtectionMeasures;
// ===== FINAL CONFIRMATIONS (TRANSACTION_FLOW.md lines 84-85) =====
/// Seller confirms all information is accurate and complete
@override@JsonKey() final  bool informationAccuracyConfirmed;
/// Platform terms commitment (payment, shipping, inspection)
@override final  bool termsAgreed;
// ===== DELIVERY DETAILS (Existing) =====
@override final  String? deliveryDate;
@override final  String? deliveryLocation;
 final  List<String> _uploadedDocuments;
@override@JsonKey() List<String> get uploadedDocuments {
  if (_uploadedDocuments is EqualUnmodifiableListView) return _uploadedDocuments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uploadedDocuments);
}

// ===== METADATA =====
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreTransactionConfirmation&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.vehicleIdentityConfirmed, vehicleIdentityConfirmed) || other.vehicleIdentityConfirmed == vehicleIdentityConfirmed)&&(identical(other.vinNumber, vinNumber) || other.vinNumber == vinNumber)&&(identical(other.licensePlate, licensePlate) || other.licensePlate == licensePlate)&&(identical(other.conditionAccuratelyRepresented, conditionAccuratelyRepresented) || other.conditionAccuratelyRepresented == conditionAccuratelyRepresented)&&const DeepCollectionEquality().equals(other._knownIssues, _knownIssues)&&(identical(other.finalBidPrice, finalBidPrice) || other.finalBidPrice == finalBidPrice)&&(identical(other.additionalFees, additionalFees) || other.additionalFees == additionalFees)&&(identical(other.paymentTimelineDays, paymentTimelineDays) || other.paymentTimelineDays == paymentTimelineDays)&&(identical(other.latePaymentPenaltyAcknowledged, latePaymentPenaltyAcknowledged) || other.latePaymentPenaltyAcknowledged == latePaymentPenaltyAcknowledged)&&(identical(other.shippingMethod, shippingMethod) || other.shippingMethod == shippingMethod)&&(identical(other.shippingCostResponsibility, shippingCostResponsibility) || other.shippingCostResponsibility == shippingCostResponsibility)&&(identical(other.insuranceResponsibility, insuranceResponsibility) || other.insuranceResponsibility == insuranceResponsibility)&&(identical(other.estimatedDeliveryDays, estimatedDeliveryDays) || other.estimatedDeliveryDays == estimatedDeliveryDays)&&const DeepCollectionEquality().equals(other._requiredShippingEvidence, _requiredShippingEvidence)&&(identical(other.shippingEvidenceCommitment, shippingEvidenceCommitment) || other.shippingEvidenceCommitment == shippingEvidenceCommitment)&&(identical(other.transitInsuranceAcknowledged, transitInsuranceAcknowledged) || other.transitInsuranceAcknowledged == transitInsuranceAcknowledged)&&(identical(other.vehicleInspectionPeriodHours, vehicleInspectionPeriodHours) || other.vehicleInspectionPeriodHours == vehicleInspectionPeriodHours)&&(identical(other.inspectionMethod, inspectionMethod) || other.inspectionMethod == inspectionMethod)&&(identical(other.acceptanceCriteria, acceptanceCriteria) || other.acceptanceCriteria == acceptanceCriteria)&&(identical(other.discrepancyProcedure, discrepancyProcedure) || other.discrepancyProcedure == discrepancyProcedure)&&(identical(other.buyerConfirmationLimitHours, buyerConfirmationLimitHours) || other.buyerConfirmationLimitHours == buyerConfirmationLimitHours)&&(identical(other.sellerInspectionReviewCommitment, sellerInspectionReviewCommitment) || other.sellerInspectionReviewCommitment == sellerInspectionReviewCommitment)&&(identical(other.inspectionNotes, inspectionNotes) || other.inspectionNotes == inspectionNotes)&&(identical(other.sellerOwnershipConfirmed, sellerOwnershipConfirmed) || other.sellerOwnershipConfirmed == sellerOwnershipConfirmed)&&(identical(other.titleTransferAcknowledged, titleTransferAcknowledged) || other.titleTransferAcknowledged == titleTransferAcknowledged)&&(identical(other.noOutstandingLiensAcknowledged, noOutstandingLiensAcknowledged) || other.noOutstandingLiensAcknowledged == noOutstandingLiensAcknowledged)&&(identical(other.ownershipTransferProcessAcknowledged, ownershipTransferProcessAcknowledged) || other.ownershipTransferProcessAcknowledged == ownershipTransferProcessAcknowledged)&&(identical(other.specialTransferInstructions, specialTransferInstructions) || other.specialTransferInstructions == specialTransferInstructions)&&(identical(other.allIssuesDisclosedAccurately, allIssuesDisclosedAccurately) || other.allIssuesDisclosedAccurately == allIssuesDisclosedAccurately)&&(identical(other.conditionAsRepresented, conditionAsRepresented) || other.conditionAsRepresented == conditionAsRepresented)&&const DeepCollectionEquality().equals(other._supportingDocumentsUrls, _supportingDocumentsUrls)&&(identical(other.discussionsLoggedAcknowledged, discussionsLoggedAcknowledged) || other.discussionsLoggedAcknowledged == discussionsLoggedAcknowledged)&&(identical(other.disputeResolutionProcessAgreed, disputeResolutionProcessAgreed) || other.disputeResolutionProcessAgreed == disputeResolutionProcessAgreed)&&(identical(other.fraudPoliciesAcknowledged, fraudPoliciesAcknowledged) || other.fraudPoliciesAcknowledged == fraudPoliciesAcknowledged)&&(identical(other.additionalProtections, additionalProtections) || other.additionalProtections == additionalProtections)&&(identical(other.sellerProtectionMeasures, sellerProtectionMeasures) || other.sellerProtectionMeasures == sellerProtectionMeasures)&&(identical(other.informationAccuracyConfirmed, informationAccuracyConfirmed) || other.informationAccuracyConfirmed == informationAccuracyConfirmed)&&(identical(other.termsAgreed, termsAgreed) || other.termsAgreed == termsAgreed)&&(identical(other.deliveryDate, deliveryDate) || other.deliveryDate == deliveryDate)&&(identical(other.deliveryLocation, deliveryLocation) || other.deliveryLocation == deliveryLocation)&&const DeepCollectionEquality().equals(other._uploadedDocuments, _uploadedDocuments)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,userName,vehicleIdentityConfirmed,vinNumber,licensePlate,conditionAccuratelyRepresented,const DeepCollectionEquality().hash(_knownIssues),finalBidPrice,additionalFees,paymentTimelineDays,latePaymentPenaltyAcknowledged,shippingMethod,shippingCostResponsibility,insuranceResponsibility,estimatedDeliveryDays,const DeepCollectionEquality().hash(_requiredShippingEvidence),shippingEvidenceCommitment,transitInsuranceAcknowledged,vehicleInspectionPeriodHours,inspectionMethod,acceptanceCriteria,discrepancyProcedure,buyerConfirmationLimitHours,sellerInspectionReviewCommitment,inspectionNotes,sellerOwnershipConfirmed,titleTransferAcknowledged,noOutstandingLiensAcknowledged,ownershipTransferProcessAcknowledged,specialTransferInstructions,allIssuesDisclosedAccurately,conditionAsRepresented,const DeepCollectionEquality().hash(_supportingDocumentsUrls),discussionsLoggedAcknowledged,disputeResolutionProcessAgreed,fraudPoliciesAcknowledged,additionalProtections,sellerProtectionMeasures,informationAccuracyConfirmed,termsAgreed,deliveryDate,deliveryLocation,const DeepCollectionEquality().hash(_uploadedDocuments),confirmedAt,notes]);

@override
String toString() {
  return 'PreTransactionConfirmation(id: $id, userId: $userId, userName: $userName, vehicleIdentityConfirmed: $vehicleIdentityConfirmed, vinNumber: $vinNumber, licensePlate: $licensePlate, conditionAccuratelyRepresented: $conditionAccuratelyRepresented, knownIssues: $knownIssues, finalBidPrice: $finalBidPrice, additionalFees: $additionalFees, paymentTimelineDays: $paymentTimelineDays, latePaymentPenaltyAcknowledged: $latePaymentPenaltyAcknowledged, shippingMethod: $shippingMethod, shippingCostResponsibility: $shippingCostResponsibility, insuranceResponsibility: $insuranceResponsibility, estimatedDeliveryDays: $estimatedDeliveryDays, requiredShippingEvidence: $requiredShippingEvidence, shippingEvidenceCommitment: $shippingEvidenceCommitment, transitInsuranceAcknowledged: $transitInsuranceAcknowledged, vehicleInspectionPeriodHours: $vehicleInspectionPeriodHours, inspectionMethod: $inspectionMethod, acceptanceCriteria: $acceptanceCriteria, discrepancyProcedure: $discrepancyProcedure, buyerConfirmationLimitHours: $buyerConfirmationLimitHours, sellerInspectionReviewCommitment: $sellerInspectionReviewCommitment, inspectionNotes: $inspectionNotes, sellerOwnershipConfirmed: $sellerOwnershipConfirmed, titleTransferAcknowledged: $titleTransferAcknowledged, noOutstandingLiensAcknowledged: $noOutstandingLiensAcknowledged, ownershipTransferProcessAcknowledged: $ownershipTransferProcessAcknowledged, specialTransferInstructions: $specialTransferInstructions, allIssuesDisclosedAccurately: $allIssuesDisclosedAccurately, conditionAsRepresented: $conditionAsRepresented, supportingDocumentsUrls: $supportingDocumentsUrls, discussionsLoggedAcknowledged: $discussionsLoggedAcknowledged, disputeResolutionProcessAgreed: $disputeResolutionProcessAgreed, fraudPoliciesAcknowledged: $fraudPoliciesAcknowledged, additionalProtections: $additionalProtections, sellerProtectionMeasures: $sellerProtectionMeasures, informationAccuracyConfirmed: $informationAccuracyConfirmed, termsAgreed: $termsAgreed, deliveryDate: $deliveryDate, deliveryLocation: $deliveryLocation, uploadedDocuments: $uploadedDocuments, confirmedAt: $confirmedAt, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$PreTransactionConfirmationCopyWith<$Res> implements $PreTransactionConfirmationCopyWith<$Res> {
  factory _$PreTransactionConfirmationCopyWith(_PreTransactionConfirmation value, $Res Function(_PreTransactionConfirmation) _then) = __$PreTransactionConfirmationCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String userName, bool vehicleIdentityConfirmed, String? vinNumber, String? licensePlate, bool conditionAccuratelyRepresented, List<String> knownIssues, double finalBidPrice, double additionalFees, int paymentTimelineDays, bool latePaymentPenaltyAcknowledged, ShippingMethod? shippingMethod, ShippingCostResponsibility? shippingCostResponsibility, InsuranceResponsibility? insuranceResponsibility, int estimatedDeliveryDays, List<String> requiredShippingEvidence, bool shippingEvidenceCommitment, bool transitInsuranceAcknowledged, int vehicleInspectionPeriodHours, InspectionMethod? inspectionMethod, String? acceptanceCriteria, String? discrepancyProcedure, int buyerConfirmationLimitHours, bool sellerInspectionReviewCommitment, String? inspectionNotes, bool sellerOwnershipConfirmed, bool titleTransferAcknowledged, bool noOutstandingLiensAcknowledged, bool ownershipTransferProcessAcknowledged, String? specialTransferInstructions, bool allIssuesDisclosedAccurately, bool conditionAsRepresented, List<String> supportingDocumentsUrls, bool discussionsLoggedAcknowledged, bool disputeResolutionProcessAgreed, bool fraudPoliciesAcknowledged, String? additionalProtections, String? sellerProtectionMeasures, bool informationAccuracyConfirmed, bool termsAgreed, String? deliveryDate, String? deliveryLocation, List<String> uploadedDocuments, DateTime confirmedAt, String? notes
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? userName = null,Object? vehicleIdentityConfirmed = null,Object? vinNumber = freezed,Object? licensePlate = freezed,Object? conditionAccuratelyRepresented = null,Object? knownIssues = null,Object? finalBidPrice = null,Object? additionalFees = null,Object? paymentTimelineDays = null,Object? latePaymentPenaltyAcknowledged = null,Object? shippingMethod = freezed,Object? shippingCostResponsibility = freezed,Object? insuranceResponsibility = freezed,Object? estimatedDeliveryDays = null,Object? requiredShippingEvidence = null,Object? shippingEvidenceCommitment = null,Object? transitInsuranceAcknowledged = null,Object? vehicleInspectionPeriodHours = null,Object? inspectionMethod = freezed,Object? acceptanceCriteria = freezed,Object? discrepancyProcedure = freezed,Object? buyerConfirmationLimitHours = null,Object? sellerInspectionReviewCommitment = null,Object? inspectionNotes = freezed,Object? sellerOwnershipConfirmed = null,Object? titleTransferAcknowledged = null,Object? noOutstandingLiensAcknowledged = null,Object? ownershipTransferProcessAcknowledged = null,Object? specialTransferInstructions = freezed,Object? allIssuesDisclosedAccurately = null,Object? conditionAsRepresented = null,Object? supportingDocumentsUrls = null,Object? discussionsLoggedAcknowledged = null,Object? disputeResolutionProcessAgreed = null,Object? fraudPoliciesAcknowledged = null,Object? additionalProtections = freezed,Object? sellerProtectionMeasures = freezed,Object? informationAccuracyConfirmed = null,Object? termsAgreed = null,Object? deliveryDate = freezed,Object? deliveryLocation = freezed,Object? uploadedDocuments = null,Object? confirmedAt = null,Object? notes = freezed,}) {
  return _then(_PreTransactionConfirmation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,vehicleIdentityConfirmed: null == vehicleIdentityConfirmed ? _self.vehicleIdentityConfirmed : vehicleIdentityConfirmed // ignore: cast_nullable_to_non_nullable
as bool,vinNumber: freezed == vinNumber ? _self.vinNumber : vinNumber // ignore: cast_nullable_to_non_nullable
as String?,licensePlate: freezed == licensePlate ? _self.licensePlate : licensePlate // ignore: cast_nullable_to_non_nullable
as String?,conditionAccuratelyRepresented: null == conditionAccuratelyRepresented ? _self.conditionAccuratelyRepresented : conditionAccuratelyRepresented // ignore: cast_nullable_to_non_nullable
as bool,knownIssues: null == knownIssues ? _self._knownIssues : knownIssues // ignore: cast_nullable_to_non_nullable
as List<String>,finalBidPrice: null == finalBidPrice ? _self.finalBidPrice : finalBidPrice // ignore: cast_nullable_to_non_nullable
as double,additionalFees: null == additionalFees ? _self.additionalFees : additionalFees // ignore: cast_nullable_to_non_nullable
as double,paymentTimelineDays: null == paymentTimelineDays ? _self.paymentTimelineDays : paymentTimelineDays // ignore: cast_nullable_to_non_nullable
as int,latePaymentPenaltyAcknowledged: null == latePaymentPenaltyAcknowledged ? _self.latePaymentPenaltyAcknowledged : latePaymentPenaltyAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,shippingMethod: freezed == shippingMethod ? _self.shippingMethod : shippingMethod // ignore: cast_nullable_to_non_nullable
as ShippingMethod?,shippingCostResponsibility: freezed == shippingCostResponsibility ? _self.shippingCostResponsibility : shippingCostResponsibility // ignore: cast_nullable_to_non_nullable
as ShippingCostResponsibility?,insuranceResponsibility: freezed == insuranceResponsibility ? _self.insuranceResponsibility : insuranceResponsibility // ignore: cast_nullable_to_non_nullable
as InsuranceResponsibility?,estimatedDeliveryDays: null == estimatedDeliveryDays ? _self.estimatedDeliveryDays : estimatedDeliveryDays // ignore: cast_nullable_to_non_nullable
as int,requiredShippingEvidence: null == requiredShippingEvidence ? _self._requiredShippingEvidence : requiredShippingEvidence // ignore: cast_nullable_to_non_nullable
as List<String>,shippingEvidenceCommitment: null == shippingEvidenceCommitment ? _self.shippingEvidenceCommitment : shippingEvidenceCommitment // ignore: cast_nullable_to_non_nullable
as bool,transitInsuranceAcknowledged: null == transitInsuranceAcknowledged ? _self.transitInsuranceAcknowledged : transitInsuranceAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,vehicleInspectionPeriodHours: null == vehicleInspectionPeriodHours ? _self.vehicleInspectionPeriodHours : vehicleInspectionPeriodHours // ignore: cast_nullable_to_non_nullable
as int,inspectionMethod: freezed == inspectionMethod ? _self.inspectionMethod : inspectionMethod // ignore: cast_nullable_to_non_nullable
as InspectionMethod?,acceptanceCriteria: freezed == acceptanceCriteria ? _self.acceptanceCriteria : acceptanceCriteria // ignore: cast_nullable_to_non_nullable
as String?,discrepancyProcedure: freezed == discrepancyProcedure ? _self.discrepancyProcedure : discrepancyProcedure // ignore: cast_nullable_to_non_nullable
as String?,buyerConfirmationLimitHours: null == buyerConfirmationLimitHours ? _self.buyerConfirmationLimitHours : buyerConfirmationLimitHours // ignore: cast_nullable_to_non_nullable
as int,sellerInspectionReviewCommitment: null == sellerInspectionReviewCommitment ? _self.sellerInspectionReviewCommitment : sellerInspectionReviewCommitment // ignore: cast_nullable_to_non_nullable
as bool,inspectionNotes: freezed == inspectionNotes ? _self.inspectionNotes : inspectionNotes // ignore: cast_nullable_to_non_nullable
as String?,sellerOwnershipConfirmed: null == sellerOwnershipConfirmed ? _self.sellerOwnershipConfirmed : sellerOwnershipConfirmed // ignore: cast_nullable_to_non_nullable
as bool,titleTransferAcknowledged: null == titleTransferAcknowledged ? _self.titleTransferAcknowledged : titleTransferAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,noOutstandingLiensAcknowledged: null == noOutstandingLiensAcknowledged ? _self.noOutstandingLiensAcknowledged : noOutstandingLiensAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,ownershipTransferProcessAcknowledged: null == ownershipTransferProcessAcknowledged ? _self.ownershipTransferProcessAcknowledged : ownershipTransferProcessAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,specialTransferInstructions: freezed == specialTransferInstructions ? _self.specialTransferInstructions : specialTransferInstructions // ignore: cast_nullable_to_non_nullable
as String?,allIssuesDisclosedAccurately: null == allIssuesDisclosedAccurately ? _self.allIssuesDisclosedAccurately : allIssuesDisclosedAccurately // ignore: cast_nullable_to_non_nullable
as bool,conditionAsRepresented: null == conditionAsRepresented ? _self.conditionAsRepresented : conditionAsRepresented // ignore: cast_nullable_to_non_nullable
as bool,supportingDocumentsUrls: null == supportingDocumentsUrls ? _self._supportingDocumentsUrls : supportingDocumentsUrls // ignore: cast_nullable_to_non_nullable
as List<String>,discussionsLoggedAcknowledged: null == discussionsLoggedAcknowledged ? _self.discussionsLoggedAcknowledged : discussionsLoggedAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,disputeResolutionProcessAgreed: null == disputeResolutionProcessAgreed ? _self.disputeResolutionProcessAgreed : disputeResolutionProcessAgreed // ignore: cast_nullable_to_non_nullable
as bool,fraudPoliciesAcknowledged: null == fraudPoliciesAcknowledged ? _self.fraudPoliciesAcknowledged : fraudPoliciesAcknowledged // ignore: cast_nullable_to_non_nullable
as bool,additionalProtections: freezed == additionalProtections ? _self.additionalProtections : additionalProtections // ignore: cast_nullable_to_non_nullable
as String?,sellerProtectionMeasures: freezed == sellerProtectionMeasures ? _self.sellerProtectionMeasures : sellerProtectionMeasures // ignore: cast_nullable_to_non_nullable
as String?,informationAccuracyConfirmed: null == informationAccuracyConfirmed ? _self.informationAccuracyConfirmed : informationAccuracyConfirmed // ignore: cast_nullable_to_non_nullable
as bool,termsAgreed: null == termsAgreed ? _self.termsAgreed : termsAgreed // ignore: cast_nullable_to_non_nullable
as bool,deliveryDate: freezed == deliveryDate ? _self.deliveryDate : deliveryDate // ignore: cast_nullable_to_non_nullable
as String?,deliveryLocation: freezed == deliveryLocation ? _self.deliveryLocation : deliveryLocation // ignore: cast_nullable_to_non_nullable
as String?,uploadedDocuments: null == uploadedDocuments ? _self._uploadedDocuments : uploadedDocuments // ignore: cast_nullable_to_non_nullable
as List<String>,confirmedAt: null == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
