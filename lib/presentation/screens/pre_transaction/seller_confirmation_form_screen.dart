import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/pre_transaction_confirmation_model.dart';
import '../../../core/constants/color_constants.dart';
import '../../providers/pre_transaction_provider.dart';

/// Comprehensive seller confirmation form compliant with TRANSACTION_FLOW.md
class SellerConfirmationFormScreen extends StatefulWidget {
  final String auctionId;
  final double finalBidAmount;

  const SellerConfirmationFormScreen({
    super.key,
    required this.auctionId,
    required this.finalBidAmount,
  });

  @override
  State<SellerConfirmationFormScreen> createState() => _SellerConfirmationFormScreenState();
}

class _SellerConfirmationFormScreenState extends State<SellerConfirmationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  // Vehicle Identity
  bool _vehicleIdentityConfirmed = false;
  final _vinNumberController = TextEditingController();
  final _licensePlateController = TextEditingController();

  // Condition & Issues (Seller-specific)
  bool _allIssuesDisclosedAccurately = false;
  bool _conditionAsRepresented = false;
  final List<TextEditingController> _knownIssuesControllers = [];
  final List<String> _supportingDocumentsUrls = [];

  // Pricing
  final _additionalFeesController = TextEditingController(text: '0');

  // Payment Timeline
  int _paymentTimelineDays = 3;
  bool _latePaymentPenaltyAcknowledged = false;

  // Shipping & Delivery (Seller-specific)
  ShippingMethod? _shippingMethod;
  ShippingCostResponsibility? _shippingCostResponsibility;
  InsuranceResponsibility? _insuranceResponsibility;
  final _estimatedDeliveryDaysController = TextEditingController(text: '3');
  bool _shippingEvidenceCommitment = false;
  bool _transitInsuranceAcknowledged = false;

  // Inspection & Acceptance (Seller-specific)
  final _vehicleInspectionPeriodController = TextEditingController(text: '48');
  InspectionMethod? _inspectionMethod;
  bool _sellerInspectionReviewCommitment = false;
  final _inspectionNotesController = TextEditingController();

  // Legal & Ownership (Seller-specific)
  bool _sellerOwnershipConfirmed = false;
  bool _titleTransferAcknowledged = false;
  bool _noOutstandingLiensAcknowledged = false;
  bool _ownershipTransferProcessAcknowledged = false;
  final _specialTransferInstructionsController = TextEditingController();

  // Dispute & Protection (Seller-specific)
  bool _discussionsLoggedAcknowledged = false;
  bool _disputeResolutionProcessAgreed = false;
  bool _fraudPoliciesAcknowledged = false;
  final _sellerProtectionMeasuresController = TextEditingController();

  // Final Confirmations
  bool _informationAccuracyConfirmed = false;
  bool _termsAgreed = false;

  // Delivery Details
  DateTime? _deliveryDate;
  final _deliveryLocationController = TextEditingController();
  final List<String> _uploadedDocuments = [];
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _vinNumberController.dispose();
    _licensePlateController.dispose();
    for (var controller in _knownIssuesControllers) {
      controller.dispose();
    }
    _additionalFeesController.dispose();
    _estimatedDeliveryDaysController.dispose();
    _vehicleInspectionPeriodController.dispose();
    _inspectionNotesController.dispose();
    _specialTransferInstructionsController.dispose();
    _sellerProtectionMeasuresController.dispose();
    _deliveryLocationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _addKnownIssue() {
    setState(() {
      _knownIssuesControllers.add(TextEditingController());
    });
  }

  void _removeKnownIssue(int index) {
    setState(() {
      _knownIssuesControllers[index].dispose();
      _knownIssuesControllers.removeAt(index);
    });
  }

  Future<void> _selectDeliveryDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _deliveryDate ?? now.add(const Duration(days: 3)),
      firstDate: now.add(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 60)),
    );

    if (picked != null) {
      setState(() {
        _deliveryDate = picked;
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

  Future<void> _pickSupportingDocument() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _supportingDocumentsUrls.add(image.path);
      });
    }
  }

  bool _canSubmit() {
    return _vehicleIdentityConfirmed &&
        _allIssuesDisclosedAccurately &&
        _conditionAsRepresented &&
        _latePaymentPenaltyAcknowledged &&
        _shippingMethod != null &&
        _shippingCostResponsibility != null &&
        _insuranceResponsibility != null &&
        _shippingEvidenceCommitment &&
        _transitInsuranceAcknowledged &&
        _inspectionMethod != null &&
        _sellerInspectionReviewCommitment &&
        _sellerOwnershipConfirmed &&
        _titleTransferAcknowledged &&
        _noOutstandingLiensAcknowledged &&
        _ownershipTransferProcessAcknowledged &&
        _discussionsLoggedAcknowledged &&
        _disputeResolutionProcessAgreed &&
        _fraudPoliciesAcknowledged &&
        _informationAccuracyConfirmed &&
        _termsAgreed &&
        _deliveryDate != null &&
        _deliveryLocationController.text.isNotEmpty;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_canSubmit()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all required confirmations'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final provider = context.read<PreTransactionProvider>();

    // Submit comprehensive seller confirmation
    final success = await provider.submitSellerConfirmation(
      sellerId: 'seller456', // Mock seller ID
      sellerName: 'Pedro Santos',
      formData: {
        'vehicleIdentityConfirmed': _vehicleIdentityConfirmed,
        'vinNumber': _vinNumberController.text.trim(),
        'licensePlate': _licensePlateController.text.trim(),
        'allIssuesDisclosedAccurately': _allIssuesDisclosedAccurately,
        'conditionAsRepresented': _conditionAsRepresented,
        'knownIssues': _knownIssuesControllers.map((c) => c.text.trim()).where((s) => s.isNotEmpty).toList(),
        'supportingDocumentsUrls': _supportingDocumentsUrls,
        'finalBidPrice': widget.finalBidAmount,
        'additionalFees': double.tryParse(_additionalFeesController.text) ?? 0.0,
        'paymentTimelineDays': _paymentTimelineDays,
        'latePaymentPenaltyAcknowledged': _latePaymentPenaltyAcknowledged,
        'shippingMethod': _shippingMethod?.name,
        'shippingCostResponsibility': _shippingCostResponsibility?.name,
        'insuranceResponsibility': _insuranceResponsibility?.name,
        'estimatedDeliveryDays': int.tryParse(_estimatedDeliveryDaysController.text) ?? 3,
        'shippingEvidenceCommitment': _shippingEvidenceCommitment,
        'transitInsuranceAcknowledged': _transitInsuranceAcknowledged,
        'vehicleInspectionPeriodHours': int.tryParse(_vehicleInspectionPeriodController.text) ?? 48,
        'inspectionMethod': _inspectionMethod?.name,
        'sellerInspectionReviewCommitment': _sellerInspectionReviewCommitment,
        'inspectionNotes': _inspectionNotesController.text.trim(),
        'sellerOwnershipConfirmed': _sellerOwnershipConfirmed,
        'titleTransferAcknowledged': _titleTransferAcknowledged,
        'noOutstandingLiensAcknowledged': _noOutstandingLiensAcknowledged,
        'ownershipTransferProcessAcknowledged': _ownershipTransferProcessAcknowledged,
        'specialTransferInstructions': _specialTransferInstructionsController.text.trim(),
        'discussionsLoggedAcknowledged': _discussionsLoggedAcknowledged,
        'disputeResolutionProcessAgreed': _disputeResolutionProcessAgreed,
        'fraudPoliciesAcknowledged': _fraudPoliciesAcknowledged,
        'sellerProtectionMeasures': _sellerProtectionMeasuresController.text.trim(),
        'informationAccuracyConfirmed': _informationAccuracyConfirmed,
        'termsAgreed': _termsAgreed,
        'deliveryDate': DateFormat('yyyy-MM-dd').format(_deliveryDate!),
        'deliveryLocation': _deliveryLocationController.text.trim(),
        'uploadedDocuments': _uploadedDocuments,
        'notes': _notesController.text.trim(),
      },
    );

    if (!mounted) return;

    if (success) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seller confirmation submitted! Waiting for admin review...'),
          backgroundColor: ColorConstants.primaryGreen,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? 'Failed to submit confirmation'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Confirmation Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Header
            _buildHeader(),
            const SizedBox(height: 24),

            // 1. Vehicle Identity Verification
            _buildSectionTitle('1. Vehicle Identity Verification'),
            _buildVehicleIdentitySection(),
            const SizedBox(height: 24),

            // 2. Condition & Disclosure (Seller-specific)
            _buildSectionTitle('2. Condition & Disclosure'),
            _buildConditionSection(),
            const SizedBox(height: 24),

            // 3. Pricing
            _buildSectionTitle('3. Pricing Confirmation'),
            _buildPricingSection(),
            const SizedBox(height: 24),

            // 4. Payment Timeline
            _buildSectionTitle('4. Payment Timeline'),
            _buildPaymentTimelineSection(),
            const SizedBox(height: 24),

            // 5. Shipping & Delivery (Seller-specific)
            _buildSectionTitle('5. Shipping & Delivery'),
            _buildShippingSection(),
            const SizedBox(height: 24),

            // 6. Inspection & Acceptance (Seller-specific)
            _buildSectionTitle('6. Vehicle Inspection & Acceptance'),
            _buildInspectionSection(),
            const SizedBox(height: 24),

            // 7. Legal & Ownership (Seller-specific)
            _buildSectionTitle('7. Legal & Ownership Transfer'),
            _buildLegalSection(),
            const SizedBox(height: 24),

            // 8. Delivery Details
            _buildSectionTitle('8. Delivery Details'),
            _buildDeliveryDetailsSection(),
            const SizedBox(height: 24),

            // 9. Dispute & Protection (Seller-specific)
            _buildSectionTitle('9. Dispute Resolution & Protection'),
            _buildDisputeSection(),
            const SizedBox(height: 24),

            // 10. Final Confirmations
            _buildSectionTitle('10. Final Confirmations'),
            _buildFinalConfirmationsSection(),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _canSubmit() ? _submitForm : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryGreen,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[300],
                ),
                child: const Text(
                  'Submit Seller Confirmation',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.verified_user, color: Colors.blue[700]),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Seller Transaction Confirmation',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Final Bid: ₱${_formatCurrency(widget.finalBidAmount)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'As the seller, you must confirm vehicle details, ownership documents, and shipping commitments. All required fields must be completed before submission.',
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue[700],
        ),
      ),
    );
  }

  Widget _buildVehicleIdentitySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CheckboxListTile(
              value: _vehicleIdentityConfirmed,
              onChanged: (value) => setState(() => _vehicleIdentityConfirmed = value ?? false),
              title: const Text(
                'I confirm the vehicle identity details are accurate',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                'VIN, license plate, make, model, year, and color',
                style: TextStyle(fontSize: 12),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _vinNumberController,
              decoration: const InputDecoration(
                labelText: 'VIN Number *',
                hintText: 'Enter vehicle identification number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.confirmation_number),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'VIN number is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _licensePlateController,
              decoration: const InputDecoration(
                labelText: 'License Plate *',
                hintText: 'Enter license plate number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.car_rental),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'License plate is required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              value: _allIssuesDisclosedAccurately,
              onChanged: (value) => setState(() => _allIssuesDisclosedAccurately = value ?? false),
              title: const Text(
                'All known issues, damages, and accidents disclosed accurately',
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
              ),
              subtitle: const Text(
                'CRITICAL: Failure to disclose may result in transaction cancellation',
                style: TextStyle(fontSize: 11, color: Colors.red),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: _conditionAsRepresented,
              onChanged: (value) => setState(() => _conditionAsRepresented = value ?? false),
              title: const Text(
                'Condition as represented in listing (scratches, dents, etc.)',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 16),
            const Text(
              'Known Issues (if any)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ..._knownIssuesControllers.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: entry.value,
                        decoration: InputDecoration(
                          labelText: 'Issue ${entry.key + 1}',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => _removeKnownIssue(entry.key),
                    ),
                  ],
                ),
              );
            }).toList(),
            OutlinedButton.icon(
              onPressed: _addKnownIssue,
              icon: const Icon(Icons.add),
              label: const Text('Add Known Issue'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Supporting Documents (photos, inspection reports, etc.)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _pickSupportingDocument,
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload Supporting Documents'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            if (_supportingDocumentsUrls.isNotEmpty) ...[
              const SizedBox(height: 12),
              ..._supportingDocumentsUrls.asMap().entries.map((entry) {
                return ListTile(
                  leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
                  title: Text('Document ${entry.key + 1}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => setState(() => _supportingDocumentsUrls.removeAt(entry.key)),
                  ),
                  tileColor: Colors.grey[50],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                );
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPricingSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.payment, color: ColorConstants.primaryGreen),
              title: const Text('Final Bid Price'),
              subtitle: Text(
                '₱${_formatCurrency(widget.finalBidAmount)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _additionalFeesController,
              decoration: const InputDecoration(
                labelText: 'Additional Fees (Optional)',
                hintText: 'Enter any additional fees agreed upon',
                border: OutlineInputBorder(),
                prefixText: '₱',
                prefixIcon: Icon(Icons.add_circle_outline),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTimelineSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Timeline (Days)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _paymentTimelineDays.toDouble(),
                    min: 1,
                    max: 14,
                    divisions: 13,
                    label: '$_paymentTimelineDays days',
                    onChanged: (value) => setState(() => _paymentTimelineDays = value.toInt()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$_paymentTimelineDays days',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              value: _latePaymentPenaltyAcknowledged,
              onChanged: (value) => setState(() => _latePaymentPenaltyAcknowledged = value ?? false),
              title: const Text(
                'I acknowledge late payment penalties',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                'Buyer penalties apply if payment not made within agreed timeline',
                style: TextStyle(fontSize: 12),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<ShippingMethod>(
              value: _shippingMethod,
              decoration: const InputDecoration(
                labelText: 'Shipping Method *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_shipping),
              ),
              items: const [
                DropdownMenuItem(value: ShippingMethod.pickup, child: Text('Pickup')),
                DropdownMenuItem(value: ShippingMethod.transporter, child: Text('Transporter')),
                DropdownMenuItem(value: ShippingMethod.sellerArranged, child: Text('Seller Arranged')),
              ],
              onChanged: (value) => setState(() => _shippingMethod = value),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<ShippingCostResponsibility>(
              value: _shippingCostResponsibility,
              decoration: const InputDecoration(
                labelText: 'Shipping Cost Responsibility *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
              items: const [
                DropdownMenuItem(value: ShippingCostResponsibility.buyer, child: Text('Buyer')),
                DropdownMenuItem(value: ShippingCostResponsibility.seller, child: Text('Seller')),
                DropdownMenuItem(value: ShippingCostResponsibility.shared, child: Text('Shared')),
              ],
              onChanged: (value) => setState(() => _shippingCostResponsibility = value),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<InsuranceResponsibility>(
              value: _insuranceResponsibility,
              decoration: const InputDecoration(
                labelText: 'Insurance Responsibility *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.security),
              ),
              items: const [
                DropdownMenuItem(value: InsuranceResponsibility.buyer, child: Text('Buyer')),
                DropdownMenuItem(value: InsuranceResponsibility.seller, child: Text('Seller')),
                DropdownMenuItem(value: InsuranceResponsibility.both, child: Text('Both')),
              ],
              onChanged: (value) => setState(() => _insuranceResponsibility = value),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _estimatedDeliveryDaysController,
              decoration: const InputDecoration(
                labelText: 'Estimated Delivery Days',
                hintText: 'Enter estimated delivery timeframe',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.schedule),
                suffixText: 'days',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _shippingEvidenceCommitment,
              onChanged: (value) => setState(() => _shippingEvidenceCommitment = value ?? false),
              title: const Text(
                'I agree to submit all required shipping evidence',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                'VIN Photo, 360° Video, Shipping Receipt, GPS Check-in',
                style: TextStyle(fontSize: 11),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: _transitInsuranceAcknowledged,
              onChanged: (value) => setState(() => _transitInsuranceAcknowledged = value ?? false),
              title: const Text(
                'I acknowledge insurance responsibility during transit',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInspectionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _vehicleInspectionPeriodController,
              decoration: const InputDecoration(
                labelText: 'Vehicle Inspection Period',
                hintText: 'Enter inspection period in hours',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.timer),
                suffixText: 'hours',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<InspectionMethod>(
              value: _inspectionMethod,
              decoration: const InputDecoration(
                labelText: 'Inspection Method *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              items: const [
                DropdownMenuItem(value: InspectionMethod.inPerson, child: Text('In Person')),
                DropdownMenuItem(value: InspectionMethod.videoWalkthrough, child: Text('Video Walkthrough')),
                DropdownMenuItem(value: InspectionMethod.thirdParty, child: Text('Third Party Inspector')),
              ],
              onChanged: (value) => setState(() => _inspectionMethod = value),
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              value: _sellerInspectionReviewCommitment,
              onChanged: (value) => setState(() => _sellerInspectionReviewCommitment = value ?? false),
              title: const Text(
                'I will review buyer inspection evidence',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                'You must review and verify buyer inspection documentation',
                style: TextStyle(fontSize: 11),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _inspectionNotesController,
              decoration: const InputDecoration(
                labelText: 'Inspection Notes (Optional)',
                hintText: 'Additional inspection instructions or notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CheckboxListTile(
              value: _sellerOwnershipConfirmed,
              onChanged: (value) => setState(() => _sellerOwnershipConfirmed = value ?? false),
              title: const Text(
                'I confirm legal ownership documents are available',
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
              ),
              subtitle: const Text(
                'CRITICAL: Official title/registration ready for transfer',
                style: TextStyle(fontSize: 11, color: Colors.red),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: _titleTransferAcknowledged,
              onChanged: (value) => setState(() => _titleTransferAcknowledged = value ?? false),
              title: const Text(
                'I acknowledge title/registration transfer upon delivery',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: _noOutstandingLiensAcknowledged,
              onChanged: (value) => setState(() => _noOutstandingLiensAcknowledged = value ?? false),
              title: const Text(
                'No outstanding loans/liens on this vehicle',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: _ownershipTransferProcessAcknowledged,
              onChanged: (value) => setState(() => _ownershipTransferProcessAcknowledged = value ?? false),
              title: const Text(
                'I acknowledge the ownership transfer process',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _specialTransferInstructionsController,
              decoration: const InputDecoration(
                labelText: 'Special Transfer Instructions (Optional)',
                hintText: 'Any special legal considerations or instructions',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryDetailsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Delivery Date *'),
              subtitle: Text(
                _deliveryDate != null
                    ? DateFormat('MMMM dd, yyyy').format(_deliveryDate!)
                    : 'Select delivery date',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _selectDeliveryDate,
              tileColor: Colors.grey[50],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _deliveryLocationController,
              decoration: const InputDecoration(
                labelText: 'Delivery Location *',
                hintText: 'Enter complete address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter delivery location';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickDocument,
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload Ownership Documents (Optional)'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            if (_uploadedDocuments.isNotEmpty) ...[
              const SizedBox(height: 12),
              ..._uploadedDocuments.asMap().entries.map((entry) {
                return ListTile(
                  leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
                  title: Text('Document ${entry.key + 1}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => setState(() => _uploadedDocuments.removeAt(entry.key)),
                  ),
                  tileColor: Colors.grey[50],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                );
              }).toList(),
            ],
            const SizedBox(height: 12),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Additional Notes (Optional)',
                hintText: 'Any special delivery instructions...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisputeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CheckboxListTile(
              value: _discussionsLoggedAcknowledged,
              onChanged: (value) => setState(() => _discussionsLoggedAcknowledged = value ?? false),
              title: const Text(
                'I acknowledge all discussions are logged for dispute resolution',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: _disputeResolutionProcessAgreed,
              onChanged: (value) => setState(() => _disputeResolutionProcessAgreed = value ?? false),
              title: const Text(
                'I agree to platform dispute resolution process',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: _fraudPoliciesAcknowledged,
              onChanged: (value) => setState(() => _fraudPoliciesAcknowledged = value ?? false),
              title: const Text(
                'I acknowledge fraud/collusion policies',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _sellerProtectionMeasuresController,
              decoration: const InputDecoration(
                labelText: 'Seller Protection Measures Requested (Optional)',
                hintText: 'Any additional protections or safeguards you want',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinalConfirmationsSection() {
    return Card(
      color: Colors.blue.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CheckboxListTile(
              value: _informationAccuracyConfirmed,
              onChanged: (value) => setState(() => _informationAccuracyConfirmed = value ?? false),
              title: const Text(
                'I confirm all information provided is accurate and complete',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: _termsAgreed,
              onChanged: (value) => setState(() => _termsAgreed = value ?? false),
              title: const Text(
                'I agree to the platform terms and conditions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Required - By checking this box, you agree to proceed with this transaction under the platform terms',
                style: TextStyle(fontSize: 11, color: Colors.red),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
