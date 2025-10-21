import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../data/models/car_image_category.dart';
import 'fullscreen_image_viewer.dart';

class CategorizedImageGallery extends StatefulWidget {
  final CategorizedCarImages categorizedImages;

  const CategorizedImageGallery({
    super.key,
    required this.categorizedImages,
  });

  @override
  State<CategorizedImageGallery> createState() => _CategorizedImageGalleryState();
}

class _CategorizedImageGalleryState extends State<CategorizedImageGallery> {
  CarImageCategory _selectedCategory = CarImageCategory.exterior;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  Icons.photo_library,
                  size: 20,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 8),
                Text(
                  'Car Photos',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${widget.categorizedImages.getTotalImageCount()} photos',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Category chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: CarImageCategory.values.length,
              itemBuilder: (context, index) {
                final category = CarImageCategory.values[index];
                final hasImages = widget.categorizedImages.hasImagesForCategory(category);
                final isSelected = _selectedCategory == category;
                final imageCount = widget.categorizedImages.getImagesForCategory(category).length;

                if (!hasImages) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    backgroundColor: colorScheme.surface,
                    selectedColor: colorScheme.primary.withValues(alpha: 0.15),
                    checkmarkColor: colorScheme.primary,
                    side: BorderSide(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.outline.withValues(alpha: 0.2),
                    ),
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          category.icon,
                          style: TextStyle(
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          category.displayName,
                          style: TextStyle(
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurface.withValues(alpha: 0.8),
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '($imageCount)',
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // Image grid for selected category
          _buildImageGrid(),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    final images = widget.categorizedImages.getImagesForCategory(_selectedCategory);

    if (images.isEmpty) {
      return Container(
        height: 150,
        alignment: Alignment.center,
        child: Text(
          'No images available',
          style: TextStyle(color: Colors.grey[600]),
        ),
      );
    }

    // Show max 6 images in grid, with "view all" on the last one if more exist
    final displayCount = images.length > 6 ? 6 : images.length;
    final hasMore = images.length > 6;

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: displayCount,
        itemBuilder: (context, index) {
          final isLastItem = index == displayCount - 1;
          final showViewAll = isLastItem && hasMore;

          return GestureDetector(
            onTap: () {
              if (showViewAll) {
                _openFullScreenGallery(0);
              } else {
                _openFullScreenGallery(index);
              }
            },
            child: Container(
              width: 280,
              margin: const EdgeInsets.only(right: 12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: images[index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.broken_image, color: Colors.grey[600]),
                      ),
                      memCacheWidth: 560,
                      maxWidthDiskCache: 560,
                    ),
                  ),
                  if (showViewAll)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black.withValues(alpha: 0.6),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.photo_library,
                              color: Colors.white,
                              size: 40,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '+${images.length - 5} more',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _openFullScreenGallery(int index) {
    final images = widget.categorizedImages.getImagesForCategory(_selectedCategory);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullscreenImageViewer(
          images: images,
          initialIndex: index,
        ),
      ),
    );
  }
}
