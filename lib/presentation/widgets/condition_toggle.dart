import 'package:flutter/material.dart';
import '../../data/models/vehicle_condition_attribute.dart';

/// Reusable widget for rendering a single condition toggle
///
/// Features:
/// - Large touch target (minimum 48dp height) for mobile accessibility
/// - Clear visual hierarchy with title and subtitle
/// - Color coding for positive (green) vs negative (orange/red) indicators
/// - Immediate state updates with callback
class ConditionToggle extends StatelessWidget {
  final VehicleConditionAttribute attribute;
  final ValueChanged<bool> onChanged;

  const ConditionToggle({
    super.key,
    required this.attribute,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      // Title: Primary label text
      title: Text(
        attribute.label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Subtitle: Descriptive text explaining the condition
      subtitle: Text(
        attribute.description,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey[600],
        ),
      ),

      // Current toggle value
      value: attribute.value,

      // Callback when user toggles the switch
      // Updates local state immediately and syncs with parent form state
      onChanged: onChanged,

      // Remove default padding to control spacing via parent
      contentPadding: EdgeInsets.zero,

      // Color coding based on attribute type
      // Positive attributes (service history, warranty) use green
      // Negative attributes (damage, modifications) use default theme color
      activeColor: attribute.isPositive ? Colors.green : null,

      // Ensure minimum touch target size for accessibility
      // This widget automatically provides 48dp minimum height
    );
  }
}

/// Widget that renders a divider between condition toggles
/// Provides consistent spacing and visual separation
class ConditionDivider extends StatelessWidget {
  const ConditionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[300],
    );
  }
}
