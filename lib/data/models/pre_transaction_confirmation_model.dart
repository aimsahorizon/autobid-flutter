import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_transaction_confirmation_model.freezed.dart';
part 'pre_transaction_confirmation_model.g.dart';

/// Shipping method options as per TRANSACTION_FLOW.md
enum ShippingMethod {
  @JsonValue('pickup')
  pickup,
  @JsonValue('transporter')
  transporter,
  @JsonValue('seller_arranged')
  sellerArranged,
}

/// Shipping cost responsibility
enum ShippingCostResponsibility {
  @JsonValue('buyer')
  buyer,
  @JsonValue('seller')
  seller,
  @JsonValue('shared')
  shared,
}

/// Insurance responsibility
enum InsuranceResponsibility {
  @JsonValue('buyer')
  buyer,
  @JsonValue('seller')
  seller,
  @JsonValue('both')
  both,
}

/// Inspection method
enum InspectionMethod {
  @JsonValue('in_person')
  inPerson,
  @JsonValue('video_walkthrough')
  videoWalkthrough,
  @JsonValue('third_party')
  thirdParty,
}

@freezed
abstract class PreTransactionConfirmation with _$PreTransactionConfirmation {
  const factory PreTransactionConfirmation({
    required String id,
    required String userId,
    required String userName,

    // ===== VEHICLE IDENTITY VERIFICATION =====
    /// Confirms VIN, license plate, make, model, year, color match listing
    required bool vehicleIdentityConfirmed,
    String? vinNumber,
    String? licensePlate,

    // ===== CONDITION & ISSUES =====
    /// Confirms vehicle condition and known issues are accurately represented
    required bool conditionAccuratelyRepresented,
    @Default([]) List<String> knownIssues,

    // ===== PRICING CONFIRMATION =====
    /// Final bid price confirmed and accepted
    required double finalBidPrice,
    @Default(0.0) double additionalFees,

    // ===== PAYMENT TIMELINE =====
    /// Number of days agreed for payment (e.g., 3 days)
    @Default(3) int paymentTimelineDays,
    /// Buyer acknowledges late payment penalties
    @Default(false) bool latePaymentPenaltyAcknowledged,

    // ===== SHIPPING & DELIVERY =====
    /// Shipping/delivery method agreed
    ShippingMethod? shippingMethod,
    /// Who pays for shipping
    ShippingCostResponsibility? shippingCostResponsibility,
    /// Who is responsible for insurance
    InsuranceResponsibility? insuranceResponsibility,
    /// Estimated delivery timeframe in days
    @Default(3) int estimatedDeliveryDays,
    /// Required shipping evidence types agreed
    @Default(['VIN Photo', '360° Video', 'Shipping Receipt', 'GPS Check-in'])
    List<String> requiredShippingEvidence,
    /// Seller agrees to submit all required shipping evidence
    @Default(false) bool shippingEvidenceCommitment,
    /// Seller acknowledges insurance responsibility during transit
    @Default(false) bool transitInsuranceAcknowledged,

    // ===== INSPECTION & ACCEPTANCE =====
    /// Vehicle inspection period (hours)
    @Default(48) int vehicleInspectionPeriodHours,
    /// Inspection method agreed
    InspectionMethod? inspectionMethod,
    /// Acceptance criteria description
    String? acceptanceCriteria,
    /// Procedure for handling discrepancies
    String? discrepancyProcedure,
    /// Buyer confirmation duration limit (hours)
    @Default(24) int buyerConfirmationLimitHours,
    /// Seller will review buyer inspection evidence
    @Default(false) bool sellerInspectionReviewCommitment,
    /// Optional inspection notes
    String? inspectionNotes,

    // ===== LEGAL & OWNERSHIP =====
    /// Seller confirms legal ownership documents available
    @Default(false) bool sellerOwnershipConfirmed,
    /// Buyer acknowledges receipt of title/registration upon delivery
    @Default(false) bool titleTransferAcknowledged,
    /// No outstanding loans/liens on vehicle
    @Default(false) bool noOutstandingLiensAcknowledged,
    /// Transfer of ownership process acknowledged
    @Default(false) bool ownershipTransferProcessAcknowledged,
    /// Special transfer instructions or legal considerations
    String? specialTransferInstructions,

    // ===== SELLER CONFIRMATIONS (TRANSACTION_FLOW.md lines 54-58) =====
    /// All known issues, damages, accidents disclosed accurately
    @Default(false) bool allIssuesDisclosedAccurately,
    /// Condition as represented in listing (scratches, dents, etc.)
    @Default(false) bool conditionAsRepresented,
    /// Supporting documents uploaded for verification
    @Default([]) List<String> supportingDocumentsUrls,

    // ===== DISPUTE & PROTECTION =====
    /// Discussions/messages logged for dispute resolution
    @Default(false) bool discussionsLoggedAcknowledged,
    /// Agrees to platform dispute resolution process
    @Default(false) bool disputeResolutionProcessAgreed,
    /// Acknowledges fraud/collusion policies
    @Default(false) bool fraudPoliciesAcknowledged,
    /// Additional protections requested or agreed
    String? additionalProtections,
    /// Seller-requested protection measures
    String? sellerProtectionMeasures,

    // ===== FINAL CONFIRMATIONS (TRANSACTION_FLOW.md lines 84-85) =====
    /// Seller confirms all information is accurate and complete
    @Default(false) bool informationAccuracyConfirmed,
    /// Platform terms commitment (payment, shipping, inspection)
    required bool termsAgreed,

    // ===== DELIVERY DETAILS (Existing) =====
    String? deliveryDate,
    String? deliveryLocation,
    @Default([]) List<String> uploadedDocuments,

    // ===== METADATA =====
    required DateTime confirmedAt,
    String? notes,
  }) = _PreTransactionConfirmation;

  factory PreTransactionConfirmation.fromJson(Map<String, dynamic> json) =>
      _$PreTransactionConfirmationFromJson(json);
}
