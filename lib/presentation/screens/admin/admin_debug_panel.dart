import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/color_constants.dart';
import '../../../data/models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';

/// Admin Debug Panel for testing KYC approval/rejection flow
/// This is a debug-only feature for prototype testing
class AdminDebugPanel extends ConsumerStatefulWidget {
  const AdminDebugPanel({super.key});

  @override
  ConsumerState<AdminDebugPanel> createState() => _AdminDebugPanelState();
}

class _AdminDebugPanelState extends ConsumerState<AdminDebugPanel> {
  final _rejectionReasonController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _rejectionReasonController.dispose();
    super.dispose();
  }

  Future<void> _handleStatusChange(AccountStatus status) async {
    final user = ref.read(currentUserProvider);
    if (user == null) {
      _showMessage('No user logged in', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.updateAccountStatus(
        userId: user.id,
        status: status,
        rejectionReason: status == AccountStatus.rejected
            ? _rejectionReasonController.text
            : null,
      );

      if (!mounted) return;

      if (result.success) {
        _showMessage('Account status updated to ${status.name}');
        Navigator.of(context).pop();
      } else {
        _showMessage(result.errorMessage ?? 'Failed to update status',
            isError: true);
      }
    } catch (e) {
      if (mounted) {
        _showMessage('Error: $e', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? ColorConstants.error : ColorConstants.primaryGreen,
      ),
    );
  }

  void _showConfirmDialog(AccountStatus status, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            if (status == AccountStatus.rejected) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _rejectionReasonController,
                decoration: InputDecoration(
                  labelText: 'Rejection Reason',
                  hintText: 'Enter reason for rejection',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _handleStatusChange(status);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: status == AccountStatus.rejected
                  ? ColorConstants.error
                  : ColorConstants.primaryGreen,
            ),
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final authService = ref.read(authServiceProvider);
    final allUsers = authService.getAllUsers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Debug Panel'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.orange),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'DEBUG ONLY: Admin panel for testing KYC approval/rejection flows',
                      style: TextStyle(
                        color: Colors.orange.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Current User Section
            if (user != null) ...[
              Text(
                'Current User',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              _buildUserCard(user, isCurrent: true),
              const SizedBox(height: 32),
            ],

            // All Users Section
            Text(
              'All Users (${allUsers.length})',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            if (allUsers.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    'No users registered yet',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ),
              )
            else
              ...allUsers.map((u) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildUserCard(u),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(UserModel user, {bool isCurrent = false}) {
    return Card(
      elevation: isCurrent ? 4 : 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: ColorConstants.primaryGreen,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'CURRENT',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryGreen,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Status Badge
            _buildStatusBadge(user.accountStatus),

            const SizedBox(height: 8),

            // Additional Info
            Text(
              'Phone: ${user.phoneNumber ?? 'N/A'}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'KYC Status: ${user.kycStatus}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Created: ${_formatDate(user.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            if (user.rejectionReason != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorConstants.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Rejection Reason: ${user.rejectionReason}',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstants.error,
                  ),
                ),
              ),
            ],

            // Admin Actions (only if this is the current user)
            if (isCurrent && user.accountStatus != AccountStatus.guest) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                'Admin Actions',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isLoading
                          ? null
                          : () => _showConfirmDialog(
                                AccountStatus.verified,
                                'Approve KYC',
                                'Approve this user\'s KYC and grant full access?',
                              ),
                      icon: Icon(Icons.check_circle),
                      label: Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isLoading
                          ? null
                          : () => _showConfirmDialog(
                                AccountStatus.rejected,
                                'Reject KYC',
                                'Reject this user\'s KYC submission?',
                              ),
                      icon: Icon(Icons.cancel),
                      label: Text('Reject'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.error,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              if (user.accountStatus == AccountStatus.locked) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading
                        ? null
                        : () => _handleStatusChange(AccountStatus.pending),
                    icon: Icon(Icons.lock_open),
                    label: Text('Unlock Account'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(AccountStatus status) {
    Color color;
    IconData icon;
    String text;

    switch (status) {
      case AccountStatus.guest:
        color = Colors.grey;
        icon = Icons.visibility_outlined;
        text = 'Guest';
        break;
      case AccountStatus.pending:
        color = Colors.orange;
        icon = Icons.hourglass_empty;
        text = 'Pending Review';
        break;
      case AccountStatus.verified:
        color = Colors.green;
        icon = Icons.verified;
        text = 'Verified';
        break;
      case AccountStatus.rejected:
        color = ColorConstants.error;
        icon = Icons.cancel;
        text = 'Rejected';
        break;
      case AccountStatus.locked:
        color = Colors.red.shade900;
        icon = Icons.lock;
        text = 'Locked';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
