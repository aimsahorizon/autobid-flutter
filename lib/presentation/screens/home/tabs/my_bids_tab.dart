import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auction_provider.dart';
import '../../../../data/models/auction_model.dart';
import '../../../widgets/active_bid_card.dart';

class MyBidsTab extends StatefulWidget {
  const MyBidsTab({super.key});

  @override
  State<MyBidsTab> createState() => _MyBidsTabState();
}

class _MyBidsTabState extends State<MyBidsTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Won'),
            Tab(text: 'Lost'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _ActiveTab(),
              _WonTab(),
              _LostTab(),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuctionProvider>(
      builder: (context, provider, child) {
        final activeAuctions = provider.getUserActiveAuctions();

        if (activeAuctions.isEmpty) {
          return _buildEmptyState(
            icon: Icons.gavel,
            title: 'No Active Bids',
            subtitle: 'Browse auctions to start bidding',
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: activeAuctions.length,
          itemBuilder: (context, index) {
            final auction = activeAuctions[index];
            final userBidStatus = provider.getUserBidStatus(auction.id);
            final userBidAmount = provider.getUserBidAmount(auction.id);

            if (userBidStatus == null || userBidAmount == null) {
              return SizedBox.shrink();
            }

            return ActiveBidCard(
              auction: auction,
              userBidStatus: userBidStatus,
              userBidAmount: userBidAmount,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/auction',
                  arguments: auction.id,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

class _WonTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuctionProvider>(
      builder: (context, provider, child) {
        final wonAuctions = provider.getUserWonAuctions();

        if (wonAuctions.isEmpty) {
          return _buildEmptyState(
            icon: Icons.emoji_events,
            title: 'No Won Auctions',
            subtitle: 'Keep bidding to win your first auction!',
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: wonAuctions.length,
          itemBuilder: (context, index) {
            final auction = wonAuctions[index];

            return _AuctionResultCard(
              auction: auction,
              won: true,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/auction',
                  arguments: auction.id,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

class _LostTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuctionProvider>(
      builder: (context, provider, child) {
        final lostAuctions = provider.getUserLostAuctions();

        if (lostAuctions.isEmpty) {
          return _buildEmptyState(
            icon: Icons.cancel,
            title: 'No Lost Auctions',
            subtitle: 'Your bid history will appear here',
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: lostAuctions.length,
          itemBuilder: (context, index) {
            final auction = lostAuctions[index];

            return _AuctionResultCard(
              auction: auction,
              won: false,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/auction',
                  arguments: auction.id,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

class _WatchingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuctionProvider>(
      builder: (context, provider, child) {
        final watchlist = provider.watchlist;

        if (watchlist.isEmpty) {
          return _buildEmptyState(
            icon: Icons.favorite_border,
            title: 'No Watched Auctions',
            subtitle: 'Add auctions to your watchlist',
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: watchlist.length,
          itemBuilder: (context, index) {
            final auction = watchlist[index];

            return _WatchlistCard(
              auction: auction,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/auction',
                  arguments: auction.id,
                );
              },
              onUnwatch: () {
                provider.unwatchAuction(auction.id);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

class _AuctionResultCard extends StatelessWidget {
  final Auction auction;
  final bool won;
  final VoidCallback onTap;

  const _AuctionResultCard({
    required this.auction,
    required this.won,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child: Icon(Icons.directions_car, size: 40, color: Colors.grey[600]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '2020 Toyota Camry',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          won ? Icons.emoji_events : Icons.cancel,
                          color: won ? Colors.green : Colors.grey,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Final Bid: ₱${_formatCurrency(auction.currentBid)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      won ? 'Congratulations! You won this auction' : 'Auction ended',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: won ? Colors.green : Colors.grey[600],
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

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}

class _WatchlistCard extends StatelessWidget {
  final Auction auction;
  final VoidCallback onTap;
  final VoidCallback onUnwatch;

  const _WatchlistCard({
    required this.auction,
    required this.onTap,
    required this.onUnwatch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child: Icon(Icons.directions_car, size: 40, color: Colors.grey[600]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2020 Toyota Camry',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Current Bid: ₱${_formatCurrency(auction.currentBid)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ends ${_formatEndTime(auction.endTime)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: onUnwatch,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  String _formatEndTime(DateTime endTime) {
    final now = DateTime.now();
    final difference = endTime.difference(now);

    if (difference.isNegative) return 'Ended';
    if (difference.inDays > 0) return 'in ${difference.inDays}d';
    if (difference.inHours > 0) return 'in ${difference.inHours}h';
    return 'in ${difference.inMinutes}m';
  }
}
