import 'package:flutter/material.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final bool compact;

  const RatingBadge({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (reviewCount == 0) {
      return Text(
        'No reviews yet',
        style: TextStyle(
          fontSize: compact ? 12 : 14,
          color: Colors.grey[600],
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star,
          color: Colors.amber,
          size: compact ? 16 : 20,
        ),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: compact ? 14 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '($reviewCount)',
          style: TextStyle(
            fontSize: compact ? 12 : 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
