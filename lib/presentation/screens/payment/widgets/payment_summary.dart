import 'package:flutter/material.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/utils/fee_calculator.dart';

class PaymentSummary extends StatelessWidget {
  final double amount;
  final bool showDetails;

  const PaymentSummary({
    super.key,
    required this.amount,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    final breakdown = FeeCalculator.getBreakdown(amount);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Payment Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (showDetails)
                Tooltip(
                  message: 'Platform fee: 3% + ₱50',
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          _buildRow(
            'Winning Bid',
            FeeCalculator.formatCurrency(breakdown['amount']!),
            false,
          ),
          const SizedBox(height: 8),
          _buildRow(
            'Platform Fee',
            FeeCalculator.formatCurrency(breakdown['platformFee']!),
            false,
            subtitle: '3% + ₱50',
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          _buildRow(
            'Total Amount',
            FeeCalculator.formatCurrency(breakdown['total']!),
            true,
          ),
          if (showDetails) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.shield, color: Colors.blue[700], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Payment secured in escrow until delivery confirmation',
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
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, bool isTotal,
      {String? subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? Colors.black87 : Colors.grey[700],
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? ColorConstants.primaryGreen : Colors.black87,
          ),
        ),
      ],
    );
  }
}
