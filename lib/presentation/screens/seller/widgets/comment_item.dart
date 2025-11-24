import 'package:flutter/material.dart';
import '../../../../data/models/auction_comment_model.dart';
import '../../../../core/utils/time_formatter.dart';

/// Individual comment item widget
/// Displays a single comment with seller-specific actions
class CommentItem extends StatelessWidget {
  final AuctionComment comment;
  final bool isSeller;
  final List<AuctionComment> replies;
  final VoidCallback? onReply;
  final VoidCallback? onPin;
  final VoidCallback? onMarkResolved;
  final VoidCallback? onLike;
  final VoidCallback? onDelete;

  const CommentItem({
    super.key,
    required this.comment,
    this.isSeller = false,
    this.replies = const [],
    this.onReply,
    this.onPin,
    this.onMarkResolved,
    this.onLike,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: comment.isSellerComment
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.15)
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: comment.isPinned
              ? theme.colorScheme.primary
              : comment.isSellerComment
                  ? theme.colorScheme.primary.withValues(alpha: 0.2)
                  : Colors.transparent,
          width: comment.isPinned ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 18,
                  backgroundColor: comment.isSellerComment
                      ? theme.colorScheme.primary
                      : theme.colorScheme.secondary,
                  child: Text(
                    comment.authorName[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            comment.authorName,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (comment.isSellerComment) ...[
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
                                'SELLER',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                          if (comment.isPinned) ...[
                            const SizedBox(width: 6),
                            Icon(
                              Icons.push_pin,
                              size: 14,
                              color: theme.colorScheme.primary,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            TimeFormatter.getRelativeTime(comment.timestamp),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (comment.isEdited) ...[
                            const SizedBox(width: 4),
                            Text(
                              '• Edited',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                // Category badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(theme).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getCategoryColor(theme).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        comment.categoryIcon,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        comment.categoryDisplayName,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _getCategoryColor(theme),
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              comment.content,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
            ),
          ),

          // Status badge for unanswered questions
          if (!comment.isSellerComment && comment.status == CommentStatus.pending) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
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
                      Icons.help_outline,
                      size: 14,
                      color: Colors.orange[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Awaiting your response',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Actions
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Row(
              children: [
                // Like button
                if (onLike != null)
                  _ActionButton(
                    icon: Icons.thumb_up_outlined,
                    label: comment.likeCount > 0 ? '${comment.likeCount}' : 'Like',
                    onTap: onLike,
                  ),
                const SizedBox(width: 8),
                // Reply button
                if (isSeller && onReply != null && !comment.isSellerComment)
                  _ActionButton(
                    icon: Icons.reply,
                    label: 'Reply',
                    onTap: onReply,
                    highlighted: comment.status == CommentStatus.pending,
                  ),
                if (replies.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  _ActionButton(
                    icon: Icons.comment_outlined,
                    label: '${replies.length} ${replies.length == 1 ? 'reply' : 'replies'}',
                    onTap: null,
                  ),
                ],
                const Spacer(),
                // Seller actions
                if (isSeller && !comment.isSellerComment) ...[
                  if (onPin != null)
                    IconButton(
                      icon: Icon(
                        comment.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                        size: 20,
                      ),
                      onPressed: onPin,
                      tooltip: comment.isPinned ? 'Unpin' : 'Pin',
                      color: comment.isPinned ? theme.colorScheme.primary : null,
                    ),
                  if (onMarkResolved != null && comment.status != CommentStatus.resolved)
                    IconButton(
                      icon: const Icon(Icons.check_circle_outline, size: 20),
                      onPressed: onMarkResolved,
                      tooltip: 'Mark as resolved',
                    ),
                ],
                if (comment.isSellerComment && onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    onPressed: onDelete,
                    tooltip: 'Delete',
                    color: Colors.red,
                  ),
              ],
            ),
          ),

          // Replies
          if (replies.isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.only(left: 48, right: 16, bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: replies.map((reply) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool highlighted;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: highlighted
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: highlighted
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: highlighted
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: highlighted ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
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
        CircleAvatar(
          radius: 14,
          backgroundColor: reply.isSellerComment
              ? theme.colorScheme.primary
              : theme.colorScheme.secondary,
          child: Text(
            reply.authorName[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    reply.authorName,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (reply.isSellerComment) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'SELLER',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
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
              const SizedBox(height: 4),
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
