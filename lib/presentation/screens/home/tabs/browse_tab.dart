import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/search_filters.dart';
import '../../../providers/auction_provider.dart';
import '../../../providers/browse_provider.dart';
import '../../../widgets/auction_card.dart';
import '../../browse/filter_bottom_sheet.dart';

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
        context.read<AuctionProvider>().loadAuctions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auctionProvider = context.watch<AuctionProvider>();
    final browseProvider = context.watch<BrowseProvider>();
    final theme = Theme.of(context);

    return Column(
      children: [
        // Filter and Sort Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border(
              bottom: BorderSide(color: theme.dividerColor),
            ),
          ),
          child: Row(
            children: [
              // Filter Button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useRootNavigator: false,
                      enableDrag: true,
                      isDismissible: true,
                      showDragHandle: false,
                      useSafeArea: true,
                      builder: (context) => const FilterBottomSheet(),
                    );
                  },
                  icon: Stack(
                    children: [
                      const Icon(Icons.filter_list, size: 20),
                      if (browseProvider.hasActiveFilters)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 14,
                              minHeight: 14,
                            ),
                            child: Text(
                              '${browseProvider.activeFilterCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  label: Text(
                    browseProvider.hasActiveFilters
                        ? 'Filters (${browseProvider.activeFilterCount})'
                        : 'Filters',
                    style: const TextStyle(fontSize: 14),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Sort Button
              Expanded(
                child: PopupMenuButton<SortBy>(
                  onSelected: (SortBy sortBy) {
                    final currentFilters = auctionProvider.filters;
                    auctionProvider.applyFilters(
                      filters: currentFilters.copyWith(sortBy: sortBy),
                    );
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: SortBy.priceAsc,
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            size: 18,
                            color: auctionProvider.filters.sortBy == SortBy.priceAsc
                                ? theme.colorScheme.primary
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Price: Low to High',
                            style: TextStyle(
                              fontWeight: auctionProvider.filters.sortBy == SortBy.priceAsc
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: auctionProvider.filters.sortBy == SortBy.priceAsc
                                  ? theme.colorScheme.primary
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: SortBy.priceDesc,
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            size: 18,
                            color: auctionProvider.filters.sortBy == SortBy.priceDesc
                                ? theme.colorScheme.primary
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Price: High to Low',
                            style: TextStyle(
                              fontWeight: auctionProvider.filters.sortBy == SortBy.priceDesc
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: auctionProvider.filters.sortBy == SortBy.priceDesc
                                  ? theme.colorScheme.primary
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: SortBy.endingSoon,
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 18,
                            color: auctionProvider.filters.sortBy == SortBy.endingSoon
                                ? theme.colorScheme.primary
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Ending Soon',
                            style: TextStyle(
                              fontWeight: auctionProvider.filters.sortBy == SortBy.endingSoon
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: auctionProvider.filters.sortBy == SortBy.endingSoon
                                  ? theme.colorScheme.primary
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: SortBy.newest,
                      child: Row(
                        children: [
                          Icon(
                            Icons.new_releases,
                            size: 18,
                            color: auctionProvider.filters.sortBy == SortBy.newest
                                ? theme.colorScheme.primary
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Newest First',
                            style: TextStyle(
                              fontWeight: auctionProvider.filters.sortBy == SortBy.newest
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: auctionProvider.filters.sortBy == SortBy.newest
                                  ? theme.colorScheme.primary
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  child: OutlinedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.sort, size: 20),
                    label: Text(
                      _getSortLabel(auctionProvider.filters.sortBy),
                      style: const TextStyle(fontSize: 14),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Auction List
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => auctionProvider.loadAuctions(),
            child: auctionProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : auctionProvider.error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 64, color: Colors.red),
                            const SizedBox(height: 16),
                            Text(auctionProvider.error!),
                            const SizedBox(height: 16),
                            FilledButton(
                              onPressed: () => auctionProvider.loadAuctions(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : auctionProvider.activeAuctions.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.gavel,
                                  size: 80,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No auctions found',
                                  style: theme.textTheme.headlineSmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'No auctions available at the moment',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : widget.isGridView
                            ? GridView.builder(
                                padding: const EdgeInsets.all(16),
                                cacheExtent: 500.0,
                                addAutomaticKeepAlives: false,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemCount: auctionProvider.activeAuctions.length,
                                itemBuilder: (context, index) {
                                  final auction = auctionProvider.activeAuctions[index];
                                  return AuctionCard(
                                    key: ValueKey(auction.id),
                                    auction: auction,
                                    onTap: () => context.push('/auction/${auction.id}'),
                                  );
                                },
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                cacheExtent: 500.0,
                                addAutomaticKeepAlives: false,
                                itemCount: auctionProvider.activeAuctions.length,
                                itemBuilder: (context, index) {
                                  final auction = auctionProvider.activeAuctions[index];
                                  return Padding(
                                    key: ValueKey(auction.id),
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: AuctionCard(
                                      auction: auction,
                                      onTap: () => context.push('/auction/${auction.id}'),
                                    ),
                                  );
                                },
                              ),
          ),
        ),
      ],
    );
  }

  String _getSortLabel(SortBy sortBy) {
    switch (sortBy) {
      case SortBy.priceAsc:
        return 'Price: Low to High';
      case SortBy.priceDesc:
        return 'Price: High to Low';
      case SortBy.yearNewest:
        return 'Year: Newest';
      case SortBy.yearOldest:
        return 'Year: Oldest';
      case SortBy.mileageLowest:
        return 'Mileage: Lowest';
      case SortBy.mileageHighest:
        return 'Mileage: Highest';
      case SortBy.horsepowerHighest:
        return 'Horsepower: Highest';
      case SortBy.horsepowerLowest:
        return 'Horsepower: Lowest';
      case SortBy.fuelEconomyBest:
        return 'Fuel Economy: Best';
      case SortBy.fuelEconomyWorst:
        return 'Fuel Economy: Worst';
      case SortBy.endingSoon:
        return 'Ending Soon';
      case SortBy.newest:
        return 'Newest First';
      case SortBy.mostViewed:
        return 'Most Viewed';
    }
  }
}
