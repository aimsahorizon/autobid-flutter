import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/kyc_provider.dart';
import '../../../data/models/kyc_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load KYC status
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<KycProvider>();
      provider.loadKycStatus('mock-user-id');
    });
  }

  @override
  Widget build(BuildContext context) {
    final kycProvider = context.watch<KycProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoBID'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              context.push('/profile');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // KYC Banner
          if (kycProvider.kycData?.verificationStatus !=
              KycVerificationStatus.verified)
            _buildKycBanner(context, kycProvider),

          // Main Content
          Expanded(
            child: _getSelectedPage(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.gavel_outlined),
            selectedIcon: Icon(Icons.gavel),
            label: 'My Bids',
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

  Widget _buildKycBanner(BuildContext context, KycProvider kycProvider) {
    final kycData = kycProvider.kycData;

    Color backgroundColor;
    Color textColor;
    IconData icon;
    String title;
    String subtitle;
    VoidCallback? onTap;

    if (kycData == null) {
      backgroundColor = Colors.orange.shade100;
      textColor = Colors.orange.shade900;
      icon = Icons.warning_amber;
      title = 'Complete KYC to Start Trading';
      subtitle = 'Verify your identity to place bids and list vehicles';
      onTap = () => context.push('/kyc-intro');
    } else if (kycData.verificationStatus == KycVerificationStatus.pending) {
      backgroundColor = Colors.blue.shade100;
      textColor = Colors.blue.shade900;
      icon = Icons.pending_actions;
      title = 'KYC Verification in Progress';
      subtitle = 'We\'re reviewing your documents. This usually takes a few minutes.';
      onTap = () => context.push('/kyc-status');
    } else {
      // Rejected
      backgroundColor = Colors.red.shade100;
      textColor = Colors.red.shade900;
      icon = Icons.error_outline;
      title = 'KYC Verification Failed';
      subtitle = 'Please resubmit your documents to continue';
      onTap = () => context.push('/kyc-status');
    }

    return Container(
      margin: const EdgeInsets.all(16),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: textColor, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: textColor.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: textColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return const _HomePage();
      case 1:
        return const _SearchPage();
      case 2:
        return const _MyBidsPage();
      case 3:
        return const _ProfileNavigator();
      default:
        return const _HomePage();
    }
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_car,
              size: 100,
              color: colorScheme.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to AutoBID',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Your premier platform for vehicle auctions',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {
                // Navigate to browse vehicles
              },
              icon: const Icon(Icons.search),
              label: const Text('Browse Vehicles'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchPage extends StatelessWidget {
  const _SearchPage();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: colorScheme.primary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Search',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Coming soon',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
          ),
        ],
      ),
    );
  }
}

class _MyBidsPage extends StatelessWidget {
  const _MyBidsPage();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.gavel,
            size: 80,
            color: colorScheme.primary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'My Bids',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'No active bids yet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
          ),
        ],
      ),
    );
  }
}

class _ProfileNavigator extends StatelessWidget {
  const _ProfileNavigator();

  @override
  Widget build(BuildContext context) {
    // Navigate to profile screen when this tab is selected
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.push('/profile');
    });

    return const SizedBox.shrink();
  }
}
