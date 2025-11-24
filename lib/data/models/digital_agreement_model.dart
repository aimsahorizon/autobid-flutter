import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_agreement_model.freezed.dart';
part 'digital_agreement_model.g.dart';

/// Digital agreement status
enum DigitalAgreementStatus {
  @JsonValue('draft')
  draft, // Agreement generated but not signed
  @JsonValue('partial_signed')
  partialSigned, // One party signed
  @JsonValue('fully_signed')
  fullySigned, // Both parties signed
}

/// Digital sale agreement model compliant with RA 8792
/// Legally binding electronic contract for vehicle sale
@freezed
abstract class DigitalAgreement with _$DigitalAgreement {
  const factory DigitalAgreement({
    required String id,
    required String auctionId,
    required String preTransactionId,

    // ===== BUYER DETAILS =====
    required String buyerId,
    required String buyerName,
    /// Buyer's digital signature (base64 encoded signature data or hash)
    String? buyerSignature,
    DateTime? buyerSignedAt,

    // ===== SELLER DETAILS =====
    required String sellerId,
    required String sellerName,
    /// Seller's digital signature (base64 encoded signature data or hash)
    String? sellerSignature,
    DateTime? sellerSignedAt,

    // ===== VEHICLE DETAILS =====
    required String vehicleMake,
    required String vehicleModel,
    required String vehicleYear,
    required String vinNumber,
    required String licensePlate,
    String? vehicleColor,

    // ===== FINANCIAL TERMS =====
    required double finalBidPrice,
    @Default(0.0) double additionalFees,
    @Default(0.0) double totalAmount, // finalBidPrice + additionalFees

    // ===== PAYMENT & DELIVERY TERMS =====
    required String paymentTerms, // e.g., "Full payment within 3 days"
    required String deliveryMethod, // e.g., "Seller-arranged delivery"

    /// Acknowledgment that ownership transfers upon delivery and payment
    @Default(true) bool transferAcknowledgment,

    // ===== RA 8792 LEGAL CONSENT =====
    /// Legal consent text displayed to both parties
    /// "This digital agreement is legally binding under the Electronic Commerce
    /// Act of 2000 (RA 8792), Sections 6-10. Electronic signatures have the
    /// same legal effect as handwritten signatures."
    required String legalConsentText,

    // ===== DISPUTE RESOLUTION =====
    /// Dispute resolution clause
    /// Default: "Any disputes arising from this agreement shall be resolved
    /// through the AutoBID dispute resolution process in accordance with
    /// Philippine law."
    required String disputeClause,

    // ===== DOCUMENT INTEGRITY =====
    /// SHA-256 hash of agreement content for audit integrity
    /// Ensures agreement cannot be tampered with after signing
    required String documentHash,

    // ===== METADATA =====
    /// Timestamp when agreement was generated
    required DateTime agreementGeneratedAt,

    /// Current status of agreement
    @Default(DigitalAgreementStatus.draft) DigitalAgreementStatus status,
  }) = _DigitalAgreement;

  factory DigitalAgreement.fromJson(Map<String, dynamic> json) =>
      _$DigitalAgreementFromJson(json);
}
