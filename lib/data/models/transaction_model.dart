import 'package:freezed_annotation/freezed_annotation.dart';
import 'transaction_timeline.dart';
import 'pricing_config.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

enum EscrowStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('held')
  held,
  @JsonValue('validating')
  validating,
  @JsonValue('released')
  released,
  @JsonValue('refunded')
  refunded,
  @JsonValue('disputed')
  disputed,
  @JsonValue('underReview')
  underReview,
}

enum PaymentMethodType {
  @JsonValue('gcash')
  gcash,
  @JsonValue('paymaya')
  paymaya,
  @JsonValue('bank_transfer')
  bankTransfer,
  @JsonValue('cash')
  cash,
  @JsonValue('card')
  card,
}

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required String auctionId,
    required String carId,
    required String buyerId,
    required String sellerId,
    required String buyerName,
    required String sellerName,
    required String carTitle,
    required double amount,
    required double platformFee,
    required double totalAmount,
    required EscrowStatus escrowStatus,
    PaymentMethodType? paymentMethod,
    String? paymentReference,
    String? paymentProof,
    required DateTime createdAt,
    DateTime? paidAt,
    DateTime? releasedAt,
    DateTime? completedAt,
    @Default([]) List<TransactionTimeline> timeline,

    // Transfer validation
    String? transferEvidenceId,
    DateTime? evidenceSubmittedAt,
    DateTime? validationCompletedAt,

    // Dispute/Refund
    String? disputeId,
    DateTime? disputedAt,
    DateTime? refundedAt,

    // ===== EXTENDED: Detailed Fee Breakdown =====
    // These fields provide transparency on platform fees:
    // - Listing fee: Fixed fee charged when auction was created
    // - Transaction fee: Percentage-based fee on final sale price
    // - Fee rate & tier: Which pricing tier was applied

    /// Listing fee charged to seller when auction was created (PHP 300-500)
    /// Separate from transaction fee, covers listing operational costs
    @Default(0.0) double listingFee,

    /// Transaction fee rate applied (e.g., 0.05 = 5%, 0.04 = 4%, 0.03 = 3%)
    /// Varies by price tier: Economy (5%), Mid-Range (4%), Premium (3%)
    @Default(0.0) double transactionFeeRate,

    /// Calculated transaction fee amount (salePrice * transactionFeeRate)
    /// This is the escrow handling fee deducted from seller's proceeds
    @Default(0.0) double transactionFee,

    /// Price tier used for fee calculation
    /// Determines which transaction fee rate applies
    PriceTier? priceTier,

    /// Amount seller receives after all fees deducted
    /// Formula: amount - listingFee - transactionFee
    @Default(0.0) double sellerPayout,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
