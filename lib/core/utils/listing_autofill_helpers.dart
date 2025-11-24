/// Autofill Helper Functions for Car Listing Steps
///
/// This file contains reusable autofill functions for each step of the car listing process.
/// Import this file and use the appropriate helper function for each step.
///
/// **IMPORTANT**: These helpers only work when `kEnableDevAutofill = true` in dev_autofill.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/providers/listing_provider.dart';
import 'dev_autofill.dart';

/// Autofill helper for Step 1: Basic Information
class Step1AutofillHelper {
  static void autofill(
    BuildContext context,
    TextEditingController modelController,
    TextEditingController variantController,
  ) {
    if (!DevAutofill.isEnabled) return;

    final provider = context.read<ListingProvider>();

    provider.setBrand(CarListingAutofillData.brand);
    provider.setYear(CarListingAutofillData.year);

    modelController.text = CarListingAutofillData.model;
    variantController.text = CarListingAutofillData.variant;

    provider.setModel(CarListingAutofillData.model);
    provider.setVariant(CarListingAutofillData.variant);

    _showSuccessSnackbar(context);
  }
}

/// Autofill helper for Step 2: Mechanical Specifications
class Step2AutofillHelper {
  static void autofill(
    BuildContext context,
    TextEditingController engineSizeController,
    TextEditingController? chargingTimeController,
  ) {
    if (!DevAutofill.isEnabled) return;

    final provider = context.read<ListingProvider>();

    engineSizeController.text = CarListingAutofillData.engineSize;

    provider.setEngineSize(CarListingAutofillData.engineSize);
    provider.setEngineType(CarListingAutofillData.engineType);
    provider.setCylinders(CarListingAutofillData.cylinders);
    provider.setHorsepower(CarListingAutofillData.horsepower);
    provider.setTorque(CarListingAutofillData.torque);
    provider.setTransmission(CarListingAutofillData.transmission);
    provider.setTransmissionSpeeds(CarListingAutofillData.transmissionSpeeds);
    provider.setDriveType(CarListingAutofillData.driveType);
    provider.setFuelType(CarListingAutofillData.fuelType);
    provider.setFuelConsumption(CarListingAutofillData.fuelConsumption);

    _showSuccessSnackbar(context);
  }
}

/// Autofill helper for Step 3: Dimensions & Capacity
class Step3AutofillHelper {
  static void autofill(BuildContext context) {
    if (!DevAutofill.isEnabled) return;

    final provider = context.read<ListingProvider>();

    provider.setBodyType(CarListingAutofillData.bodyType);
    provider.setDoors(CarListingAutofillData.doors);
    provider.setSeats(CarListingAutofillData.seats);
    provider.setCurbWeight(CarListingAutofillData.curbWeight);
    provider.setGrossWeight(CarListingAutofillData.grossWeight);
    provider.setCargoCapacity(CarListingAutofillData.cargoCapacity);
    provider.setLength(CarListingAutofillData.length);
    provider.setWidth(CarListingAutofillData.width);
    provider.setHeight(CarListingAutofillData.height);
    provider.setWheelbase(CarListingAutofillData.wheelbase);

    _showSuccessSnackbar(context);
  }
}

/// Autofill helper for Step 4: Exterior Details
class Step4AutofillHelper {
  static void autofill(
    BuildContext context,
    TextEditingController colorController,
  ) {
    if (!DevAutofill.isEnabled) return;

    final provider = context.read<ListingProvider>();

    colorController.text = CarListingAutofillData.color;

    provider.setColor(CarListingAutofillData.color);
    provider.setPaintType(CarListingAutofillData.paintType);
    provider.setRimSize(CarListingAutofillData.rimSize);
    provider.setRimType(CarListingAutofillData.rimType);
    provider.setTireCondition(CarListingAutofillData.tireCondition);

    _showSuccessSnackbar(context);
  }
}

/// Autofill helper for Step 5: Condition & History
class Step5AutofillHelper {
  static void autofill(
    BuildContext context,
    TextEditingController mileageController,
  ) {
    if (!DevAutofill.isEnabled) return;

    final provider = context.read<ListingProvider>();

    mileageController.text = CarListingAutofillData.mileage.toString();

    provider.setCondition(CarListingAutofillData.condition);
    provider.setMileage(CarListingAutofillData.mileage);
    provider.setNumberOfOwners(CarListingAutofillData.numberOfOwners);
    provider.setServiceHistoryComplete(
        CarListingAutofillData.serviceHistoryComplete);
    provider.setHasAccidentHistory(CarListingAutofillData.hasAccidentHistory);
    provider.setFloodDamage(CarListingAutofillData.floodDamage);

    _showSuccessSnackbar(context);
  }
}

/// Autofill helper for Step 6: Documentation & Location
class Step6AutofillHelper {
  static void autofill(
    BuildContext context,
    TextEditingController plateController,
    TextEditingController orcrController,
  ) {
    if (!DevAutofill.isEnabled) return;

    final provider = context.read<ListingProvider>();

    plateController.text = CarListingAutofillData.plateNumber;
    orcrController.text = CarListingAutofillData.orcrNumber;

    provider.setPlateNumber(CarListingAutofillData.plateNumber);
    provider.setOrcrNumber(CarListingAutofillData.orcrNumber);
    provider.setRegistrationStatus(CarListingAutofillData.registrationStatus);
    provider.setEmissionTestValid(CarListingAutofillData.emissionTestValid);
    provider.setComprehensiveInsurance(
        CarListingAutofillData.comprehensiveInsurance);
    provider.setProvince(CarListingAutofillData.province);
    provider.setCity(CarListingAutofillData.city);
    provider.setAvailableForTestDrive(
        CarListingAutofillData.availableForTestDrive);
    provider.setDeliveryAvailable(CarListingAutofillData.deliveryAvailable);
    provider.setAcceptsTrade(CarListingAutofillData.acceptsTrade);
    provider.setFinancingAvailable(CarListingAutofillData.financingAvailable);
    provider.setPriceNegotiable(CarListingAutofillData.priceNegotiable);

    _showSuccessSnackbar(context);
  }
}

/// Autofill helper for Step 7: Categorized Photos
class Step7AutofillHelper {
  static void autofill(BuildContext context) {
    if (!DevAutofill.isEnabled) return;

    final provider = context.read<ListingProvider>();

    // Simulate adding mock images for all categories
    final mockImages = {
      'exterior': List.generate(15, (i) => 'mock://exterior_$i'),
      'interior': List.generate(12, (i) => 'mock://interior_$i'),
      'engine': List.generate(6, (i) => 'mock://engine_$i'),
      'details': List.generate(13, (i) => 'mock://details_$i'),
    };

    provider.setCategorizedImages(mockImages);

    _showSuccessSnackbar(context, message: '✓ All 46 photos autofilled (Dev Mode)');
  }
}

/// Autofill helper for Step 8: Description & Review
class Step8AutofillHelper {
  static void autofill(
    BuildContext context,
    TextEditingController descriptionController,
    TextEditingController issuesController,
  ) {
    if (!DevAutofill.isEnabled) return;

    final provider = context.read<ListingProvider>();

    descriptionController.text = CarListingAutofillData.description;
    issuesController.text = CarListingAutofillData.issues ?? '';

    provider.setDescription(CarListingAutofillData.description);
    provider.setIssues(CarListingAutofillData.issues);

    // Add features
    for (final feature in CarListingAutofillData.features) {
      if (!provider.features.contains(feature)) {
        provider.toggleFeature(feature);
      }
    }

    _showSuccessSnackbar(context);
  }
}

/// Show success snackbar
void _showSuccessSnackbar(BuildContext context, {String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message ?? '✓ Form autofilled (Dev Mode)'),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.deepPurple,
    ),
  );
}

/// Generic autofill widget wrapper
class AutofillWrapper extends StatelessWidget {
  final Widget child;
  final VoidCallback onAutofill;
  final bool showInAppBar;

  const AutofillWrapper({
    super.key,
    required this.child,
    required this.onAutofill,
    this.showInAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!DevAutofill.isEnabled) return child;

    if (showInAppBar) {
      return child;
    }

    return Stack(
      children: [
        child,
        Positioned(
          right: 16,
          bottom: 80,
          child: DevAutofill.showAutofillButton(
            context: context,
            onAutofill: onAutofill,
          )!,
        ),
      ],
    );
  }
}
