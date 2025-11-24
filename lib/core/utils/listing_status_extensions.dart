import '../../data/models/car_model.dart';

/// Extension for ListingStatus enum with display properties and business logic
///
/// Backend Integration Notes:
/// - Status transitions should be validated server-side
/// - Include audit log for status changes (user_id, timestamp, reason)
/// - pendingReview -> active (admin approves)
/// - pendingReview -> cancelled (admin rejects or user cancels)
extension ListingStatusExtension on ListingStatus {
  String get displayName {
    switch (this) {
      case ListingStatus.draft:
        return 'Draft';
      case ListingStatus.pendingReview:
        return 'Pending Review';
      case ListingStatus.active:
        return 'Active';
      case ListingStatus.sold:
        return 'Sold';
      case ListingStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get description {
    switch (this) {
      case ListingStatus.draft:
        return 'Incomplete listing, not submitted';
      case ListingStatus.pendingReview:
        return 'Awaiting admin approval';
      case ListingStatus.active:
        return 'Live in marketplace';
      case ListingStatus.sold:
        return 'Vehicle has been sold';
      case ListingStatus.cancelled:
        return 'Listing cancelled';
    }
  }

  /// Color indicator for UI display (hex color values)
  int get colorValue {
    switch (this) {
      case ListingStatus.draft:
        return 0xFF9E9E9E; // Grey
      case ListingStatus.pendingReview:
        return 0xFFFF9800; // Orange
      case ListingStatus.active:
        return 0xFF4CAF50; // Green
      case ListingStatus.sold:
        return 0xFF2196F3; // Blue
      case ListingStatus.cancelled:
        return 0xFFF44336; // Red
    }
  }

  /// Icon emoji for UI display
  String get iconEmoji {
    switch (this) {
      case ListingStatus.draft:
        return '📝';
      case ListingStatus.pendingReview:
        return '⏳';
      case ListingStatus.active:
        return '🔥';
      case ListingStatus.sold:
        return '🏆';
      case ListingStatus.cancelled:
        return '✗';
    }
  }

  /// Check if this status allows editing
  bool get canEdit {
    return this == ListingStatus.draft ||
           this == ListingStatus.pendingReview;
  }

  /// Check if this status allows deletion
  bool get canDelete {
    return this == ListingStatus.draft ||
           this == ListingStatus.pendingReview ||
           this == ListingStatus.cancelled;
  }

  /// Check if listing is visible to users in marketplace
  bool get isVisibleInMarketplace {
    return this == ListingStatus.active;
  }

  /// Check if listing can be submitted for review
  bool get canSubmitForReview {
    return this == ListingStatus.draft;
  }

  /// Check if admin can approve this listing
  bool get canApprove {
    return this == ListingStatus.pendingReview;
  }

  /// Check if listing can be cancelled by user
  bool get canCancel {
    return this == ListingStatus.draft ||
           this == ListingStatus.pendingReview;
  }
}
