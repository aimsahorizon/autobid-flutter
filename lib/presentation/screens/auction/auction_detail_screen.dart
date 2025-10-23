import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider_pkg;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auction_provider.dart';
import '../../providers/auth_provider.dart';
import '../../../data/models/auction_model.dart';
import '../../../data/models/auto_bid_config.dart';
import '../../../data/models/car_model.dart';
import '../../../data/models/subscription_tier.dart';
import 'widgets/detailed_countdown_timer.dart';
import 'widgets/current_bid_card.dart';
import 'widgets/bid_input_widget.dart';
import 'widgets/auto_bid_dialog.dart';
import 'widgets/car_image_gallery.dart';
import 'widgets/categorized_image_gallery.dart';
import 'tabs/bid_history_tab.dart';
import 'tabs/car_info_tab.dart';

class AuctionDetailScreen extends ConsumerStatefulWidget {
  final String auctionId;
  final bool isSeller;
  final bool isCarId;

  const AuctionDetailScreen({
    super.key,
    required this.auctionId,
    this.isSeller = false,
    this.isCarId = false,
  });

  @override
  ConsumerState<AuctionDetailScreen> createState() => _AuctionDetailScreenState();
}

class _AuctionDetailScreenState extends ConsumerState<AuctionDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider_pkg.Provider.of<AuctionProvider>(context, listen: false).loadAuctionDetail(
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
      body: provider_pkg.Consumer<AuctionProvider>(
        builder: (context, provider, child) {
          final auction = provider.selectedAuction;

          if (auction == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 380,
                  pinned: true,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        // Share functionality
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        provider.isWatching(auction.id) ? Icons.favorite : Icons.favorite_border,
                        color: provider.isWatching(auction.id) ? Colors.red : null,
                      ),
                      onPressed: () {
                        if (provider.isWatching(auction.id)) {
                          provider.unwatchAuction(auction.id);
                        } else {
                          provider.watchAuction(auction.id);
                        }
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Use CarImageGallery widget
                        CarImageGallery(
                          images: auction.car?.images ?? [],
                          height: 380,
                          showThumbnails: true,
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildStatusBanner(auction),
                              const SizedBox(height: 8),
                              Text(
                                auction.car != null
                                  ? '${auction.car!.year} ${auction.car!.brand} ${auction.car!.model}'
                                  : 'Car Auction',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: Column(
                      children: [
                        // Modern Timer Card - Shows real-time seconds
                        if (auction.status == AuctionStatus.live)
                          DetailedCountdownTimer(
                            endTime: auction.endTime,
                          ),
                        // Current Bid Card
                        CurrentBidCard(
                          auction: auction,
                          userBidStatus: provider.getUserBidStatus(auction.id),
                          userBidAmount: provider.getUserBidAmount(auction.id),
                          isSeller: widget.isSeller,
                        ),
                        // Categorized Image Gallery
                        if (auction.car != null)
                          CategorizedImageGallery(
                            categorizedImages: auction.car!.getCategorizedImages(),
                          ),
                        if (auction.status == AuctionStatus.live && !widget.isSeller) ...[
                          const SizedBox(height: 12),
                          // Token Cost Info (REVISED Revenue Model)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green[200]!),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.generating_tokens_rounded, color: Colors.green[700], size: 20),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Each bid costs 1 token',
                                    style: TextStyle(
                                      color: Colors.green[900],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          BidInputWidget(
                            auction: auction,
                            onBidPlaced: (amount) async {
                              final success = await provider.placeBid(auction.id, amount);
                              if (success && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Bid placed successfully!')),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              if (auction.buyNowPrice != null)
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      // Buy now functionality
                                    },
                                    icon: Icon(Icons.shopping_cart),
                                    label: Text('Buy Now - ₱${_formatCurrency(auction.buyNowPrice!)}'),
                                    style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                    ),
                                  ),
                                ),
                              if (auction.buyNowPrice != null) const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () => _showAutoBidDialog(context, auction, provider),
                                  icon: Icon(Icons.auto_mode),
                                  label: Text('Auto-Bid'),
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (widget.isSeller) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.blue[200]!),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline, color: Colors.blue[700]),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'You are viewing your active listing. Bidding is disabled for sellers.',
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverTabBarDelegate(
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Bid History'),
                        Tab(text: 'Car Info'),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                BidHistoryTab(
                  auctionId: auction.id,
                  isSeller: widget.isSeller,
                  sellerId: auction.sellerId,
                ),
                CarInfoTab(auction: auction),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusBanner(Auction auction) {
    if (auction.status != AuctionStatus.live) {
      String text;
      Color color;

      switch (auction.status) {
        case AuctionStatus.upcoming:
          text = 'Upcoming';
          color = Colors.blue;
          break;
        case AuctionStatus.ended:
          text = 'Auction Ended';
          color = Colors.grey;
          break;
        case AuctionStatus.sold:
          final isWinner = auction.topBidderId == provider_pkg.Provider.of<AuctionProvider>(context, listen: false).currentUserId;
          text = isWinner ? '🎉 You Won!' : 'Sold';
          color = isWinner ? Colors.green : Colors.grey;
          break;
        case AuctionStatus.cancelled:
          text = 'Cancelled';
          color = Colors.red;
          break;
        default:
          return SizedBox.shrink();
      }

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      );
    }

    return SizedBox.shrink();
  }

  void _showAutoBidDialog(BuildContext context, Auction auction, AuctionProvider provider) {
    // REVISED Revenue Model: Check AutoBid feature access (Pro Basic/Plus only)
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    final tier = currentUser.subscriptionTier;
    final hasAutoBid = currentUser.subscriptionTier.config.hasAutoBid;

    if (!hasAutoBid || tier == SubscriptionTierType.free) {
      // Show upgrade dialog for Free tier users
      _showAutoBidUpgradeDialog();
      return;
    }

    // User has access to AutoBid
    final existingConfig = provider.getAutoBidConfig(auction.id);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AutoBidDialog(
        auction: auction,
        existingConfig: existingConfig,
      ),
    ).then((config) async {
      if (config != null && config is AutoBidConfig) {
        provider.setupAutoBid(auction.id, config);

        // Refresh auction data to reflect auto-bid changes
        await provider.loadAuctionDetail(auction.id);

        // ignore: use_build_context_synchronously
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Auto bid set successfully'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    });
  }

  // REVISED Revenue Model: AutoBid feature upgrade dialog
  void _showAutoBidUpgradeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.auto_mode,
            size: 48,
            color: Colors.blue.shade700,
          ),
        ),
        title: const Text('AutoBid is a Pro Feature'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AutoBid automatically places bids for you based on your preferences, so you never miss an auction!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade600, Colors.green.shade400],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.workspace_premium, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Included in Pro Plans',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildProFeature('Pro Basic - ₱199/month', '100 bid tokens + AutoBid'),
                  const SizedBox(height: 8),
                  _buildProFeature('Pro Plus - ₱499/month', 'Unlimited tokens + AutoBid'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Navigate to subscription upgrade screen
              // context.push('/subscription/upgrade');
            },
            icon: const Icon(Icons.upgrade),
            label: const Text('Upgrade Now'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProFeature(String title, String subtitle) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: Colors.white, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
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
