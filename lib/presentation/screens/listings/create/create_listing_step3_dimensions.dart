import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
import '../../../../core/utils/enum_extensions.dart';
import '../../../../core/utils/dev_autofill.dart';
import '../../../../core/utils/listing_autofill_helpers.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/number_input_field.dart';
import '../../../widgets/counter_input_field.dart';
import '../../../widgets/save_draft_button.dart';

class CreateListingStep3Dimensions extends StatefulWidget {
  const CreateListingStep3Dimensions({super.key});

  @override
  State<CreateListingStep3Dimensions> createState() =>
      _CreateListingStep3DimensionsState();
}

class _CreateListingStep3DimensionsState
    extends State<CreateListingStep3Dimensions> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<ListingProvider>().setCurrentStep(3);
  }

  void _autofillForm() {
    Step3AutofillHelper.autofill(context);
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
        title: const Text('Dimensions & Capacity'),
        actions: [
          if (DevAutofill.isEnabled)
            DevAutofill.showAutofillIconButton(
              context: context,
              onAutofill: _autofillForm,
            )!,
          SaveDraftButton(
            stepNumber: 3,
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
              value: 3 / 9,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 3 of 9',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),

            Text(
              'Vehicle Size & Capacity',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),

            // BODY TYPE SECTION
            Text(
              'Body Type *',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: BodyType.values.map((type) {
                final isSelected = provider.bodyType == type;
                return ChoiceChip(
                  label: Text(type.displayName),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) provider.setBodyType(type);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // DOORS AND SEATS
            Row(
              children: [
                Expanded(
                  child: CounterInputField(
                    labelText: 'Doors *',
                    value: provider.doors,
                    minValue: 2,
                    maxValue: 6,
                    unitSingular: 'door',
                    unitPlural: 'doors',
                    onChanged: provider.setDoors,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CounterInputField(
                    labelText: 'Seats *',
                    value: provider.seats,
                    minValue: 2,
                    maxValue: 15,
                    unitSingular: 'seat',
                    unitPlural: 'seats',
                    onChanged: provider.setSeats,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // WEIGHT SECTION
            Text(
              'Weight',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: NumberInputField(
                    labelText: 'Curb Weight',
                    hintText: 'kg',
                    suffixText: 'kg',
                    initialValue: provider.curbWeight,
                    minValue: 500,
                    maxValue: 10000,
                    onChanged: (value) =>
                        provider.setCurbWeight(value ?? 1500),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: NumberInputField(
                    labelText: 'Gross Weight',
                    hintText: 'kg',
                    suffixText: 'kg',
                    initialValue: provider.grossWeight,
                    minValue: 500,
                    maxValue: 15000,
                    onChanged: (value) =>
                        provider.setGrossWeight(value ?? 2000),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // CAPACITY SECTION
            Text(
              'Capacity',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: NumberInputField(
                    labelText: 'Cargo Capacity',
                    hintText: 'liters',
                    suffixText: 'L',
                    initialValue: provider.cargoCapacity,
                    minValue: 50,
                    maxValue: 5000,
                    onChanged: (value) =>
                        provider.setCargoCapacity(value ?? 500),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: NumberInputField(
                    labelText: 'Towing Capacity',
                    hintText: 'kg (optional)',
                    suffixText: 'kg',
                    initialValue: provider.towingCapacity,
                    minValue: 0,
                    maxValue: 5000,
                    onChanged: provider.setTowingCapacity,
                    validator: (_) => null, // Optional field
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            NumberInputField(
              labelText: 'Ground Clearance',
              hintText: 'mm (optional)',
              suffixText: 'mm',
              initialValue: provider.groundClearance,
              minValue: 50,
              maxValue: 500,
              onChanged: provider.setGroundClearance,
              validator: (_) => null, // Optional field
            ),
            const SizedBox(height: 24),

            // DIMENSIONS SECTION
            Text(
              'Dimensions (mm)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: NumberInputField(
                    labelText: 'Length',
                    hintText: 'mm',
                    suffixText: 'mm',
                    initialValue: provider.length,
                    minValue: 2000,
                    maxValue: 10000,
                    onChanged: (value) => provider.setLength(value ?? 4500),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: NumberInputField(
                    labelText: 'Width',
                    hintText: 'mm',
                    suffixText: 'mm',
                    initialValue: provider.width,
                    minValue: 1000,
                    maxValue: 3000,
                    onChanged: (value) => provider.setWidth(value ?? 1800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: NumberInputField(
                    labelText: 'Height',
                    hintText: 'mm',
                    suffixText: 'mm',
                    initialValue: provider.height,
                    minValue: 1000,
                    maxValue: 3000,
                    onChanged: (value) => provider.setHeight(value ?? 1500),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: NumberInputField(
                    labelText: 'Wheelbase',
                    hintText: 'mm',
                    suffixText: 'mm',
                    initialValue: provider.wheelbase,
                    minValue: 1500,
                    maxValue: 5000,
                    onChanged: (value) => provider.setWheelbase(value ?? 2700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Info box
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
                  Icon(Icons.info_outline,
                      color: Colors.blue.shade700, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You can find these specifications in your vehicle manual or online manufacturer specifications.',
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
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push('/listing/create/step2'),
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
                        provider.validateStep3()) {
                      context.push('/listing/create/step4');
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
