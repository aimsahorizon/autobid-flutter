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
              _buildInfoRow('Seller', auction.car?.sellerName ?? auction.sellerId),
              _buildInfoRow('Member Since', _formatDate(auction.createdAt)),
            ],
            theme,
          ),
          const SizedBox(height: 24),
          if (auction.car != null) ...[
            _buildSection(
              'Vehicle Specifications',
              [
                _buildInfoRow('Year', '${auction.car!.year}'),
                _buildInfoRow('Make', auction.car!.brand),
                _buildInfoRow('Model', '${auction.car!.model} ${auction.car!.variant}'),
                _buildInfoRow('Mileage', '${_formatNumber(auction.car!.mileage)} km'),
                _buildInfoRow('Transmission', _getTransmissionName(auction.car!.transmission)),
                _buildInfoRow('Fuel Type', _getFuelTypeName(auction.car!.fuelType)),
                _buildInfoRow('Color', auction.car!.color),
                _buildInfoRow('Body Type', _getBodyTypeName(auction.car!.bodyType)),
                _buildInfoRow('Engine Size', auction.car!.engineSize),
                _buildInfoRow('Seats', '${auction.car!.seats}'),
                _buildInfoRow('Doors', '${auction.car!.doors}'),
              ],
              theme,
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Location',
              [
                _buildInfoRow('City', auction.car!.location.city),
                _buildInfoRow('Province', auction.car!.location.province),
              ],
              theme,
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Documents & History',
              [
                _buildInfoRow('Plate Number', auction.car!.plateNumber),
                _buildInfoRow('OR/CR Number', auction.car!.orcrNumber),
                _buildInfoRow('Number of Owners', '${auction.car!.numberOfOwners}'),
                _buildInfoRow('Service History', auction.car!.serviceHistoryComplete ? 'Complete' : 'Incomplete'),
                _buildInfoRow('Accident History', auction.car!.hasAccidentHistory ? 'Yes' : 'No'),
              ],
              theme,
            ),
          ],
          if (auction.car != null && auction.car!.features.isNotEmpty) ...[
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
              children: auction.car!.features.map((feature) => Chip(
                label: Text(feature, style: TextStyle(fontSize: 12)),
                backgroundColor: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
              )).toList(),
            ),
          ],
          if (auction.car != null) ...[
            const SizedBox(height: 24),
            _buildSection(
              'Description',
              [],
              theme,
            ),
            const SizedBox(height: 8),
            Text(
              auction.car!.description,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            if (auction.car!.issues != null) ...[
              const SizedBox(height: 12),
              Text(
                'Known Issues:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                auction.car!.issues!,
                style: TextStyle(fontSize: 14, color: Colors.red[700]),
              ),
            ],
          ],
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

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getTransmissionName(dynamic transmission) {
    if (transmission == null) return 'Unknown';
    final name = transmission.toString().split('.').last;
    return name[0].toUpperCase() + name.substring(1);
  }

  String _getFuelTypeName(dynamic fuelType) {
    if (fuelType == null) return 'Unknown';
    final name = fuelType.toString().split('.').last;
    return name[0].toUpperCase() + name.substring(1);
  }

  String _getBodyTypeName(dynamic bodyType) {
    if (bodyType == null) return 'Unknown';
    final name = bodyType.toString().split('.').last;
    if (name == 'suv') return 'SUV';
    if (name == 'mpv') return 'MPV';
    return name[0].toUpperCase() + name.substring(1);
  }
}
