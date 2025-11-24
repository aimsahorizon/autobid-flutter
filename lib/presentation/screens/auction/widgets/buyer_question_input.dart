import 'package:flutter/material.dart';
import '../../../../data/models/auction_comment_model.dart';

/// Simple question input widget for buyers
class BuyerQuestionInput extends StatefulWidget {
  final String auctionId;
  final String authorId;
  final String authorName;
  final Function(String content, CommentCategory category) onSubmit;
  final VoidCallback? onCancel;

  const BuyerQuestionInput({
    super.key,
    required this.auctionId,
    required this.authorId,
    required this.authorName,
    required this.onSubmit,
    this.onCancel,
  });

  @override
  State<BuyerQuestionInput> createState() => _BuyerQuestionInputState();
}

class _BuyerQuestionInputState extends State<BuyerQuestionInput> {
  final _controller = TextEditingController();
  CommentCategory _selectedCategory = CommentCategory.general;
  bool _isSubmitting = false;

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
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.help_outline,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Ask the Seller a Question',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              if (widget.onCancel != null)
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: widget.onCancel,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Category selector
          Text(
            'Question Type',
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
              CommentCategory.general,
              CommentCategory.mechanical,
              CommentCategory.cosmetic,
              CommentCategory.history,
              CommentCategory.documentation,
              CommentCategory.inspection,
              CommentCategory.shipping,
            ].map((category) {
              final isSelected = _selectedCategory == category;
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_getCategoryIcon(category)),
                    const SizedBox(width: 4),
                    Text(_getCategoryName(category)),
                  ],
                ),
                selected: isSelected,
                onSelected: _isSubmitting
                    ? null
                    : (selected) {
                        setState(() => _selectedCategory = category);
                      },
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

          // Question input
          TextField(
            controller: _controller,
            enabled: !_isSubmitting,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Type your question here...\ne.g., "What is the service history?" or "Any accident history?"',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: theme.colorScheme.surface,
            ),
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 12),

          // Common questions (quick suggestions)
          Text(
            'Common Questions',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _getQuickQuestions().map((question) {
              return ActionChip(
                label: Text(
                  question,
                  style: const TextStyle(fontSize: 11),
                ),
                onPressed: _isSubmitting
                    ? null
                    : () {
                        _controller.text = question;
                      },
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),

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
                  label: Text(_isSubmitting ? 'Sending...' : 'Submit Question'),
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

  List<String> _getQuickQuestions() {
    return [
      'What is the service history?',
      'Any accident history?',
      'Can I inspect the vehicle?',
      'Is the OR/CR updated?',
      'Available for test drive?',
    ];
  }
}
