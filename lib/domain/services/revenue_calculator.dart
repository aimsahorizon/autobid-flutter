import 'package:autobid/data/models/subscription_tier.dart';

/// REVISED Revenue Calculator - Token-Based Model
///
/// This service calculates all revenue model fees:
/// 1. Token Cost (1 token per bid)
/// 2. Listing Fees (₱3,000 new / ₱1,000 relist)
/// 3. Subscription benefits & quotas
///
/// BACKEND INTEGRATION NOTES:
/// - Connect to payment gateway for fee collection
/// - Track listing fee payments before auction activation
/// - Sync subscription tier token allocations
/// - Handle monthly quota resets (rolling 30-day)
/// - Bidding deposit: ₱10,000 refundable (winner choice: credit or refund)
class RevenueCalculator {
  // Token Configuration (REVISED Model)
  static const int tokenCostPerBid = 1; // 1 token per bid

  // Listing Fee Configuration
  static const double newListingFee = 3000.0; // ₱3,000
  static const double relistingFee = 1000.0; // ₱1,000
  static const double freeExtraListingFee = 199.0; // ₱199 for Free tier extra listings

  // Bidding Deposit
  static const double biddingDepositAmount = 10000.0; // ₱10,000

  // DEPRECATED - Old GEMINI fields (kept for migration)
  @Deprecated('Use token system instead')
  static const double basePremiumRate = 0.035;
  @Deprecated('Use token system instead')
  static const double minimumPremium = 3000.0;
  @Deprecated('Use token system instead')
  static const double maximumPremium = 60000.0;

  // ========== DEPRECATED METHODS (GEMINI Model) ==========
  // These methods are kept for backward compatibility during migration.
  // Use token-based system instead.

  /// DEPRECATED: Calculate buyer's premium
  @Deprecated('Use token system instead. Winner pays final bid only, no premium.')
  static double calculateBuyersPremium({
    required double finalBid,
    required SubscriptionTierType tier,
  }) {
    return 0.0; // No longer used in REVISED model
  }

  /// DEPRECATED: Calculate total buyer payment
  @Deprecated('Use token system. Buyer pays final bid only.')
  static double calculateBuyerTotal({
    required double finalBid,
    required SubscriptionTierType tier,
  }) {
    return finalBid; // No premium in REVISED model
  }

  /// DEPRECATED: Calculate payment with deposit
  @Deprecated('Use deposit choice logic instead (credit to payment vs full refund)')
  static Map<String, double> calculateBuyerPaymentWithDeposit({
    required double finalBid,
    required SubscriptionTierType tier,
    required double depositPaid,
  }) {
    // Simplified: winner chooses credit or refund
    return {
      'finalBid': finalBid,
      'buyersPremium': 0.0,
      'depositCredit': 0.0,
      'additionalPremiumDue': 0.0,
      'depositRefund': depositPaid,
      'totalDue': finalBid,
    };
  }

  // ========== REVISED MODEL METHODS ==========

  /// Calculate buyer payment with deposit choice
  ///
  /// Winner chooses:
  /// 1. Credit deposit to payment: Pay (finalBid - ₱10,000)
  /// 2. Full refund: Pay finalBid, receive ₱10,000 refund
  ///
  /// Losers: Full refund of ₱10,000
  static Map<String, double> calculateBuyerPaymentWithDepositChoice({
    required double finalBid,
    required double depositPaid,
    required bool creditToPayment, // true = credit, false = refund
  }) {
    if (creditToPayment) {
      final paymentDue = (finalBid - depositPaid).clamp(0.0, double.infinity);
      return {
        'finalBid': finalBid,
        'depositCredit': depositPaid,
        'depositRefund': 0.0,
        'totalDue': paymentDue,
      };
    } else {
      return {
        'finalBid': finalBid,
        'depositCredit': 0.0,
        'depositRefund': depositPaid,
        'totalDue': finalBid,
      };
    }
  }

  /// Calculate listing fee
  static double calculateListingFee({required bool isRelist}) {
    return isRelist ? relistingFee : newListingFee;
  }

  /// Get subscription tier benefits summary (REVISED)
  static Map<String, dynamic> getSubscriptionBenefits(SubscriptionTierType tier) {
    final config = tier.config;
    return {
      'tier': tier,
      'displayName': config.displayName,
      'badge': config.badge,
      'monthlyTokenAllocation': config.monthlyTokenAllocation,
      'maxListingsPerMonth': config.maxListingsPerMonth,
      'hasAutoBid': config.hasAutoBid,
      'hasPriorityNotifications': config.hasPriorityNotifications,
      'hasEarlyAccess': config.hasEarlyAccess,
      'earlyAccessHours': config.earlyAccessHours,
      'hasFeaturedPlacement': config.hasFeaturedPlacement,
      'hasWaivedRelistFee': config.hasWaivedRelistFee,
    };
  }

  /// Check if user can place a bid (token-based system)
  ///
  /// In REVISED model, bids are limited by token balance, not tier limits.
  /// This method is kept for compatibility but always returns true.
  /// Use TokenService.canDeductToken() instead.
  @Deprecated('Use TokenService.canDeductToken() instead')
  static bool canPlaceBid({
    required SubscriptionTierType tier,
    required int currentActiveBids,
  }) {
    return true; // No tier-based bid limits in REVISED model
  }

  /// Check if user can create a listing based on monthly quota
  ///
  /// REVISED Model: Rolling 30-day quota, not concurrent limit
  static bool canCreateListing({
    required SubscriptionTierType tier,
    required int listingsUsedThisMonth,
  }) {
    final monthlyQuota = tier.config.maxListingsPerMonth;
    return listingsUsedThisMonth < monthlyQuota;
  }

  /// Calculate extra listing fee for Free tier users
  ///
  /// Free tier: 1 listing/month, ₱199 per additional listing
  static double calculateExtraListingFee({
    required SubscriptionTierType tier,
    required int listingsUsedThisMonth,
  }) {
    if (tier != SubscriptionTierType.free) {
      return 0.0; // Only Free tier pays extra listing fee
    }

    final quota = tier.config.maxListingsPerMonth; // 1 for Free
    if (listingsUsedThisMonth < quota) {
      return 0.0; // Within quota
    }

    return freeExtraListingFee; // ₱199 per extra listing
  }

  /// Calculate effective listing fee with subscription benefits
  ///
  /// Pro Plus tier gets waived re-list fee
  static double calculateEffectiveListingFee({
    required bool isRelist,
    required SubscriptionTierType tier,
  }) {
    if (isRelist && tier.config.hasWaivedRelistFee) {
      return 0.0; // Pro Plus waives re-list fee
    }
    return calculateListingFee(isRelist: isRelist);
  }

  /// Format currency for display (Philippine Peso)
  static String formatCurrency(double amount) {
    return '₱${amount.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }

  /// Format percentage for display
  static String formatPercentage(double rate) {
    return '${(rate * 100).toStringAsFixed(1)}%';
  }

  /// Round up to nearest increment (e.g., nearest ₱10)
  static double _roundUpToNearest(double value, double increment) {
    return (value / increment).ceil() * increment;
  }

  /// Calculate comprehensive fee breakdown for auction transaction (REVISED)
  static Map<String, dynamic> calculateTransactionBreakdown({
    required double finalBid,
    required SubscriptionTierType buyerTier,
    required double depositPaid,
    required bool depositCreditToPayment,
    required double listingFeePaid,
    required int tokensCost, // Tokens used for bidding
  }) {
    final paymentWithDeposit = calculateBuyerPaymentWithDepositChoice(
      finalBid: finalBid,
      depositPaid: depositPaid,
      creditToPayment: depositCreditToPayment,
    );

    final sellerPayout = finalBid - listingFeePaid;
    final platformRevenue = listingFeePaid; // Only listing fee, no buyer's premium

    return {
      // Buyer side (REVISED - No premium)
      'finalBid': finalBid,
      'depositCredit': paymentWithDeposit['depositCredit'],
      'depositRefund': paymentWithDeposit['depositRefund'],
      'buyerTotalDue': paymentWithDeposit['totalDue'],
      'tokensCost': tokensCost, // Informational

      // Seller side
      'listingFeePaid': listingFeePaid,
      'sellerPayout': sellerPayout,

      // Platform
      'platformRevenue': platformRevenue,

      // Tier info
      'buyerTier': buyerTier.displayName,
      'buyerBadge': buyerTier.badge,
    };
  }

  /// Example calculation for display/testing (REVISED Model)
  static void printExampleCalculation() {
    const finalBid = 500000.0;

    print('=== REVISED Revenue Model - Token-Based System ===\n');

    print('=== Subscription Tiers & Token Allocations ===');
    for (final tier in SubscriptionTierType.values) {
      final config = tier.config;
      final tokenAllocation = config.monthlyTokenAllocation == -1
          ? 'Unlimited'
          : '${config.monthlyTokenAllocation} tokens';
      final listingQuota = '${config.maxListingsPerMonth} listings';

      print('${tier.displayName} (${tier.badge})');
      print('  Monthly Tokens: $tokenAllocation');
      print('  Monthly Listings: $listingQuota');
      print('  AutoBid: ${config.hasAutoBid ? 'Yes' : 'No'}');
      print('');
    }

    print('=== Token System ===');
    print('  Cost per Bid: $tokenCostPerBid token');
    print('  Purchase Tiers:');
    print('    ₱100 = 100 tokens');
    print('    ₱500 = 600 tokens (+100 bonus)');
    print('');

    print('=== Listing Fees ===');
    print('  New Listing: ${formatCurrency(newListingFee)}');
    print('  Re-listing: ${formatCurrency(relistingFee)}');
    print('  Pro Plus Re-list: ${formatCurrency(0)} (waived)');
    print('  Free Tier Extra Listing: ${formatCurrency(freeExtraListingFee)}');
    print('');

    print('=== Bidding Deposit ===');
    print('  Required Deposit: ${formatCurrency(biddingDepositAmount)}');
    print('  Winner Choice: Credit to payment OR full refund');
    print('  Losers: Full refund');
    print('');

    print('=== Example Transaction (Winning Bid: ${formatCurrency(finalBid)}) ===');
    print('\nOption 1: Credit Deposit to Payment');
    final creditPayment = calculateBuyerPaymentWithDepositChoice(
      finalBid: finalBid,
      depositPaid: biddingDepositAmount,
      creditToPayment: true,
    );
    print('  Final Bid: ${formatCurrency(finalBid)}');
    print('  Deposit Credit: ${formatCurrency(creditPayment['depositCredit']!)}');
    print('  Total Due: ${formatCurrency(creditPayment['totalDue']!)}');
    print('');

    print('Option 2: Full Refund');
    final refundPayment = calculateBuyerPaymentWithDepositChoice(
      finalBid: finalBid,
      depositPaid: biddingDepositAmount,
      creditToPayment: false,
    );
    print('  Final Bid: ${formatCurrency(finalBid)}');
    print('  Deposit Refund: ${formatCurrency(refundPayment['depositRefund']!)}');
    print('  Total Due: ${formatCurrency(refundPayment['totalDue']!)}');
    print('');
  }
}
