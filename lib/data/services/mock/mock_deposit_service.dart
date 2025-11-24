import 'dart:async';
import 'package:autobid/data/models/bidding_deposit.dart';

/// Mock Bidding Deposit Service - REVISED Revenue Model
///
/// Manages the ₱10,000 refundable bidding deposit required before first bid.
///
/// REVISED MODEL:
/// - Winners choose: Credit to payment OR full refund
/// - Losers: Automatic full refund
/// - No buyer's premium (token-based bidding instead)
///
/// BACKEND INTEGRATION NOTES:
/// - Create deposit record when user initiates payment
/// - Update status via payment gateway webhook
/// - Present winner with choice modal after auction ends
/// - Process deposit based on winner's choice
/// - Auto-refund to losers
/// - Track deposit per user (one active deposit per user)
/// - Implement deposit expiration policy (e.g., 30 days)
class MockDepositService {
  static final MockDepositService _instance = MockDepositService._internal();
  factory MockDepositService() => _instance;
  MockDepositService._internal() {
    _initializeMockData();
  }

  // In-memory storage (replace with API calls)
  final List<BiddingDeposit> _deposits = [];
  final StreamController<List<BiddingDeposit>> _depositsController =
      StreamController<List<BiddingDeposit>>.broadcast();

  // Mock delay configuration
  static const Duration _mockDelay = Duration(milliseconds: 800);

  /// Initialize with sample data
  void _initializeMockData() {
    // Sample deposits for testing
    _deposits.addAll([
      BiddingDeposit(
        id: 'DEP001',
        userId: 'USER001',
        amount: BiddingDeposit.standardAmount,
        status: DepositStatus.paid,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        paidAt: DateTime.now().subtract(const Duration(days: 5)),
        paymentMethod: 'gcash',
        paymentReference: 'GCASH123456',
        expiresAt: DateTime.now().add(const Duration(days: 25)),
      ),
    ]);
    _notifyListeners();
  }

  /// Get deposits stream
  Stream<List<BiddingDeposit>> get depositsStream => _depositsController.stream;

  /// Get current active deposit for user
  Future<BiddingDeposit?> getUserDeposit(String userId) async {
    await Future.delayed(_mockDelay);
    try {
      return _deposits.firstWhere(
        (d) => d.userId == userId && (d.status.isPaid || d.status.isPending),
      );
    } catch (e) {
      return null;
    }
  }

  /// Check if user has paid deposit
  Future<bool> hasDeposit(String userId) async {
    final deposit = await getUserDeposit(userId);
    return deposit?.status.canBid ?? false;
  }

  /// Create pending deposit
  Future<BiddingDeposit> createDeposit({required String userId}) async {
    await Future.delayed(_mockDelay);

    // Check if user already has active deposit
    final existing = await getUserDeposit(userId);
    if (existing != null && existing.status.canBid) {
      throw Exception('User already has an active deposit');
    }

    final deposit = BiddingDeposit.create(userId: userId);
    _deposits.add(deposit);
    _notifyListeners();

    return deposit;
  }

  /// Pay deposit (simulate payment confirmation)
  Future<BiddingDeposit> payDeposit({
    required String depositId,
    required String paymentMethod,
    required String paymentReference,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate payment processing

    final index = _deposits.indexWhere((d) => d.id == depositId);
    if (index == -1) {
      throw Exception('Deposit not found');
    }

    final old = _deposits[index];
    if (old.status != DepositStatus.pending) {
      throw Exception('Deposit is not in pending status');
    }

    final paid = old.copyWith(
      status: DepositStatus.paid,
      paidAt: DateTime.now(),
      paymentMethod: paymentMethod,
      paymentReference: paymentReference,
      transactionId: 'TXN${DateTime.now().millisecondsSinceEpoch}',
    );

    _deposits[index] = paid;
    _notifyListeners();

    return paid;
  }

  // ========== REVISED MODEL METHODS ==========

  /// Mark deposit as winner/loser after auction ends
  Future<BiddingDeposit> markAuctionResult({
    required String depositId,
    required String auctionId,
    required bool isWinner,
  }) async {
    await Future.delayed(_mockDelay);

    final index = _deposits.indexWhere((d) => d.id == depositId);
    if (index == -1) {
      throw Exception('Deposit not found');
    }

    final old = _deposits[index];
    if (!old.status.canBid) {
      throw Exception('Deposit is not in paid status');
    }

    final marked = old.copyWith(
      isWinner: isWinner,
      auctionIdCredited: auctionId,
    );

    _deposits[index] = marked;
    _notifyListeners();

    // If loser, auto-refund
    if (!isWinner) {
      return await refundDeposit(
        depositId: depositId,
        reason: 'Auction lost - automatic refund',
      );
    }

    return marked;
  }

  /// Record winner's choice for deposit disposition
  Future<BiddingDeposit> recordWinnerChoice({
    required String depositId,
    required DepositDisposition disposition,
  }) async {
    await Future.delayed(_mockDelay);

    final index = _deposits.indexWhere((d) => d.id == depositId);
    if (index == -1) {
      throw Exception('Deposit not found');
    }

    final old = _deposits[index];
    if (old.isWinner != true) {
      throw Exception('Can only set disposition for winners');
    }

    final updated = old.copyWith(
      winnerDisposition: disposition,
    );

    _deposits[index] = updated;
    _notifyListeners();

    return updated;
  }

  /// Process deposit based on winner's choice
  Future<BiddingDeposit> processWinnerDeposit({
    required String depositId,
    required DepositDisposition disposition,
    required double finalBidAmount,
  }) async {
    await Future.delayed(_mockDelay);

    final index = _deposits.indexWhere((d) => d.id == depositId);
    if (index == -1) {
      throw Exception('Deposit not found');
    }

    final old = _deposits[index];
    if (old.isWinner != true) {
      throw Exception('Can only process deposit for winners');
    }

    // Update disposition
    var updated = old.copyWith(winnerDisposition: disposition);
    _deposits[index] = updated;

    if (disposition == DepositDisposition.creditToPayment) {
      // Credit deposit to final payment
      final credited = updated.copyWith(
        status: DepositStatus.credited,
        creditedAt: DateTime.now(),
        amountCredited: old.amount,
        notes: 'Deposit credited to payment (₱${finalBidAmount} - ₱${old.amount})',
      );
      _deposits[index] = credited;
      _notifyListeners();
      return credited;
    } else {
      // Full refund
      final refunded = updated.copyWith(
        status: DepositStatus.refunded,
        refundedAt: DateTime.now(),
        amountRefunded: old.amount,
        refundTransactionId: 'REFUND${DateTime.now().millisecondsSinceEpoch}',
        notes: 'Winner chose full refund',
      );
      _deposits[index] = refunded;
      _notifyListeners();
      return refunded;
    }
  }

  // ========== DEPRECATED METHODS (GEMINI Model) ==========

  /// DEPRECATED: Credit deposit to auction win (buyer's premium)
  ///
  /// Use processWinnerDeposit() instead for REVISED model
  @Deprecated('Use processWinnerDeposit() instead')
  Future<BiddingDeposit> creditDeposit({
    required String depositId,
    required String auctionId,
    required double premiumAmount,
  }) async {
    await Future.delayed(_mockDelay);

    final index = _deposits.indexWhere((d) => d.id == depositId);
    if (index == -1) {
      throw Exception('Deposit not found');
    }

    final old = _deposits[index];
    if (!old.status.canBid) {
      throw Exception('Deposit is not in paid status');
    }

    // In REVISED model, just mark as credited with full amount
    final credited = old.copyWith(
      status: DepositStatus.credited,
      creditedAt: DateTime.now(),
      auctionIdCredited: auctionId,
      amountCredited: old.amount,
    );

    _deposits[index] = credited;
    _notifyListeners();

    return credited;
  }

  /// Refund deposit (no wins or cancelled)
  Future<BiddingDeposit> refundDeposit({
    required String depositId,
    String? reason,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate refund processing

    final index = _deposits.indexWhere((d) => d.id == depositId);
    if (index == -1) {
      throw Exception('Deposit not found');
    }

    final old = _deposits[index];
    if (old.status.isRefunded || old.status.isCredited) {
      throw Exception('Deposit already processed');
    }

    final refunded = old.copyWith(
      status: DepositStatus.refunded,
      refundedAt: DateTime.now(),
      amountRefunded: old.amount,
      refundTransactionId: 'REFUND${DateTime.now().millisecondsSinceEpoch}',
      notes: reason,
    );

    _deposits[index] = refunded;
    _notifyListeners();

    return refunded;
  }

  /// Get deposit history for user
  Future<List<BiddingDeposit>> getDepositHistory(String userId) async {
    await Future.delayed(_mockDelay);
    return _deposits.where((d) => d.userId == userId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get all deposits (admin)
  Future<List<BiddingDeposit>> getAllDeposits() async {
    await Future.delayed(_mockDelay);
    return List.unmodifiable(_deposits);
  }

  /// Check for expired deposits and auto-refund
  Future<void> processExpiredDeposits() async {
    await Future.delayed(_mockDelay);

    final now = DateTime.now();
    for (var i = 0; i < _deposits.length; i++) {
      final deposit = _deposits[i];
      if (deposit.status.isPaid &&
          deposit.expiresAt != null &&
          deposit.expiresAt!.isBefore(now)) {
        // Auto-refund expired deposits
        final refunded = deposit.copyWith(
          status: DepositStatus.refunded,
          refundedAt: now,
          amountRefunded: deposit.amount,
          refundTransactionId: 'AUTO_REFUND${now.millisecondsSinceEpoch}',
          notes: 'Deposit expired - automatically refunded',
        );
        _deposits[i] = refunded;
      }
    }

    _notifyListeners();
  }

  /// Get deposit statistics (admin)
  Future<Map<String, dynamic>> getDepositStatistics() async {
    await Future.delayed(_mockDelay);

    final total = _deposits.length;
    final paid = _deposits.where((d) => d.status.isPaid).length;
    final credited = _deposits.where((d) => d.status.isCredited).length;
    final refunded = _deposits.where((d) => d.status.isRefunded).length;
    final pending = _deposits.where((d) => d.status.isPending).length;

    final totalAmount = _deposits.fold<double>(
      0,
      (sum, d) => sum + d.amount,
    );
    final creditedAmount = _deposits.fold<double>(
      0,
      (sum, d) => sum + (d.amountCredited ?? 0),
    );
    final refundedAmount = _deposits.fold<double>(
      0,
      (sum, d) => sum + (d.amountRefunded ?? 0),
    );

    return {
      'total': total,
      'paid': paid,
      'credited': credited,
      'refunded': refunded,
      'pending': pending,
      'totalAmount': totalAmount,
      'creditedAmount': creditedAmount,
      'refundedAmount': refundedAmount,
    };
  }

  // ===== Private Helper Methods =====

  void _notifyListeners() {
    _depositsController.add(List.unmodifiable(_deposits));
  }

  /// Dispose resources
  void dispose() {
    _depositsController.close();
  }
}
