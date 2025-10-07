import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/car_brands.dart';
import '../../../../core/utils/dev_autofill.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/save_draft_button.dart';

class CreateListingStep1Basic extends StatefulWidget {
  const CreateListingStep1Basic({super.key});

  @override
  State<CreateListingStep1Basic> createState() =>
      _CreateListingStep1BasicState();
}

class _CreateListingStep1BasicState extends State<CreateListingStep1Basic> {
  final _formKey = GlobalKey<FormState>();
  final _modelController = TextEditingController();
  final _variantController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    _modelController.text = provider.model ?? '';
    _variantController.text = provider.variant ?? '';
  }

  @override
  void dispose() {
    _modelController.dispose();
    _variantController.dispose();
    super.dispose();
  }

  void _autofillForm() {
    final provider = context.read<ListingProvider>();

    provider.setBrand(CarListingAutofillData.brand);
    provider.setYear(CarListingAutofillData.year);

    setState(() {
      _modelController.text = CarListingAutofillData.model;
      _variantController.text = CarListingAutofillData.variant;
    });

    provider.setModel(CarListingAutofillData.model);
    provider.setVariant(CarListingAutofillData.variant);

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
            validateForm: () {
              return _formKey.currentState!.validate() && provider.validateStep1();
            },
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
              value: 1 / 6,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 1 of 6',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
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
              initialValue: provider.brand,
              decoration: const InputDecoration(
                labelText: 'Brand *',
                hintText: 'Select vehicle brand',
                border: OutlineInputBorder(),
              ),
              items: CarBrands.popularBrands
                  .map((brand) => DropdownMenuItem(
                        value: brand,
                        child: Text(brand),
                      ))
                  .toList(),
              onChanged: (value) => provider.setBrand(value),
              validator: (value) =>
                  value == null ? 'Please select a brand' : null,
            ),
            const SizedBox(height: 16),

            // Model
            CustomTextField(
              controller: _modelController,
              labelText: 'Model *',
              hintText: 'e.g., Vios, City, Montero',
              onChanged: (value) => provider.setModel(value),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter model' : null,
            ),
            const SizedBox(height: 16),

            // Variant
            CustomTextField(
              controller: _variantController,
              labelText: 'Variant *',
              hintText: 'e.g., 1.3 E, VX CVT, GLS',
              onChanged: (value) => provider.setVariant(value),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter variant' : null,
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
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Make sure to enter the exact model and variant as shown in your vehicle registration documents.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade900,
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
