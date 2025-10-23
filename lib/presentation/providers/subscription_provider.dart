import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:autobid/data/models/subscription_tier.dart';
import 'package:autobid/data/models/user_model.dart';
import 'package:autobid/data/services/mock/mock_subscription_service.dart';
import 'package:autobid/presentation/providers/token_provider.dart';
import 'package:autobid/presentation/providers/auth_provider.dart';

part 'subscription_provider.g.dart';

/// Subscription service provider
@Riverpod(keepAlive: true)
MockSubscriptionService subscriptionService(Ref ref) {
  return MockSubscriptionService();
}

/// Current user's subscription provider
@riverpod
Future<UserSubscription?> userSubscription(
  Ref ref,
  String userId,
) async {
  final service = ref.watch(subscriptionServiceProvider);
  return await service.getUserSubscription(userId);
}

/// Current user's subscription tier provider
@riverpod
Future<SubscriptionTierType> userSubscriptionTier(
  Ref ref,
  String userId,
) async {
  final service = ref.watch(subscriptionServiceProvider);
  return await service.getUserTier(userId);
}

/// Available subscription tiers provider
@riverpod
List<SubscriptionTier> availableSubscriptionTiers(
  Ref ref,
) {
  return SubscriptionTier.allTiers;
}

/// Subscription benefits summary provider
@riverpod
Future<Map<String, dynamic>> subscriptionBenefits(
  Ref ref,
  String userId,
) async {
  final service = ref.watch(subscriptionServiceProvider);
  return await service.getBenefitsSummary(userId);
}

/// Check if user can place bid provider
@riverpod
Future<bool> canPlaceBid(
  Ref ref,
  String userId,
  int currentActiveBids,
) async {
  final service = ref.watch(subscriptionServiceProvider);
  return await service.canPlaceBid(
    userId: userId,
    currentActiveBids: currentActiveBids,
  );
}

/// Check if user can create listing provider
@riverpod
Future<bool> canCreateListing(
  Ref ref,
  String userId,
  int currentActiveListings,
) async {
  final service = ref.watch(subscriptionServiceProvider);
  return await service.canCreateListing(
    userId: userId,
    currentActiveListings: currentActiveListings,
  );
}

// ========== REVISED MODEL - Quota Management ==========

/// Check if user's listing quota needs reset (rolling 30-day)
@riverpod
bool needsQuotaReset(
  Ref ref,
  UserModel user,
) {
  final resetDate = user.listingQuotaResetDate;
  if (resetDate == null) return true; // First time, needs initialization

  final now = DateTime.now();
  return now.isAfter(resetDate);
}

/// Get remaining listing quota for user
@riverpod
int remainingListingQuota(
  Ref ref,
  UserModel user,
) {
  final tier = user.subscriptionTier.config;
  final used = user.listingsUsedThisMonth;
  final quota = tier.maxListingsPerMonth;

  return (quota - used).clamp(0, quota);
}

/// Check if user can create listing (REVISED - monthly quota)
@riverpod
bool canCreateListingRevised(
  Ref ref,
  UserModel user,
) {
  // Check if quota needs reset first
  if (ref.watch(needsQuotaResetProvider(user))) {
    return true; // After reset, they can create listings
  }

  final remaining = ref.watch(remainingListingQuotaProvider(user));
  return remaining > 0;
}

/// Calculate extra listing fee for Free tier
@riverpod
double extraListingFee(
  Ref ref,
  UserModel user,
) {
  if (user.subscriptionTier != SubscriptionTierType.free) {
    return 0.0;
  }

  final quota = user.subscriptionTier.config.maxListingsPerMonth; // 1 for Free
  final used = user.listingsUsedThisMonth;

  if (used < quota) {
    return 0.0; // Within quota
  }

  return 199.0; // ₱199 per extra listing
}

/// Subscription action notifier for managing subscriptions
@riverpod
class SubscriptionActions extends _$SubscriptionActions {
  @override
  FutureOr<void> build() {}

  /// Subscribe to a tier (REVISED - with token allocation)
  Future<UserSubscription> subscribe({
    required String userId,
    required SubscriptionTierType tierType,
    required BillingCycle billingCycle,
  }) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(subscriptionServiceProvider);
      final subscription = await service.subscribe(
        userId: userId,
        tierType: tierType,
        billingCycle: billingCycle,
      );

      // Allocate monthly tokens for new subscription
      final tokenActions = ref.read(tokenActionsProvider.notifier);
      await tokenActions.allocateSubscriptionTokens(
        userId: userId,
        tierType: tierType,
      );

      // Invalidate related providers
      ref.invalidate(userSubscriptionProvider);
      ref.invalidate(userSubscriptionTierProvider);
      ref.invalidate(subscriptionBenefitsProvider);

      state = const AsyncValue.data(null);
      return subscription;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Upgrade subscription
  Future<UserSubscription> upgrade({
    required String userId,
    required SubscriptionTierType newTier,
  }) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(subscriptionServiceProvider);
      final subscription = await service.upgrade(
        userId: userId,
        newTier: newTier,
      );

      // Invalidate related providers
      ref.invalidate(userSubscriptionProvider);
      ref.invalidate(userSubscriptionTierProvider);
      ref.invalidate(subscriptionBenefitsProvider);

      state = const AsyncValue.data(null);
      return subscription;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Downgrade subscription
  Future<UserSubscription> downgrade({
    required String userId,
    required SubscriptionTierType newTier,
  }) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(subscriptionServiceProvider);
      final subscription = await service.downgrade(
        userId: userId,
        newTier: newTier,
      );

      // Invalidate related providers
      ref.invalidate(userSubscriptionProvider);
      ref.invalidate(userSubscriptionTierProvider);
      ref.invalidate(subscriptionBenefitsProvider);

      state = const AsyncValue.data(null);
      return subscription;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Cancel subscription
  Future<void> cancel(String userId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(subscriptionServiceProvider);
      await service.cancel(userId);

      // Invalidate related providers
      ref.invalidate(userSubscriptionProvider);
      ref.invalidate(userSubscriptionTierProvider);
      ref.invalidate(subscriptionBenefitsProvider);
    });
  }

  // ========== REVISED MODEL - Quota Management Methods ==========

  /// Reset listing quota (rolling 30-day)
  ///
  /// Call this when:
  /// 1. User's quota reset date has passed
  /// 2. User upgrades subscription
  /// 3. Manual reset (admin)
  Future<void> resetListingQuota({
    required String userId,
  }) async {
    state = const AsyncValue.loading();
    try {
      // This would update the user's listingsUsedThisMonth = 0
      // and listingQuotaResetDate = now + 30 days
      // In real implementation, this would call a backend API
      // For now, we'll just invalidate providers

      ref.invalidate(userSubscriptionProvider);
      ref.invalidate(userSubscriptionTierProvider);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Increment listing usage
  ///
  /// Call this after successfully creating a listing
  Future<void> incrementListingUsage({
    required String userId,
  }) async {
    state = const AsyncValue.loading();
    try {
      // This would increment user's listingsUsedThisMonth += 1
      // In real implementation, this would call a backend API
      // For now, we'll just invalidate providers

      ref.invalidate(userSubscriptionProvider);
      ref.invalidate(userSubscriptionTierProvider);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Renew subscription and allocate monthly tokens
  ///
  /// Call this on subscription renewal (monthly/yearly billing cycle)
  Future<void> renewSubscription({
    required String userId,
    required SubscriptionTierType tierType,
  }) async {
    state = const AsyncValue.loading();
    try {
      // Allocate monthly tokens
      final tokenActions = ref.read(tokenActionsProvider.notifier);
      await tokenActions.allocateSubscriptionTokens(
        userId: userId,
        tierType: tierType,
      );

      // Reset listing quota
      await resetListingQuota(userId: userId);

      // Invalidate related providers
      ref.invalidate(userSubscriptionProvider);
      ref.invalidate(userSubscriptionTierProvider);
      ref.invalidate(subscriptionBenefitsProvider);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

