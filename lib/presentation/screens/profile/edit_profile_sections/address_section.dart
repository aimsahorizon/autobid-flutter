import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/user_model.dart';

/// Section 3: Address Information
/// - Street, City, Province, ZIP
/// - Allow multiple saved addresses
/// - "Set as default" toggle
class AddressSection extends ConsumerStatefulWidget {
  final UserModel user;

  const AddressSection({super.key, required this.user});

  @override
  ConsumerState<AddressSection> createState() => _AddressSectionState();
}

class _AddressSectionState extends ConsumerState<AddressSection> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _barangayController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _zipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  void _loadAddress() {
    _streetController.text = widget.user.street ?? '';
    _barangayController.text = widget.user.barangay ?? '';
    _cityController.text = widget.user.city ?? '';
    _provinceController.text = widget.user.province ?? '';
    _zipController.text = widget.user.zipCode ?? '';
  }

  @override
  void dispose() {
    _streetController.dispose();
    _barangayController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    // TODO: Implement address update
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Address updated successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Section Header
        Text(
          'Address Information',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your residential address details',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 24),

        Form(
          key: _formKey,
          child: Column(
            children: [
              // Street
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(
                  labelText: 'Street Address',
                  hintText: 'House/Block/Lot No., Street Name',
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Street address is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Barangay
              TextFormField(
                controller: _barangayController,
                decoration: const InputDecoration(
                  labelText: 'Barangay',
                  hintText: 'Enter barangay',
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // City
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City/Municipality',
                  hintText: 'Enter city or municipality',
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'City is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Province
              TextFormField(
                controller: _provinceController,
                decoration: const InputDecoration(
                  labelText: 'Province',
                  hintText: 'Enter province',
                  prefixIcon: Icon(Icons.map),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Province is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ZIP Code
              TextFormField(
                controller: _zipController,
                decoration: const InputDecoration(
                  labelText: 'ZIP Code',
                  hintText: '0000',
                  prefixIcon: Icon(Icons.pin_drop),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 4,
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length != 4) {
                    return 'ZIP code must be 4 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _saveAddress,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Address'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
