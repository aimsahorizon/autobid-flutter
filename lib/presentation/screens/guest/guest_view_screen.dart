import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import 'tabs/browse_tab.dart';
import 'tabs/account_tab.dart';

class GuestViewScreen extends StatefulWidget {
  final int initialTab;

  const GuestViewScreen({super.key, this.initialTab = 0});

  @override
  State<GuestViewScreen> createState() => _GuestViewScreenState();
}

class _GuestViewScreenState extends State<GuestViewScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoBID'),
        centerTitle: true,
        backgroundColor: ColorConstants.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          BrowseTab(),
          AccountTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        selectedItemColor: ColorConstants.primaryGreen,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_outlined),
            activeIcon: Icon(Icons.directions_car),
            label: 'Browse Listings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
