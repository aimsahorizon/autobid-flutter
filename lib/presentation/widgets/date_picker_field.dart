import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final String labelText;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? hintText;
  final String? Function(DateTime?)? validator;

  const DatePickerField({
    super.key,
    required this.labelText,
    this.selectedDate,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
    this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(1900),
          lastDate: lastDate ?? DateTime(2100),
        );
        if (date != null) {
          onChanged(date);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
          errorText: validator?.call(selectedDate),
        ),
        child: Text(
          selectedDate != null ? dateFormat.format(selectedDate!) : '',
          style: selectedDate != null
              ? Theme.of(context).textTheme.bodyLarge
              : Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
        ),
      ),
    );
  }
}
