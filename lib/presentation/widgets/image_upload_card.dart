import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Uint8List? imageData;
  final VoidCallback onTap;
  final VoidCallback? onRemove;
  final IconData icon;

  const ImageUploadCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageData,
    required this.onTap,
    this.onRemove,
    this.icon = Icons.upload_file,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasImage = imageData != null;

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: hasImage
                  ? Colors.green.withValues(alpha: 0.5)
                  : colorScheme.outline.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: hasImage
              ? _buildImagePreview(context)
              : _buildUploadPrompt(context),
        ),
      ),
    );
  }

  Widget _buildUploadPrompt(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 48,
          color: colorScheme.primary,
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: onTap,
          icon: const Icon(Icons.camera_alt),
          label: const Text('Upload'),
        ),
      ],
    );
  }

  Widget _buildImagePreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                imageData!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            if (onRemove != null)
              Positioned(
                top: 8,
                right: 8,
                child: IconButton.filled(
                  onPressed: onRemove,
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade900,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: onTap,
          icon: const Icon(Icons.refresh),
          label: const Text('Change Image'),
        ),
      ],
    );
  }
}

class ImageUploadHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<Uint8List?> pickImage({
    ImageSource source = ImageSource.gallery,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        return await image.readAsBytes();
      }
      return null;
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  static Future<void> showImageSourceDialog(
    BuildContext context,
    Function(Uint8List) onImagePicked,
  ) async {
    final colorScheme = Theme.of(context).colorScheme;

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: colorScheme.primary),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                final image = await pickImage(source: ImageSource.camera);
                if (image != null) {
                  onImagePicked(image);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: colorScheme.primary),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final image = await pickImage(source: ImageSource.gallery);
                if (image != null) {
                  onImagePicked(image);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
