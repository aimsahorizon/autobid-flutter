import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../providers/browse_provider.dart';
import '../../../providers/auction_provider.dart';
import '../../../widgets/car_card.dart';
import '../../auction/widgets/countdown_timer.dart';

class BrowseTab extends StatefulWidget {
  final bool isGridView;

  const BrowseTab({super.key, required this.isGridView});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<BrowseProvider>().loadAllCars();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final browseProvider = context.watch<BrowseProvider>();
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: () => browseProvider.loadAllCars(),
      child: browseProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : browseProvider.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(browseProvider.error!),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => browseProvider.loadAllCars(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : browseProvider.filteredCars.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No cars found',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            browseProvider.hasActiveFilters
                                ? 'Try adjusting your filters'
                                : 'No cars available at the moment',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[500],
                            ),
                          ),
                          if (browseProvider.hasActiveFilters) ...[
                            const SizedBox(height: 16),
                            FilledButton.icon(
                              onPressed: () => browseProvider.clearFilters(),
                              icon: const Icon(Icons.clear),
                              label: const Text('Clear Filters'),
                            ),
                          ],
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        // Auctions Section
                        _buildAuctionsSection(context),

                        // Active filters summary
                        if (browseProvider.hasActiveFilters)
                          Container(
                            padding: const EdgeInsets.all(12),
                            color: theme.colorScheme.primaryContainer,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${browseProvider.filteredCars.length} cars found with ${browseProvider.activeFilterCount} filter(s)',
                                    style: TextStyle(
                                      color: theme.colorScheme.onPrimaryContainer,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => browseProvider.clearFilters(),
                                  child: const Text('Clear All'),
                                ),
                              ],
                            ),
                          ),

                        // Cars list/grid
                        Expanded(
                          child: widget.isGridView
                              ? GridView.builder(
                                  padding: const EdgeInsets.all(16),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.65,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                  ),
                                  itemCount: browseProvider.filteredCars.length,
                                  itemBuilder: (context, index) {
                                    final car = browseProvider.filteredCars[index];
                                    return CarCard(
                                      car: car,
                                      onTap: () => context.push('/car/${car.id}'),
                                    );
                                  },
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(16),
                                  itemCount: browseProvider.filteredCars.length,
                                  itemBuilder: (context, index) {
                                    final car = browseProvider.filteredCars[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: CarCard(
                                        car: car,
                                        onTap: () => context.push('/car/${car.id}'),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
    );
  }

  Widget _buildAuctionsSection(BuildContext context) {
    return Consumer<AuctionProvider>(
      builder: (context, auctionProvider, child) {
        final auctions = auctionProvider.activeAuctions.take(5).toList();

        if (auctions.isEmpty) {
          return SizedBox.shrink();
        }

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.gavel, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Live Auctions',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to My Bids tab
                        // This will be handled by parent HomeScreen
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: auctions.length,
                  itemBuilder: (context, index) {
                    final auction = auctions[index];
                    return _buildAuctionCard(context, auction);
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAuctionCard(BuildContext context, auction) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            context.push('/auction/${auction.id}');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: Icon(Icons.directions_car, size: 40, color: Colors.grey[600]),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CountdownTimer(
                        endTime: auction.endTime,
                        textStyle: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2020 Toyota Camry',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Current Bid',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      '₱${_formatCurrency(auction.currentBid)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.people, size: 12, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${auction.totalBids} bids',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
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
