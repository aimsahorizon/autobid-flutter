import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' as provider_pkg;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/car_features.dart';
import '../../../../core/utils/enum_extensions.dart';
import '../../../../data/models/subscription_tier.dart';
import '../../../providers/listing_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/subscription_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/save_draft_button.dart';
import '../../../widgets/token_top_up_sheet.dart';
import 'create_listing_step_mixin.dart';

class CreateListingStep9Summary extends ConsumerStatefulWidget {
  const CreateListingStep9Summary({super.key});

  @override
  ConsumerState<CreateListingStep9Summary> createState() =>
      _CreateListingStep9SummaryState();
}

class _CreateListingStep9SummaryState extends ConsumerState<CreateListingStep9Summary> with CreateListingMixin {
  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    provider.setCurrentStep(9);
  }

  @override
  Widget build(BuildContext context) {
    final provider = provider_pkg.Provider.of<ListingProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => handleBackWithWarning(),
        ),
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
            backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[200],
          ),
          const SizedBox(height: 24),

          Text(
            'Step 9 of 9',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
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
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
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
              _buildInfoRow('Engine Type', provider.engineType!.displayName),
              _buildInfoRow('Cylinders', provider.cylinders.toString()),
              _buildInfoRow('Horsepower', '${provider.horsepower} HP'),
              _buildInfoRow('Torque', '${provider.torque} Nm'),
              const SizedBox(height: 8),
              _buildSubsectionTitle('Transmission & Drive'),
              _buildInfoRow('Transmission', provider.transmission?.displayName ?? 'N/A'),
              _buildInfoRow('Transmission Speeds', '${provider.transmissionSpeeds}-speed'),
              _buildInfoRow('Drive Type', provider.driveType!.displayName),
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
              _buildInfoRow('Paint Type', provider.paintType!.displayName),
              _buildInfoRow('Rim Size', '${provider.rimSize}"'),
              _buildInfoRow('Rim Type', provider.rimType!.displayName),
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
                        color: provider.description.isEmpty
                            ? (isDarkMode ? Colors.grey[500] : Colors.grey)
                            : (isDarkMode ? Colors.grey[300] : Colors.black87),
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
                          color: isDarkMode ? Colors.grey[300] : Colors.black87,
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
                          color: isDarkMode ? Colors.grey[500] : Colors.grey,
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
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
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
                              backgroundColor: isDarkMode
                                  ? Colors.green.shade900.withOpacity(0.3)
                                  : Colors.green.shade50,
                              side: BorderSide(
                                color: isDarkMode ? Colors.green.shade700 : Colors.green.shade200,
                              ),
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
              color: isDarkMode
                  ? Colors.green.shade900.withOpacity(0.3)
                  : Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDarkMode ? Colors.green.shade700 : Colors.green.shade200,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: isDarkMode ? Colors.green.shade300 : Colors.green.shade700,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Review all information carefully. Once submitted, your listing will be reviewed by our team before going live. You can edit the listing by tapping on each section above.',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDarkMode ? Colors.green.shade100 : Colors.green.shade900,
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
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push('/listing/create/step8'),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: CustomButton(
                  text: 'Submit Listing',
                  onPressed: () async {
                    await _submitListing(context, provider);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitListing(BuildContext context, ListingProvider provider) async {
    // REVISED Revenue Model: Check listing quota
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      _showErrorDialog('Please log in to create a listing');
      return;
    }

    // Check if quota needs reset (rolling 30-day)
    final subscriptionActions = ref.read(subscriptionActionsProvider.notifier);
    if (ref.read(needsQuotaResetProvider(currentUser))) {
      await subscriptionActions.resetListingQuota(userId: currentUser.id);
    }

    // Get remaining quota after potential reset
    final remainingQuota = ref.read(remainingListingQuotaProvider(currentUser));
    final tier = currentUser.subscriptionTier.config;

    if (remainingQuota <= 0) {
      // Quota exceeded
      if (currentUser.subscriptionTier == SubscriptionTierType.free) {
        // Free tier - show payment dialog for ₱199 extra listing
        final shouldProceed = await _showExtraListingPaymentDialog();
        if (!shouldProceed) return;

        // Process payment (mock)
        await _processExtraListingPayment(currentUser.id);
      } else {
        // Pro tiers should not run out of quota
        _showErrorDialog(
          'You have reached your monthly listing limit (${tier.maxListingsPerMonth} listings). '
          'Your quota will reset on ${_getQuotaResetDate(currentUser)}.'
        );
        return;
      }
    }

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
        currentUser.id,
        currentUser.fullName,
        isDraft: false,
      );

      // Increment listingsUsedThisMonth
      await subscriptionActions.incrementListingUsage(userId: currentUser.id);

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
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

  // REVISED Revenue Model: Extra listing payment dialog
  Future<bool> _showExtraListingPaymentDialog() async {
    final result = await showDialog<bool>(
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
            Icons.post_add,
            size: 48,
            color: Colors.orange.shade700,
          ),
        ),
        title: const Text('Extra Listing Quota'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You have used your monthly free listing quota.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    'Additional Listing Fee',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₱199',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'per extra listing',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
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
                      Icon(Icons.lightbulb_outline,
                          size: 16, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'Tip: Upgrade to Pro',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '• Pro Basic: 3 listings/month (₱199/mo)\n'
                    '• Pro Plus: 10 listings/month (₱499/mo)',
                    style: TextStyle(
                      fontSize: 11,
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
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.payment),
            label: const Text('Pay ₱199'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  // REVISED Revenue Model: Process extra listing payment
  Future<void> _processExtraListingPayment(String userId) async {
    // TODO: Integrate with actual payment gateway
    // For now, simulate payment delay
    await Future.delayed(const Duration(milliseconds: 500));

    // In production:
    // 1. Redirect to payment gateway
    // 2. Wait for payment confirmation
    // 3. Record transaction
    // 4. Grant extra listing quota
  }

  // Helper: Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.error_outline, size: 48, color: Colors.red),
        title: const Text('Cannot Create Listing'),
        content: Text(message),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Helper: Get quota reset date formatted
  String _getQuotaResetDate(dynamic user) {
    final resetDate = user.listingQuotaResetDate;
    if (resetDate == null) return 'N/A';
    return DateFormat('MMM dd, yyyy').format(resetDate);
  }
}
