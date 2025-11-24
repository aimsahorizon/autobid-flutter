import 'dart:math';
import '../../models/car_model.dart';

/// Mock AI Pricing Prediction Service
///
/// Simulates AI-powered price predictions based on car characteristics.
/// In production, this would connect to a real ML model API.
///
/// BACKEND INTEGRATION NOTES:
/// - Replace with actual ML model API (TensorFlow, PyTorch, etc.)
/// - Train model on historical auction data
/// - Consider factors: brand, model, year, condition, mileage, location
/// - Update predictions periodically as market changes
class MockAIPricingService {
  /// Predict optimal auction prices for a car
  ///
  /// Returns a map containing:
  /// - openingPrice: Recommended starting bid
  /// - reservePrice: Minimum acceptable price
  /// - estimatedValue: Estimated market value
  /// - bidIncrement: Recommended bid increment
  /// - confidence: Prediction confidence (0-100%)
  Future<Map<String, dynamic>> predictPricing(CarModel car) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Base price calculation using simple heuristics
    // In production, this would be a trained ML model
    final baseValue = _calculateBaseValue(car);

    // Calculate depreciation
    final currentYear = DateTime.now().year;
    final yearsOld = currentYear - car.year;
    final depreciation = _calculateDepreciation(yearsOld, car.condition);

    // Calculate mileage factor
    final mileageFactor = _calculateMileageFactor(car.mileage.toDouble());

    // Final estimated value
    final estimatedValue = baseValue * depreciation * mileageFactor;

    // Opening price (80-85% of estimated value)
    final openingPrice = estimatedValue * (0.80 + Random().nextDouble() * 0.05);

    // Reserve price (85-90% of estimated value)
    final reservePrice = estimatedValue * (0.85 + Random().nextDouble() * 0.05);

    // Bid increment (1-2% of opening price, rounded to nearest 100 or 500)
    final rawIncrement = openingPrice * (0.01 + Random().nextDouble() * 0.01);
    final bidIncrement = _roundToNice(rawIncrement);

    // Confidence based on car data completeness
    final confidence = _calculateConfidence(car);

    return {
      'openingPrice': openingPrice.roundToDouble(),
      'reservePrice': reservePrice.roundToDouble(),
      'estimatedValue': estimatedValue.roundToDouble(),
      'bidIncrement': bidIncrement.roundToDouble(),
      'confidence': confidence,
      'marketTrend': _getMarketTrend(car.brand),
      'demandLevel': _getDemandLevel(car.bodyType),
      'insights': _generateInsights(car, estimatedValue),
    };
  }

  /// Calculate base value from brand, model, and vehicle type
  double _calculateBaseValue(CarModel car) {
    // Base prices for different brands (in PHP)
    final brandMultipliers = {
      'Toyota': 1.0,
      'Honda': 0.95,
      'Nissan': 0.85,
      'Mitsubishi': 0.80,
      'Ford': 0.90,
      'Mazda': 0.92,
      'Hyundai': 0.75,
      'Kia': 0.72,
      'Suzuki': 0.70,
      'Isuzu': 0.85,
      'Subaru': 1.05,
      'BMW': 1.80,
      'Mercedes-Benz': 2.00,
      'Audi': 1.75,
      'Lexus': 1.70,
    };

    // Body type base prices
    final bodyTypeBase = {
      BodyType.sedan: 600000.0,
      BodyType.suv: 900000.0,
      BodyType.hatchback: 550000.0,
      BodyType.pickup: 850000.0,
      BodyType.van: 700000.0,
      BodyType.wagon: 650000.0,
      BodyType.coupe: 750000.0,
      BodyType.convertible: 950000.0,
      BodyType.mpv: 800000.0,
    };

    final brandMultiplier = brandMultipliers[car.brand] ?? 0.80;
    final basePrice = bodyTypeBase[car.bodyType] ?? 600000.0;

    return basePrice * brandMultiplier;
  }

  /// Calculate depreciation based on age and condition
  double _calculateDepreciation(int yearsOld, CarCondition condition) {
    // Base depreciation curve
    double depreciationRate;
    if (yearsOld == 0) {
      depreciationRate = 1.0; // Brand new
    } else if (yearsOld <= 3) {
      depreciationRate = 1.0 - (yearsOld * 0.10); // 10% per year
    } else if (yearsOld <= 7) {
      depreciationRate = 0.70 - ((yearsOld - 3) * 0.06); // 6% per year
    } else {
      depreciationRate = 0.46 - ((yearsOld - 7) * 0.03); // 3% per year
    }

    // Adjust based on condition
    final conditionMultipliers = {
      CarCondition.brandNew: 1.0,
      CarCondition.almostNew: 0.95,
      CarCondition.certified: 0.90,
      CarCondition.used: 0.75,
      CarCondition.forParts: 0.40,
    };

    return (depreciationRate * (conditionMultipliers[condition] ?? 0.70))
        .clamp(0.20, 1.0);
  }

  /// Calculate mileage impact factor
  double _calculateMileageFactor(double mileage) {
    // Average annual mileage: 15,000 km
    // High mileage: > 20,000 km/year
    // Low mileage: < 10,000 km/year

    if (mileage < 30000) {
      return 1.00; // Low mileage, premium
    } else if (mileage < 60000) {
      return 0.98;
    } else if (mileage < 100000) {
      return 0.95;
    } else if (mileage < 150000) {
      return 0.90;
    } else if (mileage < 200000) {
      return 0.85;
    } else {
      return 0.75; // High mileage
    }
  }

  /// Round to "nice" number (100s or 500s)
  double _roundToNice(double value) {
    if (value < 500) {
      return (value / 100).round() * 100.0;
    } else if (value < 2000) {
      return (value / 500).round() * 500.0;
    } else {
      return (value / 1000).round() * 1000.0;
    }
  }

  /// Calculate confidence score based on data completeness
  int _calculateConfidence(CarModel car) {
    int score = 60; // Base confidence

    // More complete data = higher confidence
    if (car.images.length >= 8) score += 10;
    if (car.serviceHistoryComplete) score += 5;
    if (!car.hasAccidentHistory) score += 5;
    if (car.emissionTestValid) score += 3;
    if (car.comprehensiveInsurance) score += 2;
    if (car.mileage < 100000) score += 5;
    if (car.numberOfOwners == 1) score += 5;
    if (car.condition == CarCondition.brandNew ||
        car.condition == CarCondition.almostNew) score += 5;

    return score.clamp(60, 95);
  }

  /// Get market trend for brand
  String _getMarketTrend(String brand) {
    final popularBrands = ['Toyota', 'Honda', 'Mitsubishi', 'Nissan', 'Ford'];
    final luxuryBrands = ['BMW', 'Mercedes-Benz', 'Audi', 'Lexus'];

    if (popularBrands.contains(brand)) {
      return 'High Demand';
    } else if (luxuryBrands.contains(brand)) {
      return 'Stable Premium';
    } else {
      return 'Moderate';
    }
  }

  /// Get demand level for body type
  String _getDemandLevel(BodyType bodyType) {
    switch (bodyType) {
      case BodyType.suv:
      case BodyType.pickup:
        return 'Very High';
      case BodyType.sedan:
      case BodyType.mpv:
        return 'High';
      case BodyType.hatchback:
      case BodyType.van:
        return 'Moderate';
      default:
        return 'Niche';
    }
  }

  /// Generate AI insights
  List<String> _generateInsights(CarModel car, double estimatedValue) {
    final insights = <String>[];

    // Age insight
    final yearsOld = DateTime.now().year - car.year;
    if (yearsOld <= 2) {
      insights.add('Recent model year helps maintain value');
    } else if (yearsOld >= 10) {
      insights.add('Older model may attract budget-conscious buyers');
    }

    // Condition insight
    if (car.condition == CarCondition.brandNew ||
        car.condition == CarCondition.almostNew) {
      insights.add('Excellent condition commands premium pricing');
    }

    // Mileage insight
    if (car.mileage < 30000) {
      insights.add('Low mileage is a strong selling point');
    } else if (car.mileage > 150000) {
      insights.add('High mileage may require competitive pricing');
    }

    // Service history insight
    if (car.serviceHistoryComplete) {
      insights.add('Complete service history builds buyer confidence');
    }

    // Owners insight
    if (car.numberOfOwners == 1) {
      insights.add('Single owner history adds value');
    }

    // Brand insight
    if (['Toyota', 'Honda'].contains(car.brand)) {
      insights.add('Strong brand reputation in Philippine market');
    }

    // Market timing
    insights.add('Current market conditions favor ${_getMarketTrend(car.brand).toLowerCase()} demand');

    return insights.take(4).toList(); // Return top 4 insights
  }
}
