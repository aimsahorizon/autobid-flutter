import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../providers/pre_transaction_provider.dart';
import '../../../data/models/transaction_model.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/payment_methods.dart';
import '../../widgets/custom_button.dart';

class PreTransactionConfirmationFormScreen extends StatefulWidget {
  final String auctionId;
  final String carTitle;
  final double winningBid;

  const PreTransactionConfirmationFormScreen({
    super.key,
    required this.auctionId,
    required this.carTitle,
    required this.winningBid,
  });

  @override
  State<PreTransactionConfirmationFormScreen> createState() =>
      _PreTransactionConfirmationFormScreenState();
}

class _PreTransactionConfirmationFormScreenState
    extends State<PreTransactionConfirmationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _deliveryLocationController = TextEditingController();
  final _notesController = TextEditingController();
  final _picker = ImagePicker();

  bool _vehicleDetailsConfirmed = false;
  PaymentMethodType? _selectedPaymentMethod;
  DateTime? _selectedDeliveryDate;
  bool _termsAgreed = false;
  final List<String> _uploadedDocuments = [];

  @override
  void dispose() {
    _deliveryLocationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDeliveryDate() async {
    final now = DateTime.now();
    final firstDate = now.add(const Duration(days: 1));
    final lastDate = now.add(const Duration(days: 60));

    final picked = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        _selectedDeliveryDate = picked;
      });
    }
  }

  Future<void> _pickDocument() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _uploadedDocuments.add(image.path);
      });
    }
  }

  Future<void> _submitConfirmation() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_vehicleDetailsConfirmed) {
      _showError('Please confirm vehicle details');
      return;
    }

    if (_selectedPaymentMethod == null) {
      _showError('Please select a payment method');
      return;
    }

    if (_selectedDeliveryDate == null) {
      _showError('Please select a delivery date');
      return;
    }

    if (!_termsAgreed) {
      _showError('Please agree to the terms and conditions');
      return;
    }

    final provider = context.read<PreTransactionProvider>();

    final success = await provider.submitBuyerConfirmation(
      buyerId: 'user123', // Mock buyer ID
      buyerName: 'Juan Dela Cruz',
      vehicleDetailsConfirmed: _vehicleDetailsConfirmed,
      preferredPaymentMethod: _selectedPaymentMethod,
      deliveryDate: DateFormat('yyyy-MM-dd').format(_selectedDeliveryDate!),
      deliveryLocation: _deliveryLocationController.text.trim(),
      uploadedDocuments: _uploadedDocuments,
      termsAgreed: _termsAgreed,
      notes: _notesController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      // Navigate to status screen
      context.pushReplacement(
        '/preTransactionStatus/${widget.auctionId}?carTitle=${Uri.encodeComponent(widget.carTitle)}&winningBid=${widget.winningBid}',
      );
    } else {
      _showError(provider.error ?? 'Failed to submit confirmation');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pre-Transaction Confirmation'),
        centerTitle: true,
      ),
      body: Consumer<PreTransactionProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarSummary(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('1. Vehicle Details Confirmation'),
                  _buildVehicleConfirmation(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('2. Payment Method'),
                  _buildPaymentMethodSelection(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('3. Delivery Details'),
                  _buildDeliveryDetails(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('4. Upload Documents (Optional)'),
                  _buildDocumentUpload(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('5. Additional Notes (Optional)'),
                  _buildNotesField(),
                  const SizedBox(height: 24),
                  _buildTermsCheckbox(),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: provider.isLoading ? 'Submitting...' : 'Submit Confirmation',
                    onPressed: provider.isLoading ? null : _submitConfirmation,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstants.primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.primaryGreen.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.directions_car,
              color: Colors.grey[400],
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.carTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Final Bid: ₱${_formatCurrency(widget.winningBid)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
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

  Widget _buildVehicleConfirmation() {
    return Card(
      child: CheckboxListTile(
        value: _vehicleDetailsConfirmed,
        onChanged: (value) {
          setState(() {
            _vehicleDetailsConfirmed = value ?? false;
          });
        },
        title: const Text('I confirm the vehicle details as discussed'),
        subtitle: const Text(
          'I have reviewed the vehicle condition, specs, and agreed upon terms',
          style: TextStyle(fontSize: 12),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  Widget _buildPaymentMethodSelection() {
    return Column(
      children: PaymentMethods.allMethods.map((method) {
        final isSelected = _selectedPaymentMethod == method.type;
        return Card(
          child: RadioListTile<PaymentMethodType>(
            value: method.type,
            groupValue: _selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value;
              });
            },
            title: Row(
              children: [
                Icon(_getIconForMethod(method.icon), size: 20),
                const SizedBox(width: 12),
                Text(method.displayName),
              ],
            ),
            subtitle: Text(
              method.description,
              style: const TextStyle(fontSize: 12),
            ),
            selected: isSelected,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDeliveryDetails() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.calendar_today),
          title: const Text('Delivery Date'),
          subtitle: Text(
            _selectedDeliveryDate != null
                ? DateFormat('MMMM dd, yyyy').format(_selectedDeliveryDate!)
                : 'Select delivery date',
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: _selectDeliveryDate,
          tileColor: Colors.grey[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _deliveryLocationController,
          decoration: const InputDecoration(
            labelText: 'Delivery Location',
            hintText: 'Enter complete address',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on),
          ),
          maxLines: 2,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter delivery location';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDocumentUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton.icon(
          onPressed: _pickDocument,
          icon: const Icon(Icons.upload_file),
          label: const Text('Upload ID / Proof of Address'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
        if (_uploadedDocuments.isNotEmpty) ...[
          const SizedBox(height: 12),
          ...(_uploadedDocuments.map((doc) {
            final index = _uploadedDocuments.indexOf(doc);
            return ListTile(
              leading: const Icon(Icons.insert_drive_file, color: ColorConstants.primaryGreen),
              title: Text('Document ${index + 1}'),
              subtitle: const Text('Uploaded'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _uploadedDocuments.removeAt(index);
                  });
                },
              ),
              tileColor: Colors.grey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }).toList()),
        ],
      ],
    );
  }

  Widget _buildNotesField() {
    return TextFormField(
      controller: _notesController,
      decoration: const InputDecoration(
        labelText: 'Additional Notes',
        hintText: 'Any special instructions or concerns...',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.note),
      ),
      maxLines: 4,
    );
  }

  Widget _buildTermsCheckbox() {
    return CheckboxListTile(
      value: _termsAgreed,
      onChanged: (value) {
        setState(() {
          _termsAgreed = value ?? false;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text(
        'I agree to the AutoBID platform terms and conditions',
        style: TextStyle(fontSize: 14),
      ),
      subtitle: const Text(
        'By confirming, you agree to proceed with this transaction under the agreed terms',
        style: TextStyle(fontSize: 11),
      ),
    );
  }

  IconData _getIconForMethod(String iconName) {
    switch (iconName) {
      case 'gcash':
      case 'paymaya':
        return Icons.account_balance_wallet;
      case 'bank':
        return Icons.account_balance;
      case 'cash':
        return Icons.money;
      case 'card':
        return Icons.credit_card;
      default:
        return Icons.payment;
    }
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
