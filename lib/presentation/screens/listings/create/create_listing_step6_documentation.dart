import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
import '../../../../core/constants/ph_provinces.dart';
import '../../../../core/constants/ph_cities.dart';
import '../../../../core/utils/enum_extensions.dart';
import '../../../../core/utils/dev_autofill.dart';
import '../../../../core/utils/listing_autofill_helpers.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/date_picker_field.dart';
import '../../../widgets/save_draft_button.dart';

class CreateListingStep6Documentation extends StatefulWidget {
  const CreateListingStep6Documentation({super.key});

  @override
  State<CreateListingStep6Documentation> createState() =>
      _CreateListingStep6DocumentationState();
}

class _CreateListingStep6DocumentationState
    extends State<CreateListingStep6Documentation> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _orcrController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    provider.setCurrentStep(6);
    _plateController.text = provider.plateNumber ?? '';
    _orcrController.text = provider.orcrNumber ?? '';
  }

  @override
  void dispose() {
    _plateController.dispose();
    _orcrController.dispose();
    super.dispose();
  }

  void _autofillForm() {
    Step6AutofillHelper.autofill(context, _plateController, _orcrController);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Documentation & Location'),
        actions: [
          if (DevAutofill.isEnabled)
            DevAutofill.showAutofillIconButton(
              context: context,
              onAutofill: _autofillForm,
            )!,
          SaveDraftButton(
            stepNumber: 6,
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
              value: 6 / 9,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 6 of 9',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),

            Text(
              'Registration & Location',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),

            // REGISTRATION SECTION
            Text(
              'Registration Documents',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _plateController,
              labelText: 'Plate Number *',
              hintText: 'ABC-1234',
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) => provider.setPlateNumber(value),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter plate number';
                if (!RegExp(r'^[A-Z]{3}-\d{4}$').hasMatch(value!)) {
                  return 'Format: ABC-1234';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _orcrController,
              labelText: 'OR/CR Number *',
              hintText: 'Official Receipt / Certificate of Registration',
              onChanged: (value) => provider.setOrcrNumber(value),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter OR/CR number' : null,
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<RegistrationStatus>(
              initialValue: provider.registrationStatus,
              decoration: const InputDecoration(
                labelText: 'Registration Status *',
                border: OutlineInputBorder(),
              ),
              items: RegistrationStatus.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.displayName),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) provider.setRegistrationStatus(value);
              },
            ),
            const SizedBox(height: 16),

            DatePickerField(
              labelText: 'Registration Expiry',
              selectedDate: provider.registrationExpiry,
              onChanged: provider.setRegistrationExpiry,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 730)),
              hintText: 'Optional',
            ),
            const SizedBox(height: 24),

            // COMPLIANCE SECTION
            Text(
              'Compliance & Insurance',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            SwitchListTile(
              title: const Text('Emission Test Valid'),
              subtitle: const Text('Current emission test certificate'),
              value: provider.emissionTestValid,
              onChanged: provider.setEmissionTestValid,
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(),

            SwitchListTile(
              title: const Text('Comprehensive Insurance'),
              subtitle: const Text('Active comprehensive insurance coverage'),
              value: provider.comprehensiveInsurance,
              onChanged: provider.setComprehensiveInsurance,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),

            // LOCATION SECTION
            Text(
              'Vehicle Location',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: PhilippineProvinces.provinces.contains(provider.province)
                  ? provider.province
                  : null,
              decoration: const InputDecoration(
                labelText: 'Province *',
                border: OutlineInputBorder(),
              ),
              items: PhilippineProvinces.provinces
                  .map((province) => DropdownMenuItem(
                        value: province,
                        child: Text(province),
                      ))
                  .toList(),
              onChanged: (value) {
                provider.setProvince(value);
                provider.setCity(null);
              },
              validator: (value) =>
                  value == null ? 'Please select province' : null,
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: PhilippineCities.cities.contains(provider.city)
                  ? provider.city
                  : null,
              decoration: const InputDecoration(
                labelText: 'City/Municipality *',
                border: OutlineInputBorder(),
              ),
              items: PhilippineCities.cities
                  .map((city) => DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      ))
                  .toList(),
              onChanged: (value) => provider.setCity(value),
              validator: (value) =>
                  value == null ? 'Please select city' : null,
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
                  onPressed: () => context.push('/listing/create/step5'),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: CustomButton(
                  text: 'Next',
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        provider.validateStep6()) {
                      context.push('/listing/create/step7');
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
