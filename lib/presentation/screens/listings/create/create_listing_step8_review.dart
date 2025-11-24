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
import 'create_listing_step_mixin.dart';

class CreateListingStep8Review extends StatefulWidget {
  const CreateListingStep8Review({super.key});

  @override
  State<CreateListingStep8Review> createState() =>
      _CreateListingStep8ReviewState();
}

class _CreateListingStep8ReviewState extends State<CreateListingStep8Review> with CreateListingMixin {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _issuesController = TextEditingController();
  final _featureSearchController = TextEditingController();
  final FocusNode _featureSearchFocus = FocusNode();
  bool _showFeatureSuggestions = false;

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
    _featureSearchController.dispose();
    _featureSearchFocus.dispose();
    super.dispose();
  }

  void _autofillForm() {
    Step8AutofillHelper.autofill(
      context,
      _descriptionController,
      _issuesController,
    );
  }

  List<String> _getFilteredFeatures(String query) {
    if (query.isEmpty) return [];

    final lowerQuery = query.toLowerCase();
    final allFeatures = CarFeatures.standardFeatures;

    return allFeatures
        .where((feature) => feature.toLowerCase().contains(lowerQuery))
        .take(10)
        .toList();
  }

  void _addFeatureFromSearch(String feature, ListingProvider provider) {
    final trimmed = feature.trim();
    if (trimmed.isEmpty) return;

    // Check if it's a standard feature
    if (CarFeatures.standardFeatures.contains(trimmed)) {
      if (!provider.features.contains(trimmed)) {
        provider.toggleFeature(trimmed);
      }
    } else {
      // It's a custom feature
      if (!provider.customFeatures.contains(trimmed)) {
        provider.addCustomFeature(trimmed);
      }
    }

    _featureSearchController.clear();
    setState(() {
      _showFeatureSuggestions = false;
    });
    _featureSearchFocus.unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added: $trimmed'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showAddCustomFeatureDialog(BuildContext context, ListingProvider provider) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Feature'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter a feature that is not listed in the standard categories.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Feature Name',
                hintText: 'e.g., Custom Sound System',
                border: OutlineInputBorder(),
              ),
              maxLength: 50,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  provider.addCustomFeature(value.trim());
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final feature = controller.text.trim();
              if (feature.isNotEmpty) {
                provider.addCustomFeature(feature);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added custom feature: $feature'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => handleBackWithWarning(),
        ),
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
              backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 8 of 10',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
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
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Features',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.green.shade900.withOpacity(0.3)
                        : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDarkMode ? Colors.green.shade700 : Colors.green.shade200,
                    ),
                  ),
                  child: Text(
                    '${provider.features.length + provider.customFeatures.length} selected',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.green.shade100 : Colors.green.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Search and add features, or browse categories below',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 12),

            // QUICK ADD FEATURE SEARCH
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _featureSearchController,
                  focusNode: _featureSearchFocus,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Quick Add Feature',
                    hintText: 'Type to search or add custom feature...',
                    hintStyle: const TextStyle(fontSize: 13),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.search, size: 20),
                    suffixIcon: _featureSearchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () {
                              _featureSearchController.clear();
                              setState(() {
                                _showFeatureSuggestions = false;
                              });
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _showFeatureSuggestions = value.isNotEmpty;
                    });
                  },
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      _addFeatureFromSearch(value, provider);
                    }
                  },
                ),
                if (_showFeatureSuggestions && _featureSearchController.text.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border: Border.all(color: Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Builder(
                        builder: (context) {
                          final suggestions = _getFilteredFeatures(_featureSearchController.text);
                          final searchText = _featureSearchController.text.trim();
                          final isCustom = suggestions.isEmpty ||
                              !suggestions.any((f) => f.toLowerCase() == searchText.toLowerCase());

                          return ListView(
                            shrinkWrap: true,
                            children: [
                              ...suggestions.map((feature) {
                                final isSelected = provider.features.contains(feature);
                                return InkWell(
                                  onTap: () => _addFeatureFromSearch(feature, provider),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          isSelected ? Icons.check_circle : Icons.add_circle_outline,
                                          size: 18,
                                          color: isSelected ? Colors.green : Colors.grey,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            feature,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: isSelected ? Colors.grey : null,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              if (isCustom && searchText.isNotEmpty) ...[
                                if (suggestions.isNotEmpty) const Divider(height: 1),
                                InkWell(
                                  onTap: () => _addFeatureFromSearch(searchText, provider),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    color: Colors.green.withOpacity(0.05),
                                    child: Row(
                                      children: [
                                        Icon(Icons.add_circle, size: 18, color: Colors.green[700]),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            "Add custom: '$searchText'",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.green[700],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),

            // Selected Features Chips (Show quick preview)
            if (provider.features.isNotEmpty || provider.customFeatures.isNotEmpty)
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.check_circle, size: 16, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            'Selected Features',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          ...provider.features.map((feature) => Chip(
                                label: Text(feature, style: const TextStyle(fontSize: 11)),
                                onDeleted: () => provider.toggleFeature(feature),
                                deleteIconColor: Colors.red,
                                backgroundColor: Colors.green.shade50,
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              )),
                          ...provider.customFeatures.map((feature) => Chip(
                                label: Text(feature, style: const TextStyle(fontSize: 11)),
                                onDeleted: () => provider.removeCustomFeature(feature),
                                deleteIconColor: Colors.red,
                                backgroundColor: Colors.blue.shade50,
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            Text(
              'Browse by Category',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),

            // Categorized features with expansion tiles
            ...CarFeatures.categories.map((category) {
              final categoryFeatures = CarFeatures.getFeaturesForCategory(category);
              final selectedCount = categoryFeatures
                  .where((f) => provider.features.contains(f))
                  .length;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: selectedCount > 0,
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            category,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (selectedCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.green.shade900.withOpacity(0.3)
                                  : Colors.green.shade50,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isDarkMode ? Colors.green.shade700 : Colors.green.shade200,
                              ),
                            ),
                            child: Text(
                              '$selectedCount/${categoryFeatures.length}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.green.shade100 : Colors.green.shade700,
                              ),
                            ),
                          ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: categoryFeatures.map((feature) {
                            final isSelected = provider.features.contains(feature);
                            return FilterChip(
                              label: Text(
                                feature,
                                style: const TextStyle(fontSize: 12),
                              ),
                              selected: isSelected,
                              onSelected: (_) => provider.toggleFeature(feature),
                              selectedColor: Colors.green.shade100,
                              checkmarkColor: Colors.green.shade700,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            // CUSTOM FEATURES SECTION
            if (provider.customFeatures.isNotEmpty)
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            CarFeatures.customCategory,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.blue.shade900.withOpacity(0.3)
                                : Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isDarkMode ? Colors.blue.shade700 : Colors.blue.shade200,
                            ),
                          ),
                          child: Text(
                            '${provider.customFeatures.length}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.blue.shade100 : Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: provider.customFeatures.map((feature) {
                            return FilterChip(
                              label: Text(
                                feature,
                                style: const TextStyle(fontSize: 12),
                              ),
                              selected: true,
                              onSelected: null,
                              onDeleted: () => provider.removeCustomFeature(feature),
                              deleteIcon: const Icon(Icons.close, size: 16),
                              selectedColor: Colors.blue.shade100,
                              checkmarkColor: Colors.blue.shade700,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // ADD CUSTOM FEATURE BUTTON
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _showAddCustomFeatureDialog(context, provider),
              icon: const Icon(Icons.add),
              label: const Text('Add Custom Feature'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
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
                  onPressed: () => context.push('/listing/create/step7'),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
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
            ],
          ),
        ),
      ),
    );
  }
}
