import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/car_model.dart';
import '../../../data/models/search_filters.dart';
import '../../../core/constants/car_brands.dart';
import '../../../core/constants/ph_locations.dart';
import '../../../core/utils/car_enum_extensions.dart';
import '../../providers/browse_provider.dart';
import '../../widgets/filter_widgets.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late SearchFilters _filters;

  // Text controllers for inputs
  final TextEditingController _yearMinController = TextEditingController();
  final TextEditingController _yearMaxController = TextEditingController();
  final TextEditingController _horsepowerMinController = TextEditingController();
  final TextEditingController _horsepowerMaxController = TextEditingController();
  final TextEditingController _torqueMinController = TextEditingController();
  final TextEditingController _torqueMaxController = TextEditingController();
  final TextEditingController _curbWeightMinController = TextEditingController();
  final TextEditingController _curbWeightMaxController = TextEditingController();
  final TextEditingController _cargoCapacityMinController = TextEditingController();
  final TextEditingController _mileageMinController = TextEditingController();
  final TextEditingController _mileageMaxController = TextEditingController();

  // Mileage unit (km or miles)
  String _mileageUnit = 'km';

  @override
  void initState() {
    super.initState();
    final browseProvider = context.read<BrowseProvider>();
    _filters = browseProvider.searchFilters;

    // Initialize from filters
    if (_filters.yearMin != null) _yearMinController.text = _filters.yearMin.toString();
    if (_filters.yearMax != null) _yearMaxController.text = _filters.yearMax.toString();
    if (_filters.horsepowerMin != null) _horsepowerMinController.text = _filters.horsepowerMin.toString();
    if (_filters.horsepowerMax != null) _horsepowerMaxController.text = _filters.horsepowerMax.toString();
    if (_filters.torqueMin != null) _torqueMinController.text = _filters.torqueMin.toString();
    if (_filters.torqueMax != null) _torqueMaxController.text = _filters.torqueMax.toString();
    if (_filters.curbWeightMin != null) _curbWeightMinController.text = _filters.curbWeightMin.toString();
    if (_filters.curbWeightMax != null) _curbWeightMaxController.text = _filters.curbWeightMax.toString();
    if (_filters.cargoCapacityMin != null) _cargoCapacityMinController.text = _filters.cargoCapacityMin.toString();
    if (_filters.mileageMin != null) _mileageMinController.text = _filters.mileageMin.toString();
    if (_filters.mileageMax != null) _mileageMaxController.text = _filters.mileageMax.toString();
  }

  @override
  void dispose() {
    _yearMinController.dispose();
    _yearMaxController.dispose();
    _horsepowerMinController.dispose();
    _horsepowerMaxController.dispose();
    _torqueMinController.dispose();
    _torqueMaxController.dispose();
    _curbWeightMinController.dispose();
    _curbWeightMaxController.dispose();
    _cargoCapacityMinController.dispose();
    _mileageMinController.dispose();
    _mileageMaxController.dispose();
    super.dispose();
  }

  void _clearAllFilters() {
    // Apply cleared filters and close with animation
    context.read<BrowseProvider>().applyFilters(filters: const SearchFilters());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        snap: true,
        snapSizes: const [0.5, 0.9],
        builder: (context, scrollController) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
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
                      onPressed: _clearAllFilters,
                      child: const Text('Clear All'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
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
                          child: TextField(
                            controller: _yearMinController,
                            decoration: const InputDecoration(
                              labelText: 'Min Year',
                              border: OutlineInputBorder(),
                              hintText: 'e.g., 1990',
                            ),
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            onTap: () => _showYearPicker(true),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _yearMaxController,
                            decoration: const InputDecoration(
                              labelText: 'Max Year',
                              border: OutlineInputBorder(),
                              hintText: 'e.g., 2024',
                            ),
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            onTap: () => _showYearPicker(false),
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

                    // === ENGINE & PERFORMANCE SECTION ===
                    FilterSection(
                      title: 'Engine & Performance',
                      initiallyExpanded: false,
                      children: [
                        // Horsepower Range
                        const Text('Horsepower', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _horsepowerMinController,
                                decoration: const InputDecoration(
                                  labelText: 'Min hp',
                                  border: OutlineInputBorder(),
                                  hintText: '50',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _horsepowerMaxController,
                                decoration: const InputDecoration(
                                  labelText: 'Max hp',
                                  border: OutlineInputBorder(),
                                  hintText: '500',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Torque Range
                        const Text('Torque', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _torqueMinController,
                                decoration: const InputDecoration(
                                  labelText: 'Min Nm',
                                  border: OutlineInputBorder(),
                                  hintText: '100',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _torqueMaxController,
                                decoration: const InputDecoration(
                                  labelText: 'Max Nm',
                                  border: OutlineInputBorder(),
                                  hintText: '600',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Engine Type
                        const Text('Engine Type', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        ChipFilterGroup<EngineType>(
                          items: EngineType.values,
                          selectedItems: _filters.engineTypes,
                          labelBuilder: (type) => type.displayName,
                          onChanged: (type, selected) {
                            setState(() {
                              final types = List<EngineType>.from(_filters.engineTypes);
                              if (selected) {
                                types.add(type);
                              } else {
                                types.remove(type);
                              }
                              _filters = _filters.copyWith(engineTypes: types);
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Drive Type
                        const Text('Drive Type', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        ChipFilterGroup<DriveType>(
                          items: DriveType.values,
                          selectedItems: _filters.driveTypes,
                          labelBuilder: (type) => type.displayName,
                          onChanged: (type, selected) {
                            setState(() {
                              final types = List<DriveType>.from(_filters.driveTypes);
                              if (selected) {
                                types.add(type);
                              } else {
                                types.remove(type);
                              }
                              _filters = _filters.copyWith(driveTypes: types);
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // === DIMENSIONS & CAPACITY SECTION ===
                    FilterSection(
                      title: 'Dimensions & Capacity',
                      initiallyExpanded: false,
                      children: [
                        // Seating Capacity
                        const Text('Seating Capacity', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        ChipFilterGroup<int>(
                          items: const [2, 4, 5, 7, 8],
                          selectedItems: _filters.seats,
                          labelBuilder: (seats) => '$seats seats',
                          onChanged: (seats, selected) {
                            setState(() {
                              final seatList = List<int>.from(_filters.seats);
                              if (selected) {
                                seatList.add(seats);
                              } else {
                                seatList.remove(seats);
                              }
                              _filters = _filters.copyWith(seats: seatList);
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Door Count
                        const Text('Door Count', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        ChipFilterGroup<int>(
                          items: const [2, 3, 4, 5],
                          selectedItems: _filters.doors,
                          labelBuilder: (doors) => '$doors doors',
                          onChanged: (doors, selected) {
                            setState(() {
                              final doorList = List<int>.from(_filters.doors);
                              if (selected) {
                                doorList.add(doors);
                              } else {
                                doorList.remove(doors);
                              }
                              _filters = _filters.copyWith(doors: doorList);
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Curb Weight Range
                        const Text('Curb Weight (kg)', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _curbWeightMinController,
                                decoration: const InputDecoration(
                                  labelText: 'Min kg',
                                  border: OutlineInputBorder(),
                                  hintText: '800',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _curbWeightMaxController,
                                decoration: const InputDecoration(
                                  labelText: 'Max kg',
                                  border: OutlineInputBorder(),
                                  hintText: '3000',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Cargo Capacity
                        const Text('Minimum Cargo Capacity (L)', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _cargoCapacityMinController,
                          decoration: const InputDecoration(
                            labelText: 'Min Liters',
                            border: OutlineInputBorder(),
                            hintText: '200',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // === EXTERIOR SECTION ===
                    FilterSection(
                      title: 'Exterior',
                      initiallyExpanded: false,
                      children: [
                        // Paint Type
                        const Text('Paint Type', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        ChipFilterGroup<PaintType>(
                          items: PaintType.values,
                          selectedItems: _filters.paintTypes,
                          labelBuilder: (type) => type.displayName,
                          onChanged: (type, selected) {
                            setState(() {
                              final types = List<PaintType>.from(_filters.paintTypes);
                              if (selected) {
                                types.add(type);
                              } else {
                                types.remove(type);
                              }
                              _filters = _filters.copyWith(paintTypes: types);
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Rim Type
                        const Text('Rim Type', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        ChipFilterGroup<RimType>(
                          items: RimType.values,
                          selectedItems: _filters.rimTypes,
                          labelBuilder: (type) => type.displayName,
                          onChanged: (type, selected) {
                            setState(() {
                              final types = List<RimType>.from(_filters.rimTypes);
                              if (selected) {
                                types.add(type);
                              } else {
                                types.remove(type);
                              }
                              _filters = _filters.copyWith(rimTypes: types);
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Tire Condition
                        const Text('Tire Condition', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        ChipFilterGroup<TireCondition>(
                          items: TireCondition.values,
                          selectedItems: _filters.tireConditions,
                          labelBuilder: (cond) => cond.displayName,
                          onChanged: (cond, selected) {
                            setState(() {
                              final conds = List<TireCondition>.from(_filters.tireConditions);
                              if (selected) {
                                conds.add(cond);
                              } else {
                                conds.remove(cond);
                              }
                              _filters = _filters.copyWith(tireConditions: conds);
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // === CONDITION & HISTORY SECTION ===
                    FilterSection(
                      title: 'Condition & History',
                      initiallyExpanded: false,
                      children: [
                        // Mileage Range
                        const Text('Mileage Range', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _mileageMinController,
                                decoration: const InputDecoration(
                                  labelText: 'Min',
                                  border: OutlineInputBorder(),
                                  hintText: '0',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _mileageMaxController,
                                decoration: const InputDecoration(
                                  labelText: 'Max',
                                  border: OutlineInputBorder(),
                                  hintText: '200000',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: _mileageUnit,
                              items: const [
                                DropdownMenuItem(value: 'km', child: Text('km')),
                                DropdownMenuItem(value: 'mi', child: Text('mi')),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _mileageUnit = value;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Condition
                        const Text('Condition', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        ChipFilterGroup<CarCondition>(
                          items: CarCondition.values,
                          selectedItems: _filters.conditions,
                          labelBuilder: (cond) => cond.displayName,
                          onChanged: (cond, selected) {
                            setState(() {
                              final conds = List<CarCondition>.from(_filters.conditions);
                              if (selected) {
                                conds.add(cond);
                              } else {
                                conds.remove(cond);
                              }
                              _filters = _filters.copyWith(conditions: conds);
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Boolean filters
                        BooleanFilter(
                          label: 'Accident Free',
                          value: _filters.accidentFree,
                          onChanged: (value) {
                            setState(() {
                              _filters = _filters.copyWith(accidentFree: value);
                            });
                          },
                        ),
                        BooleanFilter(
                          label: 'Flood Free',
                          value: _filters.floodFree,
                          onChanged: (value) {
                            setState(() {
                              _filters = _filters.copyWith(floodFree: value);
                            });
                          },
                        ),
                        BooleanFilter(
                          label: 'With Warranty',
                          value: _filters.withWarranty,
                          onChanged: (value) {
                            setState(() {
                              _filters = _filters.copyWith(withWarranty: value);
                            });
                          },
                        ),
                        BooleanFilter(
                          label: 'Complete Service History',
                          value: _filters.completeServiceHistory,
                          onChanged: (value) {
                            setState(() {
                              _filters = _filters.copyWith(completeServiceHistory: value);
                            });
                          },
                        ),
                      ],
                    ),

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
                      // Parse values from text controllers
                      final yearMin = _yearMinController.text.isNotEmpty ? int.tryParse(_yearMinController.text) : null;
                      final yearMax = _yearMaxController.text.isNotEmpty ? int.tryParse(_yearMaxController.text) : null;
                      final horsepowerMin = _horsepowerMinController.text.isNotEmpty ? int.tryParse(_horsepowerMinController.text) : null;
                      final horsepowerMax = _horsepowerMaxController.text.isNotEmpty ? int.tryParse(_horsepowerMaxController.text) : null;
                      final torqueMin = _torqueMinController.text.isNotEmpty ? int.tryParse(_torqueMinController.text) : null;
                      final torqueMax = _torqueMaxController.text.isNotEmpty ? int.tryParse(_torqueMaxController.text) : null;
                      final curbWeightMin = _curbWeightMinController.text.isNotEmpty ? int.tryParse(_curbWeightMinController.text) : null;
                      final curbWeightMax = _curbWeightMaxController.text.isNotEmpty ? int.tryParse(_curbWeightMaxController.text) : null;
                      final cargoCapacityMin = _cargoCapacityMinController.text.isNotEmpty ? int.tryParse(_cargoCapacityMinController.text) : null;

                      // Parse mileage and convert if needed
                      int? mileageMin = _mileageMinController.text.isNotEmpty ? int.tryParse(_mileageMinController.text) : null;
                      int? mileageMax = _mileageMaxController.text.isNotEmpty ? int.tryParse(_mileageMaxController.text) : null;

                      // Convert miles to km if needed (stored in km)
                      if (_mileageUnit == 'mi') {
                        if (mileageMin != null) mileageMin = (mileageMin * 1.60934).round();
                        if (mileageMax != null) mileageMax = (mileageMax * 1.60934).round();
                      }

                      // Apply all filters with range values
                      final finalFilters = _filters.copyWith(
                        yearMin: yearMin,
                        yearMax: yearMax,
                        horsepowerMin: horsepowerMin,
                        horsepowerMax: horsepowerMax,
                        torqueMin: torqueMin,
                        torqueMax: torqueMax,
                        curbWeightMin: curbWeightMin,
                        curbWeightMax: curbWeightMax,
                        cargoCapacityMin: cargoCapacityMin,
                        mileageMin: mileageMin,
                        mileageMax: mileageMax,
                      );

                      context.read<BrowseProvider>().applyFilters(filters: finalFilters);
                      Navigator.of(context).pop();
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
      ),
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

  Future<void> _showYearPicker(bool isMin) async {
    final currentYear = DateTime.now().year;
    final initialYear = isMin
        ? (_yearMinController.text.isNotEmpty ? int.tryParse(_yearMinController.text) ?? 1900 : 1900)
        : (_yearMaxController.text.isNotEmpty ? int.tryParse(_yearMaxController.text) ?? currentYear : currentYear);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isMin ? 'Select Minimum Year' : 'Select Maximum Year'),
        content: SizedBox(
          width: 300,
          height: 300,
          child: YearPicker(
            firstDate: DateTime(1900),
            lastDate: DateTime(currentYear + 1),
            selectedDate: DateTime(initialYear),
            onChanged: (DateTime dateTime) {
              setState(() {
                if (isMin) {
                  _yearMinController.text = dateTime.year.toString();
                } else {
                  _yearMaxController.text = dateTime.year.toString();
                }
              });
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
