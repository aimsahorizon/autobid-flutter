import '../../data/models/pricing_config.dart';

/// Service for calculating platform fees based on pricing configuration
///
/// This service centralizes all fee calculation logic to ensure consistency
/// across the platform when:
/// - Creating auction listings (listing fee)
/// - Processing winning bids (transaction fee)
/// - Calculating seller payouts
/// - Displaying fee estimates to users
///
/// Industry best practices:
/// - Tiered pricing encourages high-value listings
/// - Fixed listing fee covers operational costs
/// - Transaction fee aligns platform success with user success
class PricingCalculator {
  final PricingConfig config;

  const PricingCalculator({required this.config});

  /// Factory constructor for default pricing
  factory PricingCalculator.withDefaultConfig() =>
      PricingCalculator(config: PricingConfig.defaultConfig());

  /// Calculate the listing fee for creating an auction
  ///
  /// Returns the fixed listing fee from configuration.
  /// In a production system, this could vary based on:
  /// - User verification level (dealers get discounts)
  /// - Promotional periods
  /// - Bulk listing packages
  double calculateListingFee() {
    return config.listingFee;
  }

  /// Determine the price tier based on sale price
  ///
  /// Tiers:
  /// - Economy: < ₱800,000 (5% fee)
  /// - Mid-Range: ₱800,000 - ₱2,000,000 (4% fee)
  /// - Premium: > ₱2,000,000 (3% fee)
  ///
  /// Industry rationale:
  /// - Lower absolute prices need higher percentage to cover costs
  /// - Higher prices generate sufficient revenue at lower percentage
  /// - Similar to Escrow.com's tiered structure
  PriceTier determinePriceTier(double salePrice) {
    if (salePrice < config.economyPriceThreshold) {
      return PriceTier.economy;
    } else if (salePrice < config.midRangePriceThreshold) {
      return PriceTier.midRange;
    } else {
      return PriceTier.premium;
    }
  }

  /// Get the transaction fee rate for a given sale price
  ///
  /// Returns the percentage rate (e.g., 0.05 for 5%)
  double getTransactionFeeRate(double salePrice) {
    final tier = determinePriceTier(salePrice);

    switch (tier) {
      case PriceTier.economy:
        return config.economyTransactionFeeRate;
      case PriceTier.midRange:
        return config.midRangeTransactionFeeRate;
      case PriceTier.premium:
        return config.premiumTransactionFeeRate;
    }
  }

  /// Calculate the transaction fee for a sale
  ///
  /// Formula:
  /// 1. Determine tier based on sale price
  /// 2. Apply corresponding fee rate
  /// 3. Enforce minimum fee if configured
  /// 4. Apply maximum cap if configured
  ///
  /// Example:
  /// - ₱500,000 sale → Economy tier → 5% → ₱25,000 fee
  /// - ₱1,500,000 sale → Mid-Range → 4% → ₱60,000 fee
  /// - ₱3,000,000 sale → Premium → 3% → ₱90,000 fee
  double calculateTransactionFee(double salePrice) {
    final feeRate = getTransactionFeeRate(salePrice);
    double fee = salePrice * feeRate;

    // Apply minimum fee
    if (fee < config.minTransactionFee) {
      fee = config.minTransactionFee;
    }

    // Apply maximum cap if configured
    if (config.maxTransactionFee != null && fee > config.maxTransactionFee!) {
      fee = config.maxTransactionFee!;
    }

    return fee;
  }

  /// Calculate comprehensive fee breakdown for a transaction
  ///
  /// This provides a complete picture of all fees and amounts:
  /// - What the buyer pays
  /// - Platform fees breakdown
  /// - What the seller receives
  ///
  /// Note: Currently, transaction fee is paid by seller (deducted from proceeds).
  /// Alternative models could split fee or charge buyer premium.
  FeeBreakdown calculateFeeBreakdown({
    required double salePrice,
    bool includeListingFee = true,
  }) {
    final listingFee = includeListingFee ? calculateListingFee() : 0.0;
    final transactionFeeRate = getTransactionFeeRate(salePrice);
    final transactionFee = calculateTransactionFee(salePrice);
    final totalPlatformFees = listingFee + transactionFee;
    final priceTier = determinePriceTier(salePrice);

    // Current model: Buyer pays sale price, seller pays fees
    final totalBuyerAmount = salePrice;
    final sellerReceives = salePrice - totalPlatformFees;

    return FeeBreakdown(
      salePrice: salePrice,
      listingFee: listingFee,
      transactionFeeRate: transactionFeeRate,
      transactionFee: transactionFee,
      totalPlatformFees: totalPlatformFees,
      totalBuyerAmount: totalBuyerAmount,
      sellerReceives: sellerReceives,
      priceTier: priceTier,
    );
  }

  /// Calculate total amount for buyer (currently same as sale price)
  ///
  /// In some auction models, buyer pays additional buyer's premium:
  /// - Copart: 5-10% buyer's premium
  /// - Christie's/Sotheby's: 20-25% buyer's premium
  ///
  /// Current model: Seller pays all fees, buyer pays listing price only
  double calculateBuyerTotal(double salePrice) {
    return salePrice;
  }

  /// Calculate amount seller receives after all fees
  ///
  /// Formula: Sale Price - Listing Fee - Transaction Fee
  ///
  /// Example for ₱1,000,000 sale:
  /// - Sale price: ₱1,000,000
  /// - Listing fee: ₱400
  /// - Transaction fee (4%): ₱40,000
  /// - Seller receives: ₱959,600
  double calculateSellerPayout({
    required double salePrice,
    bool includeListingFee = true,
  }) {
    final breakdown = calculateFeeBreakdown(
      salePrice: salePrice,
      includeListingFee: includeListingFee,
    );
    return breakdown.sellerReceives;
  }

  /// Calculate estimated revenue for platform
  ///
  /// Total revenue = Listing Fee + Transaction Fee
  ///
  /// This helps with:
  /// - Revenue projections
  /// - Analytics and reporting
  /// - Business model validation
  double calculatePlatformRevenue({
    required double salePrice,
    bool includeListingFee = true,
  }) {
    final breakdown = calculateFeeBreakdown(
      salePrice: salePrice,
      includeListingFee: includeListingFee,
    );
    return breakdown.totalPlatformFees;
  }

  /// Format fee percentage for display (e.g., "5%" or "3%")
  String formatFeeRate(double salePrice) {
    final rate = getTransactionFeeRate(salePrice);
    final percentage = (rate * 100).toStringAsFixed(0);
    return '$percentage%';
  }

  /// Format currency amount in Philippine Peso
  String formatCurrency(double amount) {
    return '₱${amount.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }
}
