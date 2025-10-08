import 'package:flutter/material.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/escrow_statuses.dart';
import '../../../../data/models/transaction_model.dart';
import '../../../../core/utils/escrow_rules.dart';

class EscrowStatusCard extends StatelessWidget {
  final Transaction transaction;

  const EscrowStatusCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final statusInfo = EscrowStatuses.getInfo(transaction.escrowStatus);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: statusInfo.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusInfo.color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(statusInfo.icon, color: statusInfo.color, size: 24),
              const SizedBox(width: 12),
              Text(
                statusInfo.displayName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: statusInfo.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            statusInfo.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 16),
          _buildTimeline(),
          if (transaction.escrowStatus == EscrowStatus.held &&
              transaction.paidAt != null) ...[
            const SizedBox(height: 16),
            _buildAutoReleaseInfo(),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final statuses = [
      EscrowStatus.pending,
      EscrowStatus.held,
      EscrowStatus.released,
    ];

    return Row(
      children: List.generate(statuses.length * 2 - 1, (index) {
        if (index.isOdd) {
          // Line
          final statusIndex = index ~/ 2;
          final isCompleted = _isStatusCompleted(statuses[statusIndex]);
          return Expanded(
            child: Container(
              height: 2,
              color: isCompleted
                  ? ColorConstants.primaryGreen
                  : Colors.grey[300],
            ),
          );
        } else {
          // Dot
          final statusIndex = index ~/ 2;
          final status = statuses[statusIndex];
          final isCompleted = _isStatusCompleted(status);
          final isCurrent = status == transaction.escrowStatus;

          return Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isCompleted || isCurrent
                  ? ColorConstants.primaryGreen
                  : Colors.grey[300],
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
            ),
            child: isCurrent
                ? const Icon(Icons.circle, color: Colors.white, size: 12)
                : (isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null),
          );
        }
      }),
    );
  }

  bool _isStatusCompleted(EscrowStatus status) {
    final currentIndex = _getStatusIndex(transaction.escrowStatus);
    final statusIndex = _getStatusIndex(status);
    return statusIndex < currentIndex;
  }

  int _getStatusIndex(EscrowStatus status) {
    switch (status) {
      case EscrowStatus.pending:
        return 0;
      case EscrowStatus.held:
        return 1;
      case EscrowStatus.released:
        return 2;
      default:
        return 0;
    }
  }

  Widget _buildAutoReleaseInfo() {
    final daysLeft = EscrowRules.daysUntilAutoRelease(transaction.paidAt!);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Auto-release in $daysLeft days if no issues reported',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
