import 'dart:async';
import 'package:autobid/data/models/subscription_tier.dart';

/// Mock Subscription Service - GEMINI Revenue Model
///
/// Simulates subscription management for testing and demo.
///
/// BACKEND INTEGRATION NOTES:
/// - Replace with real API calls to subscription service
/// - Integrate with payment gateway (Stripe, PayMongo, etc.)
/// - Handle webhook events for subscription lifecycle
/// - Sync subscription status with user profile
/// - Implement subscription analytics and usage tracking
/// - Handle proration for upgrades/downgrades
/// - Manage trial periods if applicable
class MockSubscriptionService {
  static final MockSubscriptionService _instance = MockSubscriptionService._internal();
  factory MockSubscriptionService() => _instance;
  MockSubscriptionService._internal() {
    _initializeMockData();
  }

  // In-memory storage (replace with API calls)
  final List<UserSubscription> _subscriptions = [];
  final StreamController<List<UserSubscription>> _subscriptionsController =
      StreamController<List<UserSubscription>>.broadcast();

  // Mock delay configuration
  static const Duration _mockDelay = Duration(milliseconds: 800);

  /// Initialize with sample data
  void _initializeMockData() {
    // Add sample subscriptions for testing
    _subscriptions.addAll([
      UserSubscription(
        id: 'SUB001',
        userId: 'USER001',
        tierType: SubscriptionTierType.free,
        billingCycle: BillingCycle.monthly,
        status: SubscriptionStatus.active,
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: null, // Free tier never expires
        nextBillingDate: DateTime.now(), // Not applicable for free
        amountPaid: 0,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
    ]);
    _notifyListeners();
  }

  /// Get subscription stream
  Stream<List<UserSubscription>> get subscriptionsStream =>
      _subscriptionsController.stream;

  /// Get current subscription for user
  Future<UserSubscription?> getUserSubscription(String userId) async {
    await Future.delayed(_mockDelay);
    try {
      return _subscriptions.firstWhere((s) => s.userId == userId && s.status.isActive);
    } catch (e) {
      return null;
    }
  }

  /// Get subscription tier for user
  Future<SubscriptionTierType> getUserTier(String userId) async {
    final subscription = await getUserSubscription(userId);
    return subscription?.tierType ?? SubscriptionTierType.free;
  }

  /// Subscribe to a tier
  Future<UserSubscription> subscribe({
    required String userId,
    required SubscriptionTierType tierType,
    required BillingCycle billingCycle,
  }) async {
    await Future.delayed(_mockDelay);

    if (tierType == SubscriptionTierType.free) {
      throw Exception('Cannot subscribe to Free tier');
    }

    // Calculate price
    final tier = tierType.config;
    final amount = billingCycle == BillingCycle.monthly
        ? tier.monthlyPrice
        : tier.yearlyPrice;

    // Calculate next billing date
    final now = DateTime.now();
    final nextBilling = billingCycle == BillingCycle.monthly
        ? now.add(const Duration(days: 30))
        : now.add(const Duration(days: 365));

    // Cancel existing active subscription
    await _cancelExistingSubscription(userId);

    // Create new subscription
    final subscription = UserSubscription(
      id: 'SUB${now.millisecondsSinceEpoch}',
      userId: userId,
      tierType: tierType,
      billingCycle: billingCycle,
      status: SubscriptionStatus.active,
      startDate: now,
      endDate: null,
      nextBillingDate: nextBilling,
      amountPaid: amount,
      paymentGatewaySubscriptionId: 'MOCK_${tierType.name}_${now.millisecondsSinceEpoch}',
      createdAt: now,
      updatedAt: now,
    );

    _subscriptions.add(subscription);
    _notifyListeners();

    return subscription;
  }

  /// Upgrade subscription
  Future<UserSubscription> upgrade({
    required String userId,
    required SubscriptionTierType newTier,
  }) async {
    await Future.delayed(_mockDelay);

    final current = await getUserSubscription(userId);
    if (current == null) {
      throw Exception('No active subscription found');
    }

    // Validate upgrade path
    if (_getTierLevel(newTier) <= _getTierLevel(current.tierType)) {
      throw Exception('Can only upgrade to higher tier');
    }

    // Cancel current subscription
    await cancel(userId);

    // Create new subscription with same billing cycle
    return await subscribe(
      userId: userId,
      tierType: newTier,
      billingCycle: current.billingCycle,
    );
  }

  /// Downgrade subscription (effective at end of current period)
  Future<UserSubscription> downgrade({
    required String userId,
    required SubscriptionTierType newTier,
  }) async {
    await Future.delayed(_mockDelay);

    final current = await getUserSubscription(userId);
    if (current == null) {
      throw Exception('No active subscription found');
    }

    // Validate downgrade path
    if (_getTierLevel(newTier) >= _getTierLevel(current.tierType)) {
      throw Exception('Can only downgrade to lower tier');
    }

    // For mock: immediate downgrade (real system would wait until period end)
    await cancel(userId);
    return await subscribe(
      userId: userId,
      tierType: newTier,
      billingCycle: current.billingCycle,
    );
  }

  /// Cancel subscription
  Future<void> cancel(String userId) async {
    await Future.delayed(_mockDelay);
    await _cancelExistingSubscription(userId);
  }

  /// Check if user can access feature based on subscription
  Future<bool> canAccessFeature({
    required String userId,
    required String feature,
  }) async {
    final tier = await getUserTier(userId);
    final config = tier.config;

    switch (feature) {
      case 'priority_notifications':
        return config.hasPriorityNotifications;
      case 'early_access':
        return config.hasEarlyAccess;
      case 'featured_placement':
        return config.hasFeaturedPlacement;
      case 'waived_relist':
        return config.hasWaivedRelistFee;
      case 'monthly_insights':
        return config.hasMonthlyInsights;
      case 'streak_rewards':
        return config.hasStreakRewards;
      default:
        return false;
    }
  }

  /// Check if user can place bid (based on active bid limits)
  Future<bool> canPlaceBid({
    required String userId,
    required int currentActiveBids,
  }) async {
    final tier = await getUserTier(userId);
    final maxBids = tier.config.maxActiveBids;
    return maxBids == -1 || currentActiveBids < maxBids;
  }

  /// Check if user can create listing (based on active listing limits)
  Future<bool> canCreateListing({
    required String userId,
    required int currentActiveListings,
  }) async {
    final tier = await getUserTier(userId);
    final maxListings = tier.config.maxActiveListings;
    return maxListings == -1 || currentActiveListings < maxListings;
  }

  /// Get subscription benefits summary
  Future<Map<String, dynamic>> getBenefitsSummary(String userId) async {
    final tier = await getUserTier(userId);
    final config = tier.config;
    final subscription = await getUserSubscription(userId);

    return {
      'tier': tier,
      'displayName': config.displayName,
      'badge': config.badge,
      'maxActiveBids': config.maxActiveBids,
      'maxActiveListings': config.maxActiveListings,
      'premiumDiscount': config.buyersPremiumDiscount,
      'features': config.features,
      'isActive': subscription?.status.isActive ?? false,
      'nextBillingDate': subscription?.nextBillingDate,
      'amountPaid': subscription?.amountPaid ?? 0,
    };
  }

  /// Renew subscription (called by payment webhook in real implementation)
  Future<void> renew(String subscriptionId) async {
    await Future.delayed(_mockDelay);

    final index = _subscriptions.indexWhere((s) => s.id == subscriptionId);
    if (index == -1) return;

    final old = _subscriptions[index];
    final now = DateTime.now();
    final nextBilling = old.billingCycle == BillingCycle.monthly
        ? now.add(const Duration(days: 30))
        : now.add(const Duration(days: 365));

    final renewed = old.copyWith(
      nextBillingDate: nextBilling,
      updatedAt: now,
    );

    _subscriptions[index] = renewed;
    _notifyListeners();
  }

  /// Suspend subscription (payment failed)
  Future<void> suspend(String subscriptionId) async {
    await Future.delayed(_mockDelay);

    final index = _subscriptions.indexWhere((s) => s.id == subscriptionId);
    if (index == -1) return;

    final old = _subscriptions[index];
    _subscriptions[index] = old.copyWith(
      status: SubscriptionStatus.suspended,
      updatedAt: DateTime.now(),
    );

    _notifyListeners();
  }

  /// Get all subscriptions (admin)
  Future<List<UserSubscription>> getAllSubscriptions() async {
    await Future.delayed(_mockDelay);
    return List.unmodifiable(_subscriptions);
  }

  // ===== Private Helper Methods =====

  void _notifyListeners() {
    _subscriptionsController.add(List.unmodifiable(_subscriptions));
  }

  Future<void> _cancelExistingSubscription(String userId) async {
    final existing = _subscriptions.where(
      (s) => s.userId == userId && s.status.isActive,
    );

    for (final sub in existing) {
      final index = _subscriptions.indexOf(sub);
      _subscriptions[index] = sub.copyWith(
        status: SubscriptionStatus.cancelled,
        cancelledAt: DateTime.now(),
        endDate: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }

    // Create free tier subscription
    final now = DateTime.now();
    _subscriptions.add(UserSubscription(
      id: 'SUB${now.millisecondsSinceEpoch}',
      userId: userId,
      tierType: SubscriptionTierType.free,
      billingCycle: BillingCycle.monthly,
      status: SubscriptionStatus.active,
      startDate: now,
      endDate: null,
      nextBillingDate: now,
      amountPaid: 0,
      createdAt: now,
    ));

    _notifyListeners();
  }

  int _getTierLevel(SubscriptionTierType tier) {
    switch (tier) {
      case SubscriptionTierType.free:
        return 0;
      case SubscriptionTierType.proBasic:
        return 1;
      case SubscriptionTierType.proPlus:
        return 2;
    }
  }

  /// Dispose resources
  void dispose() {
    _subscriptionsController.close();
  }
}
