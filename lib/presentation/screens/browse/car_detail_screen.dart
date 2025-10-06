import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../data/models/car_model.dart';
import '../../../data/services/mock/mock_car_service.dart';
import '../../../core/utils/price_formatter.dart';
import '../../../core/utils/enum_extensions.dart';
import '../../providers/watchlist_provider.dart';
import '../../widgets/image_carousel.dart';
import '../../widgets/spec_info_row.dart';
import '../../widgets/seller_info_card.dart';

class CarDetailScreen extends StatefulWidget {
  final String carId;

  const CarDetailScreen({super.key, required this.carId});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  final MockCarService _carService = MockCarService();
  CarModel? _car;
  bool _isLoading = true;
  bool _isDescriptionExpanded = false;

  @override
  void initState() {
    super.initState();
    _loadCar();
  }

  Future<void> _loadCar() async {
    setState(() => _isLoading = true);
    final car = await _carService.getCarById(widget.carId);
    if (car != null) {
      await _carService.incrementViewCount(widget.carId);
    }
    setState(() {
      _car = car;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final watchlistProvider = context.watch<WatchlistProvider>();

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_car == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Car not found'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    final car = _car!;
    final isWatchlisted = watchlistProvider.isWatchlisted(car.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ImageCarousel(
                images: car.images,
                height: 300,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isWatchlisted ? Icons.favorite : Icons.favorite_border,
                  color: isWatchlisted ? Colors.red : null,
                ),
                onPressed: () {
                  watchlistProvider.toggleWatchlist(car.id);
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // Share functionality
                },
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Price
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${car.brand} ${car.model} ${car.variant}',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        car.year.toString(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '${car.location.city}, ${car.location.province}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(Icons.visibility, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                '${car.viewCount} views',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider(),

                // Seller Info
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SellerInfoCard(
                    sellerName: car.sellerName,
                    onContact: () {
                      // Contact seller functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contact seller feature coming soon')),
                      );
                    },
                  ),
                ),

                // Key Specs
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Key Specifications',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 3,
                        children: [
                          SpecInfoRow(
                            icon: Icons.speed,
                            label: 'Mileage',
                            value: PriceFormatter.formatMileage(car.mileage),
                          ),
                          SpecInfoRow(
                            icon: Icons.settings,
                            label: 'Transmission',
                            value: car.transmission.displayName,
                          ),
                          SpecInfoRow(
                            icon: Icons.local_gas_station,
                            label: 'Fuel Type',
                            value: car.fuelType.displayName,
                          ),
                          SpecInfoRow(
                            icon: Icons.directions_car,
                            label: 'Body Type',
                            value: car.bodyType.displayName,
                          ),
                          SpecInfoRow(
                            icon: Icons.palette,
                            label: 'Color',
                            value: car.color,
                          ),
                          SpecInfoRow(
                            icon: Icons.calendar_today,
                            label: 'Year',
                            value: car.year.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider(),

                // Description
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        car.description,
                        maxLines: _isDescriptionExpanded ? null : 3,
                        overflow: _isDescriptionExpanded ? null : TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium,
                      ),
                      if (car.description.length > 100)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isDescriptionExpanded = !_isDescriptionExpanded;
                            });
                          },
                          child: Text(_isDescriptionExpanded ? 'Show less' : 'Show more'),
                        ),
                    ],
                  ),
                ),

                // Features
                if (car.features.isNotEmpty) ...[
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Features',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: car.features
                              .map((feature) => Chip(
                                    label: Text(feature),
                                    backgroundColor: theme.colorScheme.primaryContainer,
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],

                // Vehicle Details
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vehicle Details',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow('Engine Size', car.engineSize),
                      _buildDetailRow('Seats', car.seats.toString()),
                      _buildDetailRow('Doors', car.doors.toString()),
                      _buildDetailRow('Plate Number', car.plateNumber),
                      _buildDetailRow('OR/CR Number', car.orcrNumber),
                      _buildDetailRow('Number of Owners', car.numberOfOwners.toString()),
                      _buildDetailRow('Condition', car.condition.displayName),
                      _buildDetailRow(
                        'Service History',
                        car.serviceHistoryComplete ? 'Complete' : 'Incomplete',
                      ),
                      _buildDetailRow(
                        'Accident History',
                        car.hasAccidentHistory ? 'Yes' : 'No',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 80), // Space for bottom bar
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Bidding feature coming soon')),
                  );
                },
                icon: const Icon(Icons.gavel),
                label: const Text('Place Bid'),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contact feature coming soon')),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Icon(Icons.phone),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
