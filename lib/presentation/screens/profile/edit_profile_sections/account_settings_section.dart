import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/user_model.dart';

/// Section 5: Account Settings
/// - Change password
/// - Enable/disable 2FA
/// - Notification preferences
/// - Language/Region
class AccountSettingsSection extends ConsumerStatefulWidget {
  final UserModel user;

  const AccountSettingsSection({super.key, required this.user});

  @override
  ConsumerState<AccountSettingsSection> createState() => _AccountSettingsSectionState();
}

class _AccountSettingsSectionState extends ConsumerState<AccountSettingsSection> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _smsNotifications = false;
  bool _twoFactorEnabled = false;
  String _selectedLanguage = 'English';
  String _selectedRegion = 'Philippines';

  final List<String> _languages = ['English', 'Filipino', 'Cebuano'];
  final List<String> _regions = ['Philippines', 'NCR', 'Luzon', 'Visayas', 'Mindanao'];

  Future<void> _changePassword() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => _ChangePasswordDialog(),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password changed successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _toggleTwoFactor(bool value) async {
    if (value) {
      // Enable 2FA
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Enable Two-Factor Authentication'),
          content: const Text(
            'You will receive an OTP via SMS for each login. Continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Enable'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        setState(() => _twoFactorEnabled = true);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Two-factor authentication enabled'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } else {
      setState(() => _twoFactorEnabled = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Two-factor authentication disabled'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Section Header
        Text(
          'Account Settings',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Manage your account security and preferences',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 12),

        // Notifications Section
        Text(
          'Notification Preferences',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),

        Card(
          child: Column(
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.email),
                title: const Text('Email Notifications'),
                subtitle: const Text('Receive updates via email'),
                value: _emailNotifications,
                onChanged: (value) => setState(() => _emailNotifications = value),
              ),
              const Divider(height: 1),
              SwitchListTile(
                secondary: const Icon(Icons.notifications),
                title: const Text('Push Notifications'),
                subtitle: const Text('Receive push notifications'),
                value: _pushNotifications,
                onChanged: (value) => setState(() => _pushNotifications = value),
              ),
              const Divider(height: 1),
              SwitchListTile(
                secondary: const Icon(Icons.sms),
                title: const Text('SMS Notifications'),
                subtitle: const Text('Receive SMS alerts'),
                value: _smsNotifications,
                onChanged: (value) => setState(() => _smsNotifications = value),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Language & Region
        Text(
          'Language & Region',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),

        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                subtitle: Text(_selectedLanguage),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _languages
                          .map((lang) => ListTile(
                                title: Text(lang),
                                trailing: _selectedLanguage == lang
                                    ? const Icon(Icons.check, color: Colors.green)
                                    : null,
                                onTap: () {
                                  setState(() => _selectedLanguage = lang);
                                  Navigator.pop(context);
                                },
                              ))
                          .toList(),
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Region'),
                subtitle: Text(_selectedRegion),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _regions
                          .map((region) => ListTile(
                                title: Text(region),
                                trailing: _selectedRegion == region
                                    ? const Icon(Icons.check, color: Colors.green)
                                    : null,
                                onTap: () {
                                  setState(() => _selectedRegion = region);
                                  Navigator.pop(context);
                                },
                              ))
                          .toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChangePasswordDialog extends StatefulWidget {
  @override
  State<_ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<_ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Password'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _currentPasswordController,
              obscureText: _obscureCurrent,
              decoration: InputDecoration(
                labelText: 'Current Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscureCurrent ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscureCurrent = !_obscureCurrent),
                ),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _newPasswordController,
              obscureText: _obscureNew,
              decoration: InputDecoration(
                labelText: 'New Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_obscureNew ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscureNew = !_obscureNew),
                ),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.length < 8) {
                  return 'Must be at least 8 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirm,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                ),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value != _newPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
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
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, true);
            }
          },
          child: const Text('Change Password'),
        ),
      ],
    );
  }
}
