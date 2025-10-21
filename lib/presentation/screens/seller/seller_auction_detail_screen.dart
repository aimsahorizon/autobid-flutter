import 'package:autobid/core/utils/time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/auction_provider.dart';
import '../../../data/models/auction_model.dart';
import '../auction/widgets/car_image_gallery.dart';
import '../auction/widgets/detailed_countdown_timer.dart';
import 'widgets/comment_section.dart';

/// Seller-specific auction detail screen
/// Professional view for sellers to manage their active auctions
/// Includes buyer interaction through comment section
class SellerAuctionDetailScreen extends StatefulWidget {
  final String auctionId;
  final bool isCarId;

  const SellerAuctionDetailScreen({
    super.key,
    required this.auctionId,
    this.isCarId = false,
  });

  @override
  State<SellerAuctionDetailScreen> createState() => _SellerAuctionDetailScreenState();
}

class _SellerAuctionDetailScreenState extends State<SellerAuctionDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _currencyFormat = NumberFormat.currency(symbol: '₱', locale: 'en_PH', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuctionProvider>().loadAuctionDetail(
            widget.auctionId,
            isCarId: widget.isCarId,
          );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuctionProvider>(
        builder: (context, provider, child) {
          final auction = provider.selectedAuction;

          if (auction == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                _buildAppBar(context, auction),
                _buildAuctionHeader(context, auction),
                _buildTabBar(context),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(auction, provider),
                _buildBidActivityTab(auction, provider),
                _buildCommentsTab(auction, provider),
              ],
            ),
          );
        },
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, Auction auction) {
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 380,
      pinned: true,
      title: Text(
        'My Auction',
        style: TextStyle(
          color: theme.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            // Share auction link
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showAuctionOptions(context, auction),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CarImageGallery(
              images: auction.car?.images ?? [],
              height: 380,
              showThumbnails: true,
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      auction.car != null
                          ? '${auction.car!.year} ${auction.car!.brand} ${auction.car!.model}'
                          : 'Car Auction',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (auction.car?.variant != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        auction.car!.variant,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAuctionHeader(BuildContext context, Auction auction) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: Container(
        color: theme.colorScheme.surface,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Countdown timer
            if (auction.status == AuctionStatus.live)
              DetailedCountdownTimer(endTime: auction.endTime)
            else
              _buildStatusBanner(auction, theme),
            const SizedBox(height: 16),

            // Auction stats grid
            _buildStatsGrid(auction, theme),
          ],
        ),
      ),
    );
  }

  SliverPersistentHeader _buildTabBar(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverTabBarDelegate(
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Bid Activity'),
            Tab(text: 'Comments'),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab(Auction auction, AuctionProvider provider) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Pricing Information
        _buildSectionCard(
          theme: theme,
          title: 'Pricing',
          icon: Icons.attach_money,
          child: Column(
            children: [
              _buildInfoRow('Starting Price', _currencyFormat.format(auction.startingPrice), theme),
              const Divider(height: 24),
              _buildInfoRow('Current Bid', _currencyFormat.format(auction.currentBid), theme,
                  highlight: true),
              const Divider(height: 24),
              _buildInfoRow('Reserve Price', _currencyFormat.format(auction.reservePrice), theme),
              if (auction.buyNowPrice != null) ...[
                const Divider(height: 24),
                _buildInfoRow('Buy Now Price', _currencyFormat.format(auction.buyNowPrice!), theme),
              ],
              const Divider(height: 24),
              _buildInfoRow(
                'Reserve Status',
                auction.currentBid >= auction.reservePrice ? 'MET ✓' : 'NOT MET',
                theme,
                valueColor: auction.currentBid >= auction.reservePrice ? Colors.green : Colors.orange,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Auction Performance
        _buildSectionCard(
          theme: theme,
          title: 'Performance',
          icon: Icons.trending_up,
          child: Column(
            children: [
              _buildInfoRow('Total Bids', auction.totalBids.toString(), theme),
              const Divider(height: 24),
              _buildInfoRow('Watchers', auction.watchers.length.toString(), theme),
              const Divider(height: 24),
              _buildInfoRow('Views', '${120 + auction.totalBids * 5}', theme),
              const Divider(height: 24),
              _buildInfoRow(
                'Engagement Rate',
                '${((auction.totalBids / (auction.watchers.length + 1)) * 100).toStringAsFixed(1)}%',
                theme,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Vehicle Information
        if (auction.car != null) ...[
          _buildSectionCard(
            theme: theme,
            title: 'Vehicle Details',
            icon: Icons.directions_car,
            child: Column(
              children: [
                _buildInfoRow('Year', auction.car!.year.toString(), theme),
                const Divider(height: 24),
                _buildInfoRow('Mileage', '${NumberFormat('#,###').format(auction.car!.mileage)} km', theme),
                const Divider(height: 24),
                _buildInfoRow('Transmission', auction.car!.transmission.name.toUpperCase(), theme),
                const Divider(height: 24),
                _buildInfoRow('Fuel Type', auction.car!.fuelType.name.toUpperCase(), theme),
                const Divider(height: 24),
                _buildInfoRow('Condition', auction.car!.condition.name.toUpperCase(), theme),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildBidActivityTab(Auction auction, AuctionProvider provider) {
    final theme = Theme.of(context);
    final bids = provider.bidHistory;

    return bids.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.gavel, size: 64, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  'No bids yet',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bid activity will appear here',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bids.length,
            itemBuilder: (context, index) {
              final bid = bids[index];
              final isWinning = index == 0;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isWinning
                      ? Colors.green.withValues(alpha: 0.1)
                      : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isWinning
                        ? Colors.green.withValues(alpha: 0.3)
                        : theme.colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    if (isWinning)
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.emoji_events, color: Colors.white, size: 20),
                      )
                    else
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '#${index + 1}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bid.bidderName,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            TimeFormatter.getRelativeTime(bid.timestamp),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _currencyFormat.format(bid.amount),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isWinning ? Colors.green : null,
                          ),
                        ),
                        if (bid.isAutoBid)
                          Row(
                            children: [
                              Icon(Icons.auto_mode, size: 12, color: theme.colorScheme.primary),
                              const SizedBox(width: 4),
                              Text(
                                'Auto-bid',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }

  Widget _buildCommentsTab(Auction auction, AuctionProvider provider) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CommentSection(
          auctionId: auction.id,
          sellerId: provider.currentUserId ?? 'mock-user-id',
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required ThemeData theme,
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildStatsGrid(Auction auction, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            theme: theme,
            label: 'Current Bid',
            value: _currencyFormat.format(auction.currentBid),
            icon: Icons.gavel,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            theme: theme,
            label: 'Total Bids',
            value: auction.totalBids.toString(),
            icon: Icons.trending_up,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            theme: theme,
            label: 'Watchers',
            value: auction.watchers.length.toString(),
            icon: Icons.visibility,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required ThemeData theme,
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    ThemeData theme, {
    bool highlight = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: highlight ? FontWeight.bold : FontWeight.w600,
            color: valueColor ?? (highlight ? theme.colorScheme.primary : null),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBanner(Auction auction, ThemeData theme) {
    String text;
    Color color;

    switch (auction.status) {
      case AuctionStatus.upcoming:
        text = 'Upcoming Auction';
        color = Colors.blue;
        break;
      case AuctionStatus.ended:
        text = 'Auction Ended';
        color = Colors.grey;
        break;
      case AuctionStatus.sold:
        text = 'SOLD!';
        color = Colors.green;
        break;
      case AuctionStatus.cancelled:
        text = 'Cancelled';
        color = Colors.red;
        break;
      default:
        text = 'Live Auction';
        color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _showAuctionOptions(BuildContext context, Auction auction) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Auction'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to edit screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Auction'),
              onTap: () {
                Navigator.pop(context);
                // Share functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.pause),
              title: const Text('Pause Auction'),
              onTap: () {
                Navigator.pop(context);
                // Pause functionality
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.cancel, color: Colors.red),
              title: const Text('Cancel Auction', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showCancelConfirmation(context, auction);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context, Auction auction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Auction?'),
        content: const Text(
          'Are you sure you want to cancel this auction? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No, Keep It'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // Cancel auction logic
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
