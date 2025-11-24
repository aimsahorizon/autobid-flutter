import 'package:freezed_annotation/freezed_annotation.dart';

part 'bidding_deposit.freezed.dart';
part 'bidding_deposit.g.dart';

/// Bidding deposit status
enum DepositStatus {
  pending, // Deposit initiated but not yet paid
  paid, // Deposit paid and verified
  credited, // Applied toward buyer's premium after winning
  refunded, // Returned to user (no win or cancelled)
  forfeited, // Lost due to violation (if implemented)
}

/// Winner's choice for deposit disposition (REVISED Model)
enum DepositDisposition {
  creditToPayment, // Apply deposit to reduce final payment amount
  fullRefund, // Return deposit in full, pay bid amount separately
}

/// Bidding deposit model - ₱10,000 refundable deposit
///
/// BACKEND INTEGRATION NOTES:
/// - Create deposit record when user initiates first bid
/// - Update status after payment gateway confirmation
/// - Automatically credit to buyer's premium on auction win
/// - Refund via payment gateway if no wins within period
/// - Track deposit per user (not per auction)
/// - Consider deposit expiration policy (e.g., 30 days)
@freezed
abstract class BiddingDeposit with _$BiddingDeposit {
  const factory BiddingDeposit({
    required String id,
    required String userId,
    required double amount, // Always ₱10,000 for now
    required DepositStatus status,
    required DateTime createdAt,
    DateTime? paidAt,
    DateTime? creditedAt,
    DateTime? refundedAt,
    String? transactionId, // Payment gateway transaction ID
    String? paymentMethod, // GCash, PayMaya, etc.
    String? paymentReference,
    String? auctionIdCredited, // Which auction won that used this deposit
    double? amountCredited, // How much was applied to buyer's premium
    double? amountRefunded,
    String? refundTransactionId,
    DateTime? expiresAt, // Optional: deposit validity period
    String? notes,
    // REVISED Model - Winner Choice
    DepositDisposition? winnerDisposition, // Winner's choice: credit or refund
    bool? isWinner, // Track if user won the auction (true = winner, false = loser, null = pending)
  }) = _BiddingDeposit;

  factory BiddingDeposit.fromJson(Map<String, dynamic> json) =>
      _$BiddingDepositFromJson(json);

  /// Standard deposit amount
  static const double standardAmount = 10000.0;

  /// Create a new pending deposit
  factory BiddingDeposit.create({
    required String userId,
  }) {
    final now = DateTime.now();
    return BiddingDeposit(
      id: 'DEP${now.millisecondsSinceEpoch}',
      userId: userId,
      amount: standardAmount,
      status: DepositStatus.pending,
      createdAt: now,
      expiresAt: now.add(const Duration(days: 30)), // 30-day validity
    );
  }
}

extension DepositStatusExtension on DepositStatus {
  bool get isPaid => this == DepositStatus.paid;
  bool get canBid => this == DepositStatus.paid;
  bool get isCredited => this == DepositStatus.credited;
  bool get isRefunded => this == DepositStatus.refunded;
  bool get isPending => this == DepositStatus.pending;

  String get displayText {
    switch (this) {
      case DepositStatus.pending:
        return 'Pending Payment';
      case DepositStatus.paid:
        return 'Active';
      case DepositStatus.credited:
        return 'Credited to Purchase';
      case DepositStatus.refunded:
        return 'Refunded';
      case DepositStatus.forfeited:
        return 'Forfeited';
    }
  }

  String get description {
    switch (this) {
      case DepositStatus.pending:
        return 'Complete payment to start bidding';
      case DepositStatus.paid:
        return 'You can now place bids on auctions';
      case DepositStatus.credited:
        return 'Deposit applied toward your purchase';
      case DepositStatus.refunded:
        return 'Deposit has been returned to your account';
      case DepositStatus.forfeited:
        return 'Deposit forfeited due to policy violation';
    }
  }
}

extension DepositDispositionExtension on DepositDisposition {
  bool get isCredit => this == DepositDisposition.creditToPayment;
  bool get isRefund => this == DepositDisposition.fullRefund;

  String get displayText {
    switch (this) {
      case DepositDisposition.creditToPayment:
        return 'Credit to Payment';
      case DepositDisposition.fullRefund:
        return 'Full Refund';
    }
  }

  String get description {
    switch (this) {
      case DepositDisposition.creditToPayment:
        return 'Apply ₱10,000 deposit to reduce your final payment';
      case DepositDisposition.fullRefund:
        return 'Receive full ₱10,000 deposit refund';
    }
  }
}
