import 'package:freezed_annotation/freezed_annotation.dart';
import 'pre_transaction_message_model.dart';
import 'pre_transaction_confirmation_model.dart';
import 'kyc_verification_model.dart';
import 'digital_agreement_model.dart';
import 'payment_confirmation_model.dart';
import 'handover_confirmation_model.dart';
import 'audit_log_entry_model.dart';

part 'pre_transaction_model.freezed.dart';
part 'pre_transaction_model.g.dart';

enum PreTransactionStatus {
  @JsonValue('pending_discussion')
  pendingDiscussion,
  @JsonValue('in_discussion')
  inDiscussion,
  @JsonValue('pending_buyer_confirmation')
  pendingBuyerConfirmation,
  @JsonValue('pending_seller_confirmation')
  pendingSellerConfirmation,
  @JsonValue('pending_mutual_confirmation')
  pendingMutualConfirmation,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('pending_admin_review')
  pendingAdminReview,
  @JsonValue('admin_approved')
  adminApproved,
  @JsonValue('ready_for_payment')
  readyForPayment,
  // New checkpoint statuses (no escrow)
  @JsonValue('preparing')
  preparing,
  @JsonValue('shipping')
  shipping,
  @JsonValue('delivered')
  delivered,
  @JsonValue('payment_success')
  paymentSuccess,
  @JsonValue('transaction_complete')
  transactionComplete,
  @JsonValue('cancelled')
  cancelled,
  // ===== RA 8792 COMPLIANT STATUSES =====
  @JsonValue('pending_verification')
  pendingVerification,
  @JsonValue('verification_complete')
  verificationComplete,
  @JsonValue('agreement_draft')
  agreementDraft,
  @JsonValue('agreement_signed')
  agreementSigned,
  @JsonValue('payment_pending')
  paymentPending,
  @JsonValue('payment_confirmed')
  paymentConfirmed,
  @JsonValue('handover_pending')
  handoverPending,
  @JsonValue('handover_complete')
  handoverComplete,
  @JsonValue('transaction_completed')
  transactionCompleted,
}

/// Edit request model for combined review phase
@freezed
abstract class EditRequest with _$EditRequest {
  const factory EditRequest({
    required String id,
    required String requestedBy, // 'buyer' or 'seller'
    required String requestedFrom, // 'buyer' or 'seller'
    required String field,
    required String currentValue,
    required String requestedValue,
    required String reason,
    required DateTime requestedAt,
    @Default(false) bool resolved,
    DateTime? resolvedAt,
  }) = _EditRequest;

  factory EditRequest.fromJson(Map<String, dynamic> json) =>
      _$EditRequestFromJson(json);
}

@freezed
abstract class PreTransaction with _$PreTransaction {
  const factory PreTransaction({
    required String id,
    required String auctionId,
    required String carId,
    required String carTitle,
    required String buyerId,
    required String sellerId,
    required String buyerName,
    required String sellerName,
    required double finalBidAmount,
    required PreTransactionStatus status,
    @Default([]) List<PreTransactionMessage> messages,
    PreTransactionConfirmation? buyerConfirmation,
    PreTransactionConfirmation? sellerConfirmation,
    required DateTime createdAt,
    DateTime? discussionStartedAt,
    DateTime? buyerConfirmedAt,
    DateTime? sellerConfirmedAt,

    // ===== COMBINED REVIEW PHASE =====
    DateTime? mutualReviewStartedAt,
    @Default(false) bool buyerMutualReviewApproved,
    @Default(false) bool sellerMutualReviewApproved,
    @Default([]) List<EditRequest> editRequests,
    DateTime? mutualReviewCompletedAt,

    DateTime? mutualConfirmationAt,
    DateTime? adminReviewStartedAt,
    DateTime? adminReviewCompletedAt,
    String? adminReviewNotes,
    DateTime? readyForPaymentAt,

    // New checkpoint timestamps (no escrow)
    DateTime? preparingStartedAt,
    DateTime? shippingStartedAt,
    DateTime? deliveredAt,
    DateTime? paymentSuccessAt,
    DateTime? transactionCompletedAt,

    String? cancellationReason,
    DateTime? cancelledAt,

    // ===== RA 8792 COMPLIANT FIELDS =====
    /// KYC verification for buyer (identity verification)
    KycVerification? buyerVerification,

    /// KYC verification for seller (identity verification)
    KycVerification? sellerVerification,

    /// Digital sale agreement (legally binding under RA 8792)
    DigitalAgreement? digitalAgreement,

    /// Payment confirmation (electronic receipt under RA 8792)
    PaymentConfirmation? paymentConfirmation,

    /// Handover confirmation (vehicle transfer documentation)
    HandoverConfirmation? handoverConfirmation,

    /// Audit log entries (immutable record protected under RA 8792)
    @Default([]) List<AuditLogEntry> auditLog,
  }) = _PreTransaction;

  factory PreTransaction.fromJson(Map<String, dynamic> json) =>
      _$PreTransactionFromJson(json);
}
