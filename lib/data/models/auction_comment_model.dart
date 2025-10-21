import 'package:freezed_annotation/freezed_annotation.dart';

part 'auction_comment_model.freezed.dart';
part 'auction_comment_model.g.dart';

/// Comment categories for better organization
/// Based on professional auction platforms like BringATrailer
enum CommentCategory {
  mechanical,    // Engine, transmission, drivetrain
  cosmetic,      // Paint, interior, exterior condition
  history,       // Ownership, accident history, service records
  documentation, // Papers, registration, title
  inspection,    // Pre-purchase inspection questions
  shipping,      // Delivery, location questions
  general,       // Other questions
}

/// Comment status for seller workflow
enum CommentStatus {
  pending,   // Waiting for seller response
  answered,  // Seller has responded
  resolved,  // Issue resolved, no further action needed
}

/// Auction comment model
/// Represents buyer questions and seller responses
@freezed
abstract class AuctionComment with _$AuctionComment {
  const AuctionComment._();

  const factory AuctionComment({
    required String id,
    required String auctionId,
    required String authorId,
    required String authorName,
    required String content,
    required DateTime timestamp,
    @Default(CommentCategory.general) CommentCategory category,
    @Default(CommentStatus.pending) CommentStatus status,
    @Default(false) bool isSellerComment,
    @Default(false) bool isPinned,
    @Default(false) bool isEdited,
    String? parentCommentId, // For replies/threads
    DateTime? editedAt,
    @Default([]) List<String> likedBy,
    @Default(0) int likeCount,
  }) = _AuctionComment;

  factory AuctionComment.fromJson(Map<String, dynamic> json) =>
      _$AuctionCommentFromJson(json);
}

/// Extension for comment utilities
extension AuctionCommentX on AuctionComment {
  /// Check if this is a reply to another comment
  bool get isReply => parentCommentId != null;

  /// Check if comment is liked by user
  bool isLikedBy(String userId) => likedBy.contains(userId);

  /// Get category display name
  String get categoryDisplayName {
    switch (category) {
      case CommentCategory.mechanical:
        return 'Mechanical';
      case CommentCategory.cosmetic:
        return 'Cosmetic';
      case CommentCategory.history:
        return 'History';
      case CommentCategory.documentation:
        return 'Documentation';
      case CommentCategory.inspection:
        return 'Inspection';
      case CommentCategory.shipping:
        return 'Shipping';
      case CommentCategory.general:
        return 'General';
    }
  }

  /// Get category icon
  String get categoryIcon {
    switch (category) {
      case CommentCategory.mechanical:
        return '🔧';
      case CommentCategory.cosmetic:
        return '✨';
      case CommentCategory.history:
        return '📋';
      case CommentCategory.documentation:
        return '📄';
      case CommentCategory.inspection:
        return '🔍';
      case CommentCategory.shipping:
        return '🚚';
      case CommentCategory.general:
        return '💬';
    }
  }
}
