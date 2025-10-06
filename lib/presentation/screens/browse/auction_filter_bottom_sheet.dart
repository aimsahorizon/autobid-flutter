import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/models/search_filters.dart';
import '../../../data/models/car_model.dart';
import '../../../core/constants/car_brands.dart';
import '../../../core/constants/ph_locations.dart';
import '../../../core/utils/enum_extensions.dart';

class AuctionFilterBottomSheet extends StatefulWidget {
  final Function(SearchFilters filters) onApply;
  final SearchFilters? initialFilters;

  const AuctionFilterBottomSheet({
    super.key,
    required this.onApply,
    this.initialFilters,
  });

  @override
  State<AuctionFilterBottomSheet> createState() => _AuctionFilterBottomSheetState();
}

class _AuctionFilterBottomSheetState extends State<AuctionFilterBottomSheet> {
  late SearchFilters _filters;
  int? _yearMin;
  int? _yearMax;
  final TextEditingController _yearMinController = TextEditingController();
  final TextEditingController _yearMaxController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();
  final int _currentYear = DateTime.now().year;
  final int _earliestYear = 1990;

  @override
  void initState() {
    super.initState();
    _filters = widget.initialFilters ?? const SearchFilters();
    // Only use filter values if they were explicitly set by user
    if (_filters.yearMin != null) {
      _yearMin = _filters.yearMin!;
      _yearMinController.text = _filters.yearMin.toString();
    }
    if (_filters.yearMax != null) {
      _yearMax = _filters.yearMax!;
      _yearMaxController.text = _filters.yearMax.toString();
    }
    if (_filters.mileageMax != null) {
      _mileageController.text = _formatNumber(_filters.mileageMax!);
    }
  }

  @override
  void dispose() {
    _yearMinController.dispose();
    _yearMaxController.dispose();
    _mileageController.dispose();
    super.dispose();
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  int _parseNumber(String text) {
    return int.tryParse(text.replaceAll(',', '')) ?? 0;
  }

  void _showYearPicker(bool isMin) async {
    final selectedYear = await showDialog<int>(
      context: context,
      builder: (context) => _YearPickerDialog(
        initialYear: isMin ? _yearMin : _yearMax,
        minYear: _earliestYear,
        maxYear: _currentYear,
      ),
    );

    if (selectedYear != null) {
      setState(() {
        if (isMin) {
          _yearMin = selectedYear;
          _yearMinController.text = selectedYear.toString();
          if (_yearMax != null && _yearMin! > _yearMax!) {
            _yearMax = _yearMin;
            _yearMaxController.text = _yearMax.toString();
          }
        } else {
          _yearMax = selectedYear;
          _yearMaxController.text = selectedYear.toString();
          if (_yearMin != null && _yearMax! < _yearMin!) {
            _yearMin = _yearMax;
            _yearMinController.text = _yearMin.toString();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
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
                        'Filter Auctions',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onApply(const SearchFilters());
                        Navigator.pop(context);
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _showYearPicker(true),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: _yearMinController,
                                decoration: InputDecoration(
                                  labelText: 'Min Year',
                                  hintText: 'Any',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  suffixIcon: Icon(Icons.calendar_today, size: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InkWell(
                            onTap: () => _showYearPicker(false),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: _yearMaxController,
                                decoration: InputDecoration(
                                  labelText: 'Max Year',
                                  hintText: 'Any',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  suffixIcon: Icon(Icons.calendar_today, size: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Maximum Mileage
                    _buildSectionTitle('Maximum Mileage'),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _mileageController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        _ThousandsSeparatorInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Maximum Mileage',
                        hintText: 'e.g., 100,000',
                        suffixText: 'km',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
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
                      value: _filters.province,
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
                        value: _filters.city,
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
                    ...SortBy.values.map((sortBy) {
                      return RadioListTile<SortBy>(
                        title: Text(_getSortByLabel(sortBy)),
                        value: sortBy,
                        groupValue: _filters.sortBy,
                        onChanged: (SortBy? value) {
                          if (value != null) {
                            setState(() {
                              _filters = _filters.copyWith(sortBy: value);
                            });
                          }
                        },
                        contentPadding: EdgeInsets.zero,
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
                      // Parse mileage from text field
                      final mileageText = _mileageController.text.trim();
                      final mileageValue = mileageText.isNotEmpty ? _parseNumber(mileageText) : null;

                      final finalFilters = _filters.copyWith(
                        yearMin: _yearMin,
                        yearMax: _yearMax,
                        mileageMax: mileageValue,
                      );
                      widget.onApply(finalFilters);
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
      case SortBy.yearDesc:
        return 'Year: Newest First';
      case SortBy.mileageAsc:
        return 'Mileage: Low to High';
      case SortBy.newest:
        return 'Recently Listed';
      case SortBy.endingSoon:
        return 'Ending Soon';
    }
  }
}

class _YearPickerDialog extends StatelessWidget {
  final int? initialYear;
  final int minYear;
  final int maxYear;

  const _YearPickerDialog({
    required this.initialYear,
    required this.minYear,
    required this.maxYear,
  });

  @override
  Widget build(BuildContext context) {
    final years = List.generate(maxYear - minYear + 1, (index) => maxYear - index);
    final initialIndex = initialYear != null ? years.indexOf(initialYear!) : 0;

    return Dialog(
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Select Year',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                controller: ScrollController(
                  initialScrollOffset: initialIndex * 56.0,
                ),
                itemCount: years.length,
                itemBuilder: (context, index) {
                  final year = years[index];
                  final isSelected = year == initialYear;
                  return ListTile(
                    title: Text(
                      '$year',
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Theme.of(context).colorScheme.primary : null,
                      ),
                    ),
                    selected: isSelected,
                    selectedTileColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                    onTap: () => Navigator.pop(context, year),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final number = int.tryParse(newValue.text.replaceAll(',', ''));
    if (number == null) {
      return oldValue;
    }

    final formatted = number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
