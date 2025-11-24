import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/payment_methods.dart';
import '../../../providers/payment_provider.dart';
import '../widgets/payment_method_card.dart';

class PaymentMethodTab extends StatelessWidget {
  const PaymentMethodTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Payment Method',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose how you want to pay for this vehicle',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 24),
              ...PaymentMethods.allMethods.map((method) {
                final isSelected =
                    provider.selectedPaymentMethod?.type == method.type;
                return PaymentMethodCard(
                  method: method,
                  isSelected: isSelected,
                  onTap: () => provider.setSelectedPaymentMethod(method),
                );
              }),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  // Future feature: Add payment method
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add payment method - Coming soon'),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Payment Method'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.shield, color: Colors.blue[700], size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Secure Payment',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'All payments are secured in escrow until you confirm receipt of the vehicle. Your payment is protected.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue[900],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
