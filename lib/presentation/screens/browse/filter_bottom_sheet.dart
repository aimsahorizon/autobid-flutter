import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/car_model.dart';
import '../../../data/models/search_filters.dart';
import '../../../core/constants/car_brands.dart';
import '../../../core/constants/ph_locations.dart';
import '../../../core/utils/enum_extensions.dart';
import '../../providers/browse_provider.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late SearchFilters _filters;
  int _yearMin = 2010;
  int _yearMax = 2024;
  double _mileageMax = 150000;

  @override
  void initState() {
    super.initState();
    final browseProvider = context.read<BrowseProvider>();
    _filters = browseProvider.searchFilters;
    if (_filters.yearMin != null) _yearMin = _filters.yearMin!;
    if (_filters.yearMax != null) _yearMax = _filters.yearMax!;
    if (_filters.mileageMax != null) _mileageMax = _filters.mileageMax!.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: theme.dividerColor),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Filters',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _filters = const SearchFilters();
                          _yearMin = 2010;
                          _yearMax = 2024;
                          _mileageMax = 150000;
                        });
                      },
                      child: const Text('Clear All'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Filter content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Auction Filter
                    SwitchListTile(
                      title: Text(
                        'Auctions Only',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('Show only cars available in auctions'),
                      value: _filters.auctionsOnly,
                      onChanged: (value) {
                        setState(() {
                          _filters = _filters.copyWith(auctionsOnly: value);
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),

                    const SizedBox(height: 24),

                    // Brands
                    _buildSectionTitle('Brand'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: CarBrands.popularBrands.map((brand) {
                        final isSelected = _filters.brands.contains(brand);
                        return FilterChip(
                          label: Text(brand),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              final brands = List<String>.from(_filters.brands);
                              if (selected) {
                                brands.add(brand);
                              } else {
                                brands.remove(brand);
                              }
                              _filters = _filters.copyWith(brands: brands);
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Year Range
                    _buildSectionTitle('Year Range'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text('$_yearMin'),
                        ),
                        Expanded(
                          flex: 3,
                          child: RangeSlider(
                            values: RangeValues(_yearMin.toDouble(), _yearMax.toDouble()),
                            min: 2010,
                            max: 2024,
                            divisions: 14,
                            labels: RangeLabels(_yearMin.toString(), _yearMax.toString()),
                            onChanged: (values) {
                              setState(() {
                                _yearMin = values.start.round();
                                _yearMax = values.end.round();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '$_yearMax',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Mileage
                    _buildSectionTitle('Maximum Mileage'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Slider(
                            value: _mileageMax,
                            min: 10000,
                            max: 200000,
                            divisions: 19,
                            label: '${_mileageMax.round()} km',
                            onChanged: (value) {
                              setState(() {
                                _mileageMax = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 100,
                          child: Text(
                            '${_mileageMax.round()} km',
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Transmission
                    _buildSectionTitle('Transmission'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: TransmissionType.values.map((transmission) {
                        final isSelected = _filters.transmission.contains(transmission);
                        return FilterChip(
                          label: Text(transmission.displayName),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              final transmissions = List<TransmissionType>.from(_filters.transmission);
                              if (selected) {
                                transmissions.add(transmission);
                              } else {
                                transmissions.remove(transmission);
                              }
                              _filters = _filters.copyWith(transmission: transmissions);
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Fuel Type
                    _buildSectionTitle('Fuel Type'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: FuelType.values.map((fuelType) {
                        final isSelected = _filters.fuelType.contains(fuelType);
                        return FilterChip(
                          label: Text(fuelType.displayName),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              final fuelTypes = List<FuelType>.from(_filters.fuelType);
                              if (selected) {
                                fuelTypes.add(fuelType);
                              } else {
                                fuelTypes.remove(fuelType);
                              }
                              _filters = _filters.copyWith(fuelType: fuelTypes);
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Body Type
                    _buildSectionTitle('Body Type'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: BodyType.values.map((bodyType) {
                        final isSelected = _filters.bodyType.contains(bodyType);
                        return FilterChip(
                          label: Text(bodyType.displayName),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              final bodyTypes = List<BodyType>.from(_filters.bodyType);
                              if (selected) {
                                bodyTypes.add(bodyType);
                              } else {
                                bodyTypes.remove(bodyType);
                              }
                              _filters = _filters.copyWith(bodyType: bodyTypes);
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Location
                    _buildSectionTitle('Location'),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Province',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: _filters.province,
                      items: [
                        const DropdownMenuItem(value: null, child: Text('All Provinces')),
                        ...PhilippineLocations.provinces.map((province) {
                          return DropdownMenuItem(
                            value: province,
                            child: Text(province),
                          );
                        }),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _filters = _filters.copyWith(province: value, city: null);
                        });
                      },
                    ),
                    if (_filters.province != null) ...[
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: _filters.city,
                        items: [
                          const DropdownMenuItem(value: null, child: Text('All Cities')),
                          ...PhilippineLocations.getCitiesForProvince(_filters.province!).map((city) {
                            return DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            );
                          }),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _filters = _filters.copyWith(city: value);
                          });
                        },
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Sort By
                    _buildSectionTitle('Sort By'),
                    const SizedBox(height: 8),
                    // ignore: deprecated_member_use
                    ...SortBy.values.map((sortBy) {
                      return RadioListTile<SortBy>(
                        title: Text(_getSortByLabel(sortBy)),
                        value: sortBy,
                        // ignore: deprecated_member_use
                        groupValue: _filters.sortBy,
                        // ignore: deprecated_member_use
                        onChanged: (SortBy? value) {
                          if (value != null) {
                            setState(() {
                              _filters = _filters.copyWith(sortBy: value);
                            });
                          }
                        },
                      );
                    }),
                  ],
                ),
              ),

              // Apply button
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: theme.dividerColor),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      // Apply year and mileage filters
                      final finalFilters = _filters.copyWith(
                        yearMin: _yearMin,
                        yearMax: _yearMax,
                        mileageMax: _mileageMax.round(),
                      );

                      context.read<BrowseProvider>().applyFilters(filters: finalFilters);
                      Navigator.pop(context);
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String _getSortByLabel(SortBy sortBy) {
    switch (sortBy) {
      case SortBy.priceAsc:
        return 'Price: Low to High';
      case SortBy.priceDesc:
        return 'Price: High to Low';
      case SortBy.yearNewest:
        return 'Year: Newest First';
      case SortBy.mileageLowest:
        return 'Mileage: Low to High';
      case SortBy.newest:
        return 'Recently Listed';
      case SortBy.endingSoon:
        return 'Ending Soon';
      default:
        return 'Recently Listed';
    }
  }
}
