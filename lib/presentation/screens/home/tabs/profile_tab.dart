import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/verification_levels.dart';
import '../../../../data/models/user_model.dart';
import '../../../widgets/trust_badges.dart';
import '../widgets/profile_stat_item.dart';
import '../widgets/profile_info_tile.dart';
import '../widgets/profile_action_button.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Mock user data - would come from auth provider in production
    const userName = 'John Doe';
    const userEmail = 'john.doe@example.com';
    const userPhone = '+1 234 567 8900';
    const verificationLevel = VerificationLevel.level1;
    final verificationConfig = VerificationLevels.getConfig(verificationLevel);

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

          // Verification Level Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      verificationConfig.icon,
                      color: colorScheme.primary,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            verificationConfig.displayName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            verificationConfig.description,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Buy Limit',
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            VerificationLevels.formatLimit(
                                verificationConfig.buyLimit),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: colorScheme.outline.withValues(alpha: 0.3),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sell Limit',
                              style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.onSurface
                                    .withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              VerificationLevels.formatLimit(
                                  verificationConfig.sellLimit),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (verificationLevel != VerificationLevel.level3 &&
                    verificationLevel != VerificationLevel.dealer) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => context.push('/verification-levels'),
                      icon: const Icon(Icons.arrow_upward),
                      label: const Text('Upgrade Verification'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.primary,
                        side: BorderSide(color: colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Trust Badges
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TrustBadges(
              emailVerified: true,
              phoneVerified: true,
              idVerified: true,
              addressVerified: true,
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
