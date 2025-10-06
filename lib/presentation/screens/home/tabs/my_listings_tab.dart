import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
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
    _tabController = TabController(length: 4, vsync: this);
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
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Drafts'),
            Tab(text: 'Sold'),
            Tab(text: 'Cancelled'),
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

  Widget _buildListingList(List<CarModel> listings, ListingStatus status) {
    if (listings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No listings found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            if (status == ListingStatus.active) ...[
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
              context.read<ListingProvider>().loadListingForEdit(listing);
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
              context.read<ListingProvider>().loadListingForEdit(listing);
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
}
