import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/services/mock/mock_review_service.dart';
import 'reviews/rating_badge.dart';

class SellerInfoCard extends StatefulWidget {
  final String sellerId;
  final String sellerName;
  final VoidCallback? onContact;

  const SellerInfoCard({
    super.key,
    required this.sellerId,
    required this.sellerName,
    this.onContact,
  });

  @override
  State<SellerInfoCard> createState() => _SellerInfoCardState();
}

class _SellerInfoCardState extends State<SellerInfoCard> {
  final _reviewService = MockReviewService();
  double _averageRating = 0;
  int _reviewCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    final reviews = await _reviewService.getSellerReviews(widget.sellerId);
    if (!mounted) return;

    setState(() {
      _reviewCount = reviews.length;
      if (reviews.isNotEmpty) {
        final sum = reviews.fold<double>(0, (sum, r) => sum + r.overallRating);
        _averageRating = sum / reviews.length;
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seller Information',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(
                    widget.sellerName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.sellerName,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _isLoading
                          ? const SizedBox(
                              width: 100,
                              height: 16,
                              child: LinearProgressIndicator(),
                            )
                          : RatingBadge(
                              rating: _averageRating,
                              reviewCount: _reviewCount,
                              compact: true,
                            ),
                    ],
                  ),
                ),
                if (widget.onContact != null)
                  FilledButton.icon(
                    onPressed: widget.onContact,
                    icon: const Icon(Icons.message, size: 18),
                    label: const Text('Contact'),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
              ],
            ),
            if (_reviewCount > 0) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.push(
                      '/seller-reviews/${widget.sellerId}?sellerName=${Uri.encodeComponent(widget.sellerName)}',
                    );
                  },
                  icon: const Icon(Icons.rate_review, size: 18),
                  label: const Text('View All Reviews'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
