import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/car_features.dart';
import '../../../../core/utils/enum_extensions.dart';
import '../../../../core/utils/dev_autofill.dart';
import '../../../../core/utils/listing_autofill_helpers.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/save_draft_button.dart';

class CreateListingStep8Review extends StatefulWidget {
  const CreateListingStep8Review({super.key});

  @override
  State<CreateListingStep8Review> createState() =>
      _CreateListingStep8ReviewState();
}

class _CreateListingStep8ReviewState extends State<CreateListingStep8Review> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _issuesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    _descriptionController.text = provider.description;
    _issuesController.text = provider.issues ?? '';
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _issuesController.dispose();
    super.dispose();
  }

  void _autofillForm() {
    Step8AutofillHelper.autofill(
      context,
      _descriptionController,
      _issuesController,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Details'),
        actions: [
          if (DevAutofill.isEnabled)
            DevAutofill.showAutofillIconButton(
              context: context,
              onAutofill: _autofillForm,
            )!,
          SaveDraftButton(
            stepNumber: 8,
            validateForm: () {
              return _formKey.currentState!.validate() && provider.validateStep8();
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            LinearProgressIndicator(
              value: 8 / 8,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 8 of 8',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),

            Text(
              'Description & Features',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),

            // DESCRIPTION SECTION
            Text(
              'Vehicle Description *',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Minimum 50 characters',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 8,
              maxLength: 1000,
              decoration: InputDecoration(
                hintText:
                    'Describe your vehicle\'s condition, history, unique features, and any recent maintenance or upgrades. Be honest and detailed to attract serious buyers.',
                border: const OutlineInputBorder(),
                helperText:
                    '${_descriptionController.text.length}/1000 characters',
              ),
              onChanged: (value) {
                provider.setDescription(value);
                setState(() {}); // Update character count
              },
            ),
            const SizedBox(height: 24),

            // KNOWN ISSUES SECTION
            Text(
              'Known Issues (Optional)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _issuesController,
              maxLines: 4,
              maxLength: 500,
              decoration: const InputDecoration(
                hintText:
                    'List any known problems, defects, or repairs needed. Being transparent builds trust with buyers.',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => provider.setIssues(value),
            ),
            const SizedBox(height: 24),

            // FEATURES SECTION
            Text(
              'Features',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select all features your vehicle has',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: CarFeatures.standardFeatures.map((feature) {
                final isSelected = provider.features.contains(feature);
                return FilterChip(
                  label: Text(feature),
                  selected: isSelected,
                  onSelected: (_) => provider.toggleFeature(feature),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // SUMMARY SECTION
            Text(
              'Listing Summary',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            _buildSummaryCard(
              context,
              'Basic Info',
              [
                '${provider.brand} ${provider.model} ${provider.variant}',
                'Year: ${provider.year}',
              ],
            ),
            const SizedBox(height: 12),

            _buildSummaryCard(
              context,
              'Specifications',
              [
                'Engine: ${provider.engineSize} ${provider.engineType.displayName}',
                'Transmission: ${provider.transmission?.displayName}',
                'Fuel: ${provider.fuelType?.displayName}',
                'Mileage: ${provider.mileage} km',
              ],
            ),
            const SizedBox(height: 12),

            _buildSummaryCard(
              context,
              'Location & Documents',
              [
                '${provider.city}, ${provider.province}',
                'Plate: ${provider.plateNumber}',
                'Registration: ${provider.registrationStatus.displayName}',
              ],
            ),
            const SizedBox(height: 12),

            _buildSummaryCard(
              context,
              'Photos',
              [
                'Total Images: ${provider.categorizedImages.values.fold<int>(0, (sum, list) => sum + list.length)}/46',
                'Exterior: ${provider.categorizedImages['exterior']?.length ?? 0}/15',
                'Interior: ${provider.categorizedImages['interior']?.length ?? 0}/12',
                'Engine: ${provider.categorizedImages['engine']?.length ?? 0}/6',
                'Details: ${provider.categorizedImages['details']?.length ?? 0}/13',
              ],
            ),
            const SizedBox(height: 24),

            // Warning box
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
                      'Review all information carefully. Once submitted, your listing will be reviewed before going live.',
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
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: Save as draft
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Listing saved as draft'),
                      ),
                    );
                  },
                  child: const Text('Save as Draft'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: CustomButton(
                  text: 'Submit Listing',
                  onPressed: () async {
                    if (provider.validateStep8()) {
                      await _submitListing(context, provider);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please write at least 50 characters description'),
                        ),
                      );
                    }
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

  Widget _buildSummaryCard(
      BuildContext context, String title, List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(Icons.check, size: 16, color: Colors.green.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
