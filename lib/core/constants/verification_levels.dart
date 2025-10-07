import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';

class VerificationLevelConfig {
  final VerificationLevel level;
  final String displayName;
  final String description;
  final IconData icon;
  final int buyLimit;
  final int sellLimit;
  final List<String> requirements;
  final List<String> benefits;

  const VerificationLevelConfig({
    required this.level,
    required this.displayName,
    required this.description,
    required this.icon,
    required this.buyLimit,
    required this.sellLimit,
    required this.requirements,
    required this.benefits,
  });
}

class VerificationLevels {
  static const unverified = VerificationLevelConfig(
    level: VerificationLevel.unverified,
    displayName: 'Unverified',
    description: 'Browse listings only',
    icon: Icons.person_outline,
    buyLimit: 0,
    sellLimit: 0,
    requirements: [
      'Complete account registration',
    ],
    benefits: [
      'Browse vehicle listings',
      'View auction details',
      'Save favorites',
    ],
  );

  static const level1 = VerificationLevelConfig(
    level: VerificationLevel.level1,
    displayName: 'Level 1 - Verified',
    description: 'Basic buying and selling',
    icon: Icons.verified_user,
    buyLimit: 500000,
    sellLimit: 500000,
    requirements: [
      'Valid government-issued ID',
      'Selfie verification',
      'Proof of address (issued within 3 months)',
    ],
    benefits: [
      'Buy vehicles up to ₱500,000',
      'Sell vehicles up to ₱500,000',
      'Place bids in auctions',
      'Verified badge on profile',
    ],
  );

  static const level2 = VerificationLevelConfig(
    level: VerificationLevel.level2,
    displayName: 'Level 2 - Enhanced',
    description: 'Higher transaction limits',
    icon: Icons.workspace_premium,
    buyLimit: 2000000,
    sellLimit: 2000000,
    requirements: [
      'All Level 1 requirements',
      'NBI clearance',
      'TIN (Tax Identification Number)',
      'Proof of income',
    ],
    benefits: [
      'Buy vehicles up to ₱2,000,000',
      'Sell vehicles up to ₱2,000,000',
      'Priority customer support',
      'Enhanced badge on profile',
    ],
  );

  static const level3 = VerificationLevelConfig(
    level: VerificationLevel.level3,
    displayName: 'Level 3 - Premium',
    description: 'Unlimited transactions',
    icon: Icons.stars,
    buyLimit: -1, // -1 represents unlimited
    sellLimit: -1,
    requirements: [
      'All Level 2 requirements',
      'Video KYC verification',
      'Source of funds declaration',
      'Bank account verification',
    ],
    benefits: [
      'Unlimited buying and selling',
      'VIP customer support',
      'Early access to new features',
      'Premium badge on profile',
      'Lower platform fees',
    ],
  );

  static const dealer = VerificationLevelConfig(
    level: VerificationLevel.dealer,
    displayName: 'Dealer Account',
    description: 'For registered car dealerships',
    icon: Icons.store,
    buyLimit: 2000000,
    sellLimit: -1, // Unlimited selling
    requirements: [
      'All Level 1 requirements',
      'DTI or SEC registration',
      "Mayor's permit",
      'Dealer license',
      'Business address verification',
    ],
    benefits: [
      'Unlimited vehicle listings',
      'Dealer badge on profile',
      'Featured listings',
      'Bulk upload tools',
      'Advanced analytics',
    ],
  );

  static List<VerificationLevelConfig> get all => [
        unverified,
        level1,
        level2,
        level3,
        dealer,
      ];

  static VerificationLevelConfig getConfig(VerificationLevel level) {
    switch (level) {
      case VerificationLevel.unverified:
        return unverified;
      case VerificationLevel.level1:
        return level1;
      case VerificationLevel.level2:
        return level2;
      case VerificationLevel.level3:
        return level3;
      case VerificationLevel.dealer:
        return dealer;
    }
  }

  static String formatLimit(int limit) {
    if (limit < 0) return 'Unlimited';
    if (limit == 0) return '₱0';
    return '₱${limit.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }
}
