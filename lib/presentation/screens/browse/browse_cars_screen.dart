import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/browse_provider.dart';
import '../../widgets/car_card.dart';
import 'filter_bottom_sheet.dart';

class BrowseCarsScreen extends StatefulWidget {
  const BrowseCarsScreen({super.key});

  @override
  State<BrowseCarsScreen> createState() => _BrowseCarsScreenState();
}

class _BrowseCarsScreenState extends State<BrowseCarsScreen> {
  bool _isGridView = true;

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Cars'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.push('/search');
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const FilterBottomSheet(),
                  );
                },
              ),
              if (browseProvider.hasActiveFilters)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${browseProvider.activeFilterCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: RefreshIndicator(
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
                            child: _isGridView
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
      ),
    );
  }
}
