import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/color_constants.dart';

/// Embedded seller form for tab view with auto-save capability
class EmbeddedSellerForm extends StatefulWidget {
  final double finalBidAmount;
  final VoidCallback? onFormChanged;
  final Map<String, dynamic>? initialData;
  final bool isReadOnly;

  const EmbeddedSellerForm({
    super.key,
    required this.finalBidAmount,
    this.onFormChanged,
    this.initialData,
    this.isReadOnly = false,
  });

  @override
  State<EmbeddedSellerForm> createState() => EmbeddedSellerFormState();
}

class EmbeddedSellerFormState extends State<EmbeddedSellerForm> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Preserve state when switching tabs

  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  // Section 1: Vehicle Details Confirmation
  bool _vehicleMatchesListing = false;
  bool _allIssuesDisclosed = false;
  bool _conditionAccuratelyRepresented = false;
  final List<String> _conditionDocuments = [];

  // Section 2: Legal & Ownership Documentation
  final List<String> _ownershipDocuments = [];
  bool _noOutstandingLiens = false;
  final _specialTransferInstructionsController = TextEditingController();

  // Section 3: Shipping / Delivery Information
  String? _shippingMethod;
  final _deliveryLocationController = TextEditingController();
  final _deliveryInstructionsController = TextEditingController();
  final List<String> _shippingEvidenceDocuments = [];
  bool _agreeToSubmitShippingEvidence = false;
  bool _insuranceResponsibilityAcknowledged = false;

  // Section 4: Inspection Phase Participation
  final _availabilityController = TextEditingController();
  String? _inspectionMethod;
  bool _willReviewInspectionEvidence = false;
  final _inspectionNotesController = TextEditingController();

  // Section 5: Dispute & Extra Protection Acknowledgment
  bool _disputeResolutionAgreed = false;
  bool _fraudPoliciesAcknowledged = false;
  final _sellerProtectionsController = TextEditingController();

  // Section 6: Transaction Confirmation
  bool _informationAccuracyConfirmed = false;
  bool _platformTermsAgreed = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _addFormChangeListeners();
  }

  void _loadInitialData() {
    if (widget.initialData == null) return;

    final data = widget.initialData!;

    // Section 1
    _vehicleMatchesListing = data['vehicleMatchesListing'] ?? false;
    _allIssuesDisclosed = data['allIssuesDisclosed'] ?? false;
    _conditionAccuratelyRepresented = data['conditionAccuratelyRepresented'] ?? false;
    if (data['conditionDocuments'] is List) {
      _conditionDocuments.addAll(List<String>.from(data['conditionDocuments']));
    }

    // Section 2
    if (data['ownershipDocuments'] is List) {
      _ownershipDocuments.addAll(List<String>.from(data['ownershipDocuments']));
    }
    _noOutstandingLiens = data['noOutstandingLiens'] ?? false;
    if (data['specialTransferInstructions'] != null) {
      _specialTransferInstructionsController.text = data['specialTransferInstructions'];
    }

    // Section 3
    _shippingMethod = data['shippingMethod'];
    if (data['deliveryLocation'] != null) {
      _deliveryLocationController.text = data['deliveryLocation'];
    }
    if (data['deliveryInstructions'] != null) {
      _deliveryInstructionsController.text = data['deliveryInstructions'];
    }
    if (data['shippingEvidenceDocuments'] is List) {
      _shippingEvidenceDocuments.addAll(List<String>.from(data['shippingEvidenceDocuments']));
    }
    _agreeToSubmitShippingEvidence = data['agreeToSubmitShippingEvidence'] ?? false;
    _insuranceResponsibilityAcknowledged = data['insuranceResponsibilityAcknowledged'] ?? false;

    // Section 4
    if (data['availability'] != null) {
      _availabilityController.text = data['availability'];
    }
    _inspectionMethod = data['inspectionMethod'];
    _willReviewInspectionEvidence = data['willReviewInspectionEvidence'] ?? false;
    if (data['inspectionNotes'] != null) {
      _inspectionNotesController.text = data['inspectionNotes'];
    }

    // Section 5
    _disputeResolutionAgreed = data['disputeResolutionAgreed'] ?? false;
    _fraudPoliciesAcknowledged = data['fraudPoliciesAcknowledged'] ?? false;
    if (data['sellerProtections'] != null) {
      _sellerProtectionsController.text = data['sellerProtections'];
    }

    // Section 6
    _informationAccuracyConfirmed = data['informationAccuracyConfirmed'] ?? false;
    _platformTermsAgreed = data['platformTermsAgreed'] ?? false;
  }

  void _addFormChangeListeners() {
    _specialTransferInstructionsController.addListener(_onFieldChanged);
    _deliveryLocationController.addListener(_onFieldChanged);
    _deliveryInstructionsController.addListener(_onFieldChanged);
    _availabilityController.addListener(_onFieldChanged);
    _inspectionNotesController.addListener(_onFieldChanged);
    _sellerProtectionsController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    widget.onFormChanged?.call();
  }

  @override
  void dispose() {
    _specialTransferInstructionsController.dispose();
    _deliveryLocationController.dispose();
    _deliveryInstructionsController.dispose();
    _availabilityController.dispose();
    _inspectionNotesController.dispose();
    _sellerProtectionsController.dispose();
    super.dispose();
  }

  Future<void> _pickDocument(List<String> documentList) async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        documentList.add(image.path);
      });
      _onFieldChanged();
    }
  }

  bool canSubmit() {
    return _vehicleMatchesListing &&
        _allIssuesDisclosed &&
        _conditionAccuratelyRepresented &&
        _ownershipDocuments.isNotEmpty &&
        _noOutstandingLiens &&
        _shippingMethod != null &&
        _deliveryLocationController.text.isNotEmpty &&
        _agreeToSubmitShippingEvidence &&
        _insuranceResponsibilityAcknowledged &&
        _inspectionMethod != null &&
        _willReviewInspectionEvidence &&
        _disputeResolutionAgreed &&
        _fraudPoliciesAcknowledged &&
        _informationAccuracyConfirmed &&
        _platformTermsAgreed;
  }

  Map<String, dynamic> getFormData() {
    return {
      // Section 1
      'vehicleMatchesListing': _vehicleMatchesListing,
      'allIssuesDisclosed': _allIssuesDisclosed,
      'conditionAccuratelyRepresented': _conditionAccuratelyRepresented,
      'conditionDocuments': _conditionDocuments,

      // Section 2
      'ownershipDocuments': _ownershipDocuments,
      'noOutstandingLiens': _noOutstandingLiens,
      'specialTransferInstructions': _specialTransferInstructionsController.text,

      // Section 3
      'shippingMethod': _shippingMethod,
      'deliveryLocation': _deliveryLocationController.text,
      'deliveryInstructions': _deliveryInstructionsController.text,
      'shippingEvidenceDocuments': _shippingEvidenceDocuments,
      'agreeToSubmitShippingEvidence': _agreeToSubmitShippingEvidence,
      'insuranceResponsibilityAcknowledged': _insuranceResponsibilityAcknowledged,

      // Section 4
      'availability': _availabilityController.text,
      'inspectionMethod': _inspectionMethod,
      'willReviewInspectionEvidence': _willReviewInspectionEvidence,
      'inspectionNotes': _inspectionNotesController.text,

      // Section 5
      'disputeResolutionAgreed': _disputeResolutionAgreed,
      'fraudPoliciesAcknowledged': _fraudPoliciesAcknowledged,
      'sellerProtections': _sellerProtectionsController.text,

      // Section 6
      'informationAccuracyConfirmed': _informationAccuracyConfirmed,
      'platformTermsAgreed': _platformTermsAgreed,

      // Legacy fields for backward compatibility
      'vehicleIdentityConfirmed': _vehicleMatchesListing,
      'handoverDate': DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 7))),
      'handoverLocation': _deliveryLocationController.text,
      'uploadedDocuments': [..._ownershipDocuments, ..._shippingEvidenceDocuments, ..._conditionDocuments],
      'termsAgreed': _platformTermsAgreed,
      'notes': _inspectionNotesController.text,
    };
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Opacity(
            opacity: widget.isReadOnly ? 0.6 : 1.0,
            child: IgnorePointer(
              ignoring: widget.isReadOnly,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Auto-save indicator
                  _buildAutoSaveIndicator(),
                  const SizedBox(height: 24),

                  // Section 1: Vehicle Details Confirmation
                  _buildSectionTitle('1. Vehicle Details Confirmation'),
                  _buildVehicleDetailsSection(),
                  const SizedBox(height: 24),

                  // Section 2: Legal & Ownership Documentation
                  _buildSectionTitle('2. Legal & Ownership Documentation'),
                  _buildLegalOwnershipSection(),
                  const SizedBox(height: 24),

                  // Section 3: Shipping / Delivery Information
                  _buildSectionTitle('3. Shipping / Delivery Information'),
                  _buildShippingDeliverySection(),
                  const SizedBox(height: 24),

                  // Section 4: Inspection Phase Participation
                  _buildSectionTitle('4. Inspection Phase Participation'),
                  _buildInspectionParticipationSection(),
                  const SizedBox(height: 24),

                  // Section 5: Dispute & Extra Protection Acknowledgment
                  _buildSectionTitle('5. Dispute & Extra Protection Acknowledgment'),
                  _buildDisputeProtectionSection(),
                  const SizedBox(height: 24),

                  // Section 6: Transaction Confirmation
                  _buildSectionTitle('6. Transaction Confirmation'),
                  _buildTransactionConfirmationSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoSaveIndicator() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.cloud_done, size: 20, color: Colors.blue[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Your progress is automatically saved',
              style: TextStyle(fontSize: 12, color: Colors.blue[700], fontWeight: FontWeight.w500),
            ),
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
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: ColorConstants.primaryGreen,
        ),
      ),
    );
  }

  Widget _buildVehicleDetailsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              value: _vehicleMatchesListing,
              onChanged: (value) {
                setState(() => _vehicleMatchesListing = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I confirm that the vehicle listed matches all details: VIN, Make, Model, Year, Color, Mileage',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            CheckboxListTile(
              value: _allIssuesDisclosed,
              onChanged: (value) {
                setState(() => _allIssuesDisclosed = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I confirm that all known issues, damages, accidents, and modifications are accurately disclosed in the listing',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            CheckboxListTile(
              value: _conditionAccuratelyRepresented,
              onChanged: (value) {
                setState(() => _conditionAccuratelyRepresented = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I acknowledge the condition of the vehicle (scratches, dents, accident history, mechanical issues, modifications) is as represented in the listing',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 16),
            const Text(
              'Upload Supporting Documents (Photos, Videos)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _pickDocument(_conditionDocuments),
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload Condition Evidence'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            if (_conditionDocuments.isNotEmpty) ...[
              const SizedBox(height: 12),
              ..._conditionDocuments.asMap().entries.map((entry) {
                return ListTile(
                  leading: const Icon(Icons.insert_drive_file, color: ColorConstants.primaryGreen),
                  title: Text('Document ${entry.key + 1}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() => _conditionDocuments.removeAt(entry.key));
                      _onFieldChanged();
                    },
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

  Widget _buildLegalOwnershipSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upload Proof of Legal Ownership *',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const Text(
              'Title, Registration, Insurance documents',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _pickDocument(_ownershipDocuments),
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload Ownership Documents'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            if (_ownershipDocuments.isNotEmpty) ...[
              const SizedBox(height: 12),
              ..._ownershipDocuments.asMap().entries.map((entry) {
                return ListTile(
                  leading: const Icon(Icons.insert_drive_file, color: ColorConstants.primaryGreen),
                  title: Text('Ownership Doc ${entry.key + 1}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() => _ownershipDocuments.removeAt(entry.key));
                      _onFieldChanged();
                    },
                  ),
                  tileColor: Colors.grey[50],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                );
              }).toList(),
            ],
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _noOutstandingLiens,
              onChanged: (value) {
                setState(() => _noOutstandingLiens = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'There are no outstanding liens, loans, or legal encumbrances on the vehicle',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _specialTransferInstructionsController,
              decoration: const InputDecoration(
                labelText: 'Special Transfer Instructions (Optional)',
                hintText: 'Any special legal considerations or instructions...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingDeliverySection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _shippingMethod,
              decoration: const InputDecoration(
                labelText: 'Shipping/Delivery Method *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_shipping),
              ),
              items: const [
                DropdownMenuItem(value: 'Pickup', child: Text('Pickup')),
                DropdownMenuItem(value: 'Transporter', child: Text('Transporter')),
                DropdownMenuItem(value: 'Seller-Arranged', child: Text('Seller-Arranged')),
              ],
              onChanged: (value) {
                setState(() => _shippingMethod = value);
                _onFieldChanged();
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _deliveryLocationController,
              decoration: const InputDecoration(
                labelText: 'Delivery Location *',
                hintText: 'Enter pickup/delivery address',
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
            TextFormField(
              controller: _deliveryInstructionsController,
              decoration: const InputDecoration(
                labelText: 'Special Delivery Instructions (Optional)',
                hintText: 'Instructions for carrier or buyer...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            const Text(
              'Upload Pre-Shipping Evidence',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const Text(
              'VIN photo, 360° video, shipping receipt, GPS check-in',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _pickDocument(_shippingEvidenceDocuments),
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload Shipping Evidence'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            if (_shippingEvidenceDocuments.isNotEmpty) ...[
              const SizedBox(height: 12),
              ..._shippingEvidenceDocuments.asMap().entries.map((entry) {
                return ListTile(
                  leading: const Icon(Icons.insert_drive_file, color: ColorConstants.primaryGreen),
                  title: Text('Shipping Evidence ${entry.key + 1}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() => _shippingEvidenceDocuments.removeAt(entry.key));
                      _onFieldChanged();
                    },
                  ),
                  tileColor: Colors.grey[50],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                );
              }).toList(),
            ],
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _agreeToSubmitShippingEvidence,
              onChanged: (value) {
                setState(() => _agreeToSubmitShippingEvidence = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I agree to submit all required shipping evidence before dispatch',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            CheckboxListTile(
              value: _insuranceResponsibilityAcknowledged,
              onChanged: (value) {
                setState(() => _insuranceResponsibilityAcknowledged = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I acknowledge responsibility for insurance during transit (if applicable)',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInspectionParticipationSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _availabilityController,
              decoration: const InputDecoration(
                labelText: 'Availability for Post-Delivery Inspection',
                hintText: 'Enter dates/times when you\'re available',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _inspectionMethod,
              decoration: const InputDecoration(
                labelText: 'Method of Inspection *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              items: const [
                DropdownMenuItem(value: 'In-person', child: Text('In-person')),
                DropdownMenuItem(value: 'Video Walkthrough', child: Text('Video Walkthrough')),
                DropdownMenuItem(value: 'Third-party', child: Text('Third-party')),
              ],
              onChanged: (value) {
                setState(() => _inspectionMethod = value);
                _onFieldChanged();
              },
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _willReviewInspectionEvidence,
              onChanged: (value) {
                setState(() => _willReviewInspectionEvidence = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I will review inspection evidence submitted by the buyer and provide confirmation for checkpoint 4',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _inspectionNotesController,
              decoration: const InputDecoration(
                labelText: 'Notes Regarding Acceptance Criteria (Optional)',
                hintText: 'Specific points to verify during inspection...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisputeProtectionSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CheckboxListTile(
              value: _disputeResolutionAgreed,
              onChanged: (value) {
                setState(() => _disputeResolutionAgreed = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I agree to the platform dispute resolution process, including moderator review, evidence submission, escrow hold, timelines, and escalation if needed',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            CheckboxListTile(
              value: _fraudPoliciesAcknowledged,
              onChanged: (value) {
                setState(() => _fraudPoliciesAcknowledged = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I acknowledge platform policies for fraud, collusion, or suspicious activity',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _sellerProtectionsController,
              decoration: const InputDecoration(
                labelText: 'Seller-Requested Protection Measures (Optional)',
                hintText: 'e.g., holdback period, conditional acceptance...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionConfirmationSection() {
    return Card(
      elevation: 2,
      color: ColorConstants.primaryGreen.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CheckboxListTile(
              value: _informationAccuracyConfirmed,
              onChanged: (value) {
                setState(() => _informationAccuracyConfirmed = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I confirm that all information I have provided is accurate and complete to the best of my knowledge',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            CheckboxListTile(
              value: _platformTermsAgreed,
              onChanged: (value) {
                setState(() => _platformTermsAgreed = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I agree to platform terms and conditions and commit to facilitating payment, shipping, and inspection as required',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              subtitle: const Text(
                'Required - This is a binding agreement',
                style: TextStyle(fontSize: 11, color: Colors.red, fontWeight: FontWeight.w500),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
