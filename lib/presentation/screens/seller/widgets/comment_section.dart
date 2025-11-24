import 'package:flutter/material.dart';
import '../../../../data/models/auction_comment_model.dart';
import '../../../../data/services/mock/mock_comment_service.dart';
import 'comment_item.dart';
import 'comment_input.dart';

/// Comment section for seller auction view
/// Displays all buyer questions and seller responses
class CommentSection extends StatefulWidget {
  final String auctionId;
  final String sellerId;

  const CommentSection({
    super.key,
    required this.auctionId,
    required this.sellerId,
  });

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final _commentService = MockCommentService();
  String? _replyingToCommentId;
  CommentCategory? _filterCategory;
  CommentStatus? _filterStatus;

  @override
  void initState() {
    super.initState();
    _commentService.initializeForAuction(widget.auctionId, widget.sellerId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<List<AuctionComment>>(
      stream: _commentService.getCommentsStream(widget.auctionId),
      builder: (context, snapshot) {
        final allComments = snapshot.data ?? [];
        final topLevelComments = _commentService.getTopLevelComments(widget.auctionId);

        // Apply filters
        final filteredComments = _applyFilters(topLevelComments);

        // Calculate stats
        final pendingCount = topLevelComments.where((c) => c.status == CommentStatus.pending).length;
        final answeredCount = topLevelComments.where((c) => c.status == CommentStatus.answered).length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with stats
            _buildHeader(theme, allComments.length, pendingCount, answeredCount),
            const SizedBox(height: 16),

            // Filters
            _buildFilters(theme),
            const SizedBox(height: 16),

            // Reply input (when replying)
            if (_replyingToCommentId != null) ...[
              _buildReplyInput(),
              const SizedBox(height: 16),
            ],

            // Empty state
            if (filteredComments.isEmpty)
              _buildEmptyState(theme)
            else
              // Comments list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredComments.length,
                itemBuilder: (context, index) {
                  final comment = filteredComments[index];
                  final replies = _commentService.getReplies(
                    widget.auctionId,
                    comment.id,
                  );

                  return CommentItem(
                    comment: comment,
                    isSeller: true,
                    replies: replies,
                    onReply: () => _startReply(comment),
                    onPin: () => _togglePin(comment.id),
                    onMarkResolved: () => _markResolved(comment.id),
                    onLike: () => _toggleLike(comment.id),
                    onDelete: comment.isSellerComment
                        ? () => _deleteComment(comment.id)
                        : null,
                  );
                },
              ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(ThemeData theme, int total, int pending, int answered) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer,
            theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.comment_bank,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Buyer Questions & Comments',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _StatChip(
                icon: Icons.chat_bubble_outline,
                label: 'Total',
                value: total.toString(),
                color: Colors.blue,
              ),
              const SizedBox(width: 8),
              _StatChip(
                icon: Icons.help_outline,
                label: 'Pending',
                value: pending.toString(),
                color: Colors.orange,
              ),
              const SizedBox(width: 8),
              _StatChip(
                icon: Icons.check_circle_outline,
                label: 'Answered',
                value: answered.toString(),
                color: Colors.green,
              ),
            ],
          ),
          if (pending > 0) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.orange.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.priority_high, color: Colors.orange[700], size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '$pending ${pending == 1 ? 'question needs' : 'questions need'} your response',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilters(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter by',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // Status filters
            FilterChip(
              label: const Text('All'),
              selected: _filterStatus == null,
              onSelected: (selected) {
                setState(() => _filterStatus = null);
              },
            ),
            FilterChip(
              label: const Text('Pending'),
              selected: _filterStatus == CommentStatus.pending,
              onSelected: (selected) {
                setState(() {
                  _filterStatus = selected ? CommentStatus.pending : null;
                });
              },
              avatar: const Icon(Icons.help_outline, size: 16),
            ),
            FilterChip(
              label: const Text('Answered'),
              selected: _filterStatus == CommentStatus.answered,
              onSelected: (selected) {
                setState(() {
                  _filterStatus = selected ? CommentStatus.answered : null;
                });
              },
              avatar: const Icon(Icons.check_circle_outline, size: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReplyInput() {
    final replyingTo = _commentService
        .getComments(widget.auctionId)
        .firstWhere((c) => c.id == _replyingToCommentId);

    return CommentInput(
      replyingToAuthor: replyingTo.authorName,
      suggestedCategory: replyingTo.category,
      onSubmit: (content, category) async {
        await _commentService.addComment(
          auctionId: widget.auctionId,
          authorId: widget.sellerId,
          authorName: 'You (Seller)',
          content: content,
          isSellerComment: true,
          category: category,
          parentCommentId: _replyingToCommentId,
        );
        setState(() => _replyingToCommentId = null);
      },
      onCancel: () {
        setState(() => _replyingToCommentId = null);
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              _filterStatus != null
                  ? 'No ${_filterStatus == CommentStatus.pending ? 'pending' : 'answered'} questions'
                  : 'No questions yet',
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Buyer questions will appear here',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<AuctionComment> _applyFilters(List<AuctionComment> comments) {
    var filtered = comments;

    if (_filterStatus != null) {
      filtered = filtered.where((c) => c.status == _filterStatus).toList();
    }

    if (_filterCategory != null) {
      filtered = filtered.where((c) => c.category == _filterCategory).toList();
    }

    return filtered;
  }

  void _startReply(AuctionComment comment) {
    setState(() => _replyingToCommentId = comment.id);
  }

  Future<void> _togglePin(String commentId) async {
    await _commentService.togglePin(widget.auctionId, commentId);
  }

  Future<void> _markResolved(String commentId) async {
    await _commentService.updateCommentStatus(
      widget.auctionId,
      commentId,
      CommentStatus.resolved,
    );
  }

  Future<void> _toggleLike(String commentId) async {
    await _commentService.toggleLike(
      widget.auctionId,
      commentId,
      widget.sellerId,
    );
  }

  Future<void> _deleteComment(String commentId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete comment?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _commentService.deleteComment(widget.auctionId, commentId);
    }
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
