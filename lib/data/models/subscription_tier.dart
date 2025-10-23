import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_tier.freezed.dart';
part 'subscription_tier.g.dart';

/// Subscription tier types
enum SubscriptionTierType {
  free,
  proBasic,
  proPlus,
}

/// Subscription billing cycle
enum BillingCycle {
  monthly,
  yearly,
}

/// Subscription tier model - REVISED Revenue Model (Token-based)
///
/// BACKEND INTEGRATION NOTES:
/// - Connect to subscription service API
/// - Sync tier benefits with user permissions
/// - Handle subscription lifecycle (activation, renewal, cancellation)
/// - Track subscription start/end dates
/// - Process tier upgrades/downgrades
/// - Allocate monthly tokens on subscription renewal
@freezed
abstract class SubscriptionTier with _$SubscriptionTier {
  const factory SubscriptionTier({
    required SubscriptionTierType tierType,
    required String displayName,
    required String badge,
    required double monthlyPrice,
    required double yearlyPrice,
    required int monthlyTokenAllocation, // -1 for unlimited (Pro Plus)
    required int maxListingsPerMonth, // Monthly rolling quota
    required bool hasAutoBid,
    required bool hasPriorityNotifications,
    required bool hasEarlyAccess,
    required int earlyAccessHours, // 0 for Free/ProBasic, 2 for ProPlus
    required bool hasFeaturedPlacement,
    required bool hasWaivedRelistFee,
    required bool hasMonthlyInsights,
    required bool hasStreakRewards,
    required String description,
    required List<String> features,
    // DEPRECATED - Old GEMINI fields (kept for migration compatibility)
    @Default(0) int maxActiveBids,
    @Default(0) int maxActiveListings,
    @Default(0.0) double buyersPremiumDiscount,
  }) = _SubscriptionTier;

  factory SubscriptionTier.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionTierFromJson(json);

  /// Free tier configuration - REVISED
  static SubscriptionTier get free => const SubscriptionTier(
        tierType: SubscriptionTierType.free,
        displayName: 'Free',
        badge: '',
        monthlyPrice: 0,
        yearlyPrice: 0,
        monthlyTokenAllocation: 10, // 10 tokens per month
        maxListingsPerMonth: 1, // 1 listing per month
        hasAutoBid: false,
        hasPriorityNotifications: false,
        hasEarlyAccess: false,
        earlyAccessHours: 0,
        hasFeaturedPlacement: false,
        hasWaivedRelistFee: false,
        hasMonthlyInsights: false,
        hasStreakRewards: false,
        description: 'Browse auctions, start bidding with 10 free tokens monthly',
        features: [
          '10 tokens per month',
          '1 listing per month',
          '₱199 per additional listing',
          'Basic notifications',
          '₱10,000 refundable deposit required',
        ],
      );

  /// Pro Basic tier configuration - REVISED
  static SubscriptionTier get proBasic => const SubscriptionTier(
        tierType: SubscriptionTierType.proBasic,
        displayName: 'Pro Basic',
        badge: 'Pro Basic',
        monthlyPrice: 199,
        yearlyPrice: 1999,
        monthlyTokenAllocation: 100, // 100 tokens per month
        maxListingsPerMonth: 3, // 3 listings per month
        hasAutoBid: true,
        hasPriorityNotifications: true,
        hasEarlyAccess: false,
        earlyAccessHours: 0,
        hasFeaturedPlacement: false,
        hasWaivedRelistFee: false,
        hasMonthlyInsights: true,
        hasStreakRewards: false,
        description: 'More tokens, AutoBid, priority notifications',
        features: [
          '100 tokens per month',
          '3 listings per month',
          'AutoBid feature',
          'Priority bid notifications',
          'Pro Basic badge on profile',
          'Monthly summary reports',
        ],
      );

  /// Pro Plus tier configuration - REVISED
  static SubscriptionTier get proPlus => const SubscriptionTier(
        tierType: SubscriptionTierType.proPlus,
        displayName: 'Pro Plus',
        badge: 'Verified Pro+',
        monthlyPrice: 499,
        yearlyPrice: 4999,
        monthlyTokenAllocation: -1, // -1 = unlimited tokens
        maxListingsPerMonth: 10, // 10 listings per month
        hasAutoBid: true,
        hasPriorityNotifications: true,
        hasEarlyAccess: true,
        earlyAccessHours: 2,
        hasFeaturedPlacement: true,
        hasWaivedRelistFee: true,
        hasMonthlyInsights: true,
        hasStreakRewards: true,
        description: 'Unlimited tokens, 10 listings, all premium features',
        features: [
          'Unlimited tokens per month',
          '10 listings per month',
          'AutoBid feature',
          'Early access to auctions (2 hours)',
          'Featured placement',
          'Waived re-list fee',
          'Verified Pro+ badge',
          'Performance insights & analytics',
          'Streak rewards & bonuses',
        ],
      );

  /// Get all available tiers
  static List<SubscriptionTier> get allTiers => [free, proBasic, proPlus];
}

/// User's active subscription
///
/// BACKEND INTEGRATION NOTES:
/// - Store in user's document/profile
/// - Update status via subscription webhook (Stripe, PayMongo, etc.)
/// - Handle automatic renewals
/// - Track cancellation and grace periods
/// - Sync with payment gateway subscription ID
@freezed
abstract class UserSubscription with _$UserSubscription {
  const factory UserSubscription({
    required String id,
    required String userId,
    required SubscriptionTierType tierType,
    required BillingCycle billingCycle,
    required SubscriptionStatus status,
    required DateTime startDate,
    required DateTime? endDate,
    required DateTime nextBillingDate,
    required double amountPaid,
    String? paymentGatewaySubscriptionId, // Stripe, PayMongo, etc.
    DateTime? cancelledAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserSubscription;

  factory UserSubscription.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionFromJson(json);
}

/// Subscription status
enum SubscriptionStatus {
  active,
  cancelled,
  expired,
  pendingPayment,
  suspended,
}

extension SubscriptionStatusExtension on SubscriptionStatus {
  bool get isActive => this == SubscriptionStatus.active;
  bool get canAccessFeatures => this == SubscriptionStatus.active;
}

extension SubscriptionTierTypeExtension on SubscriptionTierType {
  SubscriptionTier get config {
    switch (this) {
      case SubscriptionTierType.free:
        return SubscriptionTier.free;
      case SubscriptionTierType.proBasic:
        return SubscriptionTier.proBasic;
      case SubscriptionTierType.proPlus:
        return SubscriptionTier.proPlus;
    }
  }

  String get displayName => config.displayName;
  String get badge => config.badge;
}
