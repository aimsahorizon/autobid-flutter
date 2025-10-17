import 'package:freezed_annotation/freezed_annotation.dart';

/// Granular transaction status tracking as per TRANSACTION_FLOW.md
/// Tracks progress through all 4 checkpoints and beyond
enum TransactionStatus {
  // ===== PRE-PAYMENT FLOW =====
  @JsonValue('active_auction')
  activeAuction,

  @JsonValue('auction_ended')
  auctionEnded,

  @JsonValue('awaiting_discussion')
  awaitingDiscussion,

  @JsonValue('discussion_in_progress')
  discussionInProgress,

  @JsonValue('terms_agreed')
  termsAgreed,

  // ===== PAYMENT PHASE =====
  @JsonValue('awaiting_payment')
  awaitingPayment,

  @JsonValue('payment_processing')
  paymentProcessing,

  /// CHECKPOINT 1 - Payment secured in escrow
  @JsonValue('payment_secured')
  paymentSecured,

  // ===== SHIPPING PHASE =====
  @JsonValue('awaiting_shipping')
  awaitingShipping,

  @JsonValue('shipping_evidence_submitted')
  shippingEvidenceSubmitted,

  @JsonValue('shipping_under_review')
  shippingUnderReview,

  /// CHECKPOINT 2 - Item shipped and verified
  @JsonValue('item_shipped')
  itemShipped,

  @JsonValue('in_transit')
  inTransit,

  // ===== DELIVERY PHASE =====
  @JsonValue('delivered_awaiting_confirmation')
  deliveredAwaitingConfirmation,

  @JsonValue('confirmation_evidence_submitted')
  confirmationEvidenceSubmitted,

  @JsonValue('delivery_under_review')
  deliveryUnderReview,

  /// CHECKPOINT 3 - Delivery confirmed
  @JsonValue('delivery_confirmed')
  deliveryConfirmed,

  /// CHECKPOINT 4 - All verifications complete
  @JsonValue('transaction_complete')
  transactionComplete,

  // ===== POST-TRANSACTION =====
  @JsonValue('payment_released')
  paymentReleased,

  @JsonValue('feedback_pending')
  feedbackPending,

  @JsonValue('closed_success')
  closedSuccess,

  // ===== CANCELLATIONS & REFUNDS =====
  @JsonValue('cancelled_timeout')
  cancelledTimeout,

  @JsonValue('cancelled_by_user')
  cancelledByUser,

  @JsonValue('refunded_shipping_fail')
  refundedShippingFail,

  @JsonValue('refunded_dispute')
  refundedDispute,

  // ===== DISPUTES =====
  @JsonValue('disputed_under_review')
  disputedUnderReview,

  @JsonValue('disputed_escalated')
  disputedEscalated,

  @JsonValue('settled_partial')
  settledPartial,

  // ===== FRAUD DETECTION =====
  @JsonValue('frozen_suspicious')
  frozenSuspicious,

  @JsonValue('banned_fraud')
  bannedFraud,
}

/// Extension to get human-readable status text
extension TransactionStatusExtension on TransactionStatus {
  String get displayName {
    switch (this) {
      case TransactionStatus.activeAuction:
        return 'Active Auction';
      case TransactionStatus.auctionEnded:
        return 'Auction Ended';
      case TransactionStatus.awaitingDiscussion:
        return 'Awaiting Discussion';
      case TransactionStatus.discussionInProgress:
        return 'Discussion in Progress';
      case TransactionStatus.termsAgreed:
        return 'Terms Agreed';
      case TransactionStatus.awaitingPayment:
        return 'Awaiting Payment';
      case TransactionStatus.paymentProcessing:
        return 'Processing Payment';
      case TransactionStatus.paymentSecured:
        return '✓ Payment Secured (CP1)';
      case TransactionStatus.awaitingShipping:
        return 'Awaiting Shipping';
      case TransactionStatus.shippingEvidenceSubmitted:
        return 'Shipping Evidence Submitted';
      case TransactionStatus.shippingUnderReview:
        return 'Shipping Under Review';
      case TransactionStatus.itemShipped:
        return '✓ Item Shipped (CP2)';
      case TransactionStatus.inTransit:
        return 'In Transit';
      case TransactionStatus.deliveredAwaitingConfirmation:
        return 'Awaiting Delivery Confirmation';
      case TransactionStatus.confirmationEvidenceSubmitted:
        return 'Confirmation Evidence Submitted';
      case TransactionStatus.deliveryUnderReview:
        return 'Delivery Under Review';
      case TransactionStatus.deliveryConfirmed:
        return '✓ Delivery Confirmed (CP3)';
      case TransactionStatus.transactionComplete:
        return '✓ Transaction Complete (CP4)';
      case TransactionStatus.paymentReleased:
        return 'Payment Released';
      case TransactionStatus.feedbackPending:
        return 'Feedback Pending';
      case TransactionStatus.closedSuccess:
        return 'Completed';
      case TransactionStatus.cancelledTimeout:
        return 'Cancelled - Timeout';
      case TransactionStatus.cancelledByUser:
        return 'Cancelled by User';
      case TransactionStatus.refundedShippingFail:
        return 'Refunded - Shipping Failed';
      case TransactionStatus.refundedDispute:
        return 'Refunded - Dispute';
      case TransactionStatus.disputedUnderReview:
        return 'Disputed - Under Review';
      case TransactionStatus.disputedEscalated:
        return 'Disputed - Escalated';
      case TransactionStatus.settledPartial:
        return 'Settled - Partial';
      case TransactionStatus.frozenSuspicious:
        return 'Frozen - Suspicious Activity';
      case TransactionStatus.bannedFraud:
        return 'Banned - Fraud Detected';
    }
  }

  /// Returns true if this is a checkpoint status
  bool get isCheckpoint {
    return this == TransactionStatus.paymentSecured ||
        this == TransactionStatus.itemShipped ||
        this == TransactionStatus.deliveryConfirmed ||
        this == TransactionStatus.transactionComplete;
  }

  /// Returns checkpoint number (1-4) or null if not a checkpoint
  int? get checkpointNumber {
    switch (this) {
      case TransactionStatus.paymentSecured:
        return 1;
      case TransactionStatus.itemShipped:
        return 2;
      case TransactionStatus.deliveryConfirmed:
        return 3;
      case TransactionStatus.transactionComplete:
        return 4;
      default:
        return null;
    }
  }
}
