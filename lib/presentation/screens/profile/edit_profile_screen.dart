import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import 'edit_profile_sections/basic_info_section.dart';
import 'edit_profile_sections/personal_info_section.dart';
import 'edit_profile_sections/address_section.dart';
import 'edit_profile_sections/kyc_info_section.dart';
import 'edit_profile_sections/account_settings_section.dart';
import 'edit_profile_sections/privacy_section.dart';
import 'edit_profile_sections/reputation_section.dart';
import 'edit_profile_sections/danger_zone_section.dart';

/// Comprehensive Edit Profile Screen with tabbed sections
///
/// Sections:
/// 1. Basic Account Info
/// 2. Personal Information
/// 3. Address Information
/// 4. KYC Information (view-only)
/// 5. Account Settings
/// 6. Privacy & Data Management
/// 7. Reputation & System Info
/// 8. Danger Zone
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: const Center(child: Text('Please log in to edit your profile')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            tabs: const [
              Tab(icon: Icon(Icons.account_circle, size: 20), text: 'Basic'),
              // Tab(icon: Icon(Icons.person, size: 20), text: 'Personal'),
              Tab(icon: Icon(Icons.home, size: 20), text: 'Address'),
              // Tab(icon: Icon(Icons.privacy_tip, size: 20), text: 'Privacy'),
              Tab(icon: Icon(Icons.warning, size: 20), text: 'Danger'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BasicInfoSection(user: user),
          // PersonalInfoSection(user: user),
          AddressSection(user: user),
          // KycInfoSection(user: user),
          AccountSettingsSection(user: user),
          // PrivacySection(user: user),
          // ReputationSection(user: user),
          DangerZoneSection(user: user),
        ],
      ),
    );
  }
}
