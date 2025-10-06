import 'package:flutter/material.dart';
import '../../../../data/models/bid_model.dart';
import '../../../../core/utils/time_formatter.dart';

class BidHistoryItem extends StatelessWidget {
  final Bid bid;
  final bool isCurrentUser;
  final bool isTopBid;
  final int? rank;

  const BidHistoryItem({
    super.key,
    required this.bid,
    this.isCurrentUser = false,
    this.isTopBid = false,
    this.rank,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayName = _getDisplayName();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
            : Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentUser
              ? theme.colorScheme.primary.withValues(alpha: 0.3)
              : Colors.grey.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          if (isTopBid)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.emoji_events,
                size: 20,
                color: Colors.white,
              ),
            )
          else if (rank != null && rank! <= 3)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '#$rank',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          else
            SizedBox(width: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      displayName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                    if (isCurrentUser) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'YOU',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    if (bid.isAutoBid) ...[
                      const SizedBox(width: 4),
                      Tooltip(
                        message: 'Auto-bid',
                        child: Icon(
                          Icons.auto_mode,
                          size: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  TimeFormatter.getRelativeTime(bid.timestamp),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '₱${_formatCurrency(bid.amount)}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isTopBid ? Colors.green : null,
            ),
          ),
        ],
      ),
    );
  }

  String _getDisplayName() {
    if (isCurrentUser) {
      return 'You';
    }

    if (rank != null && rank! > 3) {
      return 'Bidder #$rank';
    }

    return bid.bidderName;
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
