import 'package:flutter/material.dart';

/// Reusable filter section header
class FilterSectionTitle extends StatelessWidget {
  final String title;
  final int? activeCount;

  const FilterSectionTitle({
    super.key,
    required this.title,
    this.activeCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (activeCount != null && activeCount! > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$activeCount',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Expandable filter section
class FilterSection extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final int? activeCount;

  const FilterSection({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    this.activeCount,
  });

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.activeCount != null && widget.activeCount! > 0)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${widget.activeCount}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
          ],
        ),
        initiallyExpanded: widget.initiallyExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.children,
            ),
          ),
        ],
      ),
    );
  }
}

/// Range slider with labels
class RangeFilterSlider extends StatelessWidget {
  final String label;
  final int minValue;
  final int maxValue;
  final int currentMin;
  final int currentMax;
  final int divisions;
  final String Function(int)? valueFormatter;
  final void Function(int min, int max) onChanged;

  const RangeFilterSlider({
    super.key,
    required this.label,
    required this.minValue,
    required this.maxValue,
    required this.currentMin,
    required this.currentMax,
    required this.onChanged,
    this.divisions = 10,
    this.valueFormatter,
  });

  String _format(int value) {
    if (valueFormatter != null) return valueFormatter!(value);
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: Text(_format(currentMin), style: const TextStyle(fontSize: 12))),
            Expanded(
              flex: 3,
              child: RangeSlider(
                values: RangeValues(currentMin.toDouble(), currentMax.toDouble()),
                min: minValue.toDouble(),
                max: maxValue.toDouble(),
                divisions: divisions,
                labels: RangeLabels(_format(currentMin), _format(currentMax)),
                onChanged: (values) {
                  onChanged(values.start.round(), values.end.round());
                },
              ),
            ),
            Expanded(
              child: Text(
                _format(currentMax),
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Single value slider
class SingleFilterSlider extends StatelessWidget {
  final String label;
  final int minValue;
  final int maxValue;
  final int currentValue;
  final int divisions;
  final String Function(int)? valueFormatter;
  final void Function(int) onChanged;

  const SingleFilterSlider({
    super.key,
    required this.label,
    required this.minValue,
    required this.maxValue,
    required this.currentValue,
    required this.onChanged,
    this.divisions = 10,
    this.valueFormatter,
  });

  String _format(int value) {
    if (valueFormatter != null) return valueFormatter!(value);
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            Text(_format(currentValue), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
        Slider(
          value: currentValue.toDouble(),
          min: minValue.toDouble(),
          max: maxValue.toDouble(),
          divisions: divisions,
          label: _format(currentValue),
          onChanged: (value) => onChanged(value.round()),
        ),
      ],
    );
  }
}

/// Multi-select chip group
class ChipFilterGroup<T> extends StatelessWidget {
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) labelBuilder;
  final void Function(T item, bool selected) onChanged;

  const ChipFilterGroup({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.labelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selectedItems.contains(item);
        return FilterChip(
          label: Text(labelBuilder(item)),
          selected: isSelected,
          onSelected: (selected) => onChanged(item, selected),
        );
      }).toList(),
    );
  }
}

/// Boolean toggle filter
class BooleanFilter extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool value;
  final void Function(bool) onChanged;

  const BooleanFilter({
    super.key,
    required this.label,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(label),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }
}
