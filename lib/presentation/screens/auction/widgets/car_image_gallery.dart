import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'fullscreen_image_viewer.dart';

class CarImageGallery extends StatefulWidget {
  final List<String> images;
  final double height;
  final bool showThumbnails;

  const CarImageGallery({
    super.key,
    required this.images,
    this.height = 300,
    this.showThumbnails = true,
  });

  @override
  State<CarImageGallery> createState() => _CarImageGalleryState();
}

class _CarImageGalleryState extends State<CarImageGallery> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: widget.height,
        color: Colors.grey[300],
        child: Icon(Icons.directions_car, size: 100, color: Colors.grey[600]),
      );
    }

    return Column(
      children: [
        Expanded(
          child: _buildMainGallery(),
        ),
        if (widget.showThumbnails && widget.images.length > 1)
          _buildThumbnailStrip(),
      ],
    );
  }

  Widget _buildMainGallery() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Main image carousel
        PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _openFullScreenGallery(context, index),
              child: CachedNetworkImage(
                imageUrl: widget.images[index],
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 100, color: Colors.grey[600]),
                ),
                memCacheWidth: 1080,
                maxWidthDiskCache: 1080,
              ),
            );
          },
        ),

        // Gradient overlay
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
        ),

        // Navigation arrows (for larger screens)
        if (widget.images.length > 1) ...[
          // Previous button
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.chevron_left, size: 40),
                color: Colors.white,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                ),
                onPressed: _currentPage > 0
                    ? () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
              ),
            ),
          ),

          // Next button
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.chevron_right, size: 40),
                color: Colors.white,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                ),
                onPressed: _currentPage < widget.images.length - 1
                    ? () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildThumbnailStrip() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.black.withValues(alpha: 0.8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          final isSelected = index == _currentPage;
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.transparent,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: widget.images[index],
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[700],
                    child: Icon(Icons.broken_image, color: Colors.grey[500]),
                  ),
                  memCacheWidth: 160,
                  maxWidthDiskCache: 160,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openFullScreenGallery(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullscreenImageViewer(
          images: widget.images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}
