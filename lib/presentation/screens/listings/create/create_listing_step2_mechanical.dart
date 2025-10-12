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

  void _showAddCustomEngineTypeDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Engine Type'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter a custom engine type not in the standard list.'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Engine Type',
                hintText: 'e.g., W-Type, Radial',
                border: OutlineInputBorder(),
              ),
              maxLength: 30,
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
              final type = controller.text.trim();
              if (type.isNotEmpty) {
                context.read<ListingProvider>().addCustomEngineType(type);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added custom engine type: $type')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddCustomTransmissionTypeDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Transmission'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter a custom transmission type.'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Transmission Type',
                hintText: 'e.g., Sequential, Automated Manual',
                border: OutlineInputBorder(),
              ),
              maxLength: 30,
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
              final type = controller.text.trim();
              if (type.isNotEmpty) {
                context.read<ListingProvider>().addCustomTransmissionType(type);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added custom transmission: $type')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddCustomDriveTypeDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Drive Type'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter a custom drive type.'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Drive Type',
                hintText: 'e.g., Part-time 4WD',
                border: OutlineInputBorder(),
              ),
              maxLength: 30,
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
              final type = controller.text.trim();
              if (type.isNotEmpty) {
                context.read<ListingProvider>().addCustomDriveType(type);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added custom drive type: $type')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddCustomFuelTypeDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Fuel Type'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter a custom fuel type.'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Fuel Type',
                hintText: 'e.g., Ethanol, Biodiesel',
                border: OutlineInputBorder(),
              ),
              maxLength: 30,
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
              final type = controller.text.trim();
              if (type.isNotEmpty) {
                context.read<ListingProvider>().addCustomFuelType(type);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added custom fuel type: $type')),
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
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
              value: 2 / 9,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 2 of 9',
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
            DropdownButtonFormField<EngineType?>(
              value: provider.engineType,
              decoration: const InputDecoration(
                labelText: 'Engine Type *',
                border: OutlineInputBorder(),
                hintText: 'Select engine type',
              ),
              items: [
                const DropdownMenuItem<EngineType?>(
                  value: null,
                  child: Text('Select engine type', style: TextStyle(color: Colors.grey)),
                ),
                ...EngineType.values.map((type) {
                  return DropdownMenuItem<EngineType?>(
                    value: type,
                    child: Text(type.displayName),
                  );
                }).toList(),
              ],
              onChanged: (value) {
                provider.setEngineType(value);
              },
              validator: (value) => value == null ? 'Please select engine type' : null,
            ),
            if (provider.customEngineTypes.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: provider.customEngineTypes.map((type) {
                  return Chip(
                    label: Text(type, style: const TextStyle(fontSize: 11)),
                    deleteIcon: const Icon(Icons.close, size: 14),
                    visualDensity: VisualDensity.compact,
                    onDeleted: () {
                      setState(() {
                        provider.customEngineTypes.remove(type);
                      });
                    },
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: _showAddCustomEngineTypeDialog,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add Custom Engine Type', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
              ),
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
              children: [
                ...TransmissionType.values.map((type) {
                  final isSelected = provider.transmission == type;
                  return ChoiceChip(
                    label: Text(type.displayName),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) provider.setTransmission(type);
                    },
                  );
                }),
                ...provider.customTransmissionTypes.map((type) {
                  final isSelected = provider.selectedCustomTransmission == type;
                  return ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(type),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              provider.customTransmissionTypes.remove(type);
                              if (provider.selectedCustomTransmission == type) {
                                provider.setSelectedCustomTransmission(null);
                              }
                            });
                          },
                          child: const Icon(Icons.cancel, size: 16),
                        ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        provider.setTransmission(null);
                        provider.setSelectedCustomTransmission(type);
                      }
                    },
                  );
                }),
                ActionChip(
                  avatar: const Icon(Icons.add_circle_outline, size: 18),
                  label: const Text('Add option'),
                  onPressed: _showAddCustomTransmissionTypeDialog,
                  backgroundColor: Colors.grey[100],
                  side: BorderSide(color: Colors.grey[400]!, style: BorderStyle.none),
                ),
              ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<DriveType?>(
                        value: provider.driveType,
                        decoration: const InputDecoration(
                          labelText: 'Drive Type *',
                          border: OutlineInputBorder(),
                          hintText: 'Select drive type',
                        ),
                        items: [
                          const DropdownMenuItem<DriveType?>(
                            value: null,
                            child: Text('Select drive type', style: TextStyle(color: Colors.grey)),
                          ),
                          ...DriveType.values.map((type) {
                            return DropdownMenuItem<DriveType?>(
                              value: type,
                              child: Text(type.displayName),
                            );
                          }).toList(),
                        ],
                        onChanged: (value) {
                          provider.setDriveType(value);
                        },
                        validator: (value) => value == null ? 'Please select drive type' : null,
                      ),
                      if (provider.customDriveTypes.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: provider.customDriveTypes.map((type) {
                            return Chip(
                              label: Text(type, style: const TextStyle(fontSize: 11)),
                              deleteIcon: const Icon(Icons.close, size: 14),
                              visualDensity: VisualDensity.compact,
                              onDeleted: () {
                                setState(() {
                                  provider.customDriveTypes.remove(type);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                      const SizedBox(height: 4),
                      TextButton.icon(
                        onPressed: _showAddCustomDriveTypeDialog,
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Add Custom', style: TextStyle(fontSize: 12)),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      ),
                    ],
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
              children: [
                ...FuelType.values.map((type) {
                  final isSelected = provider.fuelType == type;
                  return ChoiceChip(
                    label: Text(type.displayName),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) provider.setFuelType(type);
                    },
                  );
                }),
                ...provider.customFuelTypes.map((type) {
                  final isSelected = provider.selectedCustomFuelType == type;
                  return ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(type),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              provider.customFuelTypes.remove(type);
                              if (provider.selectedCustomFuelType == type) {
                                provider.setSelectedCustomFuelType(null);
                              }
                            });
                          },
                          child: const Icon(Icons.cancel, size: 16),
                        ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        provider.setFuelType(null);
                        provider.setSelectedCustomFuelType(type);
                      }
                    },
                  );
                }),
                ActionChip(
                  avatar: const Icon(Icons.add_circle_outline, size: 18),
                  label: const Text('Add option'),
                  onPressed: _showAddCustomFuelTypeDialog,
                  backgroundColor: Colors.grey[100],
                  side: BorderSide(color: Colors.grey[400]!, style: BorderStyle.none),
                ),
              ],
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
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push('/listing/create/step1'),
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
                        provider.validateStep2()) {
                      context.push('/listing/create/step3');
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
