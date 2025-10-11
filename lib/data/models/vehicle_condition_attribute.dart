import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_condition_attribute.freezed.dart';
part 'vehicle_condition_attribute.g.dart';

/// Represents a single vehicle condition attribute (e.g., "Has Accident History")
/// This model supports dynamic rendering of condition toggles in the listing form
@freezed
abstract class VehicleConditionAttribute with _$VehicleConditionAttribute {
  const factory VehicleConditionAttribute({
    /// Unique identifier for the attribute (e.g., "hasAccidentHistory")
    required String id,

    /// Display label shown to the user
    required String label,

    /// Descriptive subtitle explaining what this condition means
    required String description,

    /// Category grouping (e.g., "Service", "Damage", "Body & Modifications", "Usage")
    required String category,

    /// Current toggle value (true/false)
    @Default(false) bool value,

    /// Sort order within category (lower = appears first)
    @Default(0) int sortOrder,

    /// Icon identifier for visual representation (optional)
    String? iconData,

    /// Whether this is a positive indicator (green) or negative (orange/red)
    @Default(false) bool isPositive,
  }) = _VehicleConditionAttribute;

  factory VehicleConditionAttribute.fromJson(Map<String, dynamic> json) =>
      _$VehicleConditionAttributeFromJson(json);
}

/// Category grouping for condition attributes
class VehicleConditionCategory {
  static const String service = 'Service';
  static const String damage = 'Damage';
  static const String bodyAndModifications = 'Body & Modifications';
  static const String usage = 'Usage';
  static const String warranty = 'Warranty';

  /// Get all available categories in display order
  static List<String> get allCategories => [
        service,
        damage,
        bodyAndModifications,
        usage,
        warranty,
      ];

  /// Get icon for category
  static String getCategoryIcon(String category) {
    switch (category) {
      case service:
        return '🔧';
      case damage:
        return '⚠️';
      case bodyAndModifications:
        return '🎨';
      case usage:
        return '🚗';
      case warranty:
        return '✅';
      default:
        return '📋';
    }
  }
}
