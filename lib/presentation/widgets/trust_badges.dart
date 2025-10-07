import 'package:flutter/material.dart';

class TrustBadge {
  final String label;
  final bool isVerified;
  final IconData icon;

  const TrustBadge({
    required this.label,
    required this.isVerified,
    required this.icon,
  });
}

class TrustBadges extends StatelessWidget {
  final bool emailVerified;
  final bool phoneVerified;
  final bool idVerified;
  final bool addressVerified;
  final double iconSize;
  final double fontSize;

  const TrustBadges({
    super.key,
    this.emailVerified = false,
    this.phoneVerified = false,
    this.idVerified = false,
    this.addressVerified = false,
    this.iconSize = 16,
    this.fontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final badges = [
      TrustBadge(
        label: 'Email',
        isVerified: emailVerified,
        icon: Icons.email,
      ),
      TrustBadge(
        label: 'Phone',
        isVerified: phoneVerified,
        icon: Icons.phone,
      ),
      TrustBadge(
        label: 'ID',
        isVerified: idVerified,
        icon: Icons.badge,
      ),
      TrustBadge(
        label: 'Address',
        isVerified: addressVerified,
        icon: Icons.home,
      ),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: badges.map((badge) {
        final badgeColor = badge.isVerified
            ? colorScheme.primary
            : colorScheme.outline.withValues(alpha: 0.5);
        final backgroundColor = badge.isVerified
            ? colorScheme.primary.withValues(alpha: 0.1)
            : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: badgeColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                badge.icon,
                size: iconSize,
                color: badgeColor,
              ),
              const SizedBox(width: 4),
              Text(
                badge.label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: badgeColor,
                ),
              ),
              const SizedBox(width: 2),
              if (badge.isVerified)
                Icon(
                  Icons.check_circle,
                  size: iconSize - 2,
                  color: badgeColor,
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
