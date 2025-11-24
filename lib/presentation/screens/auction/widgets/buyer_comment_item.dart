import 'package:flutter/material.dart';
import '../../../../data/models/auction_comment_model.dart';
import '../../../../core/utils/time_formatter.dart';

/// Buyer-focused comment item
/// Simplified view for buyers to see Q&A
class BuyerCommentItem extends StatelessWidget {
  final AuctionComment comment;
  final List<AuctionComment> replies;
  final String? currentUserId;
  final VoidCallback? onLike;

  const BuyerCommentItem({
    super.key,
    required this.comment,
    this.replies = const [],
    this.currentUserId,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMyQuestion = comment.authorId == currentUserId;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isMyQuestion
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.2)
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: comment.isPinned
              ? theme.colorScheme.primary
              : theme.colorScheme.outline.withValues(alpha: 0.2),
          width: comment.isPinned ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 16,
                backgroundColor: isMyQuestion
                    ? theme.colorScheme.primary
                    : theme.colorScheme.secondary,
                child: Text(
                  comment.authorName[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          isMyQuestion ? 'You' : comment.authorName,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (comment.isPinned) ...[
                          const SizedBox(width: 6),
                          Icon(
                            Icons.push_pin,
                            size: 12,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ],
                    ),
                    Text(
                      TimeFormatter.getRelativeTime(comment.timestamp),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              // Category badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(theme).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _getCategoryColor(theme).withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '${comment.categoryIcon} ${comment.categoryDisplayName}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: _getCategoryColor(theme),
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Question content
          Text(
            comment.content,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),

          // Status badge for unanswered questions
          if (comment.status == CommentStatus.pending) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.orange.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.pending,
                    size: 12,
                    color: Colors.orange[700],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Waiting for seller response',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.orange[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Actions (like button)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                InkWell(
                  onTap: onLike,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          comment.isLikedBy(currentUserId ?? '')
                              ? Icons.thumb_up
                              : Icons.thumb_up_outlined,
                          size: 14,
                          color: comment.isLikedBy(currentUserId ?? '')
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                        if (comment.likeCount > 0) ...[
                          const SizedBox(width: 4),
                          Text(
                            '${comment.likeCount}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                if (replies.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.comment_outlined,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${replies.length} ${replies.length == 1 ? 'reply' : 'replies'}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Seller replies
          if (replies.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: replies.map((reply) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _ReplyItem(reply: reply, theme: theme),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getCategoryColor(ThemeData theme) {
    switch (comment.category) {
      case CommentCategory.mechanical:
        return Colors.blue;
      case CommentCategory.cosmetic:
        return Colors.purple;
      case CommentCategory.history:
        return Colors.brown;
      case CommentCategory.documentation:
        return Colors.teal;
      case CommentCategory.inspection:
        return Colors.orange;
      case CommentCategory.shipping:
        return Colors.indigo;
      case CommentCategory.general:
        return Colors.grey;
    }
  }
}

class _ReplyItem extends StatelessWidget {
  final AuctionComment reply;
  final ThemeData theme;

  const _ReplyItem({
    required this.reply,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Seller avatar
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.store,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Seller',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'VERIFIED',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    TimeFormatter.getRelativeTime(reply.timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                reply.content,
                style: theme.textTheme.bodySmall?.copyWith(
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
