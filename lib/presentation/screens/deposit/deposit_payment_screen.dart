import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/bidding_deposit.dart';
import '../../providers/deposit_provider.dart';
import '../../providers/auth_provider.dart';

class DepositPaymentScreen extends ConsumerStatefulWidget {
  const DepositPaymentScreen({super.key});

  @override
  ConsumerState<DepositPaymentScreen> createState() => _DepositPaymentScreenState();
}

class _DepositPaymentScreenState extends ConsumerState<DepositPaymentScreen> {
  String? _selectedPaymentMethod;
  final _referenceController = TextEditingController();
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _payMongoMethods = [
    {
      'id': 'gcash',
      'name': 'GCash',
      'icon': Icons.account_balance_wallet,
      'color': Colors.blue,
      'description': 'Pay via GCash mobile wallet',
    },
    {
      'id': 'paymaya',
      'name': 'Maya',
      'icon': Icons.account_balance_wallet_outlined,
      'color': Colors.green,
      'description': 'Pay via Maya mobile wallet',
    },
    {
      'id': 'card',
      'name': 'Credit/Debit Card',
      'icon': Icons.credit_card,
      'color': Colors.purple,
      'description': 'Visa, Mastercard, JCB',
    },
  ];

  @override
  void dispose() {
    _referenceController.dispose();
    super.dispose();
  }

  Future<void> _showMockPaymentUI(String method) async {
    String? reference;

    if (method == 'gcash') {
      reference = await _showGCashPayment();
    } else if (method == 'paymaya') {
      reference = await _showMayaPayment();
    } else if (method == 'card') {
      reference = await _showCardPayment();
    }

    if (reference != null) {
      setState(() {
        _referenceController.text = reference!;
      });
    }
  }

  Future<String?> _showGCashPayment() async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.account_balance_wallet, color: Colors.blue),
            const SizedBox(width: 12),
            const Text('GCash Payment'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.qr_code_2, size: 120, color: Colors.blue.shade700),
                  const SizedBox(height: 16),
                  Text('Scan QR Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Amount: ₱10,000.00', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('Open GCash app and scan to pay', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final ref = 'GCASH${DateTime.now().millisecondsSinceEpoch}';
              Navigator.pop(context, ref);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('I\'ve Paid'),
          ),
        ],
      ),
    );
  }

  Future<String?> _showMayaPayment() async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.account_balance_wallet_outlined, color: Colors.green),
            const SizedBox(width: 12),
            const Text('Maya Payment'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.qr_code_2, size: 120, color: Colors.green.shade700),
                  const SizedBox(height: 16),
                  Text('Scan QR Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Amount: ₱10,000.00', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('Open Maya app and scan to pay', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final ref = 'MAYA${DateTime.now().millisecondsSinceEpoch}';
              Navigator.pop(context, ref);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('I\'ve Paid'),
          ),
        ],
      ),
    );
  }

  Future<String?> _showCardPayment() async {
    final cardController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();
    bool isFormValid = false;

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          void validateForm() {
            final cardNumber = cardController.text.replaceAll(' ', '');
            final expiry = expiryController.text;
            final cvv = cvvController.text;

            // Validate card number (16 digits)
            final isCardValid = cardNumber.length == 16 && int.tryParse(cardNumber) != null;

            // Validate expiry (MM/YY format and valid month)
            final isExpiryValid = expiry.length == 5 && expiry.contains('/');
            bool isExpiryDateValid = false;
            if (isExpiryValid) {
              final parts = expiry.split('/');
              if (parts.length == 2) {
                final month = int.tryParse(parts[0]);
                final year = int.tryParse(parts[1]);
                if (month != null && year != null && month >= 1 && month <= 12) {
                  final now = DateTime.now();
                  final expiryYear = 2000 + year;
                  final expiryDate = DateTime(expiryYear, month);
                  isExpiryDateValid = expiryDate.isAfter(now);
                }
              }
            }

            // Validate CVV (3 digits)
            final isCvvValid = cvv.length == 3 && int.tryParse(cvv) != null;

            setState(() {
              isFormValid = isCardValid && isExpiryDateValid && isCvvValid;
            });
          }

          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.credit_card, color: Colors.purple),
                const SizedBox(width: 12),
                const Text('Card Payment'),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: cardController,
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      hintText: '1234 5678 9012 3456',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      counterText: '',
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 19,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      _CardNumberFormatter(),
                    ],
                    onChanged: (_) => validateForm(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: expiryController,
                          decoration: InputDecoration(
                            labelText: 'Expiry',
                            hintText: 'MM/YY',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            counterText: '',
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 5,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            _ExpiryDateFormatter(),
                          ],
                          onChanged: (_) => validateForm(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: cvvController,
                          decoration: InputDecoration(
                            labelText: 'CVV',
                            hintText: '123',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            counterText: '',
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          obscureText: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (_) => validateForm(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Amount: ', style: TextStyle(fontSize: 14)),
                        Text('₱10,000.00', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple)),
                      ],
                    ),
                  ),
                  if (!isFormValid && (cardController.text.isNotEmpty || expiryController.text.isNotEmpty || cvvController.text.isNotEmpty)) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, size: 16, color: Colors.red.shade700),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Please fill all fields correctly',
                              style: TextStyle(fontSize: 12, color: Colors.red.shade900),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  cardController.dispose();
                  expiryController.dispose();
                  cvvController.dispose();
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: isFormValid ? () {
                  final ref = 'CARD${DateTime.now().millisecondsSinceEpoch}';
                  Navigator.pop(context, ref);
                } : null,
                style: FilledButton.styleFrom(backgroundColor: Colors.purple),
                child: const Text('Pay Now'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _processPayment() async {
    if (_selectedPaymentMethod == null) {
      _showError('Please select a payment method');
      return;
    }

    if (_referenceController.text.trim().isEmpty) {
      _showError('Please enter payment reference number');
      return;
    }

    // Read user and provider BEFORE any async operations
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      _showError('User not authenticated');
      return;
    }

    // Read provider notifier BEFORE setState and async operations
    final depositActions = ref.read(depositActionsProvider.notifier);

    setState(() => _isProcessing = true);

    try {
      // Step 1: Create pending deposit
      final deposit = await depositActions.createDeposit(userId: currentUser.id);

      // Check if widget is still mounted after async operation
      if (!mounted) return;

      // Step 2: Simulate PayMongo payment processing (2 seconds)
      await Future.delayed(const Duration(seconds: 2));

      // Check if widget is still mounted after delay
      if (!mounted) return;

      // Step 3: Complete payment
      await depositActions.payDeposit(
        depositId: deposit.id,
        paymentMethod: _selectedPaymentMethod!,
        paymentReference: _referenceController.text.trim(),
      );

      // Step 4: Show success and navigate back
      if (mounted) {
        _showSuccess();
      }
    } catch (e) {
      if (mounted) {
        _showError(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle,
            size: 64,
            color: Colors.green.shade600,
          ),
        ),
        title: const Text('Payment Successful!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Your deposit of ₱10,000 has been confirmed.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'You can now place bids on auctions!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              context.pop(); // Go back to auction
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Start Bidding'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Deposit'),
        centerTitle: true,
      ),
      body: _isProcessing
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    'Processing payment via PayMongo...',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please wait',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount Card
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.account_balance_wallet, color: Colors.green),
                              const SizedBox(width: 12),
                              Text(
                                'Deposit Amount',
                                style: theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '₱10,000',
                            style: theme.textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle, size: 16, color: Colors.green),
                                const SizedBox(width: 8),
                                Text(
                                  '100% Refundable',
                                  style: TextStyle(
                                    color: Colors.green.shade900,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Payment Method Section
                  Text(
                    'Select Payment Method',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/paymongo-logo.png',
                        height: 20,
                        errorBuilder: (context, error, stackTrace) =>
                            const Text('Powered by PayMongo', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Payment Methods
                  ..._payMongoMethods.map((method) {
                    final isSelected = _selectedPaymentMethod == method['id'];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            _selectedPaymentMethod = method['id'];
                          });
                          await _showMockPaymentUI(method['id']);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? method['color'] : Colors.grey[300]!,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: isSelected ? method['color'].withOpacity(0.05) : null,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: method['color'].withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  method['icon'],
                                  color: method['color'],
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      method['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      method['description'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check_circle, color: method['color']),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 24),

                  // Payment Reference Display
                  Text(
                    'Payment Reference',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _referenceController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Reference Number',
                      hintText: 'Generated after payment',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.numbers),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Reference number will be auto-generated after completing payment',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _processPayment,
                      icon: const Icon(Icons.payment),
                      label: const Text(
                        'Confirm Payment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Security Note
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.security, color: Colors.blue[700], size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Secured by PayMongo. Your payment information is encrypted and protected.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

/// Custom formatter for credit card number (adds space every 4 digits)
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue;
    }

    // Remove all spaces
    final digitsOnly = text.replaceAll(' ', '');

    // Limit to 16 digits
    if (digitsOnly.length > 16) {
      return oldValue;
    }

    // Add space every 4 digits
    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(digitsOnly[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Custom formatter for expiry date (auto-formats to MM/YY)
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue;
    }

    // Remove all slashes
    final digitsOnly = text.replaceAll('/', '');

    // Limit to 4 digits (MMYY)
    if (digitsOnly.length > 4) {
      return oldValue;
    }

    // Auto-format to MM/YY
    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(digitsOnly[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
