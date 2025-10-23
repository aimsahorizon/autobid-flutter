import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/user_model.dart';

/// Section 6: Privacy & Data Management
/// - View Data Summary
/// - Download My Data (simulated)
/// - Request Account Deletion (soft delete)
class PrivacySection extends ConsumerWidget {
  final UserModel user;

  const PrivacySection({super.key, required this.user});

  Future<void> _showDataSummary(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your Data Summary'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDataRow('Account Created', '${user.createdAt}'.split(' ')[0]),
              _buildDataRow('Profile Updates', '23 times'),
              _buildDataRow('Auctions Participated', '15'),
              _buildDataRow('Bids Placed', '47'),
              _buildDataRow('Cars Listed', '3'),
              _buildDataRow('Transactions', '2'),
              _buildDataRow('Data Storage', '~45 MB'),
              const SizedBox(height: 16),
              Text(
                'Last updated: ${DateTime.now().toString().split(' ')[0]}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadData(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download Your Data'),
        content: const Text(
          'We will prepare a copy of your data and send it to your email within 48 hours. '
          'This includes all your profile information, auction history, and transactions.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Request Download'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data export requested. You will receive an email soon.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  static Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Section Header
        Text(
          'Privacy & Data Management',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Control your data and privacy settings',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 24),

        // View Data Summary
        Card(
          child: ListTile(
            leading: const Icon(Icons.pie_chart, color: Colors.blue),
            title: const Text('View Data Summary'),
            subtitle: const Text('See what data we have about you'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showDataSummary(context),
          ),
        ),
        const SizedBox(height: 12),

        // Download My Data
        Card(
          child: ListTile(
            leading: const Icon(Icons.download, color: Colors.green),
            title: const Text('Download My Data'),
            subtitle: const Text('Get a copy of your data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _downloadData(context),
          ),
        ),
        const SizedBox(height: 12),

        // Privacy Policy
        Card(
          child: ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.purple),
            title: const Text('Privacy Policy'),
            subtitle: const Text('Read our privacy policy'),
            trailing: const Icon(Icons.open_in_new, size: 20),
            onTap: () {
              // TODO: Open privacy policy
            },
          ),
        ),
        const SizedBox(height: 12),

        // Terms of Service
        Card(
          child: ListTile(
            leading: const Icon(Icons.description, color: Colors.orange),
            title: const Text('Terms of Service'),
            subtitle: const Text('Read our terms and conditions'),
            trailing: const Icon(Icons.open_in_new, size: 20),
            onTap: () {
              // TODO: Open terms of service
            },
          ),
        ),
        const SizedBox(height: 24),

        // Privacy Info Banner
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.security, color: Colors.blue.shade700, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your Privacy Matters',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'We are committed to protecting your personal data. Your information is encrypted and stored securely. '
                'You have full control over your data and can request deletion at any time.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blue.shade900,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
