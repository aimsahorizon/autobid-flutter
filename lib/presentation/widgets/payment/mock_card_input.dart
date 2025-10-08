import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/color_constants.dart';

class MockCardInput extends StatefulWidget {
  final Function(CardDetails) onCardDetailsChanged;
  final bool enabled;

  const MockCardInput({
    super.key,
    required this.onCardDetailsChanged,
    this.enabled = true,
  });

  @override
  State<MockCardInput> createState() => _MockCardInputState();
}

class _MockCardInputState extends State<MockCardInput> {
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();
  final _nameController = TextEditingController();

  final _cardNumberFocus = FocusNode();
  final _expiryFocus = FocusNode();
  final _cvcFocus = FocusNode();
  final _nameFocus = FocusNode();

  String _cardType = 'unknown';
  bool _isCardNumberValid = false;
  bool _isExpiryValid = false;
  bool _isCvcValid = false;
  bool _isNameValid = false;

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_onCardNumberChanged);
    _expiryController.addListener(_onExpiryChanged);
    _cvcController.addListener(_onCvcChanged);
    _nameController.addListener(_onNameChanged);
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    _nameController.dispose();
    _cardNumberFocus.dispose();
    _expiryFocus.dispose();
    _cvcFocus.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  void _onCardNumberChanged() {
    final text = _cardNumberController.text.replaceAll(' ', '');
    _cardType = _detectCardType(text);
    _isCardNumberValid = _validateCardNumber(text);
    _notifyChanges();
  }

  void _onExpiryChanged() {
    _isExpiryValid = _validateExpiry(_expiryController.text);
    _notifyChanges();
  }

  void _onCvcChanged() {
    _isCvcValid = _validateCvc(_cvcController.text);
    _notifyChanges();
  }

  void _onNameChanged() {
    _isNameValid = _nameController.text.trim().length >= 3;
    _notifyChanges();
  }

  void _notifyChanges() {
    widget.onCardDetailsChanged(CardDetails(
      cardNumber: _cardNumberController.text.replaceAll(' ', ''),
      expiry: _expiryController.text,
      cvc: _cvcController.text,
      cardholderName: _nameController.text,
      cardType: _cardType,
      isValid: _isCardNumberValid && _isExpiryValid && _isCvcValid && _isNameValid,
    ));
    setState(() {});
  }

  String _detectCardType(String number) {
    if (number.startsWith('4')) return 'visa';
    if (number.startsWith('5')) return 'mastercard';
    if (number.startsWith('3')) return 'amex';
    return 'unknown';
  }

  bool _validateCardNumber(String number) {
    if (number.length < 13 || number.length > 19) return false;

    // Luhn algorithm
    int sum = 0;
    bool alternate = false;
    for (int i = number.length - 1; i >= 0; i--) {
      int digit = int.parse(number[i]);
      if (alternate) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      alternate = !alternate;
    }
    return (sum % 10 == 0);
  }

  bool _validateExpiry(String expiry) {
    if (expiry.length != 5) return false;
    final parts = expiry.split('/');
    if (parts.length != 2) return false;

    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) return false;
    if (month < 1 || month > 12) return false;

    final now = DateTime.now();
    final expiryDate = DateTime(2000 + year, month);
    return expiryDate.isAfter(now);
  }

  bool _validateCvc(String cvc) {
    return cvc.length >= 3 && cvc.length <= 4;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Number
          _buildLabel('Card number'),
          const SizedBox(height: 8),
          _buildCardNumberField(),
          const SizedBox(height: 16),

          // Expiry and CVC Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Expiry'),
                    const SizedBox(height: 8),
                    _buildExpiryField(),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('CVC'),
                    const SizedBox(height: 8),
                    _buildCvcField(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Cardholder Name
          _buildLabel('Cardholder name'),
          const SizedBox(height: 8),
          _buildNameField(),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildCardNumberField() {
    return TextField(
      controller: _cardNumberController,
      focusNode: _cardNumberFocus,
      enabled: widget.enabled,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        _CardNumberFormatter(),
      ],
      decoration: InputDecoration(
        hintText: '1234 1234 1234 1234',
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorConstants.primaryGreen, width: 2),
        ),
        suffixIcon: _buildCardIcon(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      onChanged: (value) {
        if (value.replaceAll(' ', '').length == 16) {
          _expiryFocus.requestFocus();
        }
      },
    );
  }

  Widget _buildExpiryField() {
    return TextField(
      controller: _expiryController,
      focusNode: _expiryFocus,
      enabled: widget.enabled,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        _ExpiryDateFormatter(),
      ],
      decoration: InputDecoration(
        hintText: 'MM/YY',
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorConstants.primaryGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      onChanged: (value) {
        if (value.length == 5) {
          _cvcFocus.requestFocus();
        }
      },
    );
  }

  Widget _buildCvcField() {
    return TextField(
      controller: _cvcController,
      focusNode: _cvcFocus,
      enabled: widget.enabled,
      keyboardType: TextInputType.number,
      obscureText: true,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      decoration: InputDecoration(
        hintText: '123',
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorConstants.primaryGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      onChanged: (value) {
        if (value.length >= 3) {
          _nameFocus.requestFocus();
        }
      },
    );
  }

  Widget _buildNameField() {
    return TextField(
      controller: _nameController,
      focusNode: _nameFocus,
      enabled: widget.enabled,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: 'Full name on card',
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorConstants.primaryGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildCardIcon() {
    IconData icon;
    Color color;

    switch (_cardType) {
      case 'visa':
        icon = Icons.credit_card;
        color = Colors.blue;
        break;
      case 'mastercard':
        icon = Icons.credit_card;
        color = Colors.orange;
        break;
      case 'amex':
        icon = Icons.credit_card;
        color = Colors.blue[900]!;
        break;
      default:
        icon = Icons.credit_card;
        color = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Icon(icon, color: color),
    );
  }
}

// Card Details Model
class CardDetails {
  final String cardNumber;
  final String expiry;
  final String cvc;
  final String cardholderName;
  final String cardType;
  final bool isValid;

  CardDetails({
    required this.cardNumber,
    required this.expiry,
    required this.cvc,
    required this.cardholderName,
    required this.cardType,
    required this.isValid,
  });
}

// Card Number Formatter
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i + 1 != text.length) {
        buffer.write(' ');
      }
    }

    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

// Expiry Date Formatter
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.length >= 2 && !text.contains('/')) {
      return TextEditingValue(
        text: '${text.substring(0, 2)}/${text.substring(2)}',
        selection: TextSelection.collapsed(offset: text.length + 1),
      );
    }

    return newValue;
  }
}
