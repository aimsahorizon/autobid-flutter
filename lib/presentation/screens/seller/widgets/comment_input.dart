import 'package:flutter/material.dart';
import '../../../../data/models/auction_comment_model.dart';

/// Comment input widget for sellers to reply to buyer questions
class CommentInput extends StatefulWidget {
  final String? replyingToAuthor;
  final CommentCategory? suggestedCategory;
  final Function(String content, CommentCategory category) onSubmit;
  final VoidCallback? onCancel;

  const CommentInput({
    super.key,
    this.replyingToAuthor,
    this.suggestedCategory,
    required this.onSubmit,
    this.onCancel,
  });

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final _controller = TextEditingController();
  late CommentCategory _selectedCategory;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.suggestedCategory ?? CommentCategory.general;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() => _isSubmitting = true);

    try {
      await widget.onSubmit(_controller.text.trim(), _selectedCategory);
      _controller.clear();
      if (widget.onCancel != null) {
        widget.onCancel!();
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          if (widget.replyingToAuthor != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.reply,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Replying to ${widget.replyingToAuthor}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (widget.onCancel != null)
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: widget.onCancel,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
            ),

          // Category selector
          Text(
            'Category',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: CommentCategory.values.map((category) {
              final isSelected = _selectedCategory == category;
              return FilterChip(
                label: Text(_getCategoryName(category)),
                selected: isSelected,
                onSelected: _isSubmitting
                    ? null
                    : (selected) {
                        setState(() => _selectedCategory = category);
                      },
                avatar: Text(_getCategoryIcon(category)),
                selectedColor: theme.colorScheme.primary.withValues(alpha: 0.2),
                checkmarkColor: theme.colorScheme.primary,
                labelStyle: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),

          // Text input
          TextField(
            controller: _controller,
            enabled: !_isSubmitting,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: widget.replyingToAuthor != null
                  ? 'Write your reply...'
                  : 'Add a comment or answer a buyer question...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest,
            ),
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 12),

          // Quick response templates (for sellers)
          if (widget.replyingToAuthor != null) ...[
            Text(
              'Quick responses',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _getQuickResponses().map((template) {
                return ActionChip(
                  label: Text(
                    template,
                    style: const TextStyle(fontSize: 11),
                  ),
                  onPressed: _isSubmitting
                      ? null
                      : () {
                          _controller.text = template;
                        },
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
          ],

          // Submit button
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _controller.text.trim().isEmpty || _isSubmitting
                      ? null
                      : _submit,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send, size: 18),
                  label: Text(_isSubmitting ? 'Sending...' : 'Send Reply'),
                ),
              ),
            ],
          ),
        ],
      ),
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

  List<String> _getQuickResponses() {
    return [
      'Thank you for your interest!',
      'Available for inspection anytime.',
      'All documents are ready.',
      'Can schedule a test drive.',
      'Shipping can be arranged.',
      'PPI is welcome.',
    ];
  }
}
