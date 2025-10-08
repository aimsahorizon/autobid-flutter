import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/transaction_provider.dart';
import '../../widgets/custom_button.dart';

class SubmitReviewScreen extends StatefulWidget {
  final String transactionId;
  final String carTitle;
  final String sellerName;

  const SubmitReviewScreen({
    super.key,
    required this.transactionId,
    required this.carTitle,
    required this.sellerName,
  });

  @override
  State<SubmitReviewScreen> createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends State<SubmitReviewScreen> {
  double _overallRating = 0;
  double _communicationRating = 0;
  double _accuracyRating = 0;
  double _conditionRating = 0;
  double _processRating = 0;
  final _commentController = TextEditingController();
  bool _isAnonymous = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_overallRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide an overall rating')),
      );
      return;
    }

    if (_communicationRating == 0 ||
        _accuracyRating == 0 ||
        _conditionRating == 0 ||
        _processRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please rate all categories')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final success = await context.read<TransactionProvider>().submitReview(
          widget.transactionId,
          _overallRating,
          _communicationRating,
          _accuracyRating,
          _conditionRating,
          _processRating,
          _commentController.text.trim().isEmpty
              ? null
              : _commentController.text.trim(),
          _isAnonymous,
        );

    if (!mounted) return;

    setState(() => _isSubmitting = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Review submitted successfully'),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/home?tab=2&subTab=1');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit review'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Your Experience'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTransactionInfo(),
            const SizedBox(height: 24),
            _buildOverallRating(),
            const SizedBox(height: 24),
            const Text(
              'Category Ratings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildCategoryRating(
              'Communication',
              'How responsive and clear was the seller?',
              _communicationRating,
              (value) => setState(() => _communicationRating = value),
            ),
            _buildCategoryRating(
              'Accuracy',
              'Did the car match the listing description?',
              _accuracyRating,
              (value) => setState(() => _accuracyRating = value),
            ),
            _buildCategoryRating(
              'Condition',
              'Was the vehicle in the stated condition?',
              _conditionRating,
              (value) => setState(() => _conditionRating = value),
            ),
            _buildCategoryRating(
              'Process',
              'How smooth was the overall transaction?',
              _processRating,
              (value) => setState(() => _processRating = value),
            ),
            const SizedBox(height: 24),
            _buildCommentSection(),
            const SizedBox(height: 16),
            _buildAnonymousOption(),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Submit Review',
              onPressed: _isSubmitting ? null : _submitReview,
              isLoading: _isSubmitting,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.carTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16),
              const SizedBox(width: 4),
              Text(
                'Seller: ${widget.sellerName}',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverallRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overall Rating',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() => _overallRating = (index + 1).toDouble());
                      },
                      child: Icon(
                        index < _overallRating ? Icons.star : Icons.star_border,
                        size: 48,
                        color: Colors.amber,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  _overallRating > 0
                      ? '${_overallRating.toStringAsFixed(1)} / 5.0'
                      : 'Tap to rate',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryRating(
    String title,
    String subtitle,
    double value,
    ValueChanged<double> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () => onChanged((index + 1).toDouble()),
                      child: Icon(
                        index < value ? Icons.star : Icons.star_border,
                        size: 32,
                        color: Colors.amber,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 40,
                child: Text(
                  value > 0 ? value.toStringAsFixed(1) : '-',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Written Review (Optional)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _commentController,
          maxLines: 5,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: 'Share more details about your experience...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnonymousOption() {
    return CheckboxListTile(
      value: _isAnonymous,
      onChanged: (value) {
        setState(() => _isAnonymous = value ?? false);
      },
      title: const Text('Post anonymously'),
      subtitle: Text(
        'Your name will be hidden from the seller',
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
