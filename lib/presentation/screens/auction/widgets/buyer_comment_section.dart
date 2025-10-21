import 'package:flutter/material.dart';
import '../../../../data/models/auction_comment_model.dart';
import '../../../../data/services/mock/mock_comment_service.dart';
import 'buyer_comment_item.dart';
import 'buyer_question_input.dart';

/// Buyer-focused comment section for auction detail screen
/// Shows Q&A between buyers and seller
class BuyerCommentSection extends StatefulWidget {
  final String auctionId;
  final String sellerId;
  final String? currentUserId;

  const BuyerCommentSection({
    super.key,
    required this.auctionId,
    required this.sellerId,
    this.currentUserId,
  });

  @override
  State<BuyerCommentSection> createState() => _BuyerCommentSectionState();
}

class _BuyerCommentSectionState extends State<BuyerCommentSection> {
  final _commentService = MockCommentService();
  bool _showQuestionInput = false;
  CommentCategory? _filterCategory;

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
        final topLevelComments = _commentService.getTopLevelComments(widget.auctionId);

        // Apply filters
        final filteredComments = _applyFilters(topLevelComments);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            _buildHeader(theme, topLevelComments.length),
            const SizedBox(height: 16),

            // Category filters (horizontal scroll)
            if (topLevelComments.isNotEmpty) ...[
              _buildCategoryFilters(theme),
              const SizedBox(height: 16),
            ],

            // Ask a Question button
            if (!_showQuestionInput) ...[
              OutlinedButton.icon(
                onPressed: () {
                  setState(() => _showQuestionInput = true);
                },
                icon: const Icon(Icons.help_outline),
                label: const Text('Ask a Question'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: BorderSide(color: theme.colorScheme.primary),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Question input (when active)
            if (_showQuestionInput) ...[
              BuyerQuestionInput(
                auctionId: widget.auctionId,
                authorId: widget.currentUserId ?? 'guest',
                authorName: 'You',
                onSubmit: (content, category) async {
                  await _commentService.addComment(
                    auctionId: widget.auctionId,
                    authorId: widget.currentUserId ?? 'guest',
                    authorName: 'You',
                    content: content,
                    isSellerComment: false,
                    category: category,
                  );
                  setState(() => _showQuestionInput = false);
                },
                onCancel: () {
                  setState(() => _showQuestionInput = false);
                },
              ),
              const SizedBox(height: 16),
            ],

            // Comments list
            if (filteredComments.isEmpty)
              _buildEmptyState(theme)
            else
              ...filteredComments.map((comment) {
                final replies = _commentService.getReplies(
                  widget.auctionId,
                  comment.id,
                );

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: BuyerCommentItem(
                    comment: comment,
                    replies: replies,
                    currentUserId: widget.currentUserId,
                    onLike: () => _toggleLike(comment.id),
                  ),
                );
              }),
          ],
        );
      },
    );
  }

  Widget _buildHeader(ThemeData theme, int totalComments) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.question_answer,
            color: theme.colorScheme.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Questions & Answers',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (totalComments > 0)
                Text(
                  '$totalComments ${totalComments == 1 ? 'question' : 'questions'}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilters(ThemeData theme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterChip(
            label: const Text('All'),
            selected: _filterCategory == null,
            onSelected: (selected) {
              setState(() => _filterCategory = null);
            },
          ),
          const SizedBox(width: 8),
          ...CommentCategory.values.map((category) {
            final isSelected = _filterCategory == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_getCategoryIcon(category)),
                    const SizedBox(width: 4),
                    Text(_getCategoryName(category)),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _filterCategory = selected ? category : null;
                  });
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 48,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 12),
          Text(
            _filterCategory != null
                ? 'No ${_getCategoryName(_filterCategory!).toLowerCase()} questions yet'
                : 'No questions yet',
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Be the first to ask a question!',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  List<AuctionComment> _applyFilters(List<AuctionComment> comments) {
    if (_filterCategory != null) {
      return comments.where((c) => c.category == _filterCategory).toList();
    }
    return comments;
  }

  Future<void> _toggleLike(String commentId) async {
    await _commentService.toggleLike(
      widget.auctionId,
      commentId,
      widget.currentUserId ?? 'guest',
    );
  }

  String _getCategoryName(CommentCategory category) {
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

  String _getCategoryIcon(CommentCategory category) {
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
