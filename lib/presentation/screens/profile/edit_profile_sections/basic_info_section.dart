import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/user_model.dart';
import '../../../providers/auth_provider.dart';

/// Section 1: Basic Account Info
/// - Email (view only)
/// - Mobile Number (editable with OTP reconfirmation)
/// - Account Status (Verified / Pending / Suspended)
class BasicInfoSection extends ConsumerStatefulWidget {
  final UserModel user;

  const BasicInfoSection({super.key, required this.user});

  @override
  ConsumerState<BasicInfoSection> createState() => _BasicInfoSectionState();
}

class _BasicInfoSectionState extends ConsumerState<BasicInfoSection> {
  final _phoneController = TextEditingController();
  bool _isEditingPhone = false;

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.user.phoneNumber ?? '';
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Color _getStatusColor(AccountStatus status) {
    switch (status) {
      case AccountStatus.verified:
        return Colors.green;
      case AccountStatus.pending:
        return Colors.orange;
      case AccountStatus.locked:
      case AccountStatus.rejected:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(AccountStatus status) {
    switch (status) {
      case AccountStatus.verified:
        return 'Verified';
      case AccountStatus.pending:
        return 'Pending Verification';
      case AccountStatus.locked:
        return 'Account Locked';
      case AccountStatus.rejected:
        return 'Verification Rejected';
      case AccountStatus.guest:
        return 'Guest';
    }
  }

  Future<void> _updatePhoneNumber() async {
    // TODO: Implement OTP verification flow
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Phone Number'),
        content: const Text(
          'An OTP will be sent to your new number for verification. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Send OTP'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      // TODO: Trigger OTP send and navigate to OTP verification screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent! Please verify your new number.'),
          backgroundColor: Colors.blue,
        ),
      );
      setState(() => _isEditingPhone = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Section Header
        Text(
          'Basic Account Information',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Core account details and verification status',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 24),

        // Email (view only)
        Card(
          child: ListTile(
            leading: const Icon(Icons.email, color: Colors.blue),
            title: const Text('Email Address'),
            subtitle: Text(widget.user.email),
            trailing: Chip(
              label: const Text('Verified', style: TextStyle(fontSize: 11)),
              backgroundColor: Colors.green.shade50,
              side: BorderSide(color: Colors.green.shade200),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Mobile Number (editable with OTP)
        Card(
          child: _isEditingPhone
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'New Phone Number',
                          hintText: '+63 XXX XXX XXXX',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => setState(() => _isEditingPhone = false),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 8),
                          FilledButton.icon(
                            onPressed: _updatePhoneNumber,
                            icon: const Icon(Icons.sms, size: 18),
                            label: const Text('Verify with OTP'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : ListTile(
                  leading: const Icon(Icons.phone, color: Colors.green),
                  title: const Text('Mobile Number'),
                  subtitle: Text(widget.user.phoneNumber ?? 'Not set'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => setState(() => _isEditingPhone = true),
                  ),
                ),
        ),
        const SizedBox(height: 12),

        // Account Status
        Card(
          child: ListTile(
            leading: Icon(Icons.verified_user, color: _getStatusColor(widget.user.accountStatus)),
            title: const Text('Account Status'),
            subtitle: Text(_getStatusText(widget.user.accountStatus)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(widget.user.accountStatus).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _getStatusColor(widget.user.accountStatus)),
              ),
              child: Text(
                _getStatusText(widget.user.accountStatus).toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(widget.user.accountStatus),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Account ID (for reference)
        Card(
          color: Colors.grey[50],
          child: ListTile(
            leading: const Icon(Icons.fingerprint, color: Colors.grey),
            title: const Text('Account ID'),
            subtitle: Text(
              widget.user.id,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Member Since
        Card(
          color: Colors.grey[50],
          child: ListTile(
            leading: const Icon(Icons.calendar_today, color: Colors.grey),
            title: const Text('Member Since'),
            subtitle: Text(
              '${widget.user.createdAt.year}-${widget.user.createdAt.month.toString().padLeft(2, '0')}-${widget.user.createdAt.day.toString().padLeft(2, '0')}',
            ),
          ),
        ),
      ],
    );
  }
}
