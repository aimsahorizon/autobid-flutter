import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/listing_provider.dart';
import '../../providers/browse_provider.dart';
import '../browse/filter_bottom_sheet.dart';
import 'tabs/browse_tab.dart';
import 'tabs/watchlist_tab.dart';
import 'tabs/my_bids_tab.dart';
import 'tabs/my_listings_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  final int initialTabIndex;

  const HomeScreen({super.key, this.initialTabIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;
  bool _isGridView = false;
  bool _isBrowseGridView = true;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTabIndex;
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Browse Cars';
      case 1:
        return 'Watchlist';
      case 2:
        return 'My Bids';
      case 3:
        return 'My Listings';
      case 4:
        return 'Profile';
      default:
        return 'AutoBID';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        actions: [
          // Browse tab actions
          if (_selectedIndex == 0) ...[
            Consumer<BrowseProvider>(
              builder: (context, browseProvider, child) {
                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useRootNavigator: false,
                          enableDrag: true,
                          isDismissible: true,
                          showDragHandle: false,
                          useSafeArea: true,
                          transitionAnimationController: null,
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
                );
              },
            ),
            IconButton(
              icon: Icon(_isBrowseGridView ? Icons.view_list : Icons.grid_view),
              onPressed: () {
                setState(() {
                  _isBrowseGridView = !_isBrowseGridView;
                });
              },
            ),
          ],
          if (_selectedIndex == 3) // Show create listing button on My Listings tab
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Create Listing',
              onPressed: () {
                context.read<ListingProvider>().reset();
                context.push('/listing/create/step1');
              },
            ),
          if (_selectedIndex == 3) // Show grid/list toggle on My Listings tab
            IconButton(
              icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
              onPressed: () {
                setState(() {
                  _isGridView = !_isGridView;
                });
              },
            ),
          if (_selectedIndex != 4) // Don't show profile icon on profile tab
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                // Navigate to notifications
              },
            ),
          if (_selectedIndex != 4)
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                setState(() {
                  _selectedIndex = 4; // Navigate to profile tab
                });
              },
            ),
          if (_selectedIndex == 4) // Show settings icon on profile tab
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to settings
              },
            ),
        ],
      ),
      body: _getSelectedPage(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.directions_car_outlined),
            selectedIcon: Icon(Icons.directions_car),
            label: 'Browse',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Watchlist',
          ),
          NavigationDestination(
            icon: Icon(Icons.gavel_outlined),
            selectedIcon: Icon(Icons.gavel),
            label: 'My Bids',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt),
            selectedIcon: Icon(Icons.list_alt),
            label: 'My Listings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return BrowseTab(isGridView: _isBrowseGridView);
      case 1:
        return const WatchlistTab();
      case 2:
        return const MyBidsTab();
      case 3:
        return MyListingsTab(isGridView: _isGridView);
      case 4:
        return const ProfileTab();
      default:
        return BrowseTab(isGridView: _isBrowseGridView);
    }
  }
}
