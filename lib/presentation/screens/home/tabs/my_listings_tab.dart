import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
import '../../../../core/utils/listing_status_extensions.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/car_card.dart';

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
    _tabController = TabController(length: 5, vsync: this);
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
          isScrollable: false,
          tabAlignment: TabAlignment.fill,
          tabs: [
            _buildTab('Active', ListingStatus.active, provider),
            _buildTab('Pending', ListingStatus.pendingReview, provider),
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

  Widget _buildTab(String label, ListingStatus status, ListingProvider provider) {
    final count = provider.myListings.where((l) => l.status == status).length;

    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (count > 0) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Color(status.colorValue),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
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

              // For draft listings, navigate to the step after last completed
              if (listing.status == ListingStatus.draft) {
                final nextStep = _getNextIncompleteStep(provider);
                context.push('/listing/create/step$nextStep');
              } else {
                // For other statuses, start from step 1
                context.push('/listing/create/step1');
              }
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

              // For draft listings, navigate to the step after last completed
              if (listing.status == ListingStatus.draft) {
                final nextStep = _getNextIncompleteStep(provider);
                context.push('/listing/create/step$nextStep');
              } else {
                // For other statuses, start from step 1
                context.push('/listing/create/step1');
              }
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

  /// Determines the next incomplete step for a draft listing
  /// Returns step number (1-8) based on validation status
  int _getNextIncompleteStep(ListingProvider provider) {
    // Check each step in order and return the first incomplete one
    if (!provider.validateStep1()) return 1;
    if (!provider.validateStep2()) return 2;
    if (!provider.validateStep3()) return 3;
    if (!provider.validateStep4()) return 4;
    if (!provider.validateStep5()) return 5;
    if (!provider.validateStep6()) return 6;
    if (!provider.validateStep7()) return 7;
    if (!provider.validateStep8()) return 8;

    // If all steps are complete, go to step 8 (review)
    return 8;
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
}
