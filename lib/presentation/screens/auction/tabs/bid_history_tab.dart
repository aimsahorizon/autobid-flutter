import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auction_provider.dart';
import '../widgets/bid_history_item.dart';

class BidHistoryTab extends StatelessWidget {
  final String auctionId;

  const BidHistoryTab({
    super.key,
    required this.auctionId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuctionProvider>(
      builder: (context, provider, child) {
        final bids = provider.bidHistory;

        if (bids.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.gavel,
                  size: 64,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'No bids yet',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Be the first to place a bid!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bids.length,
          itemBuilder: (context, index) {
            final bid = bids[index];
            final isCurrentUser = bid.bidderId == provider.currentUserId;
            final isTopBid = index == 0;
            final rank = index + 1;

            return BidHistoryItem(
              bid: bid,
              isCurrentUser: isCurrentUser,
              isTopBid: isTopBid,
              rank: rank,
            );
          },
        );
      },
    );
  }
}
