import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/car_model.dart';
import '../../../core/utils/enum_extensions.dart';
import '../../widgets/spec_info_row.dart';
import '../../widgets/listing_status_badge.dart';

class CarDetailScreen extends StatelessWidget {
  final CarModel car;

  const CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Image Carousel
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: car.images.isNotEmpty
                  ? PageView.builder(
                      itemCount: car.images.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          car.images[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.directions_car, size: 100),
                            );
                          },
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.directions_car, size: 100),
                    ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Badge
                  ListingStatusBadge(status: car.status),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    '${car.brand} ${car.model} ${car.variant}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    '${car.year}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 24),

                  // Key Specs
                  Text(
                    'Key Specifications',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickSpec(
                          context,
                          Icons.speed,
                          'Mileage',
                          '${car.mileage.toString().replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => '${m[1]},',
                              )} km',
                        ),
                      ),
                      Expanded(
                        child: _buildQuickSpec(
                          context,
                          Icons.settings,
                          'Transmission',
                          car.transmission.displayName,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickSpec(
                          context,
                          Icons.local_gas_station,
                          'Fuel',
                          car.fuelType.displayName,
                        ),
                      ),
                      Expanded(
                        child: _buildQuickSpec(
                          context,
                          Icons.directions_car,
                          'Body',
                          car.bodyType.displayName,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Detailed Specs
                  Text(
                    'Detailed Specifications',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  SpecInfoRow(
                    icon: Icons.palette,
                    label: 'Color',
                    value: car.color,
                  ),
                  SpecInfoRow(
                    icon: Icons.engineering,
                    label: 'Engine Size',
                    value: car.engineSize,
                  ),
                  SpecInfoRow(
                    icon: Icons.event_seat,
                    label: 'Seats',
                    value: '${car.seats} seats',
                  ),
                  SpecInfoRow(
                    icon: Icons.sensor_door,
                    label: 'Doors',
                    value: '${car.doors} doors',
                  ),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    car.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),

                  // Issues (if any)
                  if (car.issues != null && car.issues!.isNotEmpty) ...[
                    Text(
                      'Known Issues',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[700],
                          ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange[200]!),
                      ),
                      child: Text(
                        car.issues!,
                        style: TextStyle(color: Colors.orange[900]),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Features
                  if (car.features.isNotEmpty) ...[
                    Text(
                      'Features',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                                avatar: const Icon(Icons.check_circle, size: 18),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Documents & Location
                  Text(
                    'Documents & Location',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  SpecInfoRow(
                    icon: Icons.confirmation_number,
                    label: 'Plate Number',
                    value: car.plateNumber,
                  ),
                  SpecInfoRow(
                    icon: Icons.location_on,
                    label: 'Location',
                    value: '${car.location.city}, ${car.location.province}',
                  ),
                  SpecInfoRow(
                    icon: Icons.people,
                    label: 'Previous Owners',
                    value: '${car.numberOfOwners}',
                  ),
                  SpecInfoRow(
                    icon: Icons.description,
                    label: 'Service History',
                    value: car.serviceHistoryComplete ? 'Complete' : 'Incomplete',
                  ),
                  SpecInfoRow(
                    icon: Icons.warning,
                    label: 'Accident History',
                    value: car.hasAccidentHistory ? 'Yes' : 'No',
                  ),
                  const SizedBox(height: 24),

                  // Seller Info
                  Text(
                    'Seller Information',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(car.sellerName),
                      subtitle: const Text('Verified Seller'),
                      trailing: const Icon(Icons.verified, color: Colors.green),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Stats
                  Row(
                    children: [
                      Icon(Icons.visibility, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${car.viewCount} views',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Listed ${_getTimeAgo(car.createdAt)}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: car.sellerId == 'mock-user-id'
          ? FloatingActionButton.extended(
              onPressed: () {
                // Edit listing
                context.push('/listing/create/step1');
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Listing'),
            )
          : null,
    );
  }

  Widget _buildQuickSpec(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'just now';
    }
  }
}
