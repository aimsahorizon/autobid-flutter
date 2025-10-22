import 'package:flutter/material.dart';
import '../../core/constants/ph_locations.dart';

/// Reusable 5-field Philippine address picker with dynamic filtering
/// Fields: Region, Province, City, Barangay, Additional Landmark
class PhilippineAddressPicker extends StatefulWidget {
  final String? initialRegion;
  final String? initialProvince;
  final String? initialCity;
  final String? initialBarangay;
  final String? initialLandmark;
  final Function(Map<String, String>) onAddressChanged;
  final bool enabled;

  const PhilippineAddressPicker({
    super.key,
    this.initialRegion,
    this.initialProvince,
    this.initialCity,
    this.initialBarangay,
    this.initialLandmark,
    required this.onAddressChanged,
    this.enabled = true,
  });

  @override
  State<PhilippineAddressPicker> createState() => PhilippineAddressPickerState();
}

class PhilippineAddressPickerState extends State<PhilippineAddressPicker> {
  String? _selectedRegion;
  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedBarangay;
  final _landmarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedRegion = widget.initialRegion;
    _selectedProvince = widget.initialProvince;
    _selectedCity = widget.initialCity;
    _selectedBarangay = widget.initialBarangay;
    if (widget.initialLandmark != null) {
      _landmarkController.text = widget.initialLandmark!;
    }
    _landmarkController.addListener(_notifyChange);
  }

  @override
  void dispose() {
    _landmarkController.dispose();
    super.dispose();
  }

  void _notifyChange() {
    widget.onAddressChanged({
      'region': _selectedRegion ?? '',
      'province': _selectedProvince ?? '',
      'city': _selectedCity ?? '',
      'barangay': _selectedBarangay ?? '',
      'landmark': _landmarkController.text,
    });
  }

  void resetAddress() {
    setState(() {
      _selectedRegion = null;
      _selectedProvince = null;
      _selectedCity = null;
      _selectedBarangay = null;
      _landmarkController.clear();
    });
    _notifyChange();
  }

  Map<String, String> getAddress() {
    return {
      'region': _selectedRegion ?? '',
      'province': _selectedProvince ?? '',
      'city': _selectedCity ?? '',
      'barangay': _selectedBarangay ?? '',
      'landmark': _landmarkController.text,
    };
  }

  String getFullAddress() {
    final parts = <String>[];
    if (_landmarkController.text.isNotEmpty) parts.add(_landmarkController.text);
    if (_selectedBarangay != null && _selectedBarangay!.isNotEmpty) parts.add(_selectedBarangay!);
    if (_selectedCity != null && _selectedCity!.isNotEmpty) parts.add(_selectedCity!);
    if (_selectedProvince != null && _selectedProvince!.isNotEmpty) parts.add(_selectedProvince!);
    if (_selectedRegion != null && _selectedRegion!.isNotEmpty) parts.add(_selectedRegion!);
    return parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Region Dropdown
        _buildDropdown(
          label: 'Region',
          value: _selectedRegion,
          items: PhilippineLocations.regions,
          icon: Icons.public_outlined,
          onChanged: widget.enabled
              ? (value) {
                  setState(() {
                    _selectedRegion = value;
                    _selectedProvince = null;
                    _selectedCity = null;
                    _selectedBarangay = null;
                  });
                  _notifyChange();
                }
              : null,
        ),
        const SizedBox(height: 12),

        // Province Dropdown (filtered by region)
        _buildDropdown(
          label: 'Province',
          value: _selectedProvince,
          items: _selectedRegion == null
              ? []
              : PhilippineLocations.getProvincesForRegion(_selectedRegion!),
          icon: Icons.map_outlined,
          onChanged: (_selectedRegion == null || !widget.enabled)
              ? null
              : (value) {
                  setState(() {
                    _selectedProvince = value;
                    _selectedCity = null;
                    _selectedBarangay = null;
                  });
                  _notifyChange();
                },
        ),
        const SizedBox(height: 12),

        // City Dropdown (filtered by province)
        _buildDropdown(
          label: 'City / Municipality',
          value: _selectedCity,
          items: _selectedProvince == null
              ? []
              : PhilippineLocations.getCitiesForProvince(_selectedProvince!),
          icon: Icons.location_city_outlined,
          onChanged: (_selectedProvince == null || !widget.enabled)
              ? null
              : (value) {
                  setState(() {
                    _selectedCity = value;
                    _selectedBarangay = null;
                  });
                  _notifyChange();
                },
        ),
        const SizedBox(height: 12),

        // Barangay (dropdown if available, text field otherwise)
        _buildBarangayField(),
        const SizedBox(height: 12),

        // Additional Landmark (text field)
        TextField(
          controller: _landmarkController,
          enabled: widget.enabled,
          decoration: const InputDecoration(
            labelText: 'Additional Landmark',
            hintText: 'e.g., Near SM Mall, Corner of Main Street',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.add_location_outlined),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          maxLength: 200,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required IconData icon,
    required void Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: (value != null && items.contains(value)) ? value : null,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: InputBorder.none,
              prefixIcon: Icon(icon),
              hintText: 'Select $label',
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            isExpanded: true,
          ),
        ),
      ],
    );
  }

  Widget _buildBarangayField() {
    final barangays = _selectedCity == null
        ? <String>[]
        : PhilippineLocations.getBarangaysForCity(_selectedCity!);

    if (barangays.isEmpty) {
      // No barangays available, show text field
      return TextField(
        onChanged: widget.enabled
            ? (value) {
                setState(() {
                  _selectedBarangay = value;
                });
                _notifyChange();
              }
            : null,
        enabled: widget.enabled,
        controller: TextEditingController(text: _selectedBarangay),
        decoration: const InputDecoration(
          labelText: 'Barangay',
          hintText: 'Enter barangay',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.location_on_outlined),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      );
    }

    // Barangays available, show dropdown
    if (_selectedBarangay != null && !barangays.contains(_selectedBarangay)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _selectedBarangay = null;
          });
          _notifyChange();
        }
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Barangay',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: (_selectedBarangay != null && barangays.contains(_selectedBarangay))
                ? _selectedBarangay
                : null,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.location_on_outlined),
              hintText: 'Select barangay',
            ),
            items: barangays.map((barangay) {
              return DropdownMenuItem(
                value: barangay,
                child: Text(barangay),
              );
            }).toList(),
            onChanged: (_selectedCity == null || !widget.enabled)
                ? null
                : (value) {
                    setState(() {
                      _selectedBarangay = value;
                    });
                    _notifyChange();
                  },
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}
