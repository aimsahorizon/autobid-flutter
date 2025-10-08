import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestCardsInfo extends StatelessWidget {
  const TestCardsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
              const SizedBox(width: 8),
              Text(
                'Demo Mode - Test Cards',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.blue[900],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Use these test cards for demo purposes:',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 12),
          _buildTestCard(
            context,
            label: 'Success',
            number: '4242 4242 4242 4242',
            icon: Icons.check_circle,
            color: Colors.green,
          ),
          const SizedBox(height: 8),
          _buildTestCard(
            context,
            label: 'Declined',
            number: '4000 0000 0000 0002',
            icon: Icons.cancel,
            color: Colors.red,
          ),
          const SizedBox(height: 8),
          _buildTestCard(
            context,
            label: 'Insufficient',
            number: '4000 0000 0000 9995',
            icon: Icons.warning,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'For all test cards:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[900],
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoRow('Expiry:', 'Any future date (e.g., 12/28)'),
                _buildInfoRow('CVC:', 'Any 3 digits (e.g., 123)'),
                _buildInfoRow('Name:', 'Any name'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestCard(
    BuildContext context, {
    required String label,
    required String number,
    required IconData icon,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: number.replaceAll(' ', '')));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label card copied: $number'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            SizedBox(
              width: 85,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[900],
                ),
              ),
            ),
            Expanded(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.blue[800],
                ),
              ),
            ),
            Icon(
              Icons.copy,
              size: 16,
              color: Colors.blue[600],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
