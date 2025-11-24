import 'package:freezed_annotation/freezed_annotation.dart';

part 'pricing_config.freezed.dart';
part 'pricing_config.g.dart';

/// Pricing configuration for the AutoBID platform
///
/// Industry References:
/// - Escrow.com: Charges 0.89% - 3.25% for vehicle transactions
/// - Copart (US Auto Auction): $59-$189 listing fee + 5-10% buyer's premium
/// - Manheim (Wholesale Auction): $75-$300 listing fee + transaction fees
/// - Cars.com: $50-$150 per listing
/// - Bring A Trailer: $99 listing fee + no commission
///
/// Philippine Context:
/// - Average vehicle prices: ₱300k - ₱2M
/// - Economy segment: < ₱800k
/// - Mid-range: ₱800k - ₱2M
/// - Premium: > ₱2M
@freezed
abstract class PricingConfig with _$PricingConfig {
  const factory PricingConfig({
    /// Fixed listing fee charged when creating an auction (PHP 300-500)
    /// Industry: Similar to Copart ($59-$189) and Manheim ($75-$300)
    @Default(400.0) double listingFee,

    /// Minimum listing fee allowed (PHP)
    @Default(300.0) double minListingFee,

    /// Maximum listing fee allowed (PHP)
    @Default(500.0) double maxListingFee,

    /// Transaction fee for economy vehicles (< ₱800,000): 5%
    /// Industry: Higher than premium to offset lower absolute revenue
    /// Similar to Copart's buyer premium for lower-value vehicles
    @Default(0.05) double economyTransactionFeeRate,

    /// Price threshold for economy vehicles (PHP)
    @Default(800000.0) double economyPriceThreshold,

    /// Transaction fee for mid-range vehicles (₱800k - ₱2M): 4%
    /// Industry: Standard rate balancing volume and revenue
    /// Comparable to Escrow.com's mid-tier rates (~3-4%)
    @Default(0.04) double midRangeTransactionFeeRate,

    /// Price threshold for mid-range vehicles (PHP)
    @Default(2000000.0) double midRangePriceThreshold,

    /// Transaction fee for premium vehicles (> ₱2M): 3%
    /// Industry: Lower rate for high-value transactions
    /// Similar to Escrow.com's premium tier (0.89% - 3.25%)
    @Default(0.03) double premiumTransactionFeeRate,

    /// Minimum transaction fee (PHP)
    /// Set to 0 to use pure percentage-based fees
    @Default(0.0) double minTransactionFee,

    /// Maximum transaction fee cap (PHP) - optional ceiling
    /// Set to null for no maximum cap
    double? maxTransactionFee,

    /// Whether listing fee is refundable if auction doesn't complete
    @Default(false) bool listingFeeRefundable,

    /// Whether listing fee is charged upfront or deducted from sale
    @Default(true) bool listingFeeUpfront,
  }) = _PricingConfig;

  factory PricingConfig.fromJson(Map<String, dynamic> json) =>
      _$PricingConfigFromJson(json);

  /// Default configuration for production
  factory PricingConfig.defaultConfig() => const PricingConfig();

  /// Alternative configuration with lower fees for promotional periods
  factory PricingConfig.promotional() => const PricingConfig(
        listingFee: 300.0,
        economyTransactionFeeRate: 0.045, // 4.5%
        midRangeTransactionFeeRate: 0.035, // 3.5%
        premiumTransactionFeeRate: 0.025, // 2.5%
      );

  /// Configuration for dealer accounts (optional future feature)
  factory PricingConfig.dealer() => const PricingConfig(
        listingFee: 250.0, // Discounted for high-volume dealers
        economyTransactionFeeRate: 0.04, // 4%
        midRangeTransactionFeeRate: 0.03, // 3%
        premiumTransactionFeeRate: 0.025, // 2.5%
      );
}

/// Detailed breakdown of fees for a transaction
@freezed
abstract class FeeBreakdown with _$FeeBreakdown {
  const factory FeeBreakdown({
    /// Original sale price before fees
    required double salePrice,

    /// Listing fee charged to seller
    required double listingFee,

    /// Transaction fee rate applied (as percentage, e.g., 0.05 = 5%)
    required double transactionFeeRate,

    /// Calculated transaction fee amount
    required double transactionFee,

    /// Total platform fees (listing fee + transaction fee)
    required double totalPlatformFees,

    /// Total amount buyer pays (sale price + buyer portion if applicable)
    required double totalBuyerAmount,

    /// Amount seller receives after fees
    required double sellerReceives,

    /// Price tier used for calculation
    required PriceTier priceTier,
  }) = _FeeBreakdown;

  factory FeeBreakdown.fromJson(Map<String, dynamic> json) =>
      _$FeeBreakdownFromJson(json);
}

/// Price tier categories for different fee structures
enum PriceTier {
  @JsonValue('economy')
  economy, // < ₱800k

  @JsonValue('midRange')
  midRange, // ₱800k - ₱2M

  @JsonValue('premium')
  premium, // > ₱2M
}
