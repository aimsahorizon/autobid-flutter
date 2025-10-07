import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
import '../../../../core/utils/enum_extensions.dart';
import '../../../../core/utils/dev_autofill.dart';
import '../../../../core/utils/listing_autofill_helpers.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/number_input_field.dart';
import '../../../widgets/counter_input_field.dart';
import '../../../widgets/save_draft_button.dart';

class CreateListingStep2Mechanical extends StatefulWidget {
  const CreateListingStep2Mechanical({super.key});

  @override
  State<CreateListingStep2Mechanical> createState() =>
      _CreateListingStep2MechanicalState();
}

class _CreateListingStep2MechanicalState
    extends State<CreateListingStep2Mechanical> {
  final _formKey = GlobalKey<FormState>();
  final _engineSizeController = TextEditingController();
  final _chargingTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    provider.setCurrentStep(2);
    _engineSizeController.text = provider.engineSize ?? '';
    _chargingTimeController.text = provider.chargingTime ?? '';
  }

  @override
  void dispose() {
    _engineSizeController.dispose();
    _chargingTimeController.dispose();
    super.dispose();
  }

  bool _isElectric(FuelType? fuelType) {
    return fuelType == FuelType.electric || fuelType == FuelType.plugInHybrid;
  }

  void _autofillForm() {
    Step2AutofillHelper.autofill(
      context,
      _engineSizeController,
      _chargingTimeController,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mechanical Specifications'),
        actions: [
          if (DevAutofill.isEnabled)
            DevAutofill.showAutofillIconButton(
              context: context,
              onAutofill: _autofillForm,
            )!,
          SaveDraftButton(
            stepNumber: 2,
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
              value: 2 / 8,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 2 of 8',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),

            Text(
              'Engine & Powertrain',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),

            // ENGINE SECTION
            Text(
              'Engine Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _engineSizeController,
              labelText: 'Engine Size *',
              hintText: 'e.g., 1.5L, 2.0L, 3.5L',
              onChanged: (value) => provider.setEngineSize(value),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter engine size' : null,
            ),
            const SizedBox(height: 16),

            // Engine Type
            DropdownButtonFormField<EngineType>(
              initialValue: provider.engineType,
              decoration: const InputDecoration(
                labelText: 'Engine Type *',
                border: OutlineInputBorder(),
              ),
              items: EngineType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.displayName),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) provider.setEngineType(value);
              },
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CounterInputField(
                    labelText: 'Cylinders',
                    value: provider.cylinders,
                    minValue: 2,
                    maxValue: 16,
                    onChanged: provider.setCylinders,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: NumberInputField(
                    labelText: 'Horsepower',
                    hintText: 'HP',
                    initialValue: provider.horsepower,
                    minValue: 50,
                    maxValue: 2000,
                    onChanged: (value) =>
                        provider.setHorsepower(value ?? 150),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: NumberInputField(
                    labelText: 'Torque',
                    hintText: 'Nm',
                    suffixText: 'Nm',
                    initialValue: provider.torque,
                    minValue: 50,
                    maxValue: 3000,
                    onChanged: (value) => provider.setTorque(value ?? 200),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: NumberInputField(
                    labelText: 'Fuel Consumption',
                    hintText: 'L/100km',
                    suffixText: 'L/100km',
                    allowDecimal: true,
                    initialDoubleValue: provider.fuelConsumption,
                    onDoubleChanged: (value) =>
                        provider.setFuelConsumption(value ?? 7.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // TRANSMISSION SECTION
            Text(
              'Transmission & Drive',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Transmission Type
            Text(
              'Transmission *',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: TransmissionType.values.map((type) {
                final isSelected = provider.transmission == type;
                return ChoiceChip(
                  label: Text(type.displayName),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) provider.setTransmission(type);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CounterInputField(
                    labelText: 'Transmission Speeds',
                    value: provider.transmissionSpeeds,
                    minValue: 3,
                    maxValue: 10,
                    unitSingular: 'speed',
                    unitPlural: 'speeds',
                    onChanged: provider.setTransmissionSpeeds,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<DriveType>(
                    initialValue: provider.driveType,
                    decoration: const InputDecoration(
                      labelText: 'Drive Type *',
                      border: OutlineInputBorder(),
                    ),
                    items: DriveType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.displayName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) provider.setDriveType(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // FUEL TYPE SECTION
            Text(
              'Fuel Type *',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: FuelType.values.map((type) {
                final isSelected = provider.fuelType == type;
                return ChoiceChip(
                  label: Text(type.displayName),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) provider.setFuelType(type);
                  },
                );
              }).toList(),
            ),

            // Electric/Hybrid Specific Fields
            if (_isElectric(provider.fuelType)) ...[
              const SizedBox(height: 24),
              Text(
                'Electric Vehicle Details',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: NumberInputField(
                      labelText: 'Electric Range',
                      hintText: 'km',
                      suffixText: 'km',
                      initialValue: provider.electricRange,
                      minValue: 10,
                      maxValue: 1000,
                      onChanged: provider.setElectricRange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: NumberInputField(
                      labelText: 'Battery Capacity',
                      hintText: 'kWh',
                      suffixText: 'kWh',
                      allowDecimal: true,
                      initialDoubleValue: provider.batteryCapacity,
                      onDoubleChanged: provider.setBatteryCapacity,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              CustomTextField(
                controller: _chargingTimeController,
                labelText: 'Charging Time',
                hintText: 'e.g., 8 hours (AC), 45 min (DC)',
                onChanged: provider.setChargingTime,
              ),
            ],

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
                      'Check your vehicle manual or registration documents for accurate technical specifications.',
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
                  provider.validateStep2()) {
                context.push('/listing/create/step3');
              }
            },
          ),
        ),
      ),
    );
  }
}
