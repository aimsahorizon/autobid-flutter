import 'package:flutter_test/flutter_test.dart';
import 'package:autobid/domain/services/pricing_calculator.dart';
import 'package:autobid/data/models/pricing_config.dart';

/// Unit tests for PricingCalculator service
///
/// Tests verify:
/// - Listing fee calculation
/// - Tiered transaction fee calculation (economy, mid-range, premium)
/// - Fee breakdown accuracy
/// - Seller payout calculation
/// - Edge cases and boundary conditions
void main() {
  group('PricingCalculator - Listing Fee', () {
    test('should return default listing fee of 400 PHP', () {
      final calculator = PricingCalculator.withDefaultConfig();
      final listingFee = calculator.calculateListingFee();

      expect(listingFee, equals(400.0));
    });

    test('should use custom listing fee from config', () {
      final customConfig = PricingConfig(listingFee: 350.0);
      final calculator = PricingCalculator(config: customConfig);
      final listingFee = calculator.calculateListingFee();

      expect(listingFee, equals(350.0));
    });
  });

  group('PricingCalculator - Price Tier Determination', () {
    final calculator = PricingCalculator.withDefaultConfig();

    test('should classify economy tier for prices below 800k', () {
      expect(calculator.determinePriceTier(500000), equals(PriceTier.economy));
      expect(calculator.determinePriceTier(799999), equals(PriceTier.economy));
      expect(calculator.determinePriceTier(100000), equals(PriceTier.economy));
    });

    test('should classify mid-range tier for prices 800k-2M', () {
      expect(
          calculator.determinePriceTier(800000), equals(PriceTier.midRange));
      expect(
          calculator.determinePriceTier(1500000), equals(PriceTier.midRange));
      expect(
          calculator.determinePriceTier(1999999), equals(PriceTier.midRange));
    });

    test('should classify premium tier for prices above 2M', () {
      expect(
          calculator.determinePriceTier(2000000), equals(PriceTier.premium));
      expect(
          calculator.determinePriceTier(3000000), equals(PriceTier.premium));
      expect(
          calculator.determinePriceTier(5000000), equals(PriceTier.premium));
    });
  });

  group('PricingCalculator - Transaction Fee Rate', () {
    final calculator = PricingCalculator.withDefaultConfig();

    test('should return 5% for economy tier (< 800k)', () {
      expect(calculator.getTransactionFeeRate(500000), equals(0.05));
      expect(calculator.getTransactionFeeRate(799999), equals(0.05));
    });

    test('should return 4% for mid-range tier (800k-2M)', () {
      expect(calculator.getTransactionFeeRate(800000), equals(0.04));
      expect(calculator.getTransactionFeeRate(1500000), equals(0.04));
      expect(calculator.getTransactionFeeRate(1999999), equals(0.04));
    });

    test('should return 3% for premium tier (> 2M)', () {
      expect(calculator.getTransactionFeeRate(2000000), equals(0.03));
      expect(calculator.getTransactionFeeRate(3000000), equals(0.03));
    });
  });

  group('PricingCalculator - Transaction Fee Calculation', () {
    final calculator = PricingCalculator.withDefaultConfig();

    test('should calculate correct fee for economy tier', () {
      // ₱500,000 × 5% = ₱25,000
      expect(calculator.calculateTransactionFee(500000), equals(25000.0));

      // ₱750,000 × 5% = ₱37,500
      expect(calculator.calculateTransactionFee(750000), equals(37500.0));
    });

    test('should calculate correct fee for mid-range tier', () {
      // ₱1,000,000 × 4% = ₱40,000
      expect(calculator.calculateTransactionFee(1000000), equals(40000.0));

      // ₱1,500,000 × 4% = ₱60,000
      expect(calculator.calculateTransactionFee(1500000), equals(60000.0));
    });

    test('should calculate correct fee for premium tier', () {
      // ₱2,500,000 × 3% = ₱75,000
      expect(calculator.calculateTransactionFee(2500000), equals(75000.0));

      // ₱3,000,000 × 3% = ₱90,000
      expect(calculator.calculateTransactionFee(3000000), equals(90000.0));
    });

    test('should calculate pure percentage without minimum fee', () {
      // Very low sale prices use pure percentage (no ₱50 minimum)
      // ₱100 × 5% = ₱5
      expect(calculator.calculateTransactionFee(100), equals(5.0));
      // ₱500 × 5% = ₱25
      expect(calculator.calculateTransactionFee(500), equals(25.0));
    });
  });

  group('PricingCalculator - Fee Breakdown (Buyer\'s Premium Model)', () {
    final calculator = PricingCalculator.withDefaultConfig();

    test('should provide complete breakdown for economy tier sale', () {
      // ₱500,000 sale - Buyer's Premium Model
      final breakdown = calculator.calculateFeeBreakdown(salePrice: 500000);

      expect(breakdown.salePrice, equals(500000.0));
      expect(breakdown.listingFee, equals(400.0)); // Seller pays
      expect(breakdown.transactionFeeRate, equals(0.05));
      expect(breakdown.transactionFee, equals(25000.0)); // 5% buyer's premium
      expect(breakdown.totalPlatformFees, equals(25400.0)); // 400 + 25000
      expect(breakdown.totalBuyerAmount, equals(525000.0)); // 500000 + 25000
      expect(breakdown.sellerReceives, equals(499600.0)); // 500000 - 400
      expect(breakdown.priceTier, equals(PriceTier.economy));
    });

    test('should provide complete breakdown for mid-range tier sale', () {
      // ₱1,000,000 sale - Buyer's Premium Model
      final breakdown = calculator.calculateFeeBreakdown(salePrice: 1000000);

      expect(breakdown.salePrice, equals(1000000.0));
      expect(breakdown.listingFee, equals(400.0)); // Seller pays
      expect(breakdown.transactionFeeRate, equals(0.04));
      expect(breakdown.transactionFee, equals(40000.0)); // 4% buyer's premium
      expect(breakdown.totalPlatformFees, equals(40400.0)); // 400 + 40000
      expect(breakdown.totalBuyerAmount, equals(1040000.0)); // 1000000 + 40000
      expect(breakdown.sellerReceives, equals(999600.0)); // 1000000 - 400
      expect(breakdown.priceTier, equals(PriceTier.midRange));
    });

    test('should provide complete breakdown for premium tier sale', () {
      // ₱3,000,000 sale - Buyer's Premium Model
      final breakdown = calculator.calculateFeeBreakdown(salePrice: 3000000);

      expect(breakdown.salePrice, equals(3000000.0));
      expect(breakdown.listingFee, equals(400.0)); // Seller pays
      expect(breakdown.transactionFeeRate, equals(0.03));
      expect(breakdown.transactionFee, equals(90000.0)); // 3% buyer's premium
      expect(breakdown.totalPlatformFees, equals(90400.0)); // 400 + 90000
      expect(breakdown.totalBuyerAmount, equals(3090000.0)); // 3000000 + 90000
      expect(breakdown.sellerReceives, equals(2999600.0)); // 3000000 - 400
      expect(breakdown.priceTier, equals(PriceTier.premium));
    });

    test('should exclude listing fee when requested', () {
      final breakdown = calculator.calculateFeeBreakdown(
        salePrice: 1000000,
        includeListingFee: false,
      );

      expect(breakdown.listingFee, equals(0.0));
      expect(breakdown.totalPlatformFees, equals(40000.0)); // Only transaction fee
      expect(breakdown.totalBuyerAmount, equals(1040000.0)); // 1000000 + 40000
      expect(breakdown.sellerReceives, equals(1000000.0)); // Full sale price
    });
  });

  group('PricingCalculator - Seller Payout (Buyer\'s Premium Model)', () {
    final calculator = PricingCalculator.withDefaultConfig();

    test('should calculate correct seller payout for economy tier', () {
      // ₱500,000 - ₱400 (listing only) = ₱499,600
      // Transaction fee paid by buyer, not deducted from seller
      final payout = calculator.calculateSellerPayout(salePrice: 500000);
      expect(payout, equals(499600.0));
    });

    test('should calculate correct seller payout for mid-range tier', () {
      // ₱1,000,000 - ₱400 (listing only) = ₱999,600
      // Transaction fee paid by buyer, not deducted from seller
      final payout = calculator.calculateSellerPayout(salePrice: 1000000);
      expect(payout, equals(999600.0));
    });

    test('should calculate correct seller payout for premium tier', () {
      // ₱3,000,000 - ₱400 (listing only) = ₱2,999,600
      // Transaction fee paid by buyer, not deducted from seller
      final payout = calculator.calculateSellerPayout(salePrice: 3000000);
      expect(payout, equals(2999600.0));
    });

    test('should exclude listing fee when requested', () {
      final payout = calculator.calculateSellerPayout(
        salePrice: 1000000,
        includeListingFee: false,
      );
      // ₱1,000,000 (full sale price, no fees deducted)
      expect(payout, equals(1000000.0));
    });
  });

  group('PricingCalculator - Buyer Total (Buyer\'s Premium Model)', () {
    final calculator = PricingCalculator.withDefaultConfig();

    test('should add buyer\'s premium to sale price', () {
      // ₱500,000 + ₱25,000 (5%) = ₱525,000
      expect(calculator.calculateBuyerTotal(500000), equals(525000.0));

      // ₱1,000,000 + ₱40,000 (4%) = ₱1,040,000
      expect(calculator.calculateBuyerTotal(1000000), equals(1040000.0));

      // ₱3,000,000 + ₱90,000 (3%) = ₱3,090,000
      expect(calculator.calculateBuyerTotal(3000000), equals(3090000.0));
    });
  });

  group('PricingCalculator - Platform Revenue', () {
    final calculator = PricingCalculator.withDefaultConfig();

    test('should calculate total platform revenue for economy tier', () {
      // ₱400 (listing) + ₱25,000 (5% transaction) = ₱25,400
      final revenue = calculator.calculatePlatformRevenue(salePrice: 500000);
      expect(revenue, equals(25400.0));
    });

    test('should calculate total platform revenue for mid-range tier', () {
      // ₱400 (listing) + ₱40,000 (4% transaction) = ₱40,400
      final revenue = calculator.calculatePlatformRevenue(salePrice: 1000000);
      expect(revenue, equals(40400.0));
    });

    test('should calculate total platform revenue for premium tier', () {
      // ₱400 (listing) + ₱90,000 (3% transaction) = ₱90,400
      final revenue = calculator.calculatePlatformRevenue(salePrice: 3000000);
      expect(revenue, equals(90400.0));
    });
  });

  group('PricingCalculator - Tier Boundary Edge Cases', () {
    final calculator = PricingCalculator.withDefaultConfig();

    test('should handle exact boundary at 800k', () {
      // Exactly ₱800,000 should be mid-range (4%)
      final breakdown = calculator.calculateFeeBreakdown(salePrice: 800000);
      expect(breakdown.priceTier, equals(PriceTier.midRange));
      expect(breakdown.transactionFeeRate, equals(0.04));
      expect(breakdown.transactionFee, equals(32000.0)); // 4% of 800k
    });

    test('should handle exact boundary at 2M', () {
      // Exactly ₱2,000,000 should be premium (3%)
      final breakdown = calculator.calculateFeeBreakdown(salePrice: 2000000);
      expect(breakdown.priceTier, equals(PriceTier.premium));
      expect(breakdown.transactionFeeRate, equals(0.03));
      expect(breakdown.transactionFee, equals(60000.0)); // 3% of 2M
    });

    test('should handle just below boundaries', () {
      // ₱799,999 should be economy (5%)
      final breakdown1 = calculator.calculateFeeBreakdown(salePrice: 799999);
      expect(breakdown1.priceTier, equals(PriceTier.economy));
      expect(breakdown1.transactionFeeRate, equals(0.05));

      // ₱1,999,999 should be mid-range (4%)
      final breakdown2 =
          calculator.calculateFeeBreakdown(salePrice: 1999999);
      expect(breakdown2.priceTier, equals(PriceTier.midRange));
      expect(breakdown2.transactionFeeRate, equals(0.04));
    });
  });

  group('PricingCalculator - Custom Configuration', () {
    test('should use custom config values', () {
      final customConfig = PricingConfig(
        listingFee: 300.0,
        economyTransactionFeeRate: 0.06, // 6%
        midRangeTransactionFeeRate: 0.05, // 5%
        premiumTransactionFeeRate: 0.04, // 4%
      );
      final calculator = PricingCalculator(config: customConfig);

      expect(calculator.calculateListingFee(), equals(300.0));
      expect(calculator.getTransactionFeeRate(500000), equals(0.06));
      expect(calculator.getTransactionFeeRate(1000000), equals(0.05));
      expect(calculator.getTransactionFeeRate(3000000), equals(0.04));
    });

    test('should use promotional config', () {
      final promoConfig = PricingConfig.promotional();
      final calculator = PricingCalculator(config: promoConfig);

      expect(calculator.calculateListingFee(), equals(300.0)); // Discounted
      expect(calculator.getTransactionFeeRate(500000), equals(0.045)); // 4.5%
      expect(calculator.getTransactionFeeRate(1000000), equals(0.035)); // 3.5%
      expect(calculator.getTransactionFeeRate(3000000), equals(0.025)); // 2.5%
    });

    test('should use dealer config', () {
      final dealerConfig = PricingConfig.dealer();
      final calculator = PricingCalculator(config: dealerConfig);

      expect(calculator.calculateListingFee(), equals(250.0)); // Lower for dealers
      expect(calculator.getTransactionFeeRate(500000), equals(0.04)); // 4%
      expect(calculator.getTransactionFeeRate(1000000), equals(0.03)); // 3%
      expect(calculator.getTransactionFeeRate(3000000), equals(0.025)); // 2.5%
    });
  });

  group('PricingCalculator - Formatting', () {
    final calculator = PricingCalculator.withDefaultConfig();

    test('should format fee rate as percentage', () {
      expect(calculator.formatFeeRate(500000), equals('5%'));
      expect(calculator.formatFeeRate(1000000), equals('4%'));
      expect(calculator.formatFeeRate(3000000), equals('3%'));
    });

    test('should format currency with peso sign and commas', () {
      expect(calculator.formatCurrency(1000), equals('₱1,000.00'));
      expect(calculator.formatCurrency(500000), equals('₱500,000.00'));
      expect(calculator.formatCurrency(1234567.89), equals('₱1,234,567.89'));
    });
  });

  group('PricingCalculator - Real-World Scenarios (Buyer\'s Premium)', () {
    final calculator = PricingCalculator.withDefaultConfig();

    test('Toyota Vios sale (₱450,000) - economy tier', () {
      final breakdown = calculator.calculateFeeBreakdown(salePrice: 450000);

      expect(breakdown.priceTier, equals(PriceTier.economy));
      expect(breakdown.transactionFee, equals(22500.0)); // 5% buyer's premium
      expect(breakdown.totalPlatformFees, equals(22900.0)); // 400 + 22500
      expect(breakdown.totalBuyerAmount, equals(472500.0)); // 450000 + 22500
      expect(breakdown.sellerReceives, equals(449600.0)); // 450000 - 400
    });

    test('Honda Civic sale (₱1,200,000) - mid-range tier', () {
      final breakdown = calculator.calculateFeeBreakdown(salePrice: 1200000);

      expect(breakdown.priceTier, equals(PriceTier.midRange));
      expect(breakdown.transactionFee, equals(48000.0)); // 4% buyer's premium
      expect(breakdown.totalPlatformFees, equals(48400.0)); // 400 + 48000
      expect(breakdown.totalBuyerAmount, equals(1248000.0)); // 1200000 + 48000
      expect(breakdown.sellerReceives, equals(1199600.0)); // 1200000 - 400
    });

    test('BMW 5 Series sale (₱2,500,000) - premium tier', () {
      final breakdown = calculator.calculateFeeBreakdown(salePrice: 2500000);

      expect(breakdown.priceTier, equals(PriceTier.premium));
      expect(breakdown.transactionFee, equals(75000.0)); // 3% buyer's premium
      expect(breakdown.totalPlatformFees, equals(75400.0)); // 400 + 75000
      expect(breakdown.totalBuyerAmount, equals(2575000.0)); // 2500000 + 75000
      expect(breakdown.sellerReceives, equals(2499600.0)); // 2500000 - 400
    });
  });
}
