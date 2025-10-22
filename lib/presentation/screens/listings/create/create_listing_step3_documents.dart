import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/ph_provinces.dart';
import '../../../../core/constants/ph_cities.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class CreateListingStep3Documents extends StatefulWidget {
  const CreateListingStep3Documents({super.key});

  @override
  State<CreateListingStep3Documents> createState() =>
      _CreateListingStep3DocumentsState();
}

class _CreateListingStep3DocumentsState
    extends State<CreateListingStep3Documents> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _orcrController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    _plateController.text = provider.plateNumber ?? '';
    _orcrController.text = provider.orcrNumber ?? '';
  }

  @override
  void dispose() {
    _plateController.dispose();
    _orcrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents & Location'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            LinearProgressIndicator(
              value: 3 / 6,
              backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 3 of 6',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
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

            // Plate Number
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

            // OR/CR Number
            CustomTextField(
              controller: _orcrController,
              labelText: 'OR/CR Number *',
              hintText: 'Official Receipt / Certificate of Registration number',
              onChanged: (value) => provider.setOrcrNumber(value),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter OR/CR number' : null,
            ),
            const SizedBox(height: 24),

            // Province
            DropdownButtonFormField<String>(
              initialValue: provider.province,
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
                provider.setCity(null); // Reset city when province changes
              },
              validator: (value) =>
                  value == null ? 'Please select province' : null,
            ),
            const SizedBox(height: 16),

            // City
            DropdownButtonFormField<String>(
              initialValue: provider.city,
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
            const SizedBox(height: 24),

            // Number of Owners
            Text(
              'Number of Previous Owners *',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (provider.numberOfOwners > 1) {
                      provider.setNumberOfOwners(provider.numberOfOwners - 1);
                    }
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  '${provider.numberOfOwners}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  onPressed: () {
                    if (provider.numberOfOwners < 10) {
                      provider.setNumberOfOwners(provider.numberOfOwners + 1);
                    }
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
                const SizedBox(width: 8),
                Text(
                  provider.numberOfOwners == 1 ? 'owner' : 'owners',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Service History
            SwitchListTile(
              title: const Text('Complete Service History'),
              subtitle: const Text('All maintenance records available'),
              value: provider.serviceHistoryComplete,
              onChanged: (value) => provider.setServiceHistoryComplete(value),
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(),

            // Accident History
            SwitchListTile(
              title: const Text('Has Accident History'),
              subtitle: const Text('Vehicle has been in an accident'),
              value: provider.hasAccidentHistory,
              onChanged: (value) => provider.setHasAccidentHistory(value),
              contentPadding: EdgeInsets.zero,
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
                  provider.validateStep3()) {
                context.push('/listing/create/step4');
              }
            },
          ),
        ),
      ),
    );
  }
}
