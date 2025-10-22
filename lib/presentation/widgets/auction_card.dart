import 'package:flutter/material.dart';
import '../../data/models/auction_model.dart';
import '../screens/auction/widgets/countdown_timer.dart';

class AuctionCard extends StatelessWidget {
  final Auction auction;
  final VoidCallback? onTap;

  const AuctionCard({
    super.key,
    required this.auction,
    this.onTap,
  });

  /// Build image widget based on image path type
  Widget _buildCarImage(String imagePath) {
    final isAsset = imagePath.startsWith('assets/');

    if (isAsset) {
      return Image.asset(
        imagePath,
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
        cacheWidth: 400,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 120,
          width: double.infinity,
          color: Colors.grey[300],
          child: Icon(Icons.directions_car, size: 40, color: Colors.grey[600]),
        ),
      );
    } else {
      return Image.network(
        imagePath,
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
        cacheWidth: 400,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 120,
          width: double.infinity,
          color: Colors.grey[300],
          child: Icon(Icons.directions_car, size: 40, color: Colors.grey[600]),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                auction.car?.images.isNotEmpty == true
                  ? _buildCarImage(auction.car!.images.first)
                  : Container(
                      height: 120,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(Icons.directions_car, size: 40, color: Colors.grey[600]),
                    ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CountdownTimer(
                      endTime: auction.endTime,
                      textStyle: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    auction.car != null
                      ? '${auction.car!.year} ${auction.car!.brand} ${auction.car!.model}'
                      : 'Car Auction',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Current Bid',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '₱${_formatCurrency(auction.currentBid)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.people, size: 12, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${auction.totalBids} bids',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
