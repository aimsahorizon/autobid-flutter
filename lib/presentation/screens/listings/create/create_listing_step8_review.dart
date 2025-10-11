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
    provider.setCurrentStep(8);
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
            validateForm: () => _formKey.currentState?.validate() ?? false,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            LinearProgressIndicator(
              value: 8 / 9,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 8 of 9',
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
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomButton(
            text: 'Next',
            onPressed: () {
              if (provider.validateStep8()) {
                context.push('/listing/create/step9');
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
      ),
    );
  }
}
