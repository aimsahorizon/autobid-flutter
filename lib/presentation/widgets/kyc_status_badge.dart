import 'package:flutter/material.dart';
import '../../data/models/kyc_model.dart';

class KycStatusBadge extends StatelessWidget {
  final KycVerificationStatus status;
  final bool isCompact;

  const KycStatusBadge({
    super.key,
    required this.status,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    IconData icon;
    String label;

    switch (status) {
      case KycVerificationStatus.verified:
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade900;
        icon = Icons.verified;
        label = 'Verified';
        break;
      case KycVerificationStatus.pending:
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade900;
        icon = Icons.pending;
        label = 'Pending';
        break;
      case KycVerificationStatus.rejected:
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade900;
        icon = Icons.cancel;
        label = 'Rejected';
        break;
    }

    if (isCompact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: textColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: textColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
