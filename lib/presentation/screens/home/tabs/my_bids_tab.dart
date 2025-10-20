import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../providers/auction_provider.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../widgets/active_bid_card.dart';
import '../../../providers/payment_provider.dart';
import '../../../../data/models/transaction_model.dart';
import '../../../../core/constants/escrow_statuses.dart';

class MyBidsTab extends StatefulWidget {
  final int initialSubTab;

  const MyBidsTab({super.key, this.initialSubTab = 0});

  @override
  State<MyBidsTab> createState() => _MyBidsTabState();
}

class _MyBidsTabState extends State<MyBidsTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialSubTab,
    );

    // Load transactions to show pending actions count
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentProvider>().loadUserTransactions('user123');
    });
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
          cacheExtent: 500.0, // Cache 2 screens ahead
          addAutomaticKeepAlives: false, // Reduce memory
          itemCount: activeAuctions.length,
          itemBuilder: (context, index) {
            final auction = activeAuctions[index];
            final userBidStatus = provider.getUserBidStatus(auction.id);
            final userBidAmount = provider.getUserBidAmount(auction.id);

            if (userBidStatus == null || userBidAmount == null) {
              return SizedBox.shrink();
            }

            return ActiveBidCard(
              key: ValueKey(auction.id), // Preserve state
              auction: auction,
              userBidStatus: userBidStatus,
              userBidAmount: userBidAmount,
              onTap: () {
                context.push('/auction/${auction.id}');
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

class _WonTab extends StatefulWidget {
  @override
  State<_WonTab> createState() => _WonTabState();
}

class _WonTabState extends State<_WonTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PaymentProvider>().loadUserTransactions('user123');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return Consumer2<AuctionProvider, PaymentProvider>(
      builder: (context, auctionProvider, paymentProvider, child) {
        final wonAuctions = auctionProvider.getUserWonAuctions();

        if (wonAuctions.isEmpty) {
          return _buildEmptyState(
            icon: Icons.emoji_events,
            title: 'No Won Auctions',
            subtitle: 'Keep bidding to win your first auction!',
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await context.read<PaymentProvider>().loadUserTransactions('user123');
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: wonAuctions.length,
            itemBuilder: (context, index) {
              final auction = wonAuctions[index];
              final transaction = paymentProvider.getTransactionByAuctionId(auction.id);

              return _AuctionResultCard(
                auction: auction,
                won: true,
                transaction: transaction,
                onTap: () {
                  context.push('/auction/${auction.id}');
                },
                onRefresh: _loadTransactions,
              );
            },
          ),
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
                context.push('/auction/${auction.id}');
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
                context.push('/auction/${auction.id}');
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
  final Transaction? transaction;
  final VoidCallback onTap;
  final VoidCallback? onRefresh;

  const _AuctionResultCard({
    required this.auction,
    required this.won,
    this.transaction,
    required this.onTap,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final carTitle = auction.car != null
        ? '${auction.car!.year} ${auction.car!.brand} ${auction.car!.model}'
        : 'Vehicle';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                    ),
                    child: auction.car?.images.isNotEmpty == true
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              auction.car!.images.first,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.directions_car,
                                size: 40,
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                        : Icon(Icons.directions_car,
                            color: Colors.grey[100]),
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
                                carTitle,
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
                          won
                              ? 'Congratulations! You won this auction'
                              : 'Auction ended',
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
            if (won) ...[
              const SizedBox(height: 12),
              _buildEscrowStatusChip(context),
              const SizedBox(height: 12),
              _buildActionButtons(context, carTitle),
            ],
          ],
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

  Widget _buildEscrowStatusChip(BuildContext context) {
    if (transaction == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber, size: 16, color: Colors.orange),
            const SizedBox(width: 6),
            Text(
              'Payment Required',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.orange[900],
              ),
            ),
          ],
        ),
      );
    }

    final statusInfo = EscrowStatuses.getInfo(transaction!.escrowStatus);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: statusInfo.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusInfo.color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusInfo.icon, size: 16, color: statusInfo.color),
          const SizedBox(width: 6),
          Text(
            statusInfo.displayName,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: statusInfo.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, String carTitle) {
    // No transaction - show start pre-transaction button
    if (transaction == null) {
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          onPressed: () async {
            await context.push(
              '/preTransaction/${auction.id}?carTitle=${Uri.encodeComponent(carTitle)}&winningBid=${auction.currentBid}',
            );
            onRefresh?.call();
          },
          icon: const Icon(Icons.chat),
          label: const Text('Start Discussion', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.primaryGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );
    }

    // Payment pending - show continue pre-transaction + view auction
    if (transaction!.escrowStatus == EscrowStatus.pending) {
      return SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await context.push(
                    '/preTransaction/${auction.id}?carTitle=${Uri.encodeComponent(carTitle)}&winningBid=${auction.currentBid}',
                  );
                  onRefresh?.call();
                },
                icon: const Icon(Icons.chat, size: 18),
                label: const Text('Continue', style: TextStyle(fontSize: 15)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  await context.push('/auction/${auction.id}');
                  onRefresh?.call();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: ColorConstants.primaryGreen, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('View', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      );
    }

    // Validating - show view transaction only
    if (transaction!.escrowStatus == EscrowStatus.validating) {
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: OutlinedButton.icon(
          onPressed: () async {
            await context.push('/transaction/${transaction!.id}');
            onRefresh?.call();
          },
          icon: const Icon(Icons.verified_user, size: 18),
          label: const Text('View Transaction', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.amber, width: 2),
            foregroundColor: Colors.amber[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );
    }

    // Escrow held - show confirm receipt + view transaction
    if (transaction!.escrowStatus == EscrowStatus.held) {
      return SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm Vehicle Receipt'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Have you received the vehicle?'),
                          const SizedBox(height: 16),
                          const Text('Next, you\'ll need to submit:'),
                          const SizedBox(height: 8),
                          _buildRequirementRow('Transfer documents (CR/OR)'),
                          _buildRequirementRow('Vehicle photos & odometer'),
                          _buildRequirementRow('VIN verification'),
                          _buildRequirementRow('Delivery receipt'),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline, size: 16, color: Colors.blue[700]),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'This protects both you and the seller',
                                    style: TextStyle(fontSize: 12, color: Colors.blue[900]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Continue'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true && context.mounted) {
                    await context.push(
                      '/submit-evidence/${transaction!.id}?carTitle=${Uri.encodeComponent(carTitle)}',
                    );
                    onRefresh?.call();
                  }
                },
                icon: const Icon(Icons.check_circle, size: 18),
                label: const Text('Confirm Receipt', style: TextStyle(fontSize: 15)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  await context.push('/transaction/${transaction!.id}');
                  onRefresh?.call();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: ColorConstants.primaryGreen, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('View', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      );
    }

    // Released, refunded, or disputed - just show view transaction
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () async {
          await context.push('/transaction/${transaction!.id}');
          onRefresh?.call();
        },
        icon: const Icon(Icons.receipt_long, size: 18),
        label: const Text('View Transaction', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: ColorConstants.primaryGreen, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  static Widget _buildRequirementRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 16, color: ColorConstants.primaryGreen),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
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
    final carTitle = auction.car != null
        ? '${auction.car!.year} ${auction.car!.brand} ${auction.car!.model}'
        : 'Vehicle';

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
                child: auction.car?.images.isNotEmpty == true
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          auction.car!.images.first,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.directions_car,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    : Icon(Icons.directions_car, size: 40, color: Colors.grey[600]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carTitle,
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
