import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/user_model.dart';
import '../../../providers/auth_provider.dart';

/// Section 8: Danger Zone
/// - Deactivate Account
/// - Permanently Delete Account
/// - Report an Issue button
class DangerZoneSection extends ConsumerWidget {
  final UserModel user;

  const DangerZoneSection({super.key, required this.user});

  Future<void> _deactivateAccount(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.pause_circle_outline,
            size: 48,
            color: Colors.orange.shade700,
          ),
        ),
        title: const Text('Deactivate Account'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your account will be temporarily disabled. You can reactivate it anytime by logging in again.'),
            SizedBox(height: 16),
            Text(
              'While deactivated:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• Your profile will be hidden'),
            Text('• You cannot place bids or list cars'),
            Text('• Active auctions will be paused'),
            Text('• Your data will be preserved'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text('Deactivate'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      // TODO: Implement account deactivation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account deactivated. You can reactivate it anytime.'),
          backgroundColor: Colors.orange,
        ),
      );
      // Logout user
      context.go('/login');
    }
  }

  Future<void> _deleteAccount(BuildContext context, WidgetRef ref) async {
    // First confirmation
    final firstConfirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.delete_forever,
            size: 48,
            color: Colors.red.shade700,
          ),
        ),
        title: const Text('Delete Account Permanently'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This action cannot be undone!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16),
            Text('If you delete your account:'),
            SizedBox(height: 8),
            Text('• All your data will be permanently deleted'),
            Text('• Your profile and listings will be removed'),
            Text('• Transaction history will be archived'),
            Text('• You cannot recover your account'),
            SizedBox(height: 16),
            Text(
              'Are you sure you want to continue?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );

    if (firstConfirm != true) return;

    // Second confirmation with password
    final passwordController = TextEditingController();
    final secondConfirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter your password to confirm account deletion:'),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              // TODO: Verify password
              if (passwordController.text.isNotEmpty) {
                Navigator.pop(context, true);
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );

    passwordController.dispose();

    if (secondConfirm == true && context.mounted) {
      // TODO: Implement account deletion (soft delete)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account deletion requested. We\'re sorry to see you go.'),
          backgroundColor: Colors.red,
        ),
      );
      // Logout user
      context.go('/login');
    }
  }

  Future<void> _reportIssue(BuildContext context) async {
    final issueController = TextEditingController();
    final categoryController = TextEditingController();

    final submitted = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report an Issue'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Issue Category',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'bug', child: Text('Bug/Technical Issue')),
                  DropdownMenuItem(value: 'abuse', child: Text('Report Abuse')),
                  DropdownMenuItem(value: 'payment', child: Text('Payment Issue')),
                  DropdownMenuItem(value: 'account', child: Text('Account Problem')),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: (value) => categoryController.text = value ?? '',
              ),
              const SizedBox(height: 16),
              TextField(
                controller: issueController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Describe the issue',
                  hintText: 'Please provide details...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (issueController.text.isNotEmpty) {
                Navigator.pop(context, true);
              }
            },
            child: const Text('Submit Report'),
          ),
        ],
      ),
    );

    issueController.dispose();
    categoryController.dispose();

    if (submitted == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Issue reported. Our team will review it shortly.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Section Header
        Row(
          children: [
            Icon(Icons.warning, color: Colors.red.shade700),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Danger Zone',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Irreversible actions - proceed with caution',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.red.shade600,
              ),
        ),
        const SizedBox(height: 24),

        // Warning Banner
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.shade300, width: 2),
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade700, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'These actions are permanent and cannot be undone. Make sure you understand the consequences before proceeding.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.red.shade900,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Report an Issue (Not dangerous, but useful here)
        Card(
          child: ListTile(
            leading: const Icon(Icons.report_problem, color: Colors.blue),
            title: const Text('Report an Issue'),
            subtitle: const Text('Report a problem or abuse'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _reportIssue(context),
          ),
        ),
        const SizedBox(height: 16),

        // Deactivate Account
        Card(
          color: Colors.orange.shade50,
          child: ListTile(
            leading: Icon(Icons.pause_circle_outline, color: Colors.orange.shade700),
            title: const Text(
              'Deactivate Account',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Temporarily disable your account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _deactivateAccount(context, ref),
          ),
        ),
        const SizedBox(height: 12),

        // Delete Account
        Card(
          color: Colors.red.shade50,
          child: ListTile(
            leading: Icon(Icons.delete_forever, color: Colors.red.shade700),
            title: const Text(
              'Delete Account Permanently',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Permanently delete your account and data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _deleteAccount(context, ref),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
