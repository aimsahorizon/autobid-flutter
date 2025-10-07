enum CarImageCategory {
  exterior,
  interior,
  engine,
  details;

  String get displayName {
    switch (this) {
      case CarImageCategory.exterior:
        return 'Exterior';
      case CarImageCategory.interior:
        return 'Interior';
      case CarImageCategory.engine:
        return 'Engine';
      case CarImageCategory.details:
        return 'Details';
    }
  }

  String get icon {
    switch (this) {
      case CarImageCategory.exterior:
        return '🚗';
      case CarImageCategory.interior:
        return '💺';
      case CarImageCategory.engine:
        return '⚙️';
      case CarImageCategory.details:
        return '🔍';
    }
  }
}

class CategorizedCarImages {
  final Map<CarImageCategory, List<String>> images;

  const CategorizedCarImages({
    required this.images,
  });

  List<String> getAllImages() {
    return images.values.expand((list) => list).toList();
  }

  List<String> getImagesForCategory(CarImageCategory category) {
    return images[category] ?? [];
  }

  bool hasImagesForCategory(CarImageCategory category) {
    return images[category]?.isNotEmpty ?? false;
  }

  int getTotalImageCount() {
    return images.values.fold(0, (sum, list) => sum + list.length);
  }
}
