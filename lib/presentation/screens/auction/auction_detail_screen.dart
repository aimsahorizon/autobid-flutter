import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auction_provider.dart';
// import '../../providers/bid_provider.dart';
import '../../../data/models/auction_model.dart';
import '../../../data/models/auto_bid_config.dart';
import 'widgets/countdown_timer.dart';
import 'widgets/current_bid_card.dart';
import 'widgets/bid_input_widget.dart';
import 'widgets/auto_bid_dialog.dart';
import 'tabs/bid_history_tab.dart';
import 'tabs/car_info_tab.dart';

class AuctionDetailScreen extends StatefulWidget {
  final String auctionId;

  const AuctionDetailScreen({
    super.key,
    required this.auctionId,
  });

  @override
  State<AuctionDetailScreen> createState() => _AuctionDetailScreenState();
}

class _AuctionDetailScreenState extends State<AuctionDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuctionProvider>().loadAuctionDetail(widget.auctionId);
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
                SliverAppBar(
                  expandedHeight: 300,
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
                        Image.network(
                          'https://via.placeholder.com/800x400',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Icon(Icons.directions_car, size: 100, color: Colors.grey[600]),
                            );
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.7),
                              ],
                            ),
                          ),
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
                                '2020 Toyota Camry',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (auction.status == AuctionStatus.live)
                                CountdownTimer(
                                  endTime: auction.endTime,
                                  textStyle: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CurrentBidCard(
                        auction: auction,
                        userBidStatus: provider.getUserBidStatus(auction.id),
                        userBidAmount: provider.getUserBidAmount(auction.id),
                      ),
                      if (auction.status == AuctionStatus.live) ...[
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 12),
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
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'Bid History'),
                    Tab(text: 'Car Info'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      BidHistoryTab(auctionId: auction.id),
                      CarInfoTab(auction: auction),
                    ],
                  ),
                ),
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
          final isWinner = auction.topBidderId == context.read<AuctionProvider>().currentUserId;
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
    final existingConfig = provider.getAutoBidConfig(auction.id);

    showDialog(
      context: context,
      builder: (context) => AutoBidDialog(
        auction: auction,
        existingConfig: existingConfig,
      ),
    ).then((config) {
      if (config != null && config is AutoBidConfig) {
        provider.setupAutoBid(auction.id, config);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Auto-bid configured successfully!')),
        );
      }
    });
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
