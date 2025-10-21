import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../data/models/pre_transaction_model.dart';
import '../../../../data/services/mock/mock_pre_transaction_service.dart';
import '../../../../data/services/mock/mock_auction_service.dart';
import '../../../../core/utils/listing_status_extensions.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/car_card.dart';
import '../../../widgets/auction_card.dart';

class MyListingsTab extends StatefulWidget {
  final bool isGridView;

  const MyListingsTab({super.key, required this.isGridView});

  @override
  State<MyListingsTab> createState() => _MyListingsTabState();
}

class _MyListingsTabState extends State<MyListingsTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadListings();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadListings() {
    final provider = context.read<ListingProvider>();
    provider.loadMyListings('mock-user-id');
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    return Column(
      children: [
        // Tab bar
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            _buildTab('Active', ListingStatus.active, provider),
            _buildTab('Pending', ListingStatus.pendingReview, provider),
            _buildTab('In Transaction', null, provider), // Special tab for sold items
            _buildTab('Drafts', ListingStatus.draft, provider),
            _buildTab('Sold', ListingStatus.sold, provider),
            _buildTab('Cancelled', ListingStatus.cancelled, provider),
          ],
        ),
        // Tab view
        Expanded(
          child: provider.isLoadingListings
              ? const Center(child: CircularProgressIndicator())
              : provider.error != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 64, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(provider.error!),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadListings,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        _buildListingList(
                          provider.myListings
                              .where((l) => l.status == ListingStatus.active)
                              .toList(),
                          ListingStatus.active,
                        ),
                        _buildPendingListingsList(
                          provider.myListings
                              .where((l) => l.status == ListingStatus.pendingReview)
                              .toList(),
                        ),
                        _buildInTransactionList(), // New tab for sold auctions
                        _buildListingList(
                          provider.myListings
                              .where((l) => l.status == ListingStatus.draft)
                              .toList(),
                          ListingStatus.draft,
                        ),
                        _buildListingList(
                          provider.myListings
                              .where((l) => l.status == ListingStatus.sold)
                              .toList(),
                          ListingStatus.sold,
                        ),
                        _buildListingList(
                          provider.myListings
                              .where((l) => l.status == ListingStatus.cancelled)
                              .toList(),
                          ListingStatus.cancelled,
                        ),
                      ],
                    ),
        ),
      ],
    );
  }

  Widget _buildTab(String label, ListingStatus? status, ListingProvider provider) {
    return Tab(
      child: Text(label),
    );
  }

  Widget _buildInTransactionList() {
    final preTransactionService = MockPreTransactionService();

    // Initialize mock data on first build
    preTransactionService.initializeSellerMockData('mock-user-id');

    final sellerTransactions = preTransactionService.getSellerPreTransactions('mock-user-id');

    if (sellerTransactions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '🤝',
                style: TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 16),
              Text(
                'No Active Transactions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sold vehicles awaiting buyer confirmation will appear here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sellerTransactions.length,
      itemBuilder: (context, index) {
        final preTransaction = sellerTransactions[index];
        return _buildPreTransactionCard(preTransaction);
      },
    );
  }

  Widget _buildPreTransactionCard(PreTransaction preTransaction) {
    final hoursAgo = DateTime.now().difference(preTransaction.createdAt).inHours;

    // Get status badge info
    final statusInfo = _getStatusBadgeInfo(preTransaction.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // Navigate to pre-transaction discussion screen (as seller)
          context.push(
            '/preTransaction/${preTransaction.auctionId}?carTitle=${Uri.encodeComponent(preTransaction.carTitle)}&winningBid=${preTransaction.finalBidAmount}&isSeller=true',
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.directions_car,
                      color: Colors.grey[400],
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          preTransaction.carTitle,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Buyer: ${preTransaction.buyerName}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₱${_formatCurrency(preTransaction.finalBidAmount)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(color: Colors.grey[300]),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusInfo['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: statusInfo['color'].withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          statusInfo['icon'],
                          size: 14,
                          color: statusInfo['color'],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          statusInfo['label'],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: statusInfo['color'],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${hoursAgo}h ago',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              // Show action hint based on status
              if (_getActionHint(preTransaction.status) != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: ColorConstants.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.touch_app, size: 14, color: ColorConstants.info),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          _getActionHint(preTransaction.status)!,
                          style: TextStyle(
                            fontSize: 11,
                            color: ColorConstants.info.withOpacity(0.9),
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
    );
  }

  Map<String, dynamic> _getStatusBadgeInfo(PreTransactionStatus status) {
    switch (status) {
      case PreTransactionStatus.inDiscussion:
        return {
          'label': 'In Discussion',
          'color': ColorConstants.warning,
          'icon': Icons.chat_bubble_outline,
        };
      case PreTransactionStatus.pendingSellerConfirmation:
        return {
          'label': 'Action Required',
          'color': ColorConstants.error,
          'icon': Icons.assignment_late,
        };
      case PreTransactionStatus.pendingAdminReview:
        return {
          'label': 'Admin Review',
          'color': ColorConstants.primary,
          'icon': Icons.admin_panel_settings,
        };
      case PreTransactionStatus.adminApproved:
      case PreTransactionStatus.readyForPayment:
        return {
          'label': 'Awaiting Payment',
          'color': ColorConstants.info,
          'icon': Icons.pending_actions,
        };
      default:
        return {
          'label': 'In Progress',
          'color': ColorConstants.textSecondaryLight,
          'icon': Icons.sync,
        };
    }
  }

  String? _getActionHint(PreTransactionStatus status) {
    switch (status) {
      case PreTransactionStatus.inDiscussion:
        return 'Discuss delivery details with buyer';
      case PreTransactionStatus.pendingSellerConfirmation:
        return 'Buyer confirmed. Fill out your seller form';
      case PreTransactionStatus.pendingAdminReview:
        return 'Admin reviewing both confirmations';
      case PreTransactionStatus.readyForPayment:
        return 'Payment received! Prepare shipping evidence';
      default:
        return null;
    }
  }

  Widget _buildListingList(List<CarModel> listings, ListingStatus status) {
    if (listings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                status.iconEmoji,
                style: const TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 16),
              Text(
                _getEmptyStateTitle(status),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                _getEmptyStateMessage(status),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              if (status == ListingStatus.draft) ...[
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () {
                    context.read<ListingProvider>().reset();
                    context.push('/listing/create/step1');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Create New Listing'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    // For ACTIVE listings, use AuctionCard like Browse tab
    if (status == ListingStatus.active) {
      return _buildActiveAuctionsList(listings);
    }

    // For SOLD listings, use custom SoldListingCard
    if (status == ListingStatus.sold) {
      return _buildSoldListingsList(listings);
    }

    // For CANCELLED listings, use custom CancelledListingCard
    if (status == ListingStatus.cancelled) {
      return _buildCancelledListingsList(listings);
    }

    // For other statuses, use CarCard as before
    // Determine if actions should be shown based on status
    final bool showEditDelete = status == ListingStatus.draft;
    final bool showActions = showEditDelete;

    if (widget.isGridView) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: listings.length,
        itemBuilder: (context, index) {
          final listing = listings[index];
          return CarCard(
            car: listing,
            onTap: status == ListingStatus.draft ? null : () => _handleListingTap(listing, status),
            showActions: showActions,
            onEdit: showEditDelete ? () {
              final provider = context.read<ListingProvider>();
              provider.loadListingForEdit(listing);
              context.push('/listing/create/step1');
            } : null,
            onDelete: showEditDelete
                ? () => _showDeleteDialog(listing)
                : null,
          );
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: listings.length,
      itemBuilder: (context, index) {
        final listing = listings[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CarCard(
            car: listing,
            onTap: status == ListingStatus.draft ? null : () => _handleListingTap(listing, status),
            showActions: showActions,
            onEdit: showEditDelete ? () {
              final provider = context.read<ListingProvider>();
              provider.loadListingForEdit(listing);
              context.push('/listing/create/step1');
            } : null,
            onDelete: showEditDelete
                ? () => _showDeleteDialog(listing)
                : null,
          ),
        );
      },
    );
  }

  // Build pending listings with custom PendingListingCard
  Widget _buildPendingListingsList(List<CarModel> listings) {
    final auctionService = MockAuctionService();

    if (listings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ListingStatus.pendingReview.iconEmoji,
                style: const TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 16),
              Text(
                'No Pending Listings',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your submitted listings will appear here while waiting for admin approval.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (widget.isGridView) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: listings.length,
        itemBuilder: (context, index) {
          final auction = auctionService.getAuctionByCarId(listings[index].id);
          return _buildPendingListingCard(listings[index], auction);
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: listings.length,
      itemBuilder: (context, index) {
        final auction = auctionService.getAuctionByCarId(listings[index].id);
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildPendingListingCard(listings[index], auction),
        );
      },
    );
  }

  Widget _buildPendingListingCard(CarModel car, Auction? auction) {
    // Mock submission date
    final submittedDate = car.createdAt;
    final hoursAgo = DateTime.now().difference(submittedDate).inHours;
    final daysAgo = hoursAgo ~/ 24;
    final timeAgoText = daysAgo > 0 ? '${daysAgo}d ago' : '${hoursAgo}h ago';
    final startingPrice = auction?.startingPrice ?? 0;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return Card(
      elevation: 1,
      child: InkWell(
        onTap: () => context.push('/listing/pending/${car.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ColorConstants.warning.withOpacity(0.3),
              width: 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorConstants.warning.withOpacity(isDarkMode ? 0.15 : 0.05),
                cardColor,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pending badge
              Row(
                children: [
                  Text(
                    timeAgoText,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: ColorConstants.warning,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.pending,
                          size: 14,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'PENDING',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Car image and details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: ColorConstants.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ColorConstants.warning.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Icon(
                        Icons.directions_car,
                        color: ColorConstants.warning.withOpacity(0.5),
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${car.brand} ${car.model}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${car.year} • ${car.transmission}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ColorConstants.warning.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Starting: ₱${_formatCurrency(startingPrice)}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.warning,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Review status banner
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: ColorConstants.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: ColorConstants.info.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: ColorConstants.info,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Under admin review. We\'ll notify you once approved',
                        style: TextStyle(
                          fontSize: 11,
                          color: ColorConstants.info.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              // Footer with action
              Row(
                children: [
                  Icon(
                    Icons.visibility_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build sold listings with custom SoldListingCard
  Widget _buildSoldListingsList(List<CarModel> listings) {
    final auctionService = MockAuctionService();

    if (widget.isGridView) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: listings.length,
        itemBuilder: (context, index) {
          final auction = auctionService.getAuctionByCarId(listings[index].id);
          return _buildSoldListingCard(listings[index], auction);
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: listings.length,
      itemBuilder: (context, index) {
        final auction = auctionService.getAuctionByCarId(listings[index].id);
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildSoldListingCard(listings[index], auction),
        );
      },
    );
  }

  Widget _buildSoldListingCard(CarModel car, Auction? auction) {
    // Mock sold date - in real app, this would come from auction/transaction data
    final soldDate = DateTime.now().subtract(Duration(days: car.id.hashCode % 30));
    final daysAgo = DateTime.now().difference(soldDate).inDays;
    final finalPrice = auction?.currentBid ?? auction?.startingPrice ?? 0;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => context.push('/listing/sold/${car.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorConstants.success.withOpacity(isDarkMode ? 0.15 : 0.05),
                cardColor,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Success badge
              Row(
                children: [
                  Text(
                    '${daysAgo}d ago',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: ColorConstants.success,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'SOLD',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Car image and details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: ColorConstants.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ColorConstants.success.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Icon(
                        Icons.directions_car,
                        color: ColorConstants.success.withOpacity(0.5),
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${car.brand} ${car.model}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${car.year} • ${car.transmission}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ColorConstants.success.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Final Sale: ₱${_formatCurrency(finalPrice)}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.success,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              // Footer with action
              Row(
                children: [
                  Icon(
                    Icons.visibility_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build cancelled listings with custom CancelledListingCard
  Widget _buildCancelledListingsList(List<CarModel> listings) {
    final auctionService = MockAuctionService();

    if (widget.isGridView) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: listings.length,
        itemBuilder: (context, index) {
          final auction = auctionService.getAuctionByCarId(listings[index].id);
          return _buildCancelledListingCard(listings[index], auction);
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: listings.length,
      itemBuilder: (context, index) {
        final auction = auctionService.getAuctionByCarId(listings[index].id);
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildCancelledListingCard(listings[index], auction),
        );
      },
    );
  }

  Widget _buildCancelledListingCard(CarModel car, Auction? auction) {
    // Mock cancellation date
    final cancelledDate = DateTime.now().subtract(Duration(days: car.id.hashCode % 60));
    final daysAgo = DateTime.now().difference(cancelledDate).inDays;
    final listedPrice = auction?.startingPrice ?? 0;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Main content
            InkWell(
              onTap: () => context.push('/listing/cancelled/${car.id}'),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cancelled badge
                    Row(
                      children: [
                        Text(
                          '${daysAgo}d ago',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDarkMode ? Colors.grey[600]! : Colors.grey[400]!,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.cancel_outlined,
                                size: 14,
                                color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'CANCELLED',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Car image and details (muted appearance)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Opacity(
                            opacity: 0.5,
                            child: Icon(
                              Icons.directions_car,
                              color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
                              size: 40,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${car.brand} ${car.model}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${car.year} • ${car.transmission}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Listed at: ₱${_formatCurrency(listedPrice)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Reauction suggestion
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: ColorConstants.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: ColorConstants.info.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            size: 16,
                            color: ColorConstants.info,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Consider re-listing with updated details',
                              style: TextStyle(
                                fontSize: 11,
                                color: ColorConstants.info.withOpacity(0.9),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Action buttons footer
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[900] : Colors.grey[50],
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                border: Border(
                  top: BorderSide(
                    color: isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _showReauctionDialog(car),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.refresh,
                              size: 18,
                              color: ColorConstants.primary,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Reauction',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: isDarkMode ? Colors.grey[700] : Colors.grey[200],
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => _showDeleteDialog(car),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(12),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              size: 18,
                              color: ColorConstants.error,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build active auctions list using AuctionCard (same as Browse tab)
  Widget _buildActiveAuctionsList(List<CarModel> listings) {
    final auctionService = MockAuctionService();

    // Get auctions for these car IDs
    final auctions = listings
        .map((car) => auctionService.getAuctionByCarId(car.id))
        .where((auction) => auction != null)
        .cast<Auction>()
        .toList();

    if (auctions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '🚗',
                style: TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 16),
              Text(
                'No Active Auctions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your active listings will appear here as auctions.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (widget.isGridView) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: auctions.length,
        itemBuilder: (context, index) {
          final auction = auctions[index];
          return AuctionCard(
            auction: auction,
            onTap: () => context.push('/seller/auction/${auction.id}'),
          );
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: auctions.length,
      itemBuilder: (context, index) {
        final auction = auctions[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AuctionCard(
            auction: auction,
            onTap: () => context.push('/seller/auction/${auction.id}'),
          ),
        );
      },
    );
  }

  void _handleListingTap(CarModel listing, ListingStatus status) {
    // Active listings go to auction view as seller
    if (status == ListingStatus.active) {
      context.push('/seller/auction/${listing.id}?isCarId=true');
    } else {
      // All other statuses go to read-only car details
      context.push('/car/${listing.id}');
    }
  }

  Future<void> _showReauctionDialog(CarModel car) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reauction Listing'),
        content: Text(
          'Do you want to reauction "${car.brand} ${car.model}"?\n\nThis will create a new active auction with the same details.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: ColorConstants.primaryGreen,
            ),
            child: const Text('Reauction'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      final provider = context.read<ListingProvider>();
      provider.loadListingForEdit(car);
      context.push('/listing/create/step1');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Edit details and submit to reauction')),
        );
      }
    }
  }

  Future<void> _showDeleteDialog(CarModel car) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Listing'),
        content: Text(
          'Are you sure you want to delete "${car.brand} ${car.model}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await context.read<ListingProvider>().deleteListing(car.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Listing deleted')),
        );
      }
    }
  }

  String _getEmptyStateTitle(ListingStatus status) {
    switch (status) {
      case ListingStatus.active:
        return 'No Active Listings';
      case ListingStatus.pendingReview:
        return 'No Pending Listings';
      case ListingStatus.draft:
        return 'No Draft Listings';
      case ListingStatus.sold:
        return 'No Sold Listings';
      case ListingStatus.cancelled:
        return 'No Cancelled Listings';
    }
  }

  String _getEmptyStateMessage(ListingStatus status) {
    switch (status) {
      case ListingStatus.active:
        return 'Create a new listing to start selling your vehicle.';
      case ListingStatus.pendingReview:
        return 'Your submitted listings will appear here while waiting for admin approval.';
      case ListingStatus.draft:
        return 'Start creating a listing and save it as a draft to continue later.';
      case ListingStatus.sold:
        return 'Sold vehicles will be shown here.';
      case ListingStatus.cancelled:
        return 'Cancelled listings will appear here.';
    }
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
