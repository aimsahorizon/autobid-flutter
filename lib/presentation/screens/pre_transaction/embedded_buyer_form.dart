import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/color_constants.dart';

/// Embedded buyer form for tab view with auto-save capability
class EmbeddedBuyerForm extends StatefulWidget {
  final double finalBidAmount;
  final VoidCallback? onFormChanged;
  final Map<String, dynamic>? initialData;
  final bool isReadOnly;

  const EmbeddedBuyerForm({
    super.key,
    required this.finalBidAmount,
    this.onFormChanged,
    this.initialData,
    this.isReadOnly = false,
  });

  @override
  State<EmbeddedBuyerForm> createState() => EmbeddedBuyerFormState();
}

class EmbeddedBuyerFormState extends State<EmbeddedBuyerForm> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Preserve state when switching tabs

  final _formKey = GlobalKey<FormState>();

  // Section 1: Final Bid & Fees
  final _additionalFeesController = TextEditingController(text: '5000');
  bool _priceAndFeesConfirmed = false;

  // Section 2: Payment Details
  int _paymentDurationDays = 3;
  String _paymentDurationUnit = 'days'; // 'hours' or 'days'
  bool _latePaymentPenaltiesAcknowledged = false;

  // Section 3: Shipping & Delivery
  String? _shippingMethod;
  String? _shippingCostResponsibility;
  final _deliveryLocationController = TextEditingController();
  String? _insuranceResponsibility;
  int _estimatedDeliveryDays = 7;

  // Section 4: Inspection & Acceptance
  int _inspectionDurationDays = 2;
  String _inspectionDurationUnit = 'days'; // 'hours' or 'days'
  String? _inspectionMethod;
  final _acceptanceCriteriaController = TextEditingController();
  final _discrepancyProcedureController = TextEditingController();
  int _buyerConfirmationLimitDays = 1;
  String _buyerConfirmationLimitUnit = 'days'; // 'hours' or 'days'

  // Section 5: Legal & Documentation
  bool _titleRegistrationAcknowledged = false;
  bool _noLiensAcknowledged = false;
  bool _transferProcessAcknowledged = false;

  // Section 6: Dispute & Extra Protections
  bool _discussionsLoggedConfirmed = false;
  bool _disputeResolutionAgreed = false;
  bool _fraudPoliciesAcknowledged = false;
  final _additionalProtectionsController = TextEditingController();

  // Section 7: Platform Terms
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
    _priceAndFeesConfirmed = data['priceAndFeesConfirmed'] ?? false;
    if (data['additionalFees'] != null) {
      _additionalFeesController.text = data['additionalFees'].toString();
    }

    // Section 2
    _paymentDurationDays = data['paymentDuration'] ?? 3;
    _paymentDurationUnit = data['paymentDurationUnit'] ?? 'days';
    _latePaymentPenaltiesAcknowledged = data['latePaymentPenaltiesAcknowledged'] ?? false;

    // Section 3
    _shippingMethod = data['shippingMethod'];
    _shippingCostResponsibility = data['shippingCostResponsibility'];
    if (data['deliveryLocation'] != null) {
      _deliveryLocationController.text = data['deliveryLocation'];
    }
    _insuranceResponsibility = data['insuranceResponsibility'];
    _estimatedDeliveryDays = data['estimatedDeliveryDays'] ?? 7;

    // Section 4
    _inspectionDurationDays = data['inspectionDuration'] ?? 2;
    _inspectionDurationUnit = data['inspectionDurationUnit'] ?? 'days';
    _inspectionMethod = data['inspectionMethod'];
    if (data['acceptanceCriteria'] != null) {
      _acceptanceCriteriaController.text = data['acceptanceCriteria'];
    }
    if (data['discrepancyProcedure'] != null) {
      _discrepancyProcedureController.text = data['discrepancyProcedure'];
    }
    _buyerConfirmationLimitDays = data['buyerConfirmationLimit'] ?? 1;
    _buyerConfirmationLimitUnit = data['buyerConfirmationLimitUnit'] ?? 'days';

    // Section 5
    _titleRegistrationAcknowledged = data['titleRegistrationAcknowledged'] ?? false;
    _noLiensAcknowledged = data['noLiensAcknowledged'] ?? false;
    _transferProcessAcknowledged = data['transferProcessAcknowledged'] ?? false;

    // Section 6
    _discussionsLoggedConfirmed = data['discussionsLoggedConfirmed'] ?? false;
    _disputeResolutionAgreed = data['disputeResolutionAgreed'] ?? false;
    _fraudPoliciesAcknowledged = data['fraudPoliciesAcknowledged'] ?? false;
    if (data['additionalProtections'] != null) {
      _additionalProtectionsController.text = data['additionalProtections'];
    }

    // Section 7
    _platformTermsAgreed = data['platformTermsAgreed'] ?? false;
  }

  void _addFormChangeListeners() {
    _additionalFeesController.addListener(_onFieldChanged);
    _deliveryLocationController.addListener(_onFieldChanged);
    _acceptanceCriteriaController.addListener(_onFieldChanged);
    _discrepancyProcedureController.addListener(_onFieldChanged);
    _additionalProtectionsController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    widget.onFormChanged?.call();
  }

  @override
  void dispose() {
    _additionalFeesController.dispose();
    _deliveryLocationController.dispose();
    _acceptanceCriteriaController.dispose();
    _discrepancyProcedureController.dispose();
    _additionalProtectionsController.dispose();
    super.dispose();
  }

  bool canSubmit() {
    return _priceAndFeesConfirmed &&
        _latePaymentPenaltiesAcknowledged &&
        _shippingMethod != null &&
        _shippingCostResponsibility != null &&
        _deliveryLocationController.text.isNotEmpty &&
        _insuranceResponsibility != null &&
        _inspectionMethod != null &&
        _titleRegistrationAcknowledged &&
        _noLiensAcknowledged &&
        _transferProcessAcknowledged &&
        _discussionsLoggedConfirmed &&
        _disputeResolutionAgreed &&
        _fraudPoliciesAcknowledged &&
        _platformTermsAgreed;
  }

  Map<String, dynamic> getFormData() {
    return {
      // Section 1
      'finalBidPrice': widget.finalBidAmount,
      'additionalFees': double.tryParse(_additionalFeesController.text) ?? 0.0,
      'priceAndFeesConfirmed': _priceAndFeesConfirmed,

      // Section 2
      'paymentDuration': _paymentDurationDays,
      'paymentDurationUnit': _paymentDurationUnit,
      'latePaymentPenaltiesAcknowledged': _latePaymentPenaltiesAcknowledged,

      // Section 3
      'shippingMethod': _shippingMethod,
      'shippingCostResponsibility': _shippingCostResponsibility,
      'deliveryLocation': _deliveryLocationController.text,
      'insuranceResponsibility': _insuranceResponsibility,
      'estimatedDeliveryDays': _estimatedDeliveryDays,

      // Section 4
      'inspectionDuration': _inspectionDurationDays,
      'inspectionDurationUnit': _inspectionDurationUnit,
      'inspectionMethod': _inspectionMethod,
      'acceptanceCriteria': _acceptanceCriteriaController.text,
      'discrepancyProcedure': _discrepancyProcedureController.text,
      'buyerConfirmationLimit': _buyerConfirmationLimitDays,
      'buyerConfirmationLimitUnit': _buyerConfirmationLimitUnit,

      // Section 5
      'titleRegistrationAcknowledged': _titleRegistrationAcknowledged,
      'noLiensAcknowledged': _noLiensAcknowledged,
      'transferProcessAcknowledged': _transferProcessAcknowledged,

      // Section 6
      'discussionsLoggedConfirmed': _discussionsLoggedConfirmed,
      'disputeResolutionAgreed': _disputeResolutionAgreed,
      'fraudPoliciesAcknowledged': _fraudPoliciesAcknowledged,
      'additionalProtections': _additionalProtectionsController.text,

      // Section 7
      'platformTermsAgreed': _platformTermsAgreed,

      // Legacy fields for backward compatibility
      'vehicleIdentityConfirmed': true,
      'deliveryDate': DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: _estimatedDeliveryDays))),
      'uploadedDocuments': [],
      'termsAgreed': _platformTermsAgreed,
      'notes': _additionalProtectionsController.text,
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

                  // Section 1: Final Bid & Fees
                  _buildSectionTitle('1. Final Bid & Fees'),
                  _buildFinalBidSection(),
                  const SizedBox(height: 24),

                  // Section 2: Payment Details
                  _buildSectionTitle('2. Payment Details'),
                  _buildPaymentDetailsSection(),
                  const SizedBox(height: 24),

                  // Section 3: Shipping & Delivery
                  _buildSectionTitle('3. Shipping & Delivery'),
                  _buildShippingDeliverySection(),
                  const SizedBox(height: 24),

                  // Section 4: Inspection & Acceptance
                  _buildSectionTitle('4. Inspection & Acceptance'),
                  _buildInspectionSection(),
                  const SizedBox(height: 24),

                  // Section 5: Legal & Documentation
                  _buildSectionTitle('5. Legal & Documentation'),
                  _buildLegalSection(),
                  const SizedBox(height: 24),

                  // Section 6: Dispute & Extra Protections
                  _buildSectionTitle('6. Dispute & Extra Protections'),
                  _buildDisputeSection(),
                  const SizedBox(height: 24),

                  // Section 7: Platform Terms
                  _buildSectionTitle('7. Platform Terms'),
                  _buildPlatformTermsSection(),
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

  Widget _buildFinalBidSection() {
    final totalAmount = widget.finalBidAmount + (double.tryParse(_additionalFeesController.text) ?? 0.0);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Final Bid Price (readonly)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Final Bid Price',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '₱${_formatCurrency(widget.finalBidAmount)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorConstants.primaryGreen),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Additional Fees (readonly)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Additional Fees',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '₱${_formatCurrency(double.tryParse(_additionalFeesController.text) ?? 0.0)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(height: 24),

            // Total
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorConstants.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorConstants.primaryGreen.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₱${_formatCurrency(totalAmount)}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorConstants.primaryGreen),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Confirmation checkbox
            CheckboxListTile(
              value: _priceAndFeesConfirmed,
              onChanged: (value) {
                setState(() => _priceAndFeesConfirmed = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I confirm and accept the final bid price and fees',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Duration',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Slider(
                    value: _paymentDurationDays.toDouble(),
                    min: 1,
                    max: _paymentDurationUnit == 'hours' ? 72 : 14,
                    divisions: _paymentDurationUnit == 'hours' ? 71 : 13,
                    label: '$_paymentDurationDays $_paymentDurationUnit',
                    onChanged: (value) {
                      setState(() => _paymentDurationDays = value.toInt());
                      _onFieldChanged();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$_paymentDurationDays',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _paymentDurationUnit,
                  items: const [
                    DropdownMenuItem(value: 'hours', child: Text('hours')),
                    DropdownMenuItem(value: 'days', child: Text('days')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _paymentDurationUnit = value ?? 'days';
                      if (_paymentDurationUnit == 'hours') {
                        _paymentDurationDays = _paymentDurationDays.clamp(1, 72);
                      } else {
                        _paymentDurationDays = _paymentDurationDays.clamp(1, 14);
                      }
                    });
                    _onFieldChanged();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _latePaymentPenaltiesAcknowledged,
              onChanged: (value) {
                setState(() => _latePaymentPenaltiesAcknowledged = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I acknowledge late payment penalties apply if payment is not made on time',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
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

            DropdownButtonFormField<String>(
              value: _shippingCostResponsibility,
              decoration: const InputDecoration(
                labelText: 'Shipping Cost Responsibility *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
              items: const [
                DropdownMenuItem(value: 'Buyer', child: Text('Buyer')),
                DropdownMenuItem(value: 'Seller', child: Text('Seller')),
                DropdownMenuItem(value: 'Shared', child: Text('Shared')),
              ],
              onChanged: (value) {
                setState(() => _shippingCostResponsibility = value);
                _onFieldChanged();
              },
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _deliveryLocationController,
              decoration: const InputDecoration(
                labelText: 'Delivery Location *',
                hintText: 'Enter complete address or pin on map',
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

            DropdownButtonFormField<String>(
              value: _insuranceResponsibility,
              decoration: const InputDecoration(
                labelText: 'Insurance Responsibility *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.security),
              ),
              items: const [
                DropdownMenuItem(value: 'Buyer', child: Text('Buyer')),
                DropdownMenuItem(value: 'Seller', child: Text('Seller')),
                DropdownMenuItem(value: 'Both', child: Text('Both')),
              ],
              onChanged: (value) {
                setState(() => _insuranceResponsibility = value);
                _onFieldChanged();
              },
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Estimated Delivery Timeframe',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$_estimatedDeliveryDays days',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Slider(
              value: _estimatedDeliveryDays.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              label: '$_estimatedDeliveryDays days',
              onChanged: (value) {
                setState(() => _estimatedDeliveryDays = value.toInt());
                _onFieldChanged();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInspectionSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inspection Duration',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Slider(
                    value: _inspectionDurationDays.toDouble(),
                    min: 1,
                    max: _inspectionDurationUnit == 'hours' ? 72 : 7,
                    divisions: _inspectionDurationUnit == 'hours' ? 71 : 6,
                    label: '$_inspectionDurationDays $_inspectionDurationUnit',
                    onChanged: (value) {
                      setState(() => _inspectionDurationDays = value.toInt());
                      _onFieldChanged();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$_inspectionDurationDays',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _inspectionDurationUnit,
                  items: const [
                    DropdownMenuItem(value: 'hours', child: Text('hours')),
                    DropdownMenuItem(value: 'days', child: Text('days')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _inspectionDurationUnit = value ?? 'days';
                      if (_inspectionDurationUnit == 'hours') {
                        _inspectionDurationDays = _inspectionDurationDays.clamp(1, 72);
                      } else {
                        _inspectionDurationDays = _inspectionDurationDays.clamp(1, 7);
                      }
                    });
                    _onFieldChanged();
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _inspectionMethod,
              decoration: const InputDecoration(
                labelText: 'Inspection Method *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              items: const [
                DropdownMenuItem(value: 'In-person', child: Text('In-person')),
                DropdownMenuItem(value: 'Video Walkthrough', child: Text('Video Walkthrough')),
                DropdownMenuItem(value: 'Third-party Inspection', child: Text('Third-party Inspection')),
              ],
              onChanged: (value) {
                setState(() => _inspectionMethod = value);
                _onFieldChanged();
              },
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _acceptanceCriteriaController,
              decoration: const InputDecoration(
                labelText: 'Acceptance Criteria',
                hintText: 'Define what you will accept...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _discrepancyProcedureController,
              decoration: const InputDecoration(
                labelText: 'Procedure for Discrepancies',
                hintText: 'How to handle issues found during inspection...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),

            const Text(
              'Buyer Confirmation Duration Limit',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Slider(
                    value: _buyerConfirmationLimitDays.toDouble(),
                    min: 1,
                    max: _buyerConfirmationLimitUnit == 'hours' ? 48 : 7,
                    divisions: _buyerConfirmationLimitUnit == 'hours' ? 47 : 6,
                    label: '$_buyerConfirmationLimitDays $_buyerConfirmationLimitUnit',
                    onChanged: (value) {
                      setState(() => _buyerConfirmationLimitDays = value.toInt());
                      _onFieldChanged();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$_buyerConfirmationLimitDays',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _buyerConfirmationLimitUnit,
                  items: const [
                    DropdownMenuItem(value: 'hours', child: Text('hours')),
                    DropdownMenuItem(value: 'days', child: Text('days')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _buyerConfirmationLimitUnit = value ?? 'days';
                      if (_buyerConfirmationLimitUnit == 'hours') {
                        _buyerConfirmationLimitDays = _buyerConfirmationLimitDays.clamp(1, 48);
                      } else {
                        _buyerConfirmationLimitDays = _buyerConfirmationLimitDays.clamp(1, 7);
                      }
                    });
                    _onFieldChanged();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CheckboxListTile(
              value: _titleRegistrationAcknowledged,
              onChanged: (value) {
                setState(() => _titleRegistrationAcknowledged = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I acknowledge receipt of title/registration upon delivery',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            CheckboxListTile(
              value: _noLiensAcknowledged,
              onChanged: (value) {
                setState(() => _noLiensAcknowledged = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I acknowledge no outstanding loans or liens exist on this vehicle',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            CheckboxListTile(
              value: _transferProcessAcknowledged,
              onChanged: (value) {
                setState(() => _transferProcessAcknowledged = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I acknowledge the transfer of ownership process',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisputeSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CheckboxListTile(
              value: _discussionsLoggedConfirmed,
              onChanged: (value) {
                setState(() => _discussionsLoggedConfirmed = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I confirm all discussions/messages are logged and may be used for dispute resolution',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            CheckboxListTile(
              value: _disputeResolutionAgreed,
              onChanged: (value) {
                setState(() => _disputeResolutionAgreed = value ?? false);
                _onFieldChanged();
              },
              title: const Text(
                'I agree to the platform dispute resolution process, including moderator review, evidence submission, escrow hold, timelines, and optional escalation to senior admin',
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
              controller: _additionalProtectionsController,
              decoration: const InputDecoration(
                labelText: 'Additional Protections Requested (Optional)',
                hintText: 'e.g., conditional acceptance, partial refunds, insurance coverage',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformTermsSection() {
    return Card(
      elevation: 2,
      color: ColorConstants.primaryGreen.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CheckboxListTile(
          value: _platformTermsAgreed,
          onChanged: (value) {
            setState(() => _platformTermsAgreed = value ?? false);
            _onFieldChanged();
          },
          title: const Text(
            'I agree to the platform terms and conditions for this transaction',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: const Text(
            'Required - This is a binding agreement',
            style: TextStyle(fontSize: 11, color: Colors.red, fontWeight: FontWeight.w500),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
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
