import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/car_features.dart';
import '../../../../core/utils/enum_extensions.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/save_draft_button.dart';

class CreateListingStep9Summary extends StatefulWidget {
  const CreateListingStep9Summary({super.key});

  @override
  State<CreateListingStep9Summary> createState() =>
      _CreateListingStep9SummaryState();
}

class _CreateListingStep9SummaryState extends State<CreateListingStep9Summary> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    provider.setCurrentStep(9);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing Summary'),
        actions: [
          SaveDraftButton(
            stepNumber: 9,
            validateForm: () => true,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          LinearProgressIndicator(
            value: 9 / 9,
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(height: 24),

          Text(
            'Step 9 of 9',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),

          Text(
            'Review Your Listing',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),

          Text(
            'Please review all information before submitting',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 24),

          // STEP 1: BASIC INFO
          _buildSummarySection(
            context,
            'Step 1: Basic Information',
            Icons.directions_car,
            [
              _buildInfoRow('Brand', provider.brand ?? 'N/A'),
              _buildInfoRow('Model', provider.model ?? 'N/A'),
              _buildInfoRow('Variant', provider.variant ?? 'N/A'),
              _buildInfoRow('Year', provider.year?.toString() ?? 'N/A'),
            ],
            onEdit: () => context.go('/listing/create/step1'),
          ),
          const SizedBox(height: 12),

          // STEP 2: MECHANICAL SPECIFICATIONS
          _buildSummarySection(
            context,
            'Step 2: Mechanical Specifications',
            Icons.build,
            [
              _buildSubsectionTitle('Engine'),
              _buildInfoRow('Engine Size', provider.engineSize ?? 'N/A'),
              _buildInfoRow('Engine Type', provider.engineType.displayName),
              _buildInfoRow('Cylinders', provider.cylinders.toString()),
              _buildInfoRow('Horsepower', '${provider.horsepower} HP'),
              _buildInfoRow('Torque', '${provider.torque} Nm'),
              const SizedBox(height: 8),
              _buildSubsectionTitle('Transmission & Drive'),
              _buildInfoRow('Transmission', provider.transmission?.displayName ?? 'N/A'),
              _buildInfoRow('Transmission Speeds', '${provider.transmissionSpeeds}-speed'),
              _buildInfoRow('Drive Type', provider.driveType.displayName),
              const SizedBox(height: 8),
              _buildSubsectionTitle('Fuel & Efficiency'),
              _buildInfoRow('Fuel Type', provider.fuelType?.displayName ?? 'N/A'),
              _buildInfoRow('Fuel Consumption', '${provider.fuelConsumption} L/100km'),
              if (provider.electricRange != null) ...[
                _buildInfoRow('Electric Range', '${provider.electricRange} km'),
              ],
              if (provider.batteryCapacity != null) ...[
                _buildInfoRow('Battery Capacity', '${provider.batteryCapacity} kWh'),
              ],
              if (provider.chargingTime != null && provider.chargingTime!.isNotEmpty) ...[
                _buildInfoRow('Charging Time', provider.chargingTime!),
              ],
            ],
            onEdit: () => context.go('/listing/create/step2'),
          ),
          const SizedBox(height: 12),

          // STEP 3: DIMENSIONS & CAPACITY
          _buildSummarySection(
            context,
            'Step 3: Dimensions & Capacity',
            Icons.straighten,
            [
              _buildInfoRow('Body Type', provider.bodyType?.displayName ?? 'N/A'),
              _buildInfoRow('Doors', '${provider.doors} doors'),
              _buildInfoRow('Seats', '${provider.seats} seats'),
              const SizedBox(height: 8),
              _buildSubsectionTitle('Weight & Capacity'),
              _buildInfoRow('Curb Weight', '${provider.curbWeight} kg'),
              _buildInfoRow('Gross Weight', '${provider.grossWeight} kg'),
              _buildInfoRow('Cargo Capacity', '${provider.cargoCapacity} L'),
              if (provider.towingCapacity != null) ...[
                _buildInfoRow('Towing Capacity', '${provider.towingCapacity} kg'),
              ],
              if (provider.groundClearance != null) ...[
                _buildInfoRow('Ground Clearance', '${provider.groundClearance} mm'),
              ],
              const SizedBox(height: 8),
              _buildSubsectionTitle('Dimensions'),
              _buildInfoRow('Length', '${provider.length} mm'),
              _buildInfoRow('Width', '${provider.width} mm'),
              _buildInfoRow('Height', '${provider.height} mm'),
              _buildInfoRow('Wheelbase', '${provider.wheelbase} mm'),
            ],
            onEdit: () => context.go('/listing/create/step3'),
          ),
          const SizedBox(height: 12),

          // STEP 4: EXTERIOR
          _buildSummarySection(
            context,
            'Step 4: Exterior',
            Icons.palette,
            [
              _buildInfoRow('Color', provider.color ?? 'N/A'),
              _buildInfoRow('Paint Type', provider.paintType.displayName),
              _buildInfoRow('Rim Size', '${provider.rimSize}"'),
              _buildInfoRow('Rim Type', provider.rimType.displayName),
              _buildInfoRow('Tire Condition', provider.tireCondition.displayName),
            ],
            onEdit: () => context.go('/listing/create/step4'),
          ),
          const SizedBox(height: 12),

          // STEP 5: CONDITION & HISTORY
          _buildSummarySection(
            context,
            'Step 5: Condition & History',
            Icons.history,
            [
              _buildInfoRow('Condition', provider.condition?.displayName ?? 'N/A'),
              _buildInfoRow('Mileage', provider.mileage != null ? '${NumberFormat('#,###').format(provider.mileage)} km' : 'N/A'),
              _buildInfoRow('Number of Owners', provider.numberOfOwners.toString()),
              const SizedBox(height: 8),
              _buildSubsectionTitle('Vehicle History'),
              _buildInfoRow('Accident History', provider.hasAccidentHistory ? 'Yes' : 'No'),
              _buildInfoRow('Flood Damage', provider.floodDamage ? 'Yes' : 'No'),
              _buildInfoRow('Fire Damage', provider.fireDamage ? 'Yes' : 'No'),
              _buildInfoRow('Structural/Frame Damage', provider.frameDamage ? 'Yes' : 'No'),
              _buildInfoRow('Repainted', provider.isRepainted ? 'Yes' : 'No'),
              _buildInfoRow('Modified/Aftermarket Parts', provider.hasModifications ? 'Yes' : 'No'),
              _buildInfoRow('Original Parts', provider.originalParts ? 'Yes' : 'No'),
              _buildInfoRow('Taxi/Rental/Fleet Use', provider.commercialUse ? 'Yes' : 'No'),
              _buildInfoRow('Smoker Vehicle', provider.smokerVehicle ? 'Yes' : 'No'),
              _buildInfoRow('Complete Service History', provider.serviceHistoryComplete ? 'Yes' : 'No'),
              _buildInfoRow('Warranty Remaining', provider.warrantyRemaining ? 'Yes' : 'No'),
              if (provider.registrationExpiry != null) ...[
                _buildInfoRow('Registration Expiry', dateFormat.format(provider.registrationExpiry!)),
              ],
            ],
            onEdit: () => context.go('/listing/create/step5'),
          ),
          const SizedBox(height: 12),

          // STEP 6: DOCUMENTATION & LOCATION
          _buildSummarySection(
            context,
            'Step 6: Documentation & Location',
            Icons.article,
            [
              _buildSubsectionTitle('Location'),
              _buildInfoRow('City', provider.city ?? 'N/A'),
              _buildInfoRow('Province', provider.province ?? 'N/A'),
              const SizedBox(height: 8),
              _buildSubsectionTitle('Documentation'),
              _buildInfoRow('Plate Number', provider.plateNumber ?? 'N/A'),
              _buildInfoRow('OR/CR Number', provider.orcrNumber ?? 'N/A'),
              _buildInfoRow('Registration Status', provider.registrationStatus.displayName),
              _buildInfoRow('Emission Test Valid', provider.emissionTestValid ? 'Yes' : 'No'),
              _buildInfoRow('Comprehensive Insurance', provider.comprehensiveInsurance ? 'Yes' : 'No'),
            ],
            onEdit: () => context.go('/listing/create/step6'),
          ),
          const SizedBox(height: 12),

          // STEP 7: PHOTOS
          _buildSummarySection(
            context,
            'Step 7: Photos',
            Icons.photo_library,
            [
              _buildInfoRow('Total Images', '${provider.categorizedImages.values.fold<int>(0, (sum, list) => sum + list.length)}/46'),
              _buildInfoRow('Exterior Photos', '${provider.categorizedImages['exterior']?.length ?? 0}/15'),
              _buildInfoRow('Interior Photos', '${provider.categorizedImages['interior']?.length ?? 0}/12'),
              _buildInfoRow('Engine Photos', '${provider.categorizedImages['engine']?.length ?? 0}/6'),
              _buildInfoRow('Details Photos', '${provider.categorizedImages['details']?.length ?? 0}/13'),
            ],
            onEdit: () => context.go('/listing/create/step7'),
          ),
          const SizedBox(height: 12),

          // STEP 8: DESCRIPTION & FEATURES
          _buildSummarySection(
            context,
            'Step 8: Description & Features',
            Icons.description,
            [
              _buildSubsectionTitle('Description'),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 4, bottom: 8),
                child: Text(
                  provider.description.isEmpty ? 'No description provided' : provider.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: provider.description.isEmpty ? Colors.grey : Colors.black87,
                        fontStyle: provider.description.isEmpty ? FontStyle.italic : FontStyle.normal,
                      ),
                ),
              ),
              if (provider.issues != null && provider.issues!.isNotEmpty) ...[
                _buildSubsectionTitle('Known Issues'),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4, bottom: 8),
                  child: Text(
                    provider.issues!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black87,
                        ),
                  ),
                ),
              ],
              _buildSubsectionTitle('Features (${provider.features.length} total)'),
              if (provider.features.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    'No features selected',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                )
              else
                ...CarFeatures.categories.map((category) {
                  final categoryFeatures = CarFeatures.getFeaturesForCategory(category)
                      .where((f) => provider.features.contains(f))
                      .toList();

                  if (categoryFeatures.isEmpty) return const SizedBox.shrink();

                  return Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$category (${categoryFeatures.length})',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: categoryFeatures.map((feature) {
                            return Chip(
                              label: Text(
                                feature,
                                style: const TextStyle(fontSize: 11),
                              ),
                              backgroundColor: Colors.green.shade50,
                              side: BorderSide(color: Colors.green.shade200),
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
            ],
            onEdit: () => context.go('/listing/create/step8'),
          ),
          const SizedBox(height: 24),

          // Warning/Info box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_outline,
                    color: Colors.green.shade700, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Review all information carefully. Once submitted, your listing will be reviewed by our team before going live. You can edit the listing by tapping on each section above.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomButton(
            text: 'Submit Listing',
            onPressed: () async {
              await _submitListing(context, provider);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _submitListing(BuildContext context, ListingProvider provider) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Submitting your listing...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      // Create the listing with pendingReview status
      final listing = await provider.createListing(
        'mock-user-id', // TODO: Get from auth
        'Mock User', // TODO: Get from auth
        isDraft: false,
      );

      if (!context.mounted) return;

      // Close loading dialog
      Navigator.pop(context);

      // Show success dialog
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          icon: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.pending_actions,
              size: 48,
              color: Colors.orange.shade700,
            ),
          ),
          title: const Text('Listing Submitted!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your ${listing.brand} ${listing.model} has been submitted for review.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 16, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'What\'s Next?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Admin review: 24-48 hours\n'
                      '• You\'ll be notified when approved\n'
                      '• View status in "Pending" tab',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to home and show pending tab
                context.go('/');
              },
              child: const Text('View My Listings'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                // Reset provider and navigate to create new listing
                provider.reset();
                context.go('/listing/create/step1');
              },
              child: const Text('Create Another'),
            ),
          ],
        ),
      );

      if (!context.mounted) return;

      // Navigate to home (My Listings tab)
      context.go('/');
    } catch (e) {
      if (!context.mounted) return;

      // Close loading dialog
      Navigator.pop(context);

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.error_outline, size: 48, color: Colors.red),
          title: const Text('Submission Failed'),
          content: Text('An error occurred: $e'),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildSummarySection(
    BuildContext context,
    String title,
    IconData icon,
    List<Widget> children, {
    VoidCallback? onEdit,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: Colors.green.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                if (onEdit != null)
                  TextButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit'),
                  ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSubsectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
