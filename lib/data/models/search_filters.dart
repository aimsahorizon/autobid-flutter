import 'package:freezed_annotation/freezed_annotation.dart';
import 'car_model.dart';

part 'search_filters.freezed.dart';
part 'search_filters.g.dart';

enum SortBy {
  @JsonValue('price_asc')
  priceAsc,
  @JsonValue('price_desc')
  priceDesc,
  @JsonValue('year_desc')
  yearDesc,
  @JsonValue('mileage_asc')
  mileageAsc,
  @JsonValue('newest')
  newest,
}

@freezed
abstract class SearchFilters with _$SearchFilters {
  const SearchFilters._();

  const factory SearchFilters({
    String? keyword,
    @Default([]) List<String> brands,
    int? yearMin,
    int? yearMax,
    double? priceMin,
    double? priceMax,
    int? mileageMax,
    @Default([]) List<TransmissionType> transmission,
    @Default([]) List<FuelType> fuelType,
    @Default([]) List<BodyType> bodyType,
    String? city,
    String? province,
    @Default(SortBy.newest) SortBy sortBy,
  }) = _SearchFilters;

  factory SearchFilters.fromJson(Map<String, dynamic> json) =>
      _$SearchFiltersFromJson(json);

  // Helper to check if filters are empty
  bool get isEmpty {
    return keyword == null &&
        brands.isEmpty &&
        yearMin == null &&
        yearMax == null &&
        priceMin == null &&
        priceMax == null &&
        mileageMax == null &&
        transmission.isEmpty &&
        fuelType.isEmpty &&
        bodyType.isEmpty &&
        city == null &&
        province == null;
  }

  // Count active filters
  int get activeFilterCount {
    int count = 0;
    if (keyword != null && keyword!.isNotEmpty) count++;
    if (brands.isNotEmpty) count++;
    if (yearMin != null || yearMax != null) count++;
    if (priceMin != null || priceMax != null) count++;
    if (mileageMax != null) count++;
    if (transmission.isNotEmpty) count++;
    if (fuelType.isNotEmpty) count++;
    if (bodyType.isNotEmpty) count++;
    if (city != null || province != null) count++;
    return count;
  }
}
