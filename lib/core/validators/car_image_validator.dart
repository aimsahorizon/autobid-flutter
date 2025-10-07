import '../../data/models/required_car_images.dart';

class CarImageValidationResult {
  final bool isValid;
  final List<String> missingImages;
  final Map<String, int> categoryImageCounts;
  final int totalImages;

  const CarImageValidationResult({
    required this.isValid,
    required this.missingImages,
    required this.categoryImageCounts,
    required this.totalImages,
  });
}

class CarImageValidator {
  static CarImageValidationResult validate(Map<String, List<String>> categorizedImages) {
    final missingImages = <String>[];
    final categoryImageCounts = <String, int>{};

    // Check exterior images
    final exteriorImages = categorizedImages['exterior'] ?? [];
    categoryImageCounts['exterior'] = exteriorImages.length;
    if (exteriorImages.length < RequiredCarImages.exteriorImages.length) {
      missingImages.add('Exterior: ${RequiredCarImages.exteriorImages.length - exteriorImages.length} missing');
    }

    // Check interior images
    final interiorImages = categorizedImages['interior'] ?? [];
    categoryImageCounts['interior'] = interiorImages.length;
    if (interiorImages.length < RequiredCarImages.interiorImages.length) {
      missingImages.add('Interior: ${RequiredCarImages.interiorImages.length - interiorImages.length} missing');
    }

    // Check engine images
    final engineImages = categorizedImages['engine'] ?? [];
    categoryImageCounts['engine'] = engineImages.length;
    if (engineImages.length < RequiredCarImages.engineImages.length) {
      missingImages.add('Engine: ${RequiredCarImages.engineImages.length - engineImages.length} missing');
    }

    // Check details images
    final detailImages = categorizedImages['details'] ?? [];
    categoryImageCounts['details'] = detailImages.length;
    if (detailImages.length < RequiredCarImages.detailImages.length) {
      missingImages.add('Details: ${RequiredCarImages.detailImages.length - detailImages.length} missing');
    }

    final totalImages = exteriorImages.length +
                        interiorImages.length +
                        engineImages.length +
                        detailImages.length;

    final isValid = missingImages.isEmpty && totalImages >= RequiredCarImages.totalRequiredImages;

    return CarImageValidationResult(
      isValid: isValid,
      missingImages: missingImages,
      categoryImageCounts: categoryImageCounts,
      totalImages: totalImages,
    );
  }

  static String getValidationMessage(CarImageValidationResult result) {
    if (result.isValid) {
      return 'All ${RequiredCarImages.totalRequiredImages} required images uploaded ✓';
    }

    return 'Missing images:\n${result.missingImages.join('\n')}\n\n'
           'Total: ${result.totalImages}/${RequiredCarImages.totalRequiredImages}';
  }

  static double getCompletionPercentage(Map<String, List<String>> categorizedImages) {
    final result = validate(categorizedImages);
    return (result.totalImages / RequiredCarImages.totalRequiredImages * 100).clamp(0, 100);
  }
}
