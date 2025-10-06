import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/enum_extensions.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';

class CreateListingStep6Review extends StatefulWidget {
  const CreateListingStep6Review({super.key});

  @override
  State<CreateListingStep6Review> createState() =>
      _CreateListingStep6ReviewState();
}

class _CreateListingStep6ReviewState extends State<CreateListingStep6Review> {
  bool _isSubmitting = false;

  Future<void> _submitListing(bool isDraft) async {
    setState(() => _isSubmitting = true);

    try {
      final provider = context.read<ListingProvider>();
      await provider.createListing(
        'mock-user-id',
        'John Doe',
        isDraft: isDraft,
      );

      if (mounted) {
        context.go('/listing/success');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          LinearProgressIndicator(
            value: 6 / 6,
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(height: 24),

          Text(
            'Step 6 of 6',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),

          Text(
            'Review your listing',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),

          // Basic Info Section
          _buildSection(
            context,
            title: 'Basic Information',
            icon: Icons.directions_car,
            onEdit: () => context.push('/listing/create/step1'),
            children: [
              _buildInfoRow('Brand', provider.brand ?? ''),
              _buildInfoRow('Model', provider.model ?? ''),
              _buildInfoRow('Variant', provider.variant ?? ''),
              _buildInfoRow('Year', provider.year?.toString() ?? ''),
            ],
          ),
          const SizedBox(height: 16),

          // Technical Details Section
          _buildSection(
            context,
            title: 'Technical Details',
            icon: Icons.build,
            onEdit: () => context.push('/listing/create/step2'),
            children: [
              _buildInfoRow('Mileage', '${provider.mileage} km'),
              _buildInfoRow(
                  'Transmission', provider.transmission?.displayName ?? ''),
              _buildInfoRow('Fuel Type', provider.fuelType?.displayName ?? ''),
              _buildInfoRow('Body Type', provider.bodyType?.displayName ?? ''),
              _buildInfoRow('Color', provider.color ?? ''),
              _buildInfoRow('Engine', provider.engineSize ?? ''),
              _buildInfoRow('Seats', provider.seats.toString()),
              _buildInfoRow('Doors', provider.doors.toString()),
            ],
          ),
          const SizedBox(height: 16),

          // Documents Section
          _buildSection(
            context,
            title: 'Documents & Location',
            icon: Icons.description,
            onEdit: () => context.push('/listing/create/step3'),
            children: [
              _buildInfoRow('Plate Number', provider.plateNumber ?? ''),
              _buildInfoRow('OR/CR Number', provider.orcrNumber ?? ''),
              _buildInfoRow('Location',
                  '${provider.city}, ${provider.province}'),
              _buildInfoRow(
                  'Previous Owners', provider.numberOfOwners.toString()),
              _buildInfoRow('Service History',
                  provider.serviceHistoryComplete ? 'Complete' : 'Incomplete'),
              _buildInfoRow('Accident History',
                  provider.hasAccidentHistory ? 'Yes' : 'No'),
            ],
          ),
          const SizedBox(height: 16),

          // Condition Section
          _buildSection(
            context,
            title: 'Condition',
            icon: Icons.verified,
            onEdit: () => context.push('/listing/create/step4'),
            children: [
              _buildInfoRow('Condition', provider.condition?.displayName ?? ''),
              const SizedBox(height: 8),
              Text(
                'Description:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(provider.description),
              if (provider.issues != null && provider.issues!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Known Issues:',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(provider.issues!),
              ],
              if (provider.features.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Features:',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: provider.features
                      .map((feature) => Chip(
                            label: Text(feature, style: const TextStyle(fontSize: 11)),
                            visualDensity: VisualDensity.compact,
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Photos Section
          _buildSection(
            context,
            title: 'Photos (${provider.images.length})',
            icon: Icons.photo_library,
            onEdit: () => context.push('/listing/create/step5'),
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.grey[600],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                text: _isSubmitting ? 'Submitting...' : 'Submit for Review',
                onPressed: _isSubmitting ? null : () => _submitListing(false),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: _isSubmitting ? null : () => _submitListing(true),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Save as Draft'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onEdit,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit'),
                ),
              ],
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
