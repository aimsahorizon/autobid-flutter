import 'package:flutter/material.dart';
import '../../data/models/car_model.dart';
import '../../core/utils/enum_extensions.dart';

class ListingStatusBadge extends StatelessWidget {
  final ListingStatus status;
  final bool isCompact;

  const ListingStatusBadge({
    super.key,
    required this.status,
    this.isCompact = false,
  });

  Color _getColor() {
    switch (status) {
      case ListingStatus.draft:
        return Colors.grey;
      case ListingStatus.pendingReview:
        return Colors.orange;
      case ListingStatus.active:
        return Colors.green;
      case ListingStatus.sold:
        return Colors.blue;
      case ListingStatus.cancelled:
        return Colors.red;
    }
  }

  IconData _getIcon() {
    switch (status) {
      case ListingStatus.draft:
        return Icons.edit_note;
      case ListingStatus.pendingReview:
        return Icons.pending;
      case ListingStatus.active:
        return Icons.check_circle;
      case ListingStatus.sold:
        return Icons.sell;
      case ListingStatus.cancelled:
        return Icons.cancel;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();

    if (isCompact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_getIcon(), size: 12, color: color),
            const SizedBox(width: 4),
            Text(
              status.displayName,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getIcon(), size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            status.displayName,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
