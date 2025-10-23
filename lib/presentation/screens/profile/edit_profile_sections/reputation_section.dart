import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/user_model.dart';

/// Section 7: Reputation & System Info
/// - Average Rating (stars)
/// - Trust Level badge (Low/Medium/High)
/// - View Transaction History button
class ReputationSection extends ConsumerWidget {
  final UserModel user;

  const ReputationSection({super.key, required this.user});

  Widget _buildTrustBadge(BuildContext context, VerificationLevel level) {
    String label;
    Color color;
    IconData icon;

    switch (level) {
      case VerificationLevel.level3:
      case VerificationLevel.dealer:
        label = 'High Trust';
        color = Colors.green;
        icon = Icons.shield;
        break;
      case VerificationLevel.level2:
        label = 'Medium Trust';
        color = Colors.orange;
        icon = Icons.verified;
        break;
      case VerificationLevel.level1:
        label = 'Low Trust';
        color = Colors.blue;
        icon = Icons.verified_user_outlined;
        break;
      default:
        label = 'Unverified';
        color = Colors.grey;
        icon = Icons.person_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data - replace with actual values from user model
    final double averageRating = 4.5;
    final int totalReviews = 23;
    final int totalTransactions = 15;
    final int successfulTransactions = 14;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Section Header
        Text(
          'Reputation & Activity',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your standing in the AutoBID community',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 24),

        // Trust Level Badge
        Center(
          child: Column(
            children: [
              Icon(
                Icons.shield,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              _buildTrustBadge(context, user.verificationLevel),
              const SizedBox(height: 8),
              Text(
                'Verification Level: ${user.verificationLevel.name.toUpperCase()}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Rating Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < averageRating.floor()
                                  ? Icons.star
                                  : index < averageRating
                                      ? Icons.star_half
                                      : Icons.star_border,
                              color: Colors.amber,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$totalReviews reviews',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn('Transactions', '$totalTransactions'),
                    _buildStatColumn('Success Rate', '${(successfulTransactions / totalTransactions * 100).toStringAsFixed(0)}%'),
                    _buildStatColumn('Bids Won', '7'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Activity Stats
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.gavel, color: Colors.blue),
                title: const Text('Auctions Participated'),
                trailing: const Text(
                  '23',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.directions_car, color: Colors.green),
                title: const Text('Cars Sold'),
                trailing: const Text(
                  '3',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.shopping_bag, color: Colors.orange),
                title: const Text('Cars Purchased'),
                trailing: const Text(
                  '2',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // View Transaction History
        Card(
          child: ListTile(
            leading: const Icon(Icons.history, color: Colors.purple),
            title: const Text('Transaction History'),
            subtitle: const Text('View all your past transactions'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to transaction history
            },
          ),
        ),
        const SizedBox(height: 12),

        // View Reviews
        Card(
          child: ListTile(
            leading: const Icon(Icons.rate_review, color: Colors.blue),
            title: const Text('My Reviews'),
            subtitle: const Text('See what others say about you'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to reviews
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
