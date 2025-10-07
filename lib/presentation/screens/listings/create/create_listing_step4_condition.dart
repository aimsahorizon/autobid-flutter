import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
import '../../../../core/constants/car_features.dart';
import '../../../../core/utils/enum_extensions.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';

class CreateListingStep4Condition extends StatefulWidget {
  const CreateListingStep4Condition({super.key});

  @override
  State<CreateListingStep4Condition> createState() =>
      _CreateListingStep4ConditionState();
}

class _CreateListingStep4ConditionState
    extends State<CreateListingStep4Condition> {
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

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Condition & Features'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          LinearProgressIndicator(
            value: 4 / 6,
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(height: 24),

          Text(
            'Step 4 of 6',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),

          Text(
            'Describe your vehicle',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),

          // Condition Selection
          Text(
            'Condition *',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),

          RadioGroup<CarCondition>(
            groupValue: provider.condition,
            onChanged: (value) {
              if (value != null) provider.setCondition(value);
            },
            child: Column(
              children: CarCondition.values.map((condition) {
                final isSelected = provider.condition == condition;
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: isSelected
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                      : null,
                  child: InkWell(
                    onTap: () => provider.setCondition(condition),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Radio<CarCondition>(
                            value: condition,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  condition.displayName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  condition.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),

          // Description
          Text(
            'Description * (minimum 50 characters)',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            maxLines: 6,
            maxLength: 1000,
            decoration: InputDecoration(
              hintText:
                  'Describe your vehicle\'s condition, history, and any special features. Be honest and detailed to attract serious buyers.',
              border: const OutlineInputBorder(),
              helperText:
                  '${_descriptionController.text.length}/1000 characters',
            ),
            onChanged: (value) => provider.setDescription(value),
          ),
          const SizedBox(height: 24),

          // Known Issues (Optional)
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
            decoration: const InputDecoration(
              hintText:
                  'List any known problems, defects, or repairs needed. Being transparent builds trust with buyers.',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => provider.setIssues(value),
          ),
          const SizedBox(height: 24),

          // Features
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
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomButton(
            text: 'Next',
            onPressed: () {
              if (provider.validateStep4()) {
                context.push('/listing/create/step5');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Please select condition and write at least 50 characters description'),
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
