import '../models/vehicle_condition_attribute.dart';

/// Mock service for fetching vehicle condition attributes
/// In production, this would call a real API endpoint
class MockVehicleConditionsService {
  /// Simulates API call to fetch vehicle condition attributes
  /// Returns a list of condition attributes grouped by category
  static Future<List<VehicleConditionAttribute>> fetchConditionAttributes() async {
    // Simulate network delay (500ms)
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock dataset: All condition attributes with categories
    // NEW ATTRIBUTES can be added here and will automatically render in the UI
    return [
      // ═══════════════════════════════════════════════════════════════
      // SERVICE CATEGORY
      // ═══════════════════════════════════════════════════════════════
      const VehicleConditionAttribute(
        id: 'serviceHistoryComplete',
        label: 'Complete Service History',
        description: 'All maintenance records available',
        category: VehicleConditionCategory.service,
        isPositive: true,
        sortOrder: 1,
      ),
      const VehicleConditionAttribute(
        id: 'warrantyRemaining',
        label: 'Warranty Remaining',
        description: 'Factory or extended warranty still active',
        category: VehicleConditionCategory.warranty,
        isPositive: true,
        sortOrder: 1,
      ),

      // ═══════════════════════════════════════════════════════════════
      // DAMAGE CATEGORY
      // ═══════════════════════════════════════════════════════════════
      const VehicleConditionAttribute(
        id: 'hasAccidentHistory',
        label: 'Has Accident History',
        description: 'Vehicle has been involved in an accident',
        category: VehicleConditionCategory.damage,
        isPositive: false,
        sortOrder: 1,
      ),
      const VehicleConditionAttribute(
        id: 'floodDamage',
        label: 'Flood Damage',
        description: 'Vehicle has flood/water damage',
        category: VehicleConditionCategory.damage,
        isPositive: false,
        sortOrder: 2,
      ),
      const VehicleConditionAttribute(
        id: 'fireDamage',
        label: 'Fire Damage',
        description: 'Vehicle has fire damage',
        category: VehicleConditionCategory.damage,
        isPositive: false,
        sortOrder: 3,
      ),
      const VehicleConditionAttribute(
        id: 'frameDamage',
        label: 'Structural/Frame Damage',
        description: 'Chassis or frame has been repaired or damaged',
        category: VehicleConditionCategory.damage,
        isPositive: false,
        sortOrder: 4,
      ),

      // ═══════════════════════════════════════════════════════════════
      // BODY & MODIFICATIONS CATEGORY
      // ═══════════════════════════════════════════════════════════════
      const VehicleConditionAttribute(
        id: 'isRepainted',
        label: 'Repainted',
        description: 'Vehicle has been repainted (full or partial)',
        category: VehicleConditionCategory.bodyAndModifications,
        isPositive: false,
        sortOrder: 1,
      ),
      const VehicleConditionAttribute(
        id: 'hasModifications',
        label: 'Modified/Aftermarket Parts',
        description: 'Has performance or cosmetic modifications',
        category: VehicleConditionCategory.bodyAndModifications,
        isPositive: false,
        sortOrder: 2,
      ),
      const VehicleConditionAttribute(
        id: 'originalParts',
        label: 'Original Parts',
        description: 'All major parts are original from manufacturer',
        category: VehicleConditionCategory.bodyAndModifications,
        isPositive: true,
        sortOrder: 3,
      ),

      // ═══════════════════════════════════════════════════════════════
      // USAGE CATEGORY
      // ═══════════════════════════════════════════════════════════════
      const VehicleConditionAttribute(
        id: 'commercialUse',
        label: 'Taxi/Rental/Fleet Use',
        description: 'Previously used as taxi, rental, or fleet vehicle',
        category: VehicleConditionCategory.usage,
        isPositive: false,
        sortOrder: 1,
      ),
      const VehicleConditionAttribute(
        id: 'smokerVehicle',
        label: 'Smoker Vehicle',
        description: 'Vehicle was regularly smoked in',
        category: VehicleConditionCategory.usage,
        isPositive: false,
        sortOrder: 2,
      ),

      // ═══════════════════════════════════════════════════════════════
      // FUTURE EXPANSION: Add new attributes here
      // Example:
      // const VehicleConditionAttribute(
      //   id: 'rustDamage',
      //   label: 'Rust Damage',
      //   description: 'Visible rust on body or undercarriage',
      //   category: VehicleConditionCategory.damage,
      //   isPositive: false,
      //   sortOrder: 5,
      // ),
      // ═══════════════════════════════════════════════════════════════
    ];
  }

  /// Simulates saving condition attributes (returns success/failure)
  static Future<bool> saveConditionAttributes(
    List<VehicleConditionAttribute> attributes,
  ) async {
    // Simulate API save delay (300ms)
    await Future.delayed(const Duration(milliseconds: 300));

    // Mock success response
    return true;
  }

  /// Group attributes by category for rendering
  static Map<String, List<VehicleConditionAttribute>> groupByCategory(
    List<VehicleConditionAttribute> attributes,
  ) {
    final Map<String, List<VehicleConditionAttribute>> grouped = {};

    for (final attribute in attributes) {
      if (!grouped.containsKey(attribute.category)) {
        grouped[attribute.category] = [];
      }
      grouped[attribute.category]!.add(attribute);
    }

    // Sort attributes within each category by sortOrder
    for (final category in grouped.keys) {
      grouped[category]!.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    }

    return grouped;
  }
}
