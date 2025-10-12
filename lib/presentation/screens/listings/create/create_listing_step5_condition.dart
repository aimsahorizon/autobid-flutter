import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
import '../../../../data/models/vehicle_condition_attribute.dart';
import '../../../../data/services/mock_vehicle_conditions_service.dart';
import '../../../../core/utils/enum_extensions.dart';
import '../../../../core/utils/dev_autofill.dart';
import '../../../../core/utils/listing_autofill_helpers.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/counter_input_field.dart';
import '../../../widgets/save_draft_button.dart';
import '../../../widgets/condition_category_section.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// REFACTORED STEP 5: DYNAMIC VEHICLE CONDITION & HISTORY
/// ═══════════════════════════════════════════════════════════════════════════
///
/// This is a refactored version of the Vehicle History step that:
/// 1. ✅ Dynamically renders condition toggles from mock API data
/// 2. ✅ Groups toggles by category (Service, Damage, Body & Modifications, Usage)
/// 3. ✅ Updates local state immediately and syncs with parent form provider
/// 4. ✅ Maintains compatibility with existing multi-step form flow
/// 5. ✅ Mobile-first UI with accessibility (large touch targets, clear labels)
/// 6. ✅ Automatically renders new attributes added to mock data (no code changes needed)
/// 7. ✅ Uses reusable components (ConditionToggle, ConditionCategorySection)
/// 8. ✅ Simulates data fetching with loading state
/// 9. ✅ Shows toast/snackbar on save confirmation
///
/// INTEGRATION: Replace Step 5 class with this implementation
/// ═══════════════════════════════════════════════════════════════════════════

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

  // ═══════════════════════════════════════════════════════════════════════════
  // STATE: DYNAMIC CONDITION ATTRIBUTES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Loading state: Shows shimmer/spinner while fetching data
  bool _isLoading = true;

  /// List of all condition attributes fetched from mock API
  List<VehicleConditionAttribute> _attributes = [];

  /// Grouped attributes by category for rendering sections
  Map<String, List<VehicleConditionAttribute>> _groupedAttributes = {};

  // ═══════════════════════════════════════════════════════════════════════════
  // LIFECYCLE: INIT & DISPOSE
  // ═══════════════════════════════════════════════════════════════════════════

  @override
  void initState() {
    super.initState();
    final provider = context.read<ListingProvider>();
    provider.setCurrentStep(5);
    _mileageController.text =
        provider.mileage != null ? provider.mileage.toString() : '';

    // Fetch condition attributes from mock API
    _loadConditionAttributes();
  }

  @override
  void dispose() {
    _mileageController.dispose();
    super.dispose();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DATA FETCHING: MOCK API CALL
  // ═══════════════════════════════════════════════════════════════════════════

  /// Loads condition attributes from mock service
  /// Simulates network delay and shows loading state
  Future<void> _loadConditionAttributes() async {
    setState(() => _isLoading = true);

    try {
      // Fetch attributes from mock API (500ms delay)
      final fetchedAttributes =
          await MockVehicleConditionsService.fetchConditionAttributes();

      // Sync with existing provider state
      // Map provider boolean fields to attribute values
      final syncedAttributes = _syncWithProviderState(fetchedAttributes);

      // Group by category for section rendering
      final grouped =
          MockVehicleConditionsService.groupByCategory(syncedAttributes);

      setState(() {
        _attributes = syncedAttributes;
        _groupedAttributes = grouped;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error (show snackbar in production)
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load conditions: $e')),
        );
      }
    }
  }

  /// Syncs fetched attributes with existing provider state
  /// This ensures continuity if user navigates back to this step
  List<VehicleConditionAttribute> _syncWithProviderState(
    List<VehicleConditionAttribute> attributes,
  ) {
    final provider = context.read<ListingProvider>();

    return attributes.map((attr) {
      // Map attribute ID to provider field and get current value
      final currentValue = _getProviderValue(attr.id, provider);
      return attr.copyWith(value: currentValue);
    }).toList();
  }

  /// Gets current value from provider based on attribute ID
  /// This is the integration point with existing form state
  /// For custom attributes, checks customConditionAttributes map
  bool _getProviderValue(String attributeId, ListingProvider provider) {
    switch (attributeId) {
      case 'serviceHistoryComplete':
        return provider.serviceHistoryComplete;
      case 'hasAccidentHistory':
        return provider.hasAccidentHistory;
      case 'floodDamage':
        return provider.floodDamage;
      case 'fireDamage':
        return provider.fireDamage;
      case 'frameDamage':
        return provider.frameDamage;
      case 'isRepainted':
        return provider.isRepainted;
      case 'hasModifications':
        return provider.hasModifications;
      case 'originalParts':
        return provider.originalParts;
      case 'commercialUse':
        return provider.commercialUse;
      case 'smokerVehicle':
        return provider.smokerVehicle;
      case 'warrantyRemaining':
        return provider.warrantyRemaining;
      default:
        // Custom attributes: check customConditionAttributes map
        return provider.customConditionAttributes[attributeId] ?? false;
    }
  }

  /// Updates provider when attribute value changes
  /// This is the integration point for saving to parent form state
  /// For custom attributes, stores in customConditionAttributes map
  void _updateProviderValue(
    String attributeId,
    bool value,
    ListingProvider provider,
  ) {
    switch (attributeId) {
      case 'serviceHistoryComplete':
        provider.setServiceHistoryComplete(value);
        break;
      case 'hasAccidentHistory':
        provider.setHasAccidentHistory(value);
        break;
      case 'floodDamage':
        provider.setFloodDamage(value);
        break;
      case 'fireDamage':
        provider.setFireDamage(value);
        break;
      case 'frameDamage':
        provider.setFrameDamage(value);
        break;
      case 'isRepainted':
        provider.setIsRepainted(value);
        break;
      case 'hasModifications':
        provider.setHasModifications(value);
        break;
      case 'originalParts':
        provider.setOriginalParts(value);
        break;
      case 'commercialUse':
        provider.setCommercialUse(value);
        break;
      case 'smokerVehicle':
        provider.setSmokerVehicle(value);
        break;
      case 'warrantyRemaining':
        provider.setWarrantyRemaining(value);
        break;
      default:
        // Custom attributes: store in customConditionAttributes map
        provider.setCustomConditionAttribute(attributeId, value);
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // EVENT HANDLERS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Handles toggle change for a condition attribute
  /// Updates both local state and provider state immediately
  void _onAttributeChanged(String attributeId, bool newValue) {
    final provider = context.read<ListingProvider>();

    setState(() {
      // Update local attribute value
      final index = _attributes.indexWhere((attr) => attr.id == attributeId);
      if (index != -1) {
        _attributes[index] = _attributes[index].copyWith(value: newValue);

        // Re-group attributes to update category badges
        _groupedAttributes =
            MockVehicleConditionsService.groupByCategory(_attributes);
      }
    });

    // Sync with provider state (maintains compatibility with existing flow)
    _updateProviderValue(attributeId, newValue, provider);
  }

  /// Autofill helper for dev mode
  void _autofillForm() {
    Step5AutofillHelper.autofill(context, _mileageController);
  }

  /// Handles "Next" button press
  /// Validates form and navigates to next step
  void _onNextPressed() {
    final provider = context.read<ListingProvider>();

    if (_formKey.currentState!.validate() && provider.validateStep5()) {
      // Show success toast confirming changes saved
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              const Text('Vehicle condition saved successfully'),
            ],
          ),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate to next step (preserves existing flow)
      context.push('/listing/create/step6');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select condition and enter mileage'),
        ),
      );
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UI: BUILD METHOD
  // ═══════════════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
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
            // Progress indicator
            LinearProgressIndicator(
              value: 5 / 9,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 24),

            // Step header
            Text(
              'Step 5 of 9',
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

            // ═══════════════════════════════════════════════════════════════
            // OVERALL CONDITION SELECTION (UNCHANGED)
            // ═══════════════════════════════════════════════════════════════
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
                            Radio<CarCondition>(value: condition),
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

            // ═══════════════════════════════════════════════════════════════
            // MILEAGE & OWNERS (UNCHANGED)
            // ═══════════════════════════════════════════════════════════════
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

            // ═══════════════════════════════════════════════════════════════
            // DYNAMIC VEHICLE HISTORY SECTION
            // Replaces hardcoded SwitchListTiles with dynamic rendering
            // ═══════════════════════════════════════════════════════════════

            // Section header
            Text(
              'Vehicle History',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            // Loading state: Show shimmer/spinner while fetching
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              )
            // Data loaded: Render categorized toggles dynamically
            else
              ..._buildCategorySections(),

            const SizedBox(height: 24),

            // Info box (unchanged)
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

      // Bottom navigation (unchanged - preserves existing flow)
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push('/listing/create/step4'),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: CustomButton(
                  text: 'Next',
                  onPressed: _onNextPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UI HELPERS: DYNAMIC SECTION RENDERING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Builds category sections dynamically from grouped attributes
  /// This is where the magic happens: new categories/attributes auto-render!
  List<Widget> _buildCategorySections() {
    final sections = <Widget>[];

    // Iterate through categories in defined order
    for (final category in VehicleConditionCategory.allCategories) {
      final attributes = _groupedAttributes[category];

      // Skip empty categories
      if (attributes == null || attributes.isEmpty) continue;

      // Render category section with all its toggles
      sections.add(
        ConditionCategorySection(
          categoryName: category,
          attributes: attributes,
          onAttributeChanged: _onAttributeChanged,
        ),
      );
    }

    // If no sections rendered, show empty state
    if (sections.isEmpty) {
      return [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              'No condition attributes available',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ),
      ];
    }

    return sections;
  }
}
