import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/subscription_tier.dart';
import '../providers/auth_provider.dart';

/// Subscription Card Widget
///
/// Displays user's current subscription tier and allows management/upgrade
class SubscriptionCard extends ConsumerWidget {
  const SubscriptionCard({super.key});

  Color _getTierColor(SubscriptionTierType tier) {
    switch (tier) {
      case SubscriptionTierType.free:
        return Colors.grey;
      case SubscriptionTierType.proBasic:
        return Colors.blue;
      case SubscriptionTierType.proPlus:
        return Colors.purple;
    }
  }

  IconData _getTierIcon(SubscriptionTierType tier) {
    switch (tier) {
      case SubscriptionTierType.free:
        return Icons.person_outline;
      case SubscriptionTierType.proBasic:
        return Icons.workspace_premium;
      case SubscriptionTierType.proPlus:
        return Icons.verified;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentUserAsync = ref.watch(authStateChangesProvider);

    return currentUserAsync.when(
      data: (user) {
        if (user == null) {
          return const SizedBox.shrink();
        }

        final tier = user.subscriptionTier;
        final tierConfig = tier.config;
        final tierColor = _getTierColor(tier);

        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                tierColor.withOpacity(0.1),
                tierColor.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: tierColor.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: tierColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getTierIcon(tier),
                        color: tierColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                tierConfig.displayName,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: tierColor,
                                ),
                              ),
                              if (tierConfig.badge.isNotEmpty) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: tierColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    tierConfig.badge,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Current Subscription',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Quick Stats
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Monthly Tokens
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.toll,
                                size: 20,
                                color: Colors.amber[700],
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Monthly Tokens',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Text(
                            tierConfig.monthlyTokenAllocation == -1
                                ? 'Unlimited'
                                : '${tierConfig.monthlyTokenAllocation}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      // Listings Quota
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.directions_car,
                                size: 20,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Listings/Month',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Text(
                            '${user.listingsUsedThisMonth}/${tierConfig.maxListingsPerMonth}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Key Features
                if (tier != SubscriptionTierType.proPlus) ...[
                  Text(
                    tier == SubscriptionTierType.free
                        ? 'Upgrade to unlock premium features'
                        : 'Upgrade to Pro Plus for unlimited tokens',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // Action Buttons
                Row(
                  children: [
                    if (tier != SubscriptionTierType.proPlus)
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            context.push('/subscription');
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: tierColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(Icons.upgrade, size: 20),
                          label: Text(
                            tier == SubscriptionTierType.free
                                ? 'Upgrade Plan'
                                : 'Upgrade to Pro Plus',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    if (tier != SubscriptionTierType.proPlus)
                      const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context.push('/subscription');
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: tierColor),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        icon: Icon(Icons.info_outline, size: 20, color: tierColor),
                        label: Text(
                          'View Plans',
                          style: TextStyle(fontSize: 14, color: tierColor),
                        ),
                      ),
                    ),
                  ],
                ),

                // Pro Plus users get manage button
                if (tier == SubscriptionTierType.proPlus) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green.shade700, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'You\'re enjoying all premium features!',
                            style: TextStyle(
                              color: Colors.green.shade900,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}
