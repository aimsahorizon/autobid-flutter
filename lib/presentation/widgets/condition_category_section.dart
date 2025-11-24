import 'package:flutter/material.dart';
import '../../data/models/vehicle_condition_attribute.dart';
import 'condition_toggle.dart';

/// Widget that renders a category section with grouped condition toggles
///
/// Features:
/// - Category header with icon and name
/// - Visual grouping with Card/Container
/// - Automatic rendering of all attributes in the category
/// - Responsive layout for mobile-first design
class ConditionCategorySection extends StatelessWidget {
  final String categoryName;
  final List<VehicleConditionAttribute> attributes;
  final Function(String id, bool value) onAttributeChanged;

  const ConditionCategorySection({
    super.key,
    required this.categoryName,
    required this.attributes,
    required this.onAttributeChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Don't render empty categories
    if (attributes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ═══════════════════════════════════════════════════════════════
        // CATEGORY HEADER
        // Shows category icon and name for clear visual grouping
        // ═══════════════════════════════════════════════════════════════
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              // Category icon (emoji)
              Text(
                VehicleConditionCategory.getCategoryIcon(categoryName),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 8),

              // Category name
              Expanded(
                child: Text(
                  categoryName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                ),
              ),

              // Badge showing count of active toggles in this category
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getActiveCount() > 0
                      ? Colors.orange.shade50
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getActiveCount() > 0
                        ? Colors.orange.shade300
                        : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  '${_getActiveCount()}/${attributes.length}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _getActiveCount() > 0
                        ? Colors.orange.shade700
                        : Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ═══════════════════════════════════════════════════════════════
        // CONDITION TOGGLES
        // Dynamically rendered from attributes list
        // Each toggle is separated by a divider for visual clarity
        // ═══════════════════════════════════════════════════════════════
        Card(
          margin: const EdgeInsets.only(bottom: 24),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: List.generate(
                attributes.length * 2 - 1, // Include dividers between toggles
                (index) {
                  // Even indices: Render condition toggle
                  if (index.isEven) {
                    final attributeIndex = index ~/ 2;
                    final attribute = attributes[attributeIndex];

                    return ConditionToggle(
                      attribute: attribute,
                      onChanged: (value) {
                        // Callback to parent with attribute ID and new value
                        // This allows parent to update both local state and provider
                        onAttributeChanged(attribute.id, value);
                      },
                    );
                  }

                  // Odd indices: Render divider
                  return const ConditionDivider();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Helper method to count how many attributes are toggled ON in this category
  /// Used for the badge display in the header
  int _getActiveCount() {
    return attributes.where((attr) => attr.value).length;
  }
}
