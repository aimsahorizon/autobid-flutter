import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/browse_provider.dart';
import '../../widgets/car_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus search field
    Future.delayed(const Duration(milliseconds: 100), () {
      _searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final browseProvider = context.watch<BrowseProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocus,
          decoration: const InputDecoration(
            hintText: 'Search cars...',
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 18),
          ),
          style: const TextStyle(fontSize: 18),
          onChanged: (value) {
            browseProvider.searchCars(value);
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                browseProvider.searchCars('');
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Quick filter chips
          if (_searchController.text.isEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Popular Searches',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildQuickSearchChip('Toyota'),
                      _buildQuickSearchChip('Honda'),
                      _buildQuickSearchChip('Mitsubishi'),
                      _buildQuickSearchChip('SUV'),
                      _buildQuickSearchChip('Sedan'),
                      _buildQuickSearchChip('Pickup'),
                    ],
                  ),
                ],
              ),
            ),
          ],

          // Search results
          if (_searchController.text.isNotEmpty)
            Expanded(
              child: browseProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : browseProvider.filteredCars.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 80,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No results found',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try a different search term',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                '${browseProvider.filteredCars.length} result(s) found',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: browseProvider.filteredCars.length,
                                itemBuilder: (context, index) {
                                  final car = browseProvider.filteredCars[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: CarCard(
                                      car: car,
                                      onTap: () {
                                        context.push('/car/${car.id}');
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickSearchChip(String label) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        _searchController.text = label;
        context.read<BrowseProvider>().searchCars(label);
      },
    );
  }
}
