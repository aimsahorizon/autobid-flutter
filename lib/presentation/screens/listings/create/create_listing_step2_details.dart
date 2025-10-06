import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
import '../../../../core/utils/enum_extensions.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class CreateListingStep2Details extends StatefulWidget {
  const CreateListingStep2Details({super.key});

  @override
  State<CreateListingStep2Details> createState() =>
      _CreateListingStep2DetailsState();
}

class _CreateListingStep2DetailsState extends State<CreateListingStep2Details> {
  final _formKey = GlobalKey<FormState>();
  final _mileageController = TextEditingController();
  final _colorController = TextEditingController();
  final _engineSizeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    _mileageController.text =
        provider.mileage != null ? provider.mileage.toString() : '';
    _colorController.text = provider.color ?? '';
    _engineSizeController.text = provider.engineSize ?? '';
  }

  @override
  void dispose() {
    _mileageController.dispose();
    _colorController.dispose();
    _engineSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            LinearProgressIndicator(
              value: 2 / 6,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 2 of 6',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),

            Text(
              'Technical specifications',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),

            // Mileage
            CustomTextField(
              controller: _mileageController,
              labelText: 'Mileage (km) *',
              hintText: 'Enter current mileage',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              suffixText: 'km',
              onChanged: (value) =>
                  provider.setMileage(int.tryParse(value)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter mileage';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Transmission
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

            // Fuel Type
            Text(
              'Fuel Type *',
              style: Theme.of(context).textTheme.titleSmall,
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
            const SizedBox(height: 16),

            // Body Type
            Text(
              'Body Type *',
              style: Theme.of(context).textTheme.titleSmall,
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
            const SizedBox(height: 16),

            // Color
            CustomTextField(
              controller: _colorController,
              labelText: 'Color *',
              hintText: 'e.g., White, Black, Silver',
              onChanged: (value) => provider.setColor(value),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter color' : null,
            ),
            const SizedBox(height: 16),

            // Engine Size
            CustomTextField(
              controller: _engineSizeController,
              labelText: 'Engine Size *',
              hintText: 'e.g., 1.5L, 2.0L, 3.5L',
              onChanged: (value) => provider.setEngineSize(value),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter engine size' : null,
            ),
            const SizedBox(height: 16),

            // Seats
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seats *',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (provider.seats > 2) {
                                provider.setSeats(provider.seats - 1);
                              }
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            '${provider.seats}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          IconButton(
                            onPressed: () {
                              if (provider.seats < 15) {
                                provider.setSeats(provider.seats + 1);
                              }
                            },
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Doors *',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (provider.doors > 2) {
                                provider.setDoors(provider.doors - 1);
                              }
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            '${provider.doors}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          IconButton(
                            onPressed: () {
                              if (provider.doors < 6) {
                                provider.setDoors(provider.doors + 1);
                              }
                            },
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
