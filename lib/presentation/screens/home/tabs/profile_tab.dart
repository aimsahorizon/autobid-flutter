import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/services/mock/mock_review_service.dart';
import '../../../widgets/reviews/rating_badge.dart';
import '../widgets/profile_stat_item.dart';
import '../widgets/profile_info_tile.dart';
import '../widgets/profile_action_button.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _reviewService = MockReviewService();
  double _averageRating = 0;
  int _reviewCount = 0;
  bool _isLoadingReviews = true;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    // Mock user ID - would come from auth
    const userId = 'user123';
    final reviews = await _reviewService.getSellerReviews(userId);

    if (!mounted) return;

    setState(() {
      _reviewCount = reviews.length;
      if (reviews.isNotEmpty) {
        final sum = reviews.fold<double>(0, (sum, r) => sum + r.overallRating);
        _averageRating = sum / reviews.length;
      }
      _isLoadingReviews = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Mock user data - would come from auth provider in production
    const userName = 'John Doe';
    const userEmail = 'john.doe@example.com';
    const userPhone = '+1 234 567 8900';
    const userId = 'user123';

    return SingleChildScrollView(
      child: Column(
        children: [
          // Profile Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withValues(alpha: 0.8),
                ],
              ),
            ),
            child: Column(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Text(
                    userName[0],
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Name
                Text(
                  userName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),

                // Email
                Text(
                  userEmail,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                ),
              ],
            ),
          ),

          // Stats Section
          Container(
            padding: const EdgeInsets.all(24),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileStatItem(
                  icon: Icons.gavel,
                  value: '0',
                  label: 'Active Bids',
                ),
                ProfileStatItem(
                  icon: Icons.emoji_events,
                  value: '0',
                  label: 'Won Auctions',
                ),
                ProfileStatItem(
                  icon: Icons.directions_car,
                  value: '0',
                  label: 'Listed Cars',
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Seller Reviews Section
          if (!_isLoadingReviews && _reviewCount > 0)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'Seller Rating',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  RatingBadge(
                    rating: _averageRating,
                    reviewCount: _reviewCount,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.push(
                          '/seller-reviews/$userId?sellerName=${Uri.encodeComponent(userName)}',
                        );
                      },
                      icon: const Icon(Icons.rate_review, size: 18),
                      label: const Text('View All Reviews'),
                    ),
                  ),
                ],
              ),
            ),

          if (_isLoadingReviews)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            ),

          const Divider(height: 1),

          // Profile Info Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personal Information',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                const ProfileInfoTile(
                  icon: Icons.person,
                  label: 'Full Name',
                  value: userName,
                ),
                const ProfileInfoTile(
                  icon: Icons.email,
                  label: 'Email',
                  value: userEmail,
                ),
                const ProfileInfoTile(
                  icon: Icons.phone,
                  label: 'Phone',
                  value: userPhone,
                ),

                const SizedBox(height: 24),

                // Actions
                ProfileActionButton(
                  icon: Icons.edit,
                  label: 'Edit Profile',
                  onTap: () {
                    // Navigate to edit profile
                  },
                ),
                const SizedBox(height: 12),
                ProfileActionButton(
                  icon: Icons.receipt_long,
                  label: 'My Transactions',
                  onTap: () {
                    context.push('/transactions');
                  },
                ),
                const SizedBox(height: 12),
                ProfileActionButton(
                  icon: Icons.security,
                  label: 'Security Settings',
                  onTap: () {
                    // Navigate to security settings
                  },
                ),
                const SizedBox(height: 12),
                ProfileActionButton(
                  icon: Icons.help_outline,
                  label: 'Help & Support',
                  onTap: () {
                    // Navigate to help
                  },
                ),
                const SizedBox(height: 24),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                    icon: const Icon(Icons.logout, color: Colors.red),
                    label: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
