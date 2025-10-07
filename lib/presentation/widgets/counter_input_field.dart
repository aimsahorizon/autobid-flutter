import 'package:flutter/material.dart';

class CounterInputField extends StatelessWidget {
  final String labelText;
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;
  final String? unitSingular;
  final String? unitPlural;

  const CounterInputField({
    super.key,
    required this.labelText,
    required this.value,
    this.minValue = 1,
    this.maxValue = 100,
    required this.onChanged,
    this.unitSingular,
    this.unitPlural,
  });

  @override
  Widget build(BuildContext context) {
    final hasUnit = unitSingular != null || unitPlural != null;
    final displayUnit = value == 1 ? unitSingular : unitPlural;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              onPressed: value > minValue ? () => onChanged(value - 1) : null,
              icon: const Icon(Icons.remove_circle_outline),
              color: value > minValue ? null : Colors.grey,
            ),
            Text(
              '$value',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            IconButton(
              onPressed: value < maxValue ? () => onChanged(value + 1) : null,
              icon: const Icon(Icons.add_circle_outline),
              color: value < maxValue ? null : Colors.grey,
            ),
            if (hasUnit) ...[
              const SizedBox(width: 8),
              Text(
                displayUnit ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
