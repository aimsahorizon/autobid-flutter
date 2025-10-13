import 'package:flutter/material.dart';

/// A dropdown that allows users to select from existing options or create new ones
/// by typing. Supports both enum values and custom string values.
class CreatableDropdown<T> extends StatefulWidget {
  final String labelText;
  final String hintText;
  final T? selectedValue;
  final String? selectedCustomValue;
  final List<T> enumValues;
  final List<String> customValues;
  final String Function(T) getDisplayName;
  final void Function(T?) onEnumSelected;
  final void Function(String?) onCustomSelected;
  final void Function(String) onAddCustomValue;
  final String? Function(dynamic)? validator;
  final int maxLength;

  const CreatableDropdown({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.selectedValue,
    required this.selectedCustomValue,
    required this.enumValues,
    required this.customValues,
    required this.getDisplayName,
    required this.onEnumSelected,
    required this.onCustomSelected,
    required this.onAddCustomValue,
    this.validator,
    this.maxLength = 30,
  });

  @override
  State<CreatableDropdown<T>> createState() => _CreatableDropdownState<T>();
}

class _CreatableDropdownState<T> extends State<CreatableDropdown<T>> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isExpanded = false;

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String get _currentDisplayValue {
    if (widget.selectedCustomValue != null) {
      return widget.selectedCustomValue!;
    }
    if (widget.selectedValue != null) {
      return widget.getDisplayName(widget.selectedValue as T);
    }
    return '';
  }

  List<String> get _allExistingValues {
    final enumNames = widget.enumValues.map((e) => widget.getDisplayName(e).toLowerCase()).toList();
    final customNames = widget.customValues.map((s) => s.toLowerCase()).toList();
    return [...enumNames, ...customNames];
  }

  bool _isDuplicate(String value) {
    return _allExistingValues.contains(value.trim().toLowerCase());
  }

  void _handleSelection(dynamic value, bool isCustom) {
    if (isCustom) {
      widget.onEnumSelected(null);
      widget.onCustomSelected(value as String);
    } else {
      widget.onCustomSelected(null);
      widget.onEnumSelected(value as T);
    }
    setState(() {
      _isExpanded = false;
      _searchController.clear();
    });
    _focusNode.unfocus();
  }

  void _handleAddNew(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || _isDuplicate(trimmed)) return;

    widget.onAddCustomValue(trimmed);
    widget.onEnumSelected(null);
    widget.onCustomSelected(trimmed);

    setState(() {
      _isExpanded = false;
      _searchController.clear();
    });
    _focusNode.unfocus();
  }

  List<Widget> _buildFilteredOptions() {
    final query = _searchController.text.toLowerCase();
    final widgets = <Widget>[];

    // Filter enum values
    final filteredEnums = widget.enumValues.where((e) {
      return widget.getDisplayName(e).toLowerCase().contains(query);
    }).toList();

    for (var enumValue in filteredEnums) {
      final isSelected = widget.selectedValue == enumValue;
      widgets.add(
        InkWell(
          onTap: () => _handleSelection(enumValue, false),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.getDisplayName(enumValue),
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? Theme.of(context).primaryColor : null,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check, color: Theme.of(context).primaryColor, size: 20),
              ],
            ),
          ),
        ),
      );
    }

    // Filter custom values
    final filteredCustom = widget.customValues.where((s) {
      return s.toLowerCase().contains(query);
    }).toList();

    if (filteredCustom.isNotEmpty && filteredEnums.isNotEmpty) {
      widgets.add(const Divider(height: 1));
    }

    for (var customValue in filteredCustom) {
      final isSelected = widget.selectedCustomValue == customValue;
      widgets.add(
        InkWell(
          onTap: () => _handleSelection(customValue, true),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    customValue,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? Theme.of(context).primaryColor : null,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check, color: Theme.of(context).primaryColor, size: 20),
              ],
            ),
          ),
        ),
      );
    }

    // Show "Add new" option if search text is not empty and not duplicate
    if (_searchController.text.trim().isNotEmpty &&
        !_isDuplicate(_searchController.text)) {
      if (widgets.isNotEmpty) {
        widgets.add(const Divider(height: 1));
      }
      widgets.add(
        InkWell(
          onTap: () => _handleAddNew(_searchController.text),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.green.withOpacity(0.05),
            child: Row(
              children: [
                Icon(Icons.add_circle_outline,
                     color: Colors.green[700],
                     size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Add '${_searchController.text.trim()}'",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
            if (_isExpanded) {
              _focusNode.requestFocus();
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              border: const OutlineInputBorder(),
              suffixIcon: Icon(_isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              errorText: widget.validator?.call(_currentDisplayValue.isEmpty ? null : _currentDisplayValue),
            ),
            child: Text(
              _currentDisplayValue.isEmpty ? widget.hintText : _currentDisplayValue,
              style: TextStyle(
                color: _currentDisplayValue.isEmpty
                    ? Theme.of(context).hintColor
                    : Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 8),
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      maxLength: widget.maxLength,
                      decoration: InputDecoration(
                        hintText: 'Search or type to add...',
                        prefixIcon: const Icon(Icons.search, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        counterText: '',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: _buildFilteredOptions(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
