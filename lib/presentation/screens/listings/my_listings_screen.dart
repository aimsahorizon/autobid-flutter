import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/car_model.dart';
import '../../providers/listing_provider.dart';
import '../../widgets/car_card.dart';

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isGridView = false;

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Listings'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Drafts'),
            Tab(text: 'Sold'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: provider.isLoadingListings
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
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
                    ),
                    _buildListingList(
                      provider.myListings
                          .where((l) => l.status == ListingStatus.draft)
                          .toList(),
                    ),
                    _buildListingList(
                      provider.myListings
                          .where((l) => l.status == ListingStatus.sold)
                          .toList(),
                    ),
                    _buildListingList(
                      provider.myListings
                          .where((l) => l.status == ListingStatus.cancelled)
                          .toList(),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<ListingProvider>().reset();
          context.push('/listing/create/step1');
        },
        icon: const Icon(Icons.add),
        label: const Text('Create Listing'),
      ),
    );
  }

  Widget _buildListingList(List<CarModel> listings) {
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
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                context.read<ListingProvider>().reset();
                context.push('/listing/create/step1');
              },
              child: const Text('Create your first listing'),
            ),
          ],
        ),
      );
    }

    if (_isGridView) {
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
