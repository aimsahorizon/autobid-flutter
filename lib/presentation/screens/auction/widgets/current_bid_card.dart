import 'package:flutter/material.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../data/models/bid_model.dart';

class CurrentBidCard extends StatelessWidget {
  final Auction auction;
  final BidStatus? userBidStatus;
  final double? userBidAmount;

  const CurrentBidCard({
    super.key,
    required this.auction,
    this.userBidStatus,
    this.userBidAmount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reserveMet = auction.currentBid >= auction.reservePrice;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Bid',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                _buildReserveIndicator(reserveMet),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '₱${_formatCurrency(auction.currentBid)}',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${auction.totalBids} ${auction.totalBids == 1 ? 'bid' : 'bids'}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                if (userBidStatus != null) _buildUserStatus(context, userBidStatus!),
              ],
            ),
            if (userBidAmount != null) ...[
              const SizedBox(height: 4),
              Text(
                'Your bid: ₱${_formatCurrency(userBidAmount!)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReserveIndicator(bool met) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: met ? Colors.green.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: met ? Colors.green : Colors.orange,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            met ? Icons.check_circle : Icons.info,
            size: 16,
            color: met ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 4),
          Text(
            met ? 'Reserve Met' : 'Reserve Not Met',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: met ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStatus(BuildContext context, BidStatus status) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case BidStatus.winning:
        color = Colors.green;
        text = 'Winning';
        icon = Icons.emoji_events;
        break;
      case BidStatus.outbid:
        color = Colors.red;
        text = 'Outbid';
        icon = Icons.trending_down;
        break;
      default:
        color = Colors.grey;
        text = 'Not Bidding';
        icon = Icons.remove_circle_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
