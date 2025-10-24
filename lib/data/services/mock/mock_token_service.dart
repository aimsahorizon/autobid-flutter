import 'dart:async';
import 'package:autobid/data/models/token_model.dart';
import 'package:autobid/data/models/subscription_tier.dart';
import 'package:autobid/data/services/mock/mock_auth_service.dart';

/// Mock Token Service - REVISED Revenue Model
///
/// Manages token purchases, balance, and transactions.
/// Tokens are used to place bids (1 token per bid).
///
/// BACKEND INTEGRATION NOTES:
/// - Connect to payment gateway for token purchases
/// - Store token balance in user profile/document
/// - Track all token transactions for audit trail
/// - Handle subscription-based token allocations (monthly renewal)
/// - Implement token expiration policy if needed
/// - Sync token balance across all user sessions
class MockTokenService {
  static final MockTokenService _instance = MockTokenService._internal();
  factory MockTokenService() => _instance;
  MockTokenService._internal() {
    _initializeMockData();
  }

  // In-memory storage (replace with API calls)
  final Map<String, int> _userBalances = {}; // userId -> token balance
  final List<TokenTransaction> _transactions = [];
  final List<TokenPurchase> _purchases = [];

  final StreamController<Map<String, int>> _balancesController =
      StreamController<Map<String, int>>.broadcast();
  final StreamController<List<TokenTransaction>> _transactionsController =
      StreamController<List<TokenTransaction>>.broadcast();

  // Mock delay configuration
  static const Duration _mockDelay = Duration(milliseconds: 500);
  static const Duration _purchaseDelay = Duration(seconds: 2);

  // Auth service reference to update user profile
  final _authService = MockAuthService();

  /// Initialize with sample data
  void _initializeMockData() {
    // Sample user with some tokens
    _userBalances['USER001'] = 50;

    // Sample transaction history
    _transactions.addAll([
      TokenTransaction(
        id: 'TXN001',
        userId: 'USER001',
        amount: 100,
        type: TokenTransactionType.purchase,
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        relatedPurchaseId: 'TKPUR001',
        description: 'Token purchase - 100 tokens',
        balanceAfter: 100,
      ),
      TokenTransaction(
        id: 'TXN002',
        userId: 'USER001',
        amount: -1,
        type: TokenTransactionType.bidPlaced,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        relatedAuctionId: 'AUC001',
        description: 'Bid placed on auction',
        balanceAfter: 99,
      ),
    ]);

    _notifyListeners();
  }

  /// Get balance stream for a user
  Stream<int> balanceStream(String userId) {
    return _balancesController.stream
        .map((balances) => balances[userId] ?? 0)
        .distinct();
  }

  /// Get transactions stream for a user
  Stream<List<TokenTransaction>> transactionsStream(String userId) {
    return _transactionsController.stream.map((transactions) =>
        transactions.where((t) => t.userId == userId).toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
  }

  /// Get current token balance for user
  Future<int> getBalance(String userId) async {
    await Future.delayed(_mockDelay);
    return _userBalances[userId] ?? 0;
  }

  /// Get transaction history for user
  Future<List<TokenTransaction>> getTransactionHistory(String userId) async {
    await Future.delayed(_mockDelay);
    final userTransactions = _transactions
        .where((t) => t.userId == userId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return userTransactions;
  }

  /// Purchase tokens
  Future<TokenPurchase> purchaseTokens({
    required String userId,
    required TokenPurchaseTier tier,
  }) async {
    await Future.delayed(_purchaseDelay); // Simulate payment processing

    final config = TokenPurchaseTierConfig.forTier(tier);

    // Create purchase record based on selected tier
    late final TokenPurchase purchase;

    switch (tier) {
      case TokenPurchaseTier.tier99:
        purchase = TokenPurchase.tier99(userId: userId);
        break;
      case TokenPurchaseTier.tier349:
        purchase = TokenPurchase.tier349(userId: userId);
        break;
      case TokenPurchaseTier.tier1299:
        purchase = TokenPurchase.tier1299(userId: userId);
        break;
    }


    // Mark as completed (simulate successful payment)
    final completedPurchase = purchase.copyWith(
      status: TokenPurchaseStatus.completed,
      paymentMethod: 'card', // Mock payment method
      paymentReference: 'REF${DateTime.now().millisecondsSinceEpoch}',
      paymentTransactionId: 'PAY${DateTime.now().millisecondsSinceEpoch}',
    );

    _purchases.add(completedPurchase);

    // Add tokens to balance
    final currentBalance = _userBalances[userId] ?? 0;
    final newBalance = currentBalance + config.totalTokens;
    _userBalances[userId] = newBalance;

    // Create transaction record
    final transaction = TokenTransaction.purchase(
      userId: userId,
      tokensAdded: config.totalTokens,
      purchaseId: completedPurchase.id,
      balanceAfter: newBalance,
    );
    _transactions.add(transaction);

    _notifyListeners();

    // Update user profile with new token balance
    await _authService.updateUserTokenBalance(
      userId: userId,
      tokenBalance: newBalance,
    );

    return completedPurchase;
  }

  /// Deduct token for bid placement
  Future<bool> deductToken({
    required String userId,
    required String auctionId,
  }) async {
    await Future.delayed(_mockDelay);

    final currentBalance = _userBalances[userId] ?? 0;

    // Check if user has enough tokens
    if (currentBalance < 1) {
      throw InsufficientTokensException(
        'Not enough tokens. Current balance: $currentBalance',
      );
    }

    // Deduct 1 token
    final newBalance = currentBalance - 1;
    _userBalances[userId] = newBalance;

    // Create transaction record
    final transaction = TokenTransaction.bidPlaced(
      userId: userId,
      auctionId: auctionId,
      balanceAfter: newBalance,
    );
    _transactions.add(transaction);

    _notifyListeners();

    // Update user profile with new token balance
    await _authService.updateUserTokenBalance(
      userId: userId,
      tokenBalance: newBalance,
    );

    return true;
  }

  /// Refund token (e.g., auction cancelled, bid cancelled)
  Future<void> refundToken({
    required String userId,
    required String auctionId,
    String? reason,
  }) async {
    await Future.delayed(_mockDelay);

    final currentBalance = _userBalances[userId] ?? 0;
    final newBalance = currentBalance + 1;
    _userBalances[userId] = newBalance;

    // Create transaction record
    final transaction = TokenTransaction(
      id: 'TXN${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      amount: 1,
      type: TokenTransactionType.bidRefund,
      createdAt: DateTime.now(),
      relatedAuctionId: auctionId,
      description: reason ?? 'Bid refunded',
      balanceAfter: newBalance,
    );
    _transactions.add(transaction);

    _notifyListeners();

    // Update user profile with new token balance
    await _authService.updateUserTokenBalance(
      userId: userId,
      tokenBalance: newBalance,
    );
  }

  /// Allocate monthly subscription tokens
  Future<void> allocateSubscriptionTokens({
    required String userId,
    required SubscriptionTierType tierType,
  }) async {
    await Future.delayed(_mockDelay);

    final tier = tierType.config;
    final tokensToAllocate = tier.monthlyTokenAllocation;

    // Pro Plus has unlimited tokens, so we don't allocate
    // Instead, we use a different check mechanism (canDeductToken)
    if (tokensToAllocate == -1) {
      return; // Unlimited tier
    }

    if (tokensToAllocate <= 0) {
      return; // No allocation for this tier
    }

    final currentBalance = _userBalances[userId] ?? 0;
    final newBalance = currentBalance + tokensToAllocate;
    _userBalances[userId] = newBalance;

    // Create transaction record
    final transaction = TokenTransaction.subscriptionAllocation(
      userId: userId,
      tokensAdded: tokensToAllocate,
      subscriptionId: 'SUB_${userId}_${DateTime.now().millisecondsSinceEpoch}',
      balanceAfter: newBalance,
    );
    _transactions.add(transaction);

    _notifyListeners();

    // Update user profile with new token balance
    await _authService.updateUserTokenBalance(
      userId: userId,
      tokenBalance: newBalance,
    );
  }

  /// Add tokens manually (admin/promotional)
  Future<void> addTokens({
    required String userId,
    required int amount,
    String? reason,
  }) async {
    await Future.delayed(_mockDelay);

    final currentBalance = _userBalances[userId] ?? 0;
    final newBalance = currentBalance + amount;
    _userBalances[userId] = newBalance;

    // Create transaction record
    final transaction = TokenTransaction(
      id: 'TXN${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      amount: amount,
      type: TokenTransactionType.promotionalGrant,
      createdAt: DateTime.now(),
      description: reason ?? 'Promotional tokens',
      balanceAfter: newBalance,
    );
    _transactions.add(transaction);

    _notifyListeners();

    // Update user profile with new token balance
    await _authService.updateUserTokenBalance(
      userId: userId,
      tokenBalance: newBalance,
    );
  }

  /// Check if user can deduct token (handles unlimited tier)
  Future<bool> canDeductToken({
    required String userId,
    required SubscriptionTierType tierType,
  }) async {
    final tier = tierType.config;

    // Pro Plus has unlimited tokens
    if (tier.monthlyTokenAllocation == -1) {
      return true;
    }

    // Regular tiers check balance
    final balance = await getBalance(userId);
    return balance > 0;
  }

  /// Get purchase history for user
  Future<List<TokenPurchase>> getPurchaseHistory(String userId) async {
    await Future.delayed(_mockDelay);
    return _purchases
        .where((p) => p.userId == userId)
        .toList()
      ..sort((a, b) => b.purchasedAt.compareTo(a.purchasedAt));
  }

  /// Get token statistics for user
  Future<TokenStatistics> getStatistics(String userId) async {
    await Future.delayed(_mockDelay);

    final balance = _userBalances[userId] ?? 0;
    final userTransactions = _transactions.where((t) => t.userId == userId).toList();

    final totalPurchased = userTransactions
        .where((t) => t.type == TokenTransactionType.purchase)
        .fold(0, (sum, t) => sum + t.amount);

    final totalSpent = userTransactions
        .where((t) => t.type == TokenTransactionType.bidPlaced)
        .fold(0, (sum, t) => sum + t.amount.abs());

    final totalAllocated = userTransactions
        .where((t) => t.type == TokenTransactionType.subscriptionAllocation)
        .fold(0, (sum, t) => sum + t.amount);

    return TokenStatistics(
      currentBalance: balance,
      totalPurchased: totalPurchased,
      totalSpent: totalSpent,
      totalAllocated: totalAllocated,
      totalTransactions: userTransactions.length,
    );
  }

  void _notifyListeners() {
    _balancesController.add(Map.from(_userBalances));
    _transactionsController.add(List.from(_transactions));
  }

  void dispose() {
    _balancesController.close();
    _transactionsController.close();
  }
}

/// Token statistics model
class TokenStatistics {
  final int currentBalance;
  final int totalPurchased;
  final int totalSpent;
  final int totalAllocated;
  final int totalTransactions;

  TokenStatistics({
    required this.currentBalance,
    required this.totalPurchased,
    required this.totalSpent,
    required this.totalAllocated,
    required this.totalTransactions,
  });

  int get totalEarned => totalPurchased + totalAllocated;
}

/// Exception thrown when user has insufficient tokens
class InsufficientTokensException implements Exception {
  final String message;
  InsufficientTokensException(this.message);

  @override
  String toString() => message;
}
