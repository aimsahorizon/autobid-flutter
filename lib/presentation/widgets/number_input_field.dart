import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final int? initialValue;
  final double? initialDoubleValue;
  final String? suffixText;
  final String? prefixText;
  final bool allowDecimal;
  final int? minValue;
  final int? maxValue;
  final ValueChanged<int?>? onChanged;
  final ValueChanged<double?>? onDoubleChanged;
  final String? Function(String?)? validator;

  const NumberInputField({
    super.key,
    required this.labelText,
    this.hintText,
    this.initialValue,
    this.initialDoubleValue,
    this.suffixText,
    this.prefixText,
    this.allowDecimal = false,
    this.minValue,
    this.maxValue,
    this.onChanged,
    this.onDoubleChanged,
    this.validator,
  });

  @override
  State<NumberInputField> createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue?.toString() ??
            widget.initialDoubleValue?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.numberWithOptions(decimal: widget.allowDecimal),
      inputFormatters: [
        if (widget.allowDecimal)
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
        else
          FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixText: widget.suffixText,
        prefixText: widget.prefixText,
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        if (widget.allowDecimal && widget.onDoubleChanged != null) {
          widget.onDoubleChanged!(double.tryParse(value));
        } else if (widget.onChanged != null) {
          widget.onChanged!(int.tryParse(value));
        }
      },
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${widget.labelText}';
            }
            if (widget.allowDecimal) {
              final doubleValue = double.tryParse(value);
              if (doubleValue == null) {
                return 'Please enter a valid number';
              }
            } else {
              final intValue = int.tryParse(value);
              if (intValue == null) {
                return 'Please enter a valid number';
              }
              if (widget.minValue != null && intValue < widget.minValue!) {
                return 'Minimum value is ${widget.minValue}';
              }
              if (widget.maxValue != null && intValue > widget.maxValue!) {
                return 'Maximum value is ${widget.maxValue}';
              }
            }
            return null;
          },
    );
  }
}
