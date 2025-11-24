import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_confirmation_model.freezed.dart';
part 'payment_confirmation_model.g.dart';

/// Payment methods available in the Philippines
enum PaymentMethod {
  @JsonValue('cash')
  cash,
  @JsonValue('bank_transfer')
  bankTransfer,
  @JsonValue('gcash')
  gcash,
  @JsonValue('paymaya')
  paymaya,
  @JsonValue('bank_check')
  bankCheck,
  @JsonValue('other')
  other,
}

/// Payment confirmation status
enum PaymentConfirmationStatus {
  @JsonValue('pending')
  pending, // Not yet initiated
  @JsonValue('initiated')
  initiated, // Buyer uploaded proof of payment
  @JsonValue('confirmed')
  confirmed, // Seller confirmed receipt
  @JsonValue('disputed')
  disputed, // Payment dispute raised
}

/// Payment confirmation model for tracking payment under RA 8792
/// Electronic acknowledgment of payment receipt (RA 8792 Section 11)
@freezed
abstract class PaymentConfirmation with _$PaymentConfirmation {
  const factory PaymentConfirmation({
    required String id,
    required String preTransactionId,

    // ===== BUYER PAYMENT INITIATION =====
    /// Whether buyer has initiated payment
    @Default(false) bool buyerInitiated,

    /// Timestamp when buyer initiated payment
    DateTime? buyerInitiatedAt,

    /// URLs to proof of payment (bank receipts, screenshots, etc.)
    @Default([]) List<String> proofOfPaymentUrls,

    /// Payment method used
    PaymentMethod? paymentMethod,

    /// Payment reference number (e.g., bank transaction ID)
    String? paymentReferenceNumber,

    /// Optional notes from buyer about payment
    String? buyerNotes,

    // ===== SELLER CONFIRMATION =====
    /// Whether seller has confirmed payment receipt
    @Default(false) bool sellerConfirmed,

    /// Timestamp when seller confirmed payment
    DateTime? sellerConfirmedAt,

    /// Optional notes from seller about payment confirmation
    String? sellerNotes,

    // ===== RA 8792 ACKNOWLEDGMENT =====
    /// Legal acknowledgment text
    /// "This payment confirmation is an electronic acknowledgment under the
    /// Electronic Commerce Act of 2000 (RA 8792), Section 11. This electronic
    /// record has the same legal validity as a written receipt."
    required String ra8792Acknowledgment,

    // ===== METADATA =====
    /// Current status of payment confirmation
    @Default(PaymentConfirmationStatus.pending) PaymentConfirmationStatus status,

    /// Amount paid (should match agreement total)
    required double amountPaid,

    /// Timestamp when payment confirmation was created
    required DateTime createdAt,
  }) = _PaymentConfirmation;

  factory PaymentConfirmation.fromJson(Map<String, dynamic> json) =>
      _$PaymentConfirmationFromJson(json);
}
