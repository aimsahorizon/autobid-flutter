import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:autobid/data/models/subscription_tier.dart';
import 'package:autobid/presentation/providers/subscription_provider.dart';
import 'package:autobid/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

/// Subscription Selection Screen - GEMINI Revenue Model
///
/// Displays all subscription tiers with features and allows user to select/upgrade.
///
/// BACKEND INTEGRATION NOTES:
/// - Connect payment button to real payment gateway
/// - Handle payment success/failure callbacks
/// - Update user subscription in database
/// - Send confirmation email after successful subscription
class SubscriptionSelectionScreen extends ConsumerStatefulWidget {
  const SubscriptionSelectionScreen({super.key});

  @override
  ConsumerState<SubscriptionSelectionScreen> createState() =>
      _SubscriptionSelectionScreenState();
}

class _SubscriptionSelectionScreenState
    extends ConsumerState<SubscriptionSelectionScreen> {
  BillingCycle _selectedCycle = BillingCycle.monthly;

  @override
  Widget build(BuildContext context) {
    final tiers = ref.watch(availableSubscriptionTiersProvider);
    final currentUserAsync = ref.watch(authStateChangesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Plan'),
        centerTitle: true,
      ),
      body: currentUserAsync.when(
        data: (currentUser) {
          if (currentUser == null) {
            return const Center(child: Text('Please log in to view subscriptions'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Billing cycle toggle
                _buildBillingCycleToggle(),
                const SizedBox(height: 24),

                // Subscription tier cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: tiers.map((tier) {
                      final isCurrentTier =
                          currentUser.subscriptionTier == tier.tierType;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _buildTierCard(
                          tier: tier,
                          isCurrentTier: isCurrentTier,
                          userId: currentUser.id,
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 24),

                // Feature comparison hint
                _buildFeatureComparisonHint(),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildBillingCycleToggle() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildCycleButton(
              'Monthly',
              BillingCycle.monthly,
              _selectedCycle == BillingCycle.monthly,
            ),
          ),
          Expanded(
            child: _buildCycleButton(
              'Yearly (Save 17%)',
              BillingCycle.yearly,
              _selectedCycle == BillingCycle.yearly,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCycleButton(String label, BillingCycle cycle, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedCycle = cycle),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.purple : Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildTierCard({
    required SubscriptionTier tier,
    required bool isCurrentTier,
    required String userId,
  }) {
    final price = _selectedCycle == BillingCycle.monthly
        ? tier.monthlyPrice
        : tier.yearlyPrice;
    final pricePerMonth = _selectedCycle == BillingCycle.yearly
        ? tier.yearlyPrice / 12
        : tier.monthlyPrice;

    final isProTier = tier.tierType != SubscriptionTierType.free;
    final isPremium = tier.tierType == SubscriptionTierType.proPlus;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isPremium
              ? Colors.amber
              : isCurrentTier
                  ? Colors.purple
                  : Colors.grey[300]!,
          width: isPremium ? 3 : isCurrentTier ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          if (isPremium)
            BoxShadow(
              color: Colors.amber.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isPremium
                  ? Colors.amber[50]
                  : isProTier
                      ? Colors.purple[50]
                      : Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tier.displayName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isCurrentTier)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Current',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (isPremium && !isCurrentTier)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Recommended',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                if (tier.badge.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Badge: ${tier.badge}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₱${price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _selectedCycle == BillingCycle.monthly
                            ? '/month'
                            : '/year',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                if (_selectedCycle == BillingCycle.yearly && isProTier)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '₱${pricePerMonth.toStringAsFixed(0)}/month when billed yearly',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Features
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tier.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                ...tier.features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.purple[600],
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),

          // Action button
          if (!isCurrentTier)
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: tier.tierType == SubscriptionTierType.free
                      ? null
                      : () => _handleSubscribe(tier, userId),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: isPremium ? Colors.amber : Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    tier.tierType == SubscriptionTierType.free
                        ? 'Current Plan'
                        : 'Choose ${tier.displayName}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeatureComparisonHint() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Choose the plan that fits your bidding needs. You can upgrade or downgrade anytime.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.blue[900],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubscribe(SubscriptionTier tier, String userId) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Subscribe to ${tier.displayName}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You will be charged ${_selectedCycle == BillingCycle.monthly ? "₱${tier.monthlyPrice.toStringAsFixed(0)}/month" : "₱${tier.yearlyPrice.toStringAsFixed(0)}/year"}.',
            ),
            const SizedBox(height: 16),
            const Text(
              'BACKEND NOTE: Payment gateway integration required here.',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Proceed to Payment'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      // Show loading indicator
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(width: 16),
                Text('Processing subscription...'),
              ],
            ),
            duration: Duration(seconds: 30),
          ),
        );
      }

      try {
        // Call subscription action using widget's ref (not dialog's context)
        final subscription =
            await ref.read(subscriptionActionsProvider.notifier).subscribe(
                  userId: userId,
                  tierType: tier.tierType,
                  billingCycle: _selectedCycle,
                );

        if (mounted) {
          // Clear loading snackbar
          ScaffoldMessenger.of(context).clearSnackBars();

          // Invalidate auth provider to refresh user data
          ref.invalidate(authStateChangesProvider);
          ref.invalidate(currentUserProvider);

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Successfully subscribed to ${tier.displayName}!',
              ),
              backgroundColor: Colors.purple,
              duration: const Duration(seconds: 3),
            ),
          );

          // Navigate back or to success screen
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          // Clear loading snackbar
          ScaffoldMessenger.of(context).clearSnackBars();

          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to subscribe: $e'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        }
      }
    }
  }
}
