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
import '../../../widgets/counter_input_field.dart';
import '../../../widgets/save_draft_button.dart';

class CreateListingStep4Exterior extends StatefulWidget {
  const CreateListingStep4Exterior({super.key});

  @override
  State<CreateListingStep4Exterior> createState() =>
      _CreateListingStep4ExteriorState();
}

class _CreateListingStep4ExteriorState
    extends State<CreateListingStep4Exterior> {
  final _formKey = GlobalKey<FormState>();
  final _colorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    provider.setCurrentStep(4);
    _colorController.text = provider.color ?? '';
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  void _autofillForm() {
    Step4AutofillHelper.autofill(context, _colorController);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exterior Details'),
        actions: [
          if (DevAutofill.isEnabled)
            DevAutofill.showAutofillIconButton(
              context: context,
              onAutofill: _autofillForm,
            )!,
          SaveDraftButton(
            stepNumber: 4,
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
              value: 4 / 8,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),

            Text(
              'Step 4 of 8',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),

            Text(
              'Paint & Wheels',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),

            // PAINT SECTION
            Text(
              'Paint',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _colorController,
              labelText: 'Color *',
              hintText: 'e.g., White, Black, Silver',
              onChanged: (value) => provider.setColor(value),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter color' : null,
            ),
            const SizedBox(height: 16),

            // Paint Type
            Text(
              'Paint Type *',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: PaintType.values.map((type) {
                final isSelected = provider.paintType == type;
                return ChoiceChip(
                  label: Text(type.displayName),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) provider.setPaintType(type);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // WHEELS SECTION
            Text(
              'Wheels & Tires',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CounterInputField(
                    labelText: 'Rim Size',
                    value: provider.rimSize,
                    minValue: 13,
                    maxValue: 24,
                    unitSingular: 'inch',
                    unitPlural: 'inches',
                    onChanged: provider.setRimSize,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<RimType>(
                    initialValue: provider.rimType,
                    decoration: const InputDecoration(
                      labelText: 'Rim Type *',
                      border: OutlineInputBorder(),
                    ),
                    items: RimType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.displayName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) provider.setRimType(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tire Condition
            Text(
              'Tire Condition *',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),

            RadioGroup<TireCondition>(
              groupValue: provider.tireCondition,
              onChanged: (value) {
                if (value != null) provider.setTireCondition(value);
              },
              child: Column(
                children: TireCondition.values.map((condition) {
                  final isSelected = provider.tireCondition == condition;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    color: isSelected
                        ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                        : null,
                    child: RadioListTile<TireCondition>(
                      value: condition,
                    title: Text(
                      condition.displayName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      _getTireConditionDescription(condition),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                );
              }).toList(),
              ),
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
                      'Accurately describing your vehicle\'s exterior helps buyers make informed decisions.',
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
                  provider.validateStep4()) {
                context.push('/listing/create/step5');
              }
            },
          ),
        ),
      ),
    );
  }

  String _getTireConditionDescription(TireCondition condition) {
    switch (condition) {
      case TireCondition.newTires:
        return 'Brand new or recently replaced tires';
      case TireCondition.good:
        return 'Tires in good condition with adequate tread';
      case TireCondition.fair:
        return 'Tires showing some wear but still usable';
      case TireCondition.needsReplacement:
        return 'Tires worn and need replacement soon';
    }
  }
}
