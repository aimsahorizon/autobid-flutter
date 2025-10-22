import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/car_brand_models.dart';
import '../../../../core/utils/dev_autofill.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/save_draft_button.dart';

class CreateListingStep1Basic extends StatefulWidget {
  const CreateListingStep1Basic({super.key});

  @override
  State<CreateListingStep1Basic> createState() =>
      _CreateListingStep1BasicState();
}

class _CreateListingStep1BasicState extends State<CreateListingStep1Basic> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    provider.setCurrentStep(1);
  }

  void _autofillForm() {
    final provider = context.read<ListingProvider>();

    provider.setBrand(CarListingAutofillData.brand);
    provider.setModel(CarListingAutofillData.model);
    provider.setVariant(CarListingAutofillData.variant);
    provider.setYear(CarListingAutofillData.year);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✓ Form autofilled (Dev Mode)'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Information'),
        actions: [
          if (DevAutofill.isEnabled)
            DevAutofill.showAutofillIconButton(
              context: context,
              onAutofill: _autofillForm,
            )!,
          SaveDraftButton(
            stepNumber: 1,
            validateForm: () => _formKey.currentState?.validate() ?? false,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: 1 / 9,
              backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 1 of 9',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),

            Text(
              'Tell us about your vehicle',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),

            // Brand dropdown
            DropdownButtonFormField<String>(
              value: CarBrandModels.brands.contains(provider.brand)
                  ? provider.brand
                  : null,
              decoration: const InputDecoration(
                labelText: 'Brand *',
                hintText: 'Select vehicle brand',
                border: OutlineInputBorder(),
              ),
              items: CarBrandModels.brands
                  .map((brand) => DropdownMenuItem(
                        value: brand,
                        child: Text(brand),
                      ))
                  .toList(),
              onChanged: (value) {
                provider.setBrand(value);
                provider.setModel(null); // Reset model when brand changes
                provider.setVariant(null); // Reset variant when brand changes
              },
              validator: (value) =>
                  value == null ? 'Please select a brand' : null,
            ),
            const SizedBox(height: 16),

            // Model dropdown (filtered by brand)
            DropdownButtonFormField<String>(
              key: ValueKey(provider.brand), // Reset dropdown when brand changes
              value: provider.model != null &&
                      CarBrandModels.getModelsForBrand(provider.brand).contains(provider.model)
                  ? provider.model
                  : null,
              decoration: InputDecoration(
                labelText: 'Model *',
                border: const OutlineInputBorder(),
                hintText: provider.brand == null
                    ? 'Select brand first'
                    : 'Select vehicle model',
              ),
              items: provider.brand == null
                  ? []
                  : CarBrandModels.getModelsForBrand(provider.brand)
                      .map((model) => DropdownMenuItem(
                            value: model,
                            child: Text(model),
                          ))
                      .toList(),
              onChanged: provider.brand == null
                  ? null
                  : (value) {
                      provider.setModel(value);
                      provider.setVariant(null); // Reset variant when model changes
                    },
              validator: (value) =>
                  value == null ? 'Please select a model' : null,
            ),
            const SizedBox(height: 16),

            // Variant dropdown (filtered by brand and model)
            DropdownButtonFormField<String>(
              key: ValueKey('${provider.brand}_${provider.model}'), // Reset dropdown when brand or model changes
              value: provider.variant != null &&
                      CarBrandModels.getVariantsForModel(provider.brand, provider.model).contains(provider.variant)
                  ? provider.variant
                  : null,
              decoration: InputDecoration(
                labelText: 'Variant *',
                border: const OutlineInputBorder(),
                hintText: provider.model == null
                    ? 'Select model first'
                    : 'Select vehicle variant',
              ),
              items: provider.model == null
                  ? []
                  : CarBrandModels.getVariantsForModel(provider.brand, provider.model)
                      .map((variant) => DropdownMenuItem(
                            value: variant,
                            child: Text(variant),
                          ))
                      .toList(),
              onChanged: provider.model == null
                  ? null
                  : (value) => provider.setVariant(value),
              validator: (value) =>
                  value == null ? 'Please select a variant' : null,
            ),
            const SizedBox(height: 16),

            // Year dropdown
            DropdownButtonFormField<int>(
              initialValue: provider.year,
              decoration: const InputDecoration(
                labelText: 'Year *',
                hintText: 'Select manufacturing year',
                border: OutlineInputBorder(),
              ),
              items: List.generate(
                36,
                (index) {
                  final year = DateTime.now().year - index;
                  return DropdownMenuItem(
                    value: year,
                    child: Text(year.toString()),
                  );
                },
              ),
              onChanged: (value) => provider.setYear(value),
              validator: (value) =>
                  value == null ? 'Please select a year' : null,
            ),
            const SizedBox(height: 24),

            // Helper text
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.blue.shade900.withOpacity(0.3)
                    : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDarkMode ? Colors.blue.shade700 : Colors.blue.shade200,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: isDarkMode ? Colors.blue.shade300 : Colors.blue.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Make sure to enter the exact model and variant as shown in your vehicle registration documents.',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode ? Colors.blue.shade100 : Colors.blue.shade900,
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
          child: CustomButton(
            text: 'Next',
            onPressed: () {
              if (_formKey.currentState!.validate() &&
                  provider.validateStep1()) {
                context.push('/listing/create/step2');
              }
            },
          ),
        ),
      ),
    );
  }
}
