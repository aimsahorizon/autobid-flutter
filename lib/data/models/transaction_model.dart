import 'package:freezed_annotation/freezed_annotation.dart';
import 'transaction_timeline.dart';

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
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
