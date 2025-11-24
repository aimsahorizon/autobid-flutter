import '../../domain/services/pricing_calculator.dart';
import '../../data/models/pricing_config.dart';

/// Legacy FeeCalculator - Updated to use new PricingCalculator
///
/// This class maintains backward compatibility with existing code
/// while leveraging the new tiered pricing system.
///
/// MIGRATION: New code should use PricingCalculator directly.
/// This class exists for backward compatibility only.
class FeeCalculator {
  // Legacy constants - kept for reference but not used
  @Deprecated('Use PricingCalculator with PricingConfig instead')
  static const double platformFeePercentage = 0.03; // 3%
  @Deprecated('Use PricingCalculator with PricingConfig instead')
  static const double platformFeeFixed = 50.0; // ₱50

  static final _pricingCalculator =
      PricingCalculator.withDefaultConfig();

  /// Calculate transaction fee based on tiered pricing model
  ///
  /// Tiered rates:
  /// - Economy (< ₱800k): 5%
  /// - Mid-Range (₱800k - ₱2M): 4%
  /// - Premium (> ₱2M): 3%
  ///
  /// This replaces the old flat 3% + ₱50 model
  static double calculatePlatformFee(double amount) {
    return _pricingCalculator.calculateTransactionFee(amount);
  }

  /// Calculate listing fee
  ///
  /// Returns the fixed listing fee (₱300-500, default ₱400)
  static double calculateListingFee() {
    return _pricingCalculator.calculateListingFee();
  }

  /// Calculate total amount buyer pays
  ///
  /// Currently: Total = Sale Price (no buyer premium)
  /// Transaction fees are paid by seller from proceeds
  static double calculateTotal(double amount) {
    return _pricingCalculator.calculateBuyerTotal(amount);
  }

  /// Calculate seller payout after all fees
  ///
  /// Formula: Sale Price - Listing Fee - Transaction Fee
  static double calculateSellerPayout({
    required double salePrice,
    bool includeListingFee = true,
  }) {
    return _pricingCalculator.calculateSellerPayout(
      salePrice: salePrice,
      includeListingFee: includeListingFee,
    );
  }

  /// Get comprehensive fee breakdown
  ///
  /// Returns detailed breakdown of all fees and amounts
  static FeeBreakdown getFeeBreakdown({
    required double salePrice,
    bool includeListingFee = true,
  }) {
    return _pricingCalculator.calculateFeeBreakdown(
      salePrice: salePrice,
      includeListingFee: includeListingFee,
    );
  }

  /// Format currency in Philippine Peso
  static String formatCurrency(double amount) {
    return _pricingCalculator.formatCurrency(amount);
  }

  /// Get legacy breakdown - kept for backward compatibility
  ///
  /// DEPRECATED: Use getFeeBreakdown() instead for detailed info
  @Deprecated('Use getFeeBreakdown() for detailed fee information')
  static Map<String, double> getBreakdown(double amount) {
    final breakdown = _pricingCalculator.calculateFeeBreakdown(
      salePrice: amount,
      includeListingFee: false, // For backward compatibility
    );

    return {
      'amount': amount,
      'platformFee': breakdown.transactionFee,
      'total': breakdown.totalBuyerAmount,
    };
  }

  /// Get transaction fee rate for a given sale price
  ///
  /// Returns the percentage rate (e.g., 0.05 for 5%)
  static double getTransactionFeeRate(double salePrice) {
    return _pricingCalculator.getTransactionFeeRate(salePrice);
  }

  /// Get formatted fee rate string (e.g., "5%")
  static String formatFeeRate(double salePrice) {
    return _pricingCalculator.formatFeeRate(salePrice);
  }
}
