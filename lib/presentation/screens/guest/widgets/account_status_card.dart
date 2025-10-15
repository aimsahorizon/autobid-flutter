import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/user_model.dart';
import '../../../widgets/custom_button.dart';

class AccountStatusCard extends StatelessWidget {
  final UserModel user;

  const AccountStatusCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Application Status',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.primaryGreen,
                ),
          ),
          const SizedBox(height: 24),
          _buildStatusCard(context),
          const SizedBox(height: 32),
          _buildUserInfo(context),
          const SizedBox(height: 32),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color iconColor;
    IconData icon;
    String title;
    String message;

    switch (user.accountStatus) {
      case AccountStatus.pending:
        backgroundColor = Colors.blue[50]!;
        borderColor = Colors.blue[200]!;
        iconColor = Colors.blue[700]!;
        icon = Icons.pending_actions_outlined;
        title = 'Application Under Review';
        message =
            'Your registration is being reviewed. We will notify you via email within 24-48 hours.';
        break;
      case AccountStatus.rejected:
        backgroundColor = Colors.red[50]!;
        borderColor = Colors.red[200]!;
        iconColor = Colors.red[700]!;
        icon = Icons.cancel_outlined;
        title = 'Application Rejected';
        message = user.rejectionReason ?? 'Your application was rejected.';
        break;
      case AccountStatus.locked:
        backgroundColor = Colors.grey[300]!;
        borderColor = Colors.grey[400]!;
        iconColor = Colors.grey[700]!;
        icon = Icons.lock_outline;
        title = 'Account Locked';
        message =
            'Your account has been locked due to too many failed OTP attempts. Please contact support.';
        break;
      default:
        backgroundColor = Colors.grey[50]!;
        borderColor = Colors.grey[300]!;
        iconColor = Colors.grey[600]!;
        icon = Icons.info_outline;
        title = 'Unknown Status';
        message = 'Your account status is unknown.';
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Icon(icon, size: 64, color: iconColor),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: iconColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Information',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.person, 'Name', user.fullName),
          _buildInfoRow(Icons.email, 'Email', user.email),
          if (user.phoneNumber != null)
            _buildInfoRow(Icons.phone, 'Phone', user.phoneNumber!),
          _buildInfoRow(
            Icons.calendar_today,
            'Registered',
            _formatDate(user.createdAt),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        if (user.accountStatus == AccountStatus.rejected) ...[
          CustomButton(
            text: 'Edit Application',
            onPressed: () {
              // TODO: Navigate to edit flow with pre-filled data
              context.go('/signup/step1');
            },
          ),
          const SizedBox(height: 12),
        ],
        CustomButton(
          text: 'Browse as Guest',
          onPressed: () {
            context.go('/guest?tab=0');
          },
          isOutlined: true,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            // Sign out
            context.go('/login');
          },
          child: const Text('Sign Out'),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
