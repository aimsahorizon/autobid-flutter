/// Development Autofill Utility
///
/// This file provides autofill functionality for development and testing purposes.
///
/// **IMPORTANT**: Set `kEnableDevAutofill` to `false` before production build.
/// This ensures all autofill features are completely removed from production code.
///
/// Usage:
/// ```dart
/// if (DevAutofill.isEnabled) {
///   DevAutofill.showAutofillButton(
///     context: context,
///     onAutofill: () => _autofillForm(),
///   );
/// }
/// ```

import 'package:flutter/material.dart';
import '../../data/models/car_model.dart';

/// Set to false to disable all autofill features in production
const bool kEnableDevAutofill = true;

class DevAutofill {
  /// Check if autofill is enabled
  static bool get isEnabled => kEnableDevAutofill;

  /// Show autofill floating action button
  static Widget? showAutofillButton({
    required BuildContext context,
    required VoidCallback onAutofill,
    String tooltip = 'Autofill (Dev Only)',
  }) {
    if (!isEnabled) return null;

    return FloatingActionButton.extended(
      onPressed: onAutofill,
      icon: const Icon(Icons.auto_fix_high),
      label: const Text('Autofill'),
      tooltip: tooltip,
      backgroundColor: Colors.deepPurple,
    );
  }

  /// Show autofill button in AppBar
  static Widget? showAutofillIconButton({
    required BuildContext context,
    required VoidCallback onAutofill,
    String tooltip = 'Autofill (Dev)',
  }) {
    if (!isEnabled) return null;

    return IconButton(
      icon: const Icon(Icons.auto_fix_high),
      tooltip: tooltip,
      onPressed: onAutofill,
      color: Colors.deepPurple,
    );
  }

  /// Show autofill banner
  static Widget? showAutofillBanner({
    required BuildContext context,
    required VoidCallback onAutofill,
  }) {
    if (!isEnabled) return null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.deepPurple.shade50,
      child: Row(
        children: [
          Icon(Icons.developer_mode, color: Colors.deepPurple.shade700, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Development Mode',
              style: TextStyle(
                fontSize: 12,
                color: Colors.deepPurple.shade900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: onAutofill,
            icon: const Icon(Icons.auto_fix_high, size: 16),
            label: const Text('Autofill'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.deepPurple.shade700,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }
}

/// Autofill data provider for car listing forms
class CarListingAutofillData {
  // Step 1: Basic Information
  static const String brand = 'Toyota';
  static const String model = 'Vios';
  static const String variant = '1.3 E MT';
  static const int year = 2020;

  // Step 2: Mechanical Specifications
  static const String engineSize = '1.3L';
  static const EngineType engineType = EngineType.inline;
  static const int cylinders = 4;
  static const int horsepower = 98;
  static const int torque = 123;
  static const TransmissionType transmission = TransmissionType.manual;
  static const int transmissionSpeeds = 5;
  static const DriveType driveType = DriveType.fwd;
  static const FuelType fuelType = FuelType.gasoline;
  static const double fuelConsumption = 5.7;

  // Step 3: Dimensions & Capacity
  static const BodyType bodyType = BodyType.sedan;
  static const int doors = 4;
  static const int seats = 5;
  static const int curbWeight = 1025;
  static const int grossWeight = 1500;
  static const int cargoCapacity = 506;
  static const int length = 4425;
  static const int width = 1730;
  static const int height = 1475;
  static const int wheelbase = 2550;

  // Step 4: Exterior Details
  static const String color = 'Silver Metallic';
  static const PaintType paintType = PaintType.metallic;
  static const int rimSize = 15;
  static const RimType rimType = RimType.alloy;
  static const TireCondition tireCondition = TireCondition.good;

  // Step 5: Condition & History
  static const CarCondition condition = CarCondition.used;
  static const int mileage = 45000;
  static const int numberOfOwners = 1;
  static const bool hasAccidentHistory = false;
  static const bool floodDamage = false;
  static const bool serviceHistoryComplete = true;
  static const bool warrantyRemaining = false;

  // Step 6: Documentation & Location
  static const String plateNumber = 'ABC-1234';
  static const String orcrNumber = 'OR123456789CR';
  static const RegistrationStatus registrationStatus = RegistrationStatus.current;
  static const bool emissionTestValid = true;
  static const bool comprehensiveInsurance = true;
  static const String province = 'Metro Manila';
  static const String city = 'Quezon City';
  static const bool availableForTestDrive = true;
  static const bool deliveryAvailable = false;
  static const bool acceptsTrade = true;
  static const bool financingAvailable = false;
  static const bool priceNegotiable = true;

  // Step 8: Description & Features
  static const String description =
      'Well-maintained Toyota Vios 1.3 E MT in excellent condition. '
      'Single owner, complete service records from Casa. '
      'All original parts, no accident history. '
      'Fresh from comprehensive maintenance. '
      'Perfect for daily commute or family use.';

  static const String? issues = 'Minor scratches on rear bumper (cosmetic only)';

  static const List<String> features = [
    'Air Conditioning',
    'Power Windows',
    'Power Steering',
    'Central Locking',
    'ABS',
    'Airbags',
  ];

  /// Get all autofill data as a map
  static Map<String, dynamic> getAllData() {
    return {
      // Step 1
      'brand': brand,
      'model': model,
      'variant': variant,
      'year': year,

      // Step 2
      'engineSize': engineSize,
      'engineType': engineType,
      'cylinders': cylinders,
      'horsepower': horsepower,
      'torque': torque,
      'transmission': transmission,
      'transmissionSpeeds': transmissionSpeeds,
      'driveType': driveType,
      'fuelType': fuelType,
      'fuelConsumption': fuelConsumption,

      // Step 3
      'bodyType': bodyType,
      'doors': doors,
      'seats': seats,
      'curbWeight': curbWeight,
      'grossWeight': grossWeight,
      'cargoCapacity': cargoCapacity,
      'length': length,
      'width': width,
      'height': height,
      'wheelbase': wheelbase,

      // Step 4
      'color': color,
      'paintType': paintType,
      'rimSize': rimSize,
      'rimType': rimType,
      'tireCondition': tireCondition,

      // Step 5
      'condition': condition,
      'mileage': mileage,
      'numberOfOwners': numberOfOwners,
      'hasAccidentHistory': hasAccidentHistory,
      'floodDamage': floodDamage,
      'serviceHistoryComplete': serviceHistoryComplete,
      'warrantyRemaining': warrantyRemaining,

      // Step 6
      'plateNumber': plateNumber,
      'orcrNumber': orcrNumber,
      'registrationStatus': registrationStatus,
      'emissionTestValid': emissionTestValid,
      'comprehensiveInsurance': comprehensiveInsurance,
      'province': province,
      'city': city,
      'availableForTestDrive': availableForTestDrive,
      'deliveryAvailable': deliveryAvailable,
      'acceptsTrade': acceptsTrade,
      'financingAvailable': financingAvailable,
      'priceNegotiable': priceNegotiable,

      // Step 8
      'description': description,
      'issues': issues,
      'features': features,
    };
  }
}

/// Alternative autofill data sets for variety in testing
class CarListingAutofillVariants {
  /// SUV variant
  static Map<String, dynamic> getSUVData() {
    return {
      'brand': 'Honda',
      'model': 'CR-V',
      'variant': '2.0 S CVT',
      'year': 2019,
      'engineSize': '2.0L',
      'bodyType': BodyType.suv,
      'seats': 7,
      'color': 'White Pearl',
      'mileage': 38000,
      'description': 'Family-friendly Honda CR-V in pristine condition. '
          '7-seater configuration, perfect for road trips. '
          'Full service history, well-maintained by authorized dealer.',
    };
  }

  /// Electric vehicle variant
  static Map<String, dynamic> getElectricData() {
    return {
      'brand': 'Tesla',
      'model': 'Model 3',
      'variant': 'Standard Range Plus',
      'year': 2021,
      'engineSize': 'Electric',
      'fuelType': FuelType.electric,
      'electricRange': 423,
      'batteryCapacity': 60.0,
      'chargingTime': '8 hours (AC), 30 min to 80% (DC)',
      'bodyType': BodyType.sedan,
      'color': 'Midnight Silver',
      'mileage': 15000,
      'description': 'Excellent condition Tesla Model 3. '
          'Low mileage, autopilot enabled. '
          'Home charging station included.',
    };
  }

  /// Pickup truck variant
  static Map<String, dynamic> getPickupData() {
    return {
      'brand': 'Ford',
      'model': 'Ranger',
      'variant': 'Wildtrak 2.0 BiTurbo 4x4 AT',
      'year': 2022,
      'engineSize': '2.0L',
      'bodyType': BodyType.pickup,
      'driveType': DriveType.fourWd,
      'color': 'Arctic White',
      'mileage': 25000,
      'description': 'Powerful and capable Ford Ranger Wildtrak. '
          'Perfect for both work and adventure. '
          'Excellent off-road performance.',
    };
  }
}
