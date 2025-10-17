import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../data/models/pre_transaction_model.dart';
import '../../../../data/services/mock/mock_auction_service.dart';
import '../../../../data/services/mock/mock_pre_transaction_service.dart';
import '../../../../core/utils/listing_status_extensions.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/car_card.dart';
import 'package:intl/intl.dart';

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
                        _buildListingList(
                          provider.myListings
                              .where((l) => l.status == ListingStatus.pendingReview)
                              .toList(),
                          ListingStatus.pendingReview,
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
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.touch_app, size: 14, color: Colors.blue[700]),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          _getActionHint(preTransaction.status)!,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blue[700],
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
          'color': Colors.orange[700],
          'icon': Icons.chat_bubble_outline,
        };
      case PreTransactionStatus.pendingSellerConfirmation:
        return {
          'label': 'Action Required',
          'color': Colors.red[700],
          'icon': Icons.assignment_late,
        };
      case PreTransactionStatus.pendingAdminReview:
        return {
          'label': 'Admin Review',
          'color': Colors.purple[700],
          'icon': Icons.admin_panel_settings,
        };
      case PreTransactionStatus.adminApproved:
      case PreTransactionStatus.readyForPayment:
        return {
          'label': 'Awaiting Payment',
          'color': Colors.blue[700],
          'icon': Icons.pending_actions,
        };
      default:
        return {
          'label': 'In Progress',
          'color': Colors.grey[700],
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
              if (status == ListingStatus.active ||
                  status == ListingStatus.draft) ...[
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
            onTap: () => context.push('/car/${listing.id}'),
            showActions: true,
            onEdit: () {
              final provider = context.read<ListingProvider>();
              provider.loadListingForEdit(listing);
              // Always start from step 1, preserving all filled information
              context.push('/listing/create/step1');
            },
            onDelete: () => _showDeleteDialog(listing),
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
            onTap: () => context.push('/car/${listing.id}'),
            showActions: true,
            onEdit: () {
              final provider = context.read<ListingProvider>();
              provider.loadListingForEdit(listing);
              // Always start from step 1, preserving all filled information
              context.push('/listing/create/step1');
            },
            onDelete: () => _showDeleteDialog(listing),
          ),
        );
      },
    );
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
