import 'package:flutter/material.dart';
import '../../../../data/models/auction_model.dart';

class CarInfoTab extends StatelessWidget {
  final Auction auction;

  const CarInfoTab({
    super.key,
    required this.auction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Auction Details',
            [
              _buildInfoRow('Starting Price', '₱${_formatCurrency(auction.startingPrice)}'),
              _buildInfoRow('Reserve Price', auction.currentBid >= auction.reservePrice ? '₱${_formatCurrency(auction.reservePrice)} (Met)' : 'Not Disclosed'),
              if (auction.buyNowPrice != null)
                _buildInfoRow('Buy Now Price', '₱${_formatCurrency(auction.buyNowPrice!)}'),
              _buildInfoRow('Total Bids', '${auction.totalBids}'),
              _buildInfoRow('Watchers', '${auction.watchers.length}'),
            ],
            theme,
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Seller Information',
            [
              _buildInfoRow('Seller ID', auction.sellerId),
              _buildInfoRow('Member Since', _formatDate(auction.createdAt)),
            ],
            theme,
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Vehicle Specifications',
            [
              _buildInfoRow('Year', '2020'),
              _buildInfoRow('Make', 'Toyota'),
              _buildInfoRow('Model', 'Camry'),
              _buildInfoRow('Mileage', '45,000 km'),
              _buildInfoRow('Transmission', 'Automatic'),
              _buildInfoRow('Fuel Type', 'Gasoline'),
              _buildInfoRow('Color', 'Silver'),
              _buildInfoRow('Body Type', 'Sedan'),
            ],
            theme,
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Features',
            [],
            theme,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Power Steering',
              'Power Windows',
              'Air Conditioning',
              'ABS Brakes',
              'Airbags',
              'Bluetooth',
              'Backup Camera',
              'Cruise Control',
            ].map((feature) => Chip(
              label: Text(feature, style: TextStyle(fontSize: 12)),
              backgroundColor: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
            )).toList(),
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Condition',
            [
              _buildInfoRow('Overall', 'Excellent'),
              _buildInfoRow('Exterior', 'Very Good'),
              _buildInfoRow('Interior', 'Excellent'),
              _buildInfoRow('Engine', 'Excellent'),
            ],
            theme,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
