import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auction_provider.dart';
import '../widgets/bid_history_item.dart';
import '../widgets/buyer_comment_section.dart';

class BidHistoryTab extends StatelessWidget {
  final String auctionId;
  final bool isSeller;
  final String sellerId;

  const BidHistoryTab({
    super.key,
    required this.auctionId,
    this.isSeller = false,
    required this.sellerId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuctionProvider>(
      builder: (context, provider, child) {
        var bids = provider.bidHistory;

        // Filter out seller's own bids if viewing as seller
        if (isSeller) {
          bids = bids.where((bid) => bid.bidderId != sellerId).toList();
        }

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
                  isSeller ? 'No buyer bids yet' : 'No bids yet',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isSeller
                      ? 'Buyer bids will appear here'
                      : 'Be the first to place a bid!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return _BidHistoryList(
          bids: bids,
          currentUserId: provider.currentUserId,
          isSeller: isSeller,
          auctionId: auctionId,
          sellerId: sellerId,
        );
      },
    );
  }
}

class _BidHistoryList extends StatefulWidget {
  final List bids;
  final String? currentUserId;
  final bool isSeller;
  final String auctionId;
  final String sellerId;

  const _BidHistoryList({
    required this.bids,
    required this.currentUserId,
    this.isSeller = false,
    required this.auctionId,
    required this.sellerId,
  });

  @override
  State<_BidHistoryList> createState() => _BidHistoryListState();
}

class _BidHistoryListState extends State<_BidHistoryList> {
  static const int _initialDisplayCount = 10;
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final displayCount = _showAll ? widget.bids.length : _initialDisplayCount;
    final hasMore = widget.bids.length > _initialDisplayCount;
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Bid items
        ...List.generate(
          displayCount.clamp(0, widget.bids.length),
          (index) {
            final bid = widget.bids[index];
            // IMPORTANT: Sellers should NEVER see "YOU" on any bids
            // because sellers cannot bid on their own auctions
            final isCurrentUser = !widget.isSeller && bid.bidderId == widget.currentUserId;
            final isTopBid = index == 0;
            final rank = index + 1;

            return BidHistoryItem(
              key: ValueKey(bid.id),
              bid: bid,
              isCurrentUser: isCurrentUser,
              isTopBid: isTopBid,
              rank: rank,
            );
          },
        ),
        // View All / Show Less button
        if (hasMore) ...[
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _showAll = !_showAll;
              });
            },
            icon: Icon(_showAll ? Icons.expand_less : Icons.expand_more),
            label: Text(
              _showAll
                  ? 'Show Less'
                  : 'View All Bids (${widget.bids.length - _initialDisplayCount} more)',
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(color: theme.colorScheme.primary.withOpacity(0.5)),
            ),
          ),
        ],

        // Divider between bid history and Q&A section
        if (widget.bids.isNotEmpty) ...[
          const SizedBox(height: 24),
          Divider(
            thickness: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 24),
        ],

        // Questions & Answers section for buyers
        BuyerCommentSection(
          auctionId: widget.auctionId,
          sellerId: widget.sellerId,
          currentUserId: widget.currentUserId,
        ),
      ],
    );
  }
}
