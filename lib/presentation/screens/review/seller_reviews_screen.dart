import 'package:flutter/material.dart';
import '../../../data/models/review_model.dart';
import '../../../data/services/mock/mock_review_service.dart';
import '../../widgets/reviews/rating_breakdown.dart';
import '../../widgets/reviews/review_card.dart';

enum ReviewFilter { all, positive, neutral, negative }

class SellerReviewsScreen extends StatefulWidget {
  final String sellerId;
  final String sellerName;

  const SellerReviewsScreen({
    super.key,
    required this.sellerId,
    required this.sellerName,
  });

  @override
  State<SellerReviewsScreen> createState() => _SellerReviewsScreenState();
}

class _SellerReviewsScreenState extends State<SellerReviewsScreen> {
  final _reviewService = MockReviewService();
  List<ReviewModel> _reviews = [];
  ReviewFilter _selectedFilter = ReviewFilter.all;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    setState(() => _isLoading = true);
    _reviews = await _reviewService.getSellerReviews(widget.sellerId);
    setState(() => _isLoading = false);
  }

  List<ReviewModel> get _filteredReviews {
    switch (_selectedFilter) {
      case ReviewFilter.positive:
        return _reviews.where((r) => r.overallRating >= 4).toList();
      case ReviewFilter.neutral:
        return _reviews.where((r) => r.overallRating == 3).toList();
      case ReviewFilter.negative:
        return _reviews.where((r) => r.overallRating < 3).toList();
      case ReviewFilter.all:
        return _reviews;
    }
  }

  double get _averageRating {
    if (_reviews.isEmpty) return 0;
    final sum = _reviews.fold<double>(0, (sum, review) => sum + review.overallRating);
    return sum / _reviews.length;
  }

  Map<int, int> get _ratingCounts {
    final counts = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var review in _reviews) {
      final rating = review.overallRating.round();
      counts[rating] = (counts[rating] ?? 0) + 1;
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.sellerName}\'s Reviews'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _reviews.isEmpty
              ? _buildEmptyState()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRatingSummary(),
                      const SizedBox(height: 24),
                      RatingBreakdown(
                        ratingCounts: _ratingCounts,
                        totalReviews: _reviews.length,
                      ),
                      const SizedBox(height: 24),
                      _buildFilterChips(),
                      const SizedBox(height: 16),
                      _buildReviewsList(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.rate_review_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No reviews yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'This seller hasn\'t received any reviews',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  _averageRating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < _averageRating ? Icons.star : Icons.star_border,
                      size: 20,
                      color: Colors.amber,
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_reviews.length} reviews',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryAverage('Communication', _getAverageCategoryRating((r) => r.communication)),
                  _buildCategoryAverage('Accuracy', _getAverageCategoryRating((r) => r.accuracy)),
                  _buildCategoryAverage('Condition', _getAverageCategoryRating((r) => r.condition)),
                  _buildCategoryAverage('Process', _getAverageCategoryRating((r) => r.process)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryAverage(String label, double rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Icon(Icons.star, size: 14, color: Colors.amber),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  double _getAverageCategoryRating(double Function(CategoryRating) selector) {
    if (_reviews.isEmpty) return 0;
    final sum = _reviews.fold<double>(0, (sum, review) => sum + selector(review.categoryRatings));
    return sum / _reviews.length;
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('All', ReviewFilter.all, _reviews.length),
          const SizedBox(width: 8),
          _buildFilterChip(
            'Positive',
            ReviewFilter.positive,
            _reviews.where((r) => r.overallRating >= 4).length,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            'Neutral',
            ReviewFilter.neutral,
            _reviews.where((r) => r.overallRating == 3).length,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            'Negative',
            ReviewFilter.negative,
            _reviews.where((r) => r.overallRating < 3).length,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, ReviewFilter filter, int count) {
    final isSelected = _selectedFilter == filter;
    return FilterChip(
      label: Text('$label ($count)'),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _selectedFilter = filter);
      },
    );
  }

  Widget _buildReviewsList() {
    final filteredReviews = _filteredReviews;
    if (filteredReviews.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            'No reviews in this category',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      );
    }

    return Column(
      children: filteredReviews.map((review) => ReviewCard(review: review)).toList(),
    );
  }
}
