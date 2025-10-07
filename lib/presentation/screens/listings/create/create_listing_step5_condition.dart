import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
import '../../../../core/utils/enum_extensions.dart';
import '../../../../core/utils/dev_autofill.dart';
import '../../../../core/utils/listing_autofill_helpers.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/counter_input_field.dart';
import '../../../widgets/save_draft_button.dart';

class CreateListingStep5Condition extends StatefulWidget {
  const CreateListingStep5Condition({super.key});

  @override
  State<CreateListingStep5Condition> createState() =>
      _CreateListingStep5ConditionState();
}

class _CreateListingStep5ConditionState
    extends State<CreateListingStep5Condition> {
  final _formKey = GlobalKey<FormState>();
  final _mileageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    provider.setCurrentStep(5);
    _mileageController.text =
        provider.mileage != null ? provider.mileage.toString() : '';
  }

  @override
  void dispose() {
    _mileageController.dispose();
    super.dispose();
  }

  void _autofillForm() {
    Step5AutofillHelper.autofill(context, _mileageController);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Condition & History'),
        actions: [
          if (DevAutofill.isEnabled)
            DevAutofill.showAutofillIconButton(
              context: context,
              onAutofill: _autofillForm,
            )!,
          SaveDraftButton(
            stepNumber: 5,
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
              value: 5 / 8,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 5 of 8',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),

            Text(
              'Vehicle Condition',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),

            // CONDITION SELECTION
            Text(
              'Overall Condition *',
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

            // MILEAGE
            CustomTextField(
              controller: _mileageController,
              labelText: 'Mileage (km) *',
              hintText: 'Enter current mileage',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              suffixText: 'km',
              onChanged: (value) => provider.setMileage(int.tryParse(value)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter mileage';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            CounterInputField(
              labelText: 'Number of Previous Owners *',
              value: provider.numberOfOwners,
              minValue: 1,
              maxValue: 10,
              unitSingular: 'owner',
              unitPlural: 'owners',
              onChanged: provider.setNumberOfOwners,
            ),
            const SizedBox(height: 24),

            // HISTORY FLAGS
            Text(
              'History',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            SwitchListTile(
              title: const Text('Complete Service History'),
              subtitle: const Text('All maintenance records available'),
              value: provider.serviceHistoryComplete,
              onChanged: provider.setServiceHistoryComplete,
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(),

            SwitchListTile(
              title: const Text('Has Accident History'),
              subtitle: const Text('Vehicle has been in an accident'),
              value: provider.hasAccidentHistory,
              onChanged: provider.setHasAccidentHistory,
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(),

            SwitchListTile(
              title: const Text('Flood Damage'),
              subtitle: const Text('Vehicle has flood/water damage'),
              value: provider.floodDamage,
              onChanged: provider.setFloodDamage,
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(),

            SwitchListTile(
              title: const Text('Warranty Remaining'),
              subtitle: const Text('Factory or extended warranty still active'),
              value: provider.warrantyRemaining,
              onChanged: provider.setWarrantyRemaining,
              contentPadding: EdgeInsets.zero,
            ),

            const SizedBox(height: 24),

            // Info box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning_amber_outlined,
                      color: Colors.orange.shade700, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Being honest about your vehicle\'s condition builds trust and prevents issues later.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange.shade900,
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
                  provider.validateStep5()) {
                context.push('/listing/create/step6');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select condition and enter mileage'),
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
