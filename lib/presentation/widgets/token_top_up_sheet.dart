import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:autobid/data/models/token_model.dart';
import 'package:autobid/presentation/providers/token_provider.dart';
import 'package:autobid/presentation/providers/auth_provider.dart';

/// Token Top-Up Bottom Sheet
///
/// Displays token purchase tiers and allows user to buy tokens.
class TokenTopUpSheet extends ConsumerWidget {
  const TokenTopUpSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenBalanceAsync = ref.watch(currentUserTokenBalanceProvider);
    final authState = ref.watch(authStateChangesProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Header with current balance
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Buy Tokens',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  tokenBalanceAsync.when(
                    data: (balance) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.generating_tokens_rounded,
                            size: 20,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$balance',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    loading: () => const SizedBox(),
                    error: (_, __) => const SizedBox(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Use tokens to place bids on auctions (1 token per bid)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              // Purchase tiers
              _buildPurchaseTier(
                context,
                ref,
                authState,
                tier: TokenPurchaseTier.tier100,
                config: TokenPurchaseTierConfig.tier100,
              ),
              const SizedBox(height: 16),
              _buildPurchaseTier(
                context,
                ref,
                authState,
                tier: TokenPurchaseTier.tier500,
                config: TokenPurchaseTierConfig.tier500,
                isRecommended: true,
              ),
              const SizedBox(height: 24),

              // Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Tokens are non-refundable. Unused tokens never expire.',
                        style: TextStyle(
                          fontSize: 13,
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
      ),
    );
  }

  Widget _buildPurchaseTier(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<dynamic> authState, {
    required TokenPurchaseTier tier,
    required TokenPurchaseTierConfig config,
    bool isRecommended = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isRecommended ? Colors.green : Colors.grey[300]!,
          width: isRecommended ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(16),
        color: isRecommended ? Colors.green[50] : Colors.white,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          config.displayName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (config.hasBonus)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              config.bonusText,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      '₱${config.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  config.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _handlePurchase(context, ref, authState, tier),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isRecommended ? Colors.green : null,
                      foregroundColor: isRecommended ? Colors.white : null,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Purchase',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isRecommended)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Best Value',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<Map<String, String>?> _showPaymentMethodDialog(BuildContext context, TokenPurchaseTierConfig config) async {
    String? selectedMethod;
    String? reference;

    final result = await showDialog<Map<String, String>?>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Select Payment Method'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Amount: ₱${config.price.toStringAsFixed(0)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                _buildPaymentOption(context, 'gcash', 'GCash', Icons.account_balance_wallet, Colors.blue, selectedMethod, (method) async {
                  setState(() => selectedMethod = method);
                  final ref = await _showGCashPayment(context, config.price);
                  setState(() => reference = ref);
                }),
                const SizedBox(height: 12),
                _buildPaymentOption(context, 'paymaya', 'Maya', Icons.account_balance_wallet_outlined, Colors.green, selectedMethod, (method) async {
                  setState(() => selectedMethod = method);
                  final ref = await _showMayaPayment(context, config.price);
                  setState(() => reference = ref);
                }),
                const SizedBox(height: 12),
                _buildPaymentOption(context, 'card', 'Credit/Debit Card', Icons.credit_card, Colors.purple, selectedMethod, (method) async {
                  setState(() => selectedMethod = method);
                  final ref = await _showCardPayment(context, config.price);
                  setState(() => reference = ref);
                }),
                if (reference != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(child: Text('Ref: $reference', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: reference != null ? () => Navigator.pop(context, {'method': selectedMethod!, 'reference': reference!}) : null,
              child: const Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );

    return result;
  }

  Widget _buildPaymentOption(BuildContext context, String id, String name, IconData icon, Color color, String? selected, Function(String) onTap) {
    final isSelected = selected == id;
    return InkWell(
      onTap: () => onTap(id),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? color : Colors.grey[300]!, width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? color.withOpacity(0.05) : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16))),
            if (isSelected) Icon(Icons.check_circle, color: color),
          ],
        ),
      ),
    );
  }

  Future<String?> _showGCashPayment(BuildContext context, double amount) async {
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
                  Text('Amount: ₱${amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
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

  Future<String?> _showMayaPayment(BuildContext context, double amount) async {
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
                  Text('Amount: ₱${amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
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

  Future<String?> _showCardPayment(BuildContext context, double amount) async {
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
                        Text('₱${amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple)),
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

  void _handlePurchase(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<dynamic> authState,
    TokenPurchaseTier tier,
  ) async {
    authState.when(
      data: (user) async {
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please log in to purchase tokens')),
          );
          return;
        }

        final config = TokenPurchaseTierConfig.forTier(tier);

        // Show payment method selection
        final paymentData = await _showPaymentMethodDialog(context, config);

        if (paymentData != null && context.mounted) {
          try {
            // Call purchase action
            final tokenActions = ref.read(tokenActionsProvider.notifier);
            await tokenActions.purchaseTokens(
              userId: user.id,
              tier: tier,
            );

            if (context.mounted) {
              // Close bottom sheet
              context.pop();

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Successfully purchased ${TokenPurchaseTierConfig.forTier(tier).totalTokens} tokens!',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to purchase tokens: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
      },
      loading: () {},
      error: (_, __) {},
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
