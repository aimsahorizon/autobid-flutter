import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_model.freezed.dart';
part 'token_model.g.dart';

/// Token transaction types
enum TokenTransactionType {
  purchase, // Bought tokens with real money
  subscriptionAllocation, // Monthly token allocation from subscription
  bidPlaced, // Token deducted when bid placed
  bidRefund, // Token refunded when bid cancelled/auction cancelled
  adminAdjustment, // Manual adjustment by admin
  promotionalGrant, // Bonus tokens from promotions
}

/// Token purchase tier
enum TokenPurchaseTier {
  tier100, // ₱100 = 100 tokens
  tier500, // ₱500 = 600 tokens (100 bonus)
}

/// Token transaction record
///
/// BACKEND INTEGRATION NOTES:
/// - Store in tokens_transactions collection
/// - Index by userId and createdAt for fast queries
/// - Track all token movements for audit trail
/// - Link to related entities (auction, purchase, subscription)
@freezed
abstract class TokenTransaction with _$TokenTransaction {
  const factory TokenTransaction({
    required String id,
    required String userId,
    required int amount, // Positive = add, Negative = deduct
    required TokenTransactionType type,
    required DateTime createdAt,
    String? relatedAuctionId, // For bid placement/refunds
    String? relatedPurchaseId, // For token purchases
    String? relatedSubscriptionId, // For subscription allocations
    String? description,
    int? balanceAfter, // Balance after this transaction
  }) = _TokenTransaction;

  factory TokenTransaction.fromJson(Map<String, dynamic> json) =>
      _$TokenTransactionFromJson(json);

  /// Create a bid placement transaction
  factory TokenTransaction.bidPlaced({
    required String userId,
    required String auctionId,
    required int balanceAfter,
  }) {
    final now = DateTime.now();
    return TokenTransaction(
      id: 'TXN${now.millisecondsSinceEpoch}',
      userId: userId,
      amount: -1, // 1 token deducted
      type: TokenTransactionType.bidPlaced,
      createdAt: now,
      relatedAuctionId: auctionId,
      description: 'Bid placed on auction',
      balanceAfter: balanceAfter,
    );
  }

  /// Create a token purchase transaction
  factory TokenTransaction.purchase({
    required String userId,
    required int tokensAdded,
    required String purchaseId,
    required int balanceAfter,
  }) {
    final now = DateTime.now();
    return TokenTransaction(
      id: 'TXN${now.millisecondsSinceEpoch}',
      userId: userId,
      amount: tokensAdded,
      type: TokenTransactionType.purchase,
      createdAt: now,
      relatedPurchaseId: purchaseId,
      description: 'Token purchase',
      balanceAfter: balanceAfter,
    );
  }

  /// Create a subscription allocation transaction
  factory TokenTransaction.subscriptionAllocation({
    required String userId,
    required int tokensAdded,
    required String subscriptionId,
    required int balanceAfter,
  }) {
    final now = DateTime.now();
    return TokenTransaction(
      id: 'TXN${now.millisecondsSinceEpoch}',
      userId: userId,
      amount: tokensAdded,
      type: TokenTransactionType.subscriptionAllocation,
      createdAt: now,
      relatedSubscriptionId: subscriptionId,
      description: 'Monthly subscription token allocation',
      balanceAfter: balanceAfter,
    );
  }
}

/// Token purchase record
///
/// BACKEND INTEGRATION NOTES:
/// - Create after successful payment gateway confirmation
/// - Link to payment transaction ID
/// - Track purchase tiers for analytics
/// - Update user token balance after purchase
@freezed
abstract class TokenPurchase with _$TokenPurchase {
  const factory TokenPurchase({
    required String id,
    required String userId,
    required TokenPurchaseTier tier,
    required int tokensAdded,
    required double amountPaid,
    required DateTime purchasedAt,
    String? paymentTransactionId, // Payment gateway transaction ID
    String? paymentMethod, // GCash, PayMaya, Card, etc.
    String? paymentReference,
    TokenPurchaseStatus? status,
  }) = _TokenPurchase;

  factory TokenPurchase.fromJson(Map<String, dynamic> json) =>
      _$TokenPurchaseFromJson(json);

  /// Create a tier 100 purchase
  factory TokenPurchase.tier100({
    required String userId,
  }) {
    final now = DateTime.now();
    return TokenPurchase(
      id: 'TKPUR${now.millisecondsSinceEpoch}',
      userId: userId,
      tier: TokenPurchaseTier.tier100,
      tokensAdded: 100,
      amountPaid: 100.0,
      purchasedAt: now,
      status: TokenPurchaseStatus.pending,
    );
  }

  /// Create a tier 500 purchase (includes bonus)
  factory TokenPurchase.tier500({
    required String userId,
  }) {
    final now = DateTime.now();
    return TokenPurchase(
      id: 'TKPUR${now.millisecondsSinceEpoch}',
      userId: userId,
      tier: TokenPurchaseTier.tier500,
      tokensAdded: 600, // 500 base + 100 bonus
      amountPaid: 500.0,
      purchasedAt: now,
      status: TokenPurchaseStatus.pending,
    );
  }
}

/// Token purchase status
enum TokenPurchaseStatus {
  pending, // Payment initiated but not confirmed
  completed, // Payment confirmed, tokens added
  failed, // Payment failed
  refunded, // Purchase refunded
}

/// Token purchase tier configuration
class TokenPurchaseTierConfig {
  final TokenPurchaseTier tier;
  final double price;
  final int baseTokens;
  final int bonusTokens;
  final String displayName;
  final String description;

  const TokenPurchaseTierConfig({
    required this.tier,
    required this.price,
    required this.baseTokens,
    required this.bonusTokens,
    required this.displayName,
    required this.description,
  });

  int get totalTokens => baseTokens + bonusTokens;
  bool get hasBonus => bonusTokens > 0;
  String get bonusText => hasBonus ? '+$bonusTokens bonus' : '';

  /// Tier 100 configuration
  static const tier100 = TokenPurchaseTierConfig(
    tier: TokenPurchaseTier.tier100,
    price: 100.0,
    baseTokens: 100,
    bonusTokens: 0,
    displayName: '100 Tokens',
    description: '₱100 for 100 tokens',
  );

  /// Tier 500 configuration
  static const tier500 = TokenPurchaseTierConfig(
    tier: TokenPurchaseTier.tier500,
    price: 500.0,
    baseTokens: 500,
    bonusTokens: 100,
    displayName: '600 Tokens',
    description: '₱500 for 600 tokens (+100 bonus)',
  );

  /// Get all available tiers
  static List<TokenPurchaseTierConfig> get allTiers => [tier100, tier500];

  /// Get configuration for a tier
  static TokenPurchaseTierConfig forTier(TokenPurchaseTier tier) {
    switch (tier) {
      case TokenPurchaseTier.tier100:
        return tier100;
      case TokenPurchaseTier.tier500:
        return tier500;
    }
  }
}

extension TokenTransactionTypeExtension on TokenTransactionType {
  bool get isCredit => this == TokenTransactionType.purchase ||
      this == TokenTransactionType.subscriptionAllocation ||
      this == TokenTransactionType.bidRefund ||
      this == TokenTransactionType.promotionalGrant;

  bool get isDebit =>
      this == TokenTransactionType.bidPlaced ||
      this == TokenTransactionType.adminAdjustment;

  String get displayText {
    switch (this) {
      case TokenTransactionType.purchase:
        return 'Token Purchase';
      case TokenTransactionType.subscriptionAllocation:
        return 'Subscription Tokens';
      case TokenTransactionType.bidPlaced:
        return 'Bid Placed';
      case TokenTransactionType.bidRefund:
        return 'Bid Refunded';
      case TokenTransactionType.adminAdjustment:
        return 'Adjustment';
      case TokenTransactionType.promotionalGrant:
        return 'Promotional Bonus';
    }
  }
}

extension TokenPurchaseStatusExtension on TokenPurchaseStatus {
  bool get isCompleted => this == TokenPurchaseStatus.completed;
  bool get isPending => this == TokenPurchaseStatus.pending;
  bool get isFailed => this == TokenPurchaseStatus.failed;

  String get displayText {
    switch (this) {
      case TokenPurchaseStatus.pending:
        return 'Processing';
      case TokenPurchaseStatus.completed:
        return 'Completed';
      case TokenPurchaseStatus.failed:
        return 'Failed';
      case TokenPurchaseStatus.refunded:
        return 'Refunded';
    }
  }
}
