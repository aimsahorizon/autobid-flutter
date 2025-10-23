import 'package:flutter/material.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../core/utils/car_enum_extensions.dart';
import '../widgets/buyer_comment_section.dart';
import 'package:provider/provider.dart';
import '../../../providers/auction_provider.dart';

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
              'Basic Information',
              [
                _buildInfoRow('Year', '${auction.car!.year}'),
                _buildInfoRow('Make', auction.car!.brand),
                _buildInfoRow('Model', '${auction.car!.model} ${auction.car!.variant}'),
                _buildInfoRow('Condition', auction.car!.condition.displayName),
              ],
              theme,
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Engine & Performance',
              [
                _buildInfoRow('Engine Size', auction.car!.engineSize),
                _buildInfoRow('Engine Type', auction.car!.engineType.displayName),
                _buildInfoRow('Cylinders', '${auction.car!.cylinders}'),
                _buildInfoRow('Horsepower', '${auction.car!.horsepower} hp'),
                _buildInfoRow('Torque', '${auction.car!.torque} Nm'),
                _buildInfoRow('Transmission', auction.car!.transmission.displayName),
                _buildInfoRow('Transmission Speeds', auction.car!.transmissionSpeeds > 0 ? '${auction.car!.transmissionSpeeds}-speed' : 'CVT'),
                _buildInfoRow('Drive Type', auction.car!.driveType.displayName),
                _buildInfoRow('Fuel Type', auction.car!.fuelType.displayName),
                _buildInfoRow('Fuel Consumption', '${auction.car!.fuelConsumption} km/L'),
                if (auction.car!.electricRange != null)
                  _buildInfoRow('Electric Range', '${auction.car!.electricRange} km'),
                if (auction.car!.batteryCapacity != null)
                  _buildInfoRow('Battery Capacity', '${auction.car!.batteryCapacity} kWh'),
                if (auction.car!.chargingTime != null)
                  _buildInfoRow('Charging Time', auction.car!.chargingTime!),
              ],
              theme,
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Dimensions & Capacity',
              [
                _buildInfoRow('Body Type', auction.car!.bodyType.displayName),
                _buildInfoRow('Doors', '${auction.car!.doors}'),
                _buildInfoRow('Seats', '${auction.car!.seats}'),
                _buildInfoRow('Curb Weight', '${_formatNumber(auction.car!.curbWeight)} kg'),
                _buildInfoRow('Gross Weight', '${_formatNumber(auction.car!.grossWeight)} kg'),
                _buildInfoRow('Cargo Capacity', '${_formatNumber(auction.car!.cargoCapacity)} L'),
                if (auction.car!.towingCapacity != null)
                  _buildInfoRow('Towing Capacity', '${_formatNumber(auction.car!.towingCapacity!)} kg'),
                if (auction.car!.groundClearance != null)
                  _buildInfoRow('Ground Clearance', '${auction.car!.groundClearance} mm'),
                _buildInfoRow('Length', '${_formatNumber(auction.car!.length)} mm'),
                _buildInfoRow('Width', '${_formatNumber(auction.car!.width)} mm'),
                _buildInfoRow('Height', '${_formatNumber(auction.car!.height)} mm'),
                _buildInfoRow('Wheelbase', '${_formatNumber(auction.car!.wheelbase)} mm'),
              ],
              theme,
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Exterior',
              [
                _buildInfoRow('Color', auction.car!.color),
                _buildInfoRow('Paint Type', auction.car!.paintType.displayName),
                _buildInfoRow('Rim Size', '${auction.car!.rimSize}"'),
                _buildInfoRow('Rim Type', auction.car!.rimType.displayName),
                _buildInfoRow('Tire Condition', auction.car!.tireCondition.displayName),
              ],
              theme,
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Condition & History',
              [
                _buildInfoRow('Mileage', '${_formatNumber(auction.car!.mileage)} km'),
                _buildInfoRow('Number of Owners', '${auction.car!.numberOfOwners}'),
                _buildInfoRow('Accident History', auction.car!.hasAccidentHistory ? 'Yes' : 'No'),
                _buildInfoRow('Flood Damage', auction.car!.floodDamage ? 'Yes' : 'No'),
                _buildInfoRow('Service History', auction.car!.serviceHistoryComplete ? 'Complete' : 'Incomplete'),
                if (auction.car!.registrationExpiry != null)
                  _buildInfoRow('Registration Expiry', _formatDate(auction.car!.registrationExpiry!)),
              ],
              theme,
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Location & Availability',
              [
                _buildInfoRow('City', auction.car!.location.city),
                _buildInfoRow('Province', auction.car!.location.province),
                _buildInfoRow('Test Drive Available', auction.car!.availableForTestDrive ? 'Yes' : 'No'),
                _buildInfoRow('Delivery Available', auction.car!.deliveryAvailable ? 'Yes' : 'No'),
              ],
              theme,
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Documentation',
              [
                _buildInfoRow('Plate Number', auction.car!.plateNumber),
                _buildInfoRow('OR/CR Number', auction.car!.orcrNumber),
                _buildInfoRow('Registration Status', auction.car!.registrationStatus.displayName),
                _buildInfoRow('Emission Test Valid', auction.car!.emissionTestValid ? 'Yes' : 'No'),
                _buildInfoRow('Comprehensive Insurance', auction.car!.comprehensiveInsurance ? 'Yes' : 'No'),
              ],
              theme,
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Seller Preferences',
              [
                _buildInfoRow('Accepts Trade', auction.car!.acceptsTrade ? 'Yes' : 'No'),
                _buildInfoRow('Financing Available', auction.car!.financingAvailable ? 'Yes' : 'No'),
                _buildInfoRow('Price Negotiable', auction.car!.priceNegotiable ? 'Yes' : 'No'),
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

          // Divider before Q&A section
          const SizedBox(height: 32),
          Divider(
            thickness: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 24),

          // Questions & Answers section
          Builder(
            builder: (context) {
              final provider = context.watch<AuctionProvider>();
              return BuyerCommentSection(
                auctionId: auction.id,
                sellerId: auction.sellerId,
                currentUserId: provider.currentUserId,
              );
            },
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

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
