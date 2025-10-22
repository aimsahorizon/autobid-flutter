import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';

class CreateListingStep5Photos extends StatefulWidget {
  const CreateListingStep5Photos({super.key});

  @override
  State<CreateListingStep5Photos> createState() =>
      _CreateListingStep5PhotosState();
}

class _CreateListingStep5PhotosState extends State<CreateListingStep5Photos> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final provider = context.read<ListingProvider>();

    if (provider.images.length >= 15) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum 15 photos allowed')),
      );
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        // In production, upload to cloud storage and get URL
        // For now, use mock URL
        provider.addImage('mock://image_${DateTime.now().millisecondsSinceEpoch}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          LinearProgressIndicator(
            value: 5 / 6,
            backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[200],
          ),
          const SizedBox(height: 24),

          Text(
            'Step 5 of 6',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),

          Text(
            'Upload photos (${provider.images.length}/15)',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),

          Text(
            'Minimum 5 photos required',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
          ),
          const SizedBox(height: 24),

          // Suggested shots
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.blue.shade900.withOpacity(0.3)
                  : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDarkMode ? Colors.blue.shade700 : Colors.blue.shade200,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: isDarkMode ? Colors.blue.shade300 : Colors.blue.shade700,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Suggested shots:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.blue.shade100 : Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Front',
                    'Rear',
                    'Both Sides',
                    'Interior',
                    'Dashboard',
                    'Engine',
                    'Odometer',
                    'Tires',
                    'Seats',
                  ]
                      .map((shot) => Chip(
                            label: Text(shot),
                            labelStyle: TextStyle(
                              fontSize: 11,
                              color: isDarkMode ? Colors.blue.shade100 : Colors.blue.shade900,
                            ),
                            backgroundColor: isDarkMode
                                ? Colors.blue.shade800.withOpacity(0.3)
                                : Colors.white,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Image Grid
          if (provider.images.isNotEmpty)
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.images.length,
              onReorder: (oldIndex, newIndex) {
                provider.reorderImages(oldIndex, newIndex);
              },
              itemBuilder: (context, index) {
                final image = provider.images[index];
                return Card(
                  key: ValueKey(image),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.image),
                    title: Text('Photo ${index + 1}'),
                    subtitle: index == 0
                        ? const Text('Cover photo', style: TextStyle(color: Colors.green))
                        : null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.drag_handle),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => provider.removeImage(image),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          const SizedBox(height: 16),

          // Add Photo Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomButton(
            text: 'Next',
            onPressed: () {
              if (provider.validateStep5()) {
                context.push('/listing/create/step6');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please upload at least 5 photos'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
