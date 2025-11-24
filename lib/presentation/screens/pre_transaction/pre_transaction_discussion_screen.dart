import 'dart:async';
import 'dart:convert'; // For JSON encoding and Agreement Hash generation
import 'package:crypto/crypto.dart'; // For SHA-256 hashing
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/pre_transaction_provider.dart';
import '../../../data/models/pre_transaction_model.dart';
import '../../../data/models/pre_transaction_message_model.dart';
import '../../../data/models/pre_transaction_confirmation_model.dart';
import '../../../core/constants/color_constants.dart';
import '../../widgets/pre_transaction_progress_tracker.dart';
import '../../widgets/ph_address_picker.dart';


class PreTransactionDiscussionScreen extends StatefulWidget {
  final String auctionId;
  final String carTitle;
  final double winningBid;
  final bool isSeller; // true if current user is seller, false if buyer

  const PreTransactionDiscussionScreen({
    super.key,
    required this.auctionId,
    required this.carTitle,
    required this.winningBid,
    this.isSeller = false,
  });

  @override
  State<PreTransactionDiscussionScreen> createState() => _PreTransactionDiscussionScreenState();
}

class _PreTransactionDiscussionScreenState extends State<PreTransactionDiscussionScreen>
    with SingleTickerProviderStateMixin {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  // Common form controllers
  final _buyerNotesController = TextEditingController();
  final _sellerNotesController = TextEditingController();
  final _handoverLocationController = TextEditingController();
  final _deliveryDelayClauseController = TextEditingController();
  final _otherConditionsController = TextEditingController();
  final _otherPaymentMethodController = TextEditingController();

  bool _isInitialized = false;

  // Tab controller for 4 tabs: Chat, Form, Other Party Form, Progress
  late TabController _tabController;
  int _currentTabIndex = 0;
  DateTime? _lastAutoSave;

  // Editing state
  bool _isEditingForm = false;
  bool _isFormDeactivated = false;
  Timer? _editRequestTimer;
  int _editRequestCount = 0;
  bool _hasConfirmedOtherParty = false;
  bool _otherPartyConfirmedMe = false;

  // RA 8792 Legal acknowledgment tracking
  bool _legalAcknowledgmentBuyer = false;
  bool _legalAcknowledgmentSeller = false;

  // Data Privacy Acknowledgment (RA 10173)
  bool _dataPrivacyConsentBuyer = false;
  bool _dataPrivacyConsentSeller = false;

  // === BUYER FORM FIELDS ===
  // Inspection Agreement
  String? _buyerInspectionChoice; // 'inspection_before_payment', 'waives_inspection', 'specify'
  final _buyerInspectionSpecifyController = TextEditingController();

  // Handover Location (5-field address)
  String? _buyerHandoverRegion;
  String? _buyerHandoverProvince;
  String? _buyerHandoverCity;
  String? _buyerHandoverBarangay;
  String? _buyerHandoverLandmark;

  // Target Delivery Date
  DateTime? _buyerTargetDeliveryDate;

  // Payment Window Commitment
  String? _buyerPaymentWindow; // '24h', '48h', '72h'

  // Conditions Before Payment
  bool _buyerConditionInspectionCompleted = false;
  bool _buyerConditionOwnershipVerified = false;
  bool _buyerConditionDeedReceived = false;
  String? _buyerOtherConditions;

  // Buyer form submission timestamp
  DateTime? _buyerSubmittedAt;

  // === SELLER FORM FIELDS ===
  // Inspection Agreement Response
  String? _sellerInspectionResponse; // 'will_allow', 'sold_as_is', 'specify'
  final _sellerInspectionSpecifyController = TextEditingController();

  // Handover Location Confirmation (5-field address)
  String? _sellerHandoverRegion;
  String? _sellerHandoverProvince;
  String? _sellerHandoverCity;
  String? _sellerHandoverBarangay;
  String? _sellerHandoverLandmark;

  // Delivery Date Commitment
  DateTime? _sellerDeliveryDate;

  // Delivery Delay Clause
  String? _sellerDeliveryDelayClause;

  // Payment Methodology
  String? _sellerPaymentMethod; // 'bank_transfer', 'gcash', 'cash', 'paymaya', 'others'
  String? _sellerOtherPaymentMethod;

  // Seller form submission timestamp
  DateTime? _sellerSubmittedAt;

  // === AGREEMENT GENERATION ===
  String? _agreementHash;
  DateTime? _agreementGeneratedAt;
  Map<String, dynamic>? _combinedAgreementData;

  // Mock update timer for other party form
  Timer? _mockUpdateTimer;
  int _mockUpdateCount = 0;

  // Mock confirmation timer (after 3 edits)
  Timer? _confirmationDialogTimer;

  // Mock checkpoint progression timer (buyer side)
  Timer? _checkpointMockTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_onTabChanged);
    _initializePreTransaction();
    _startMockUpdateTimer();

    // Start buyer-side checkpoint mock if not seller
    if (!widget.isSeller) {
      _startBuyerCheckpointMock();
    }
  }

  void _startMockUpdateTimer() {
    _mockUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _mockUpdateCount++;
        });
      }
    });
  }

  void _startBuyerCheckpointMock() {
    // Simulate seller updating checkpoints automatically every 10 seconds
    _checkpointMockTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (!mounted) {
        timer.cancel();
        return;
      }

      final provider = context.read<PreTransactionProvider>();
      final preTransaction = provider.currentPreTransaction;

      if (preTransaction == null) return;

      // Auto-progress through checkpoints
      PreTransactionStatus? nextStatus;
      switch (preTransaction.status) {
        case PreTransactionStatus.preparing:
          nextStatus = PreTransactionStatus.shipping;
          break;
        case PreTransactionStatus.shipping:
          nextStatus = PreTransactionStatus.delivered;
          break;
        case PreTransactionStatus.delivered:
          nextStatus = PreTransactionStatus.paymentSuccess;
          break;
        case PreTransactionStatus.paymentSuccess:
          nextStatus = PreTransactionStatus.transactionComplete;
          timer.cancel(); // Stop after completion
          break;
        default:
          break;
      }

      if (nextStatus != null) {
        await provider.updateCheckpointStatus(newStatus: nextStatus);
      }
    });
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      // Auto-save form data when switching tabs
      _autoSaveFormData();
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    }
  }

  void _autoSaveFormData() {
    // Auto-save form state to prevent data loss
    // This persists user input when switching between tabs
    if (_currentTabIndex == 1) {
      // Switching away from form tab - save current state
      _lastAutoSave = DateTime.now();
      debugPrint('✓ Form data auto-saved at ${_lastAutoSave}');
      // State is preserved via AutomaticKeepAliveClientMixin in embedded form
    }
  }

  void _onFormChanged() {
    // Callback when form fields change
    if (_lastAutoSave == null ||
        DateTime.now().difference(_lastAutoSave!).inSeconds > 5) {
      _lastAutoSave = DateTime.now();
      debugPrint('✓ Form auto-saved at ${_lastAutoSave}');
    }
  }

  Future<void> _initializePreTransaction() async {
    final provider = context.read<PreTransactionProvider>();

    // Try to load existing pre-transaction first
    final exists = await provider.loadPreTransactionByAuctionId(widget.auctionId);

    // If not found, create new one
    if (!exists) {
      await provider.createPreTransaction(
        auctionId: widget.auctionId,
        carId: 'CAR001', // Mock car ID
        carTitle: widget.carTitle,
        buyerId: 'user123', // Mock buyer ID
        sellerId: 'seller456', // Mock seller ID
        buyerName: 'Juan Dela Cruz',
        sellerName: 'Pedro Santos',
        finalBidAmount: widget.winningBid,
      );
    }

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });

      // Scroll to bottom when messages load
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _mockUpdateTimer?.cancel();
    _editRequestTimer?.cancel();
    _confirmationDialogTimer?.cancel();
    _checkpointMockTimer?.cancel();
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    _buyerNotesController.dispose();
    _sellerNotesController.dispose();
    _handoverLocationController.dispose();
    _deliveryDelayClauseController.dispose();
    _otherConditionsController.dispose();
    _otherPaymentMethodController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    _messageController.clear();

    final provider = context.read<PreTransactionProvider>();
    await provider.addMessage(
      sender: widget.isSeller ? MessageSender.seller : MessageSender.buyer,
      senderName: widget.isSeller ? 'Pedro Santos' : 'Juan Dela Cruz', // Mock names
      content: content,
    );

    // Scroll to bottom after sending
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction: ${widget.carTitle}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            const Tab(icon: Icon(Icons.chat_bubble_outline), text: 'Chat'),
            const Tab(icon: Icon(Icons.assignment), text: 'My Form'),
            Tab(icon: Icon(widget.isSeller ? Icons.person : Icons.storefront),
                text: widget.isSeller ? 'Buyer Form' : 'Seller Form'),
            const Tab(icon: Icon(Icons.timeline), text: 'Progress'),
          ],
        ),
      ),
      body: !_isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Consumer<PreTransactionProvider>(
              builder: (context, provider, child) {
                final preTransaction = provider.currentPreTransaction;

                // Show error only if there's an actual error (not just loading)
                if (preTransaction == null && provider.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        const Text(
                          'Failed to load discussion',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          provider.error ?? '',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            provider.clearError();
                            _initializePreTransaction();
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (preTransaction == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                return TabBarView(
                  controller: _tabController,
                  children: [
                    // Tab 1: Chat
                    _buildChatTab(preTransaction),
                    // Tab 2: My Form
                    _buildFormTab(preTransaction),
                    // Tab 3: Other Party Form
                    _buildOtherPartyFormTab(preTransaction),
                    // Tab 4: Progress Tracking
                    _buildProgressTab(preTransaction),
                  ],
                );
              },
            ),
    );
  }

  // ===== TAB BUILDERS =====

  Widget _buildChatTab(PreTransaction preTransaction) {
    return Column(
      children: [
        _buildHeader(preTransaction.finalBidAmount),
        Expanded(
          child: _buildMessageList(preTransaction.messages),
        ),
        _buildInputField(),
      ],
    );
  }

  Widget _buildFormTab(PreTransaction preTransaction) {
    // Check if form is already submitted
    final isSubmitted = widget.isSeller ? _sellerSubmittedAt != null : _buyerSubmittedAt != null;

    return Column(
      children: [
        _buildFormHeader(preTransaction),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === COMMON SECTION (Both Buyer and Seller) ===
                _buildTransactionDetailsSection(preTransaction),
                const SizedBox(height: 16),
                _buildLegalBannerSection(),
                const SizedBox(height: 16),
                _buildDataPrivacySection(),
                const SizedBox(height: 24),

                // === CONDITIONAL FORM (Buyer or Seller) ===
                if (widget.isSeller)
                  _buildSellerFormFields()
                else
                  _buildBuyerFormFields(),

                const SizedBox(height: 24),

                // === SUBMISSION TIMESTAMP (if already submitted) ===
                if (isSubmitted)
                  _buildSubmissionConfirmation(),

                const SizedBox(height: 24),

                // === DATA PRIVACY ACT SECTION (at bottom of form) ===
                _buildDataPrivacySection(),

                const SizedBox(height: 16),

                // === RA 8792 LEGAL ACKNOWLEDGMENT SECTION (at bottom of form) ===
                _buildLegalAcknowledgmentSection(preTransaction),
              ],
            ),
          ),
        ),
        _buildFormSubmitButton(preTransaction),
      ],
    );
  }

  // =============================================================================
  // COMMON SECTIONS (Visible to both Buyer and Seller)
  // =============================================================================

  Widget _buildTransactionDetailsSection(PreTransaction preTransaction) {
    // TODO: Replace mock data with actual vehicle details from preTransaction
    final vehicleMake = 'Toyota'; // Mock - replace with preTransaction.vehicleMake
    final vehicleModel = 'Vios'; // Mock - replace with preTransaction.vehicleModel
    final vehicleYear = '2020'; // Mock - replace with preTransaction.vehicleYear
    final vinPlate = 'ABC1234'; // Mock - replace with preTransaction.vinOrPlate
    final transactionId = preTransaction.id;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.description, color: ColorConstants.primaryGreen, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Transaction Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildReadOnlyField('Vehicle Make', vehicleMake),
            _buildReadOnlyField('Vehicle Model', vehicleModel),
            _buildReadOnlyField('Vehicle Year', vehicleYear),
            _buildReadOnlyField('VIN / License Plate', vinPlate),
            _buildReadOnlyField('Final Bid Amount', '₱${NumberFormat('#,##0.00').format(widget.winningBid)}'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(Icons.tag, size: 16, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Transaction ID: $transactionId',
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalBannerSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorConstants.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorConstants.info.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.gavel, color: ColorConstants.info, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Legal Framework',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  'This transaction is governed by the Electronic Commerce Act of 2000 (RA 8792). All digital records, signatures, and agreements executed through this platform are legally binding and admissible as evidence.',
                  style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataPrivacySection() {
    final isConsented = widget.isSeller ? _dataPrivacyConsentSeller : _dataPrivacyConsentBuyer;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.05),
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.privacy_tip, color: Colors.orange[700], size: 20),
              const SizedBox(width: 8),
              const Text(
                'Data Privacy Act Notice (RA 10173)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CheckboxListTile(
            value: isConsented,
            onChanged: _isFormDeactivated ? null : (value) {
              setState(() {
                if (widget.isSeller) {
                  _dataPrivacyConsentSeller = value ?? false;
                } else {
                  _dataPrivacyConsentBuyer = value ?? false;
                }
              });
            },
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            title: const Text(
              'I consent to the collection and processing of my personal data in accordance with the Data Privacy Act of 2012 (RA 10173) and applicable electronic transaction laws.',
              style: TextStyle(fontSize: 13),
            ),
          ),
          if (!isConsented)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 40),
              child: Text(
                'You must consent to data privacy terms before submitting',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.orange[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // =============================================================================
  // BUYER FORM FIELDS
  // =============================================================================

  Widget _buildBuyerFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Buyer Agreement Form',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // 1. Inspection Agreement
        _buildSectionTitle('1. Inspection Agreement'),
        _buildRadioGroup(
          value: _buyerInspectionChoice,
          options: [
            {'value': 'inspection_before_payment', 'label': 'Inspection required before payment'},
            {'value': 'waives_inspection', 'label': 'Waives inspection (buy as-is)'},
            {'value': 'specify', 'label': 'Specify custom arrangement'},
          ],
          onChanged: (value) {
            setState(() {
              _buyerInspectionChoice = value;
            });
          },
        ),
        if (_buyerInspectionChoice == 'specify') ...[
          const SizedBox(height: 8),
          TextField(
            controller: _buyerInspectionSpecifyController,
            enabled: !_isFormDeactivated,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Specify inspection arrangement',
              hintText: 'Describe your inspection arrangement',
            ),
            maxLength: 200,
            maxLines: 2,
          ),
        ],
        const SizedBox(height: 16),

        // 2. Agreed Handover Location
        _buildSectionTitle('2. Agreed Handover Location'),
        PhilippineAddressPicker(
          initialRegion: _buyerHandoverRegion,
          initialProvince: _buyerHandoverProvince,
          initialCity: _buyerHandoverCity,
          initialBarangay: _buyerHandoverBarangay,
          initialLandmark: _buyerHandoverLandmark,
          enabled: !_isFormDeactivated,
          onAddressChanged: (address) {
            setState(() {
              _buyerHandoverRegion = address['region'];
              _buyerHandoverProvince = address['province'];
              _buyerHandoverCity = address['city'];
              _buyerHandoverBarangay = address['barangay'];
              _buyerHandoverLandmark = address['landmark'];
            });
          },
        ),
        const SizedBox(height: 16),

        // 3. Target Delivery Date
        _buildSectionTitle('3. Target Delivery Date'),
        OutlinedButton.icon(
          onPressed: _isFormDeactivated ? null : () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(const Duration(days: 7)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 90)),
            );
            if (date != null) {
              setState(() {
                _buyerTargetDeliveryDate = date;
              });
            }
          },
          icon: const Icon(Icons.calendar_today),
          label: Text(
            _buyerTargetDeliveryDate == null
                ? 'Select delivery date'
                : DateFormat('MMM dd, yyyy').format(_buyerTargetDeliveryDate!),
          ),
        ),
        const SizedBox(height: 16),

        // 4. Payment Window Commitment
        _buildSectionTitle('4. Payment Window Commitment'),
        DropdownButtonFormField<String>(
          value: _buyerPaymentWindow,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Select payment window',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          items: [
            {'value': '24h', 'label': 'Within 24 hours after signing'},
            {'value': '48h', 'label': 'Within 48 hours after signing'},
            {'value': '72h', 'label': 'Within 72 hours after signing'},
          ].map((item) {
            return DropdownMenuItem(value: item['value'], child: Text(item['label']!));
          }).toList(),
          onChanged: _isFormDeactivated ? null : (value) {
            setState(() {
              _buyerPaymentWindow = value;
            });
          },
        ),
        const SizedBox(height: 16),

        // 5. Conditions Before Payment
        _buildSectionTitle('5. Conditions Before Payment'),
        CheckboxListTile(
          value: _buyerConditionInspectionCompleted,
          onChanged: _isFormDeactivated ? null : (value) {
            setState(() {
              _buyerConditionInspectionCompleted = value ?? false;
            });
          },
          title: const Text('Inspection completed', style: TextStyle(fontSize: 13)),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
        ),
        CheckboxListTile(
          value: _buyerConditionOwnershipVerified,
          onChanged: _isFormDeactivated ? null : (value) {
            setState(() {
              _buyerConditionOwnershipVerified = value ?? false;
            });
          },
          title: const Text('Ownership documents verified', style: TextStyle(fontSize: 13)),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
        ),
        CheckboxListTile(
          value: _buyerConditionDeedReceived,
          onChanged: _isFormDeactivated ? null : (value) {
            setState(() {
              _buyerConditionDeedReceived = value ?? false;
            });
          },
          title: const Text('Deed of Sale draft received', style: TextStyle(fontSize: 13)),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _otherConditionsController,
          enabled: !_isFormDeactivated,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Other conditions (optional)',
            hintText: 'Specify any additional conditions',
          ),
          maxLength: 200,
          maxLines: 2,
        ),
        const SizedBox(height: 16),

        // 6. Payment Methodology Confirmation (Read-only, set by seller)
        _buildSectionTitle('6. Payment Methodology (Seller Preference)'),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Icon(Icons.payment, color: Colors.grey[700], size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _sellerPaymentMethod != null
                      ? _getPaymentMethodLabel(_sellerPaymentMethod!)
                      : 'Waiting for seller to specify payment method',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 7. Optional Buyer Notes
        _buildSectionTitle('7. Additional Notes (Optional)'),
        TextField(
          controller: _buyerNotesController,
          enabled: !_isFormDeactivated,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Any additional notes or concerns',
          ),
          maxLength: 200,
          maxLines: 3,
        ),
      ],
    );
  }

  // =============================================================================
  // SELLER FORM FIELDS
  // =============================================================================

  Widget _buildSellerFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Seller Agreement Form',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // 1. Inspection Agreement Response
        _buildSectionTitle('1. Inspection Agreement Response'),
        _buildRadioGroup(
          value: _sellerInspectionResponse,
          options: [
            {'value': 'will_allow', 'label': 'Will allow inspection before payment'},
            {'value': 'sold_as_is', 'label': 'Sold as-is, no inspection allowed'},
            {'value': 'specify', 'label': 'Specify custom arrangement'},
          ],
          onChanged: (value) {
            setState(() {
              _sellerInspectionResponse = value;
            });
          },
        ),
        if (_sellerInspectionResponse == 'specify') ...[
          const SizedBox(height: 8),
          TextField(
            controller: _sellerInspectionSpecifyController,
            enabled: !_isFormDeactivated,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Specify inspection arrangement',
              hintText: 'Describe your inspection arrangement',
            ),
            maxLength: 200,
            maxLines: 2,
          ),
        ],
        const SizedBox(height: 16),

        // 2. Handover Location Confirmation
        _buildSectionTitle('2. Handover Location Confirmation'),
        PhilippineAddressPicker(
          initialRegion: _sellerHandoverRegion,
          initialProvince: _sellerHandoverProvince,
          initialCity: _sellerHandoverCity,
          initialBarangay: _sellerHandoverBarangay,
          initialLandmark: _sellerHandoverLandmark,
          enabled: !_isFormDeactivated,
          onAddressChanged: (address) {
            setState(() {
              _sellerHandoverRegion = address['region'];
              _sellerHandoverProvince = address['province'];
              _sellerHandoverCity = address['city'];
              _sellerHandoverBarangay = address['barangay'];
              _sellerHandoverLandmark = address['landmark'];
            });
          },
        ),
        if (false) ...[
          const SizedBox(height: 8),
          TextField(
            controller: _handoverLocationController,
            enabled: !_isFormDeactivated,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Specify location',
              hintText: 'Enter specific handover location',
            ),
            maxLength: 100,
          ),
        ],
        const SizedBox(height: 16),

        // 3. Delivery Date Commitment
        _buildSectionTitle('3. Delivery Date Commitment'),
        OutlinedButton.icon(
          onPressed: _isFormDeactivated ? null : () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _buyerTargetDeliveryDate ?? DateTime.now().add(const Duration(days: 7)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 90)),
            );
            if (date != null) {
              setState(() {
                _sellerDeliveryDate = date;
              });
            }
          },
          icon: const Icon(Icons.calendar_today),
          label: Text(
            _sellerDeliveryDate == null
                ? (_buyerTargetDeliveryDate != null
                    ? 'Buyer requested: ${DateFormat('MMM dd, yyyy').format(_buyerTargetDeliveryDate!)}'
                    : 'Select delivery date')
                : DateFormat('MMM dd, yyyy').format(_sellerDeliveryDate!),
          ),
        ),
        const SizedBox(height: 16),

        // 4. Delivery Delay Clause
        _buildSectionTitle('4. Delivery Delay Clause (Optional)'),
        TextField(
          controller: _deliveryDelayClauseController,
          enabled: !_isFormDeactivated,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'e.g., "Any delay beyond 3 days to be discussed mutually"',
          ),
          maxLength: 200,
          maxLines: 2,
        ),
        const SizedBox(height: 16),

        // 5. Payment Methodology
        _buildSectionTitle('5. Payment Methodology'),
        DropdownButtonFormField<String>(
          value: _sellerPaymentMethod,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Select preferred payment method',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          items: [
            {'value': 'bank_transfer', 'label': 'Bank Transfer'},
            {'value': 'gcash', 'label': 'GCash'},
            {'value': 'cash', 'label': 'Cash on Handover'},
            {'value': 'paymaya', 'label': 'PayMaya'},
            {'value': 'others', 'label': 'Others (specify)'},
          ].map((item) {
            return DropdownMenuItem(value: item['value'], child: Text(item['label']!));
          }).toList(),
          onChanged: _isFormDeactivated ? null : (value) {
            setState(() {
              _sellerPaymentMethod = value;
            });
          },
        ),
        if (_sellerPaymentMethod == 'others') ...[
          const SizedBox(height: 8),
          TextField(
            controller: _otherPaymentMethodController,
            enabled: !_isFormDeactivated,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Specify payment method',
              hintText: 'Enter payment method details',
            ),
            maxLength: 100,
          ),
        ],
        const SizedBox(height: 16),

        // 6. Additional Seller Notes
        _buildSectionTitle('6. Additional Notes (Optional)'),
        TextField(
          controller: _sellerNotesController,
          enabled: !_isFormDeactivated,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Any additional notes or terms',
          ),
          maxLength: 200,
          maxLines: 3,
        ),
      ],
    );
  }

  // =============================================================================
  // HELPER WIDGETS
  // =============================================================================

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF4CAF50),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioGroup({
    required String? value,
    required List<Map<String, String>> options,
    required Function(String?) onChanged,
  }) {
    return Column(
      children: options.map((option) {
        return RadioListTile<String>(
          value: option['value']!,
          groupValue: value,
          onChanged: _isFormDeactivated ? null : onChanged,
          title: Text(option['label']!, style: const TextStyle(fontSize: 13)),
          contentPadding: EdgeInsets.zero,
          dense: true,
        );
      }).toList(),
    );
  }

  Widget _buildSubmissionConfirmation() {
    final submittedAt = widget.isSeller ? _sellerSubmittedAt : _buyerSubmittedAt;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Form Submitted',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                const SizedBox(height: 4),
                Text(
                  'Submitted: ${DateFormat('MMM dd, yyyy • hh:mm a').format(submittedAt!)}',
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getPaymentMethodLabel(String method) {
    switch (method) {
      case 'bank_transfer':
        return 'Bank Transfer';
      case 'gcash':
        return 'GCash';
      case 'cash':
        return 'Cash on Handover';
      case 'paymaya':
        return 'PayMaya';
      case 'others':
        return _sellerOtherPaymentMethod ?? 'Other';
      default:
        return method;
    }
  }

  // =============================================================================
  // FORM VALIDATION AND SUBMISSION
  // =============================================================================

  String _getBuyerFullAddress() {
    final parts = <String>[];
    if (_buyerHandoverLandmark != null && _buyerHandoverLandmark!.isNotEmpty) parts.add(_buyerHandoverLandmark!);
    if (_buyerHandoverBarangay != null && _buyerHandoverBarangay!.isNotEmpty) parts.add(_buyerHandoverBarangay!);
    if (_buyerHandoverCity != null && _buyerHandoverCity!.isNotEmpty) parts.add(_buyerHandoverCity!);
    if (_buyerHandoverProvince != null && _buyerHandoverProvince!.isNotEmpty) parts.add(_buyerHandoverProvince!);
    if (_buyerHandoverRegion != null && _buyerHandoverRegion!.isNotEmpty) parts.add(_buyerHandoverRegion!);
    return parts.join(', ');
  }

  String _getSellerFullAddress() {
    final parts = <String>[];
    if (_sellerHandoverLandmark != null && _sellerHandoverLandmark!.isNotEmpty) parts.add(_sellerHandoverLandmark!);
    if (_sellerHandoverBarangay != null && _sellerHandoverBarangay!.isNotEmpty) parts.add(_sellerHandoverBarangay!);
    if (_sellerHandoverCity != null && _sellerHandoverCity!.isNotEmpty) parts.add(_sellerHandoverCity!);
    if (_sellerHandoverProvince != null && _sellerHandoverProvince!.isNotEmpty) parts.add(_sellerHandoverProvince!);
    if (_sellerHandoverRegion != null && _sellerHandoverRegion!.isNotEmpty) parts.add(_sellerHandoverRegion!);
    return parts.join(', ');
  }

  bool _isBuyerAddressFilled() {
    return (_buyerHandoverRegion != null && _buyerHandoverRegion!.isNotEmpty) ||
        (_buyerHandoverProvince != null && _buyerHandoverProvince!.isNotEmpty) ||
        (_buyerHandoverCity != null && _buyerHandoverCity!.isNotEmpty) ||
        (_buyerHandoverBarangay != null && _buyerHandoverBarangay!.isNotEmpty);
  }

  bool _isSellerAddressFilled() {
    return (_sellerHandoverRegion != null && _sellerHandoverRegion!.isNotEmpty) ||
        (_sellerHandoverProvince != null && _sellerHandoverProvince!.isNotEmpty) ||
        (_sellerHandoverCity != null && _sellerHandoverCity!.isNotEmpty) ||
        (_sellerHandoverBarangay != null && _sellerHandoverBarangay!.isNotEmpty);
  }

  bool _canSubmitBuyerForm() {
    return _dataPrivacyConsentBuyer &&
        _legalAcknowledgmentBuyer &&
        _buyerInspectionChoice != null &&
        _isBuyerAddressFilled() &&
        _buyerTargetDeliveryDate != null &&
        _buyerPaymentWindow != null;
  }

  bool _canSubmitSellerForm() {
    return _dataPrivacyConsentSeller &&
        _legalAcknowledgmentSeller &&
        _sellerInspectionResponse != null &&
        _isSellerAddressFilled() &&
        _sellerDeliveryDate != null &&
        _sellerPaymentMethod != null;
  }

  // =============================================================================
  // AGREEMENT GENERATION (Called when both parties submit)
  // =============================================================================

  void _generateCombinedAgreement() {
    if (_buyerSubmittedAt == null || _sellerSubmittedAt == null) {
      return; // Both parties must submit first
    }

    // Create combined agreement data
    _combinedAgreementData = {
      'transactionId': widget.auctionId,
      'vehicleTitle': widget.carTitle,
      'finalBidAmount': widget.winningBid,
      'buyer': {
        'inspectionChoice': _buyerInspectionChoice,
        'handoverLocation': _getBuyerFullAddress(),
        'handoverRegion': _buyerHandoverRegion,
        'handoverProvince': _buyerHandoverProvince,
        'handoverCity': _buyerHandoverCity,
        'handoverBarangay': _buyerHandoverBarangay,
        'handoverLandmark': _buyerHandoverLandmark,
        'targetDeliveryDate': _buyerTargetDeliveryDate?.toIso8601String(),
        'paymentWindow': _buyerPaymentWindow,
        'conditions': {
          'inspectionCompleted': _buyerConditionInspectionCompleted,
          'ownershipVerified': _buyerConditionOwnershipVerified,
          'deedReceived': _buyerConditionDeedReceived,
          'otherConditions': _otherConditionsController.text,
        },
        'notes': _buyerNotesController.text,
        'submittedAt': _buyerSubmittedAt?.toIso8601String(),
      },
      'seller': {
        'inspectionResponse': _sellerInspectionResponse,
        'handoverLocation': _getSellerFullAddress(),
        'handoverRegion': _sellerHandoverRegion,
        'handoverProvince': _sellerHandoverProvince,
        'handoverCity': _sellerHandoverCity,
        'handoverBarangay': _sellerHandoverBarangay,
        'handoverLandmark': _sellerHandoverLandmark,
        'deliveryDate': _sellerDeliveryDate?.toIso8601String(),
        'deliveryDelayClause': _deliveryDelayClauseController.text,
        'paymentMethod': _sellerPaymentMethod,
        'otherPaymentMethod': _otherPaymentMethodController.text,
        'notes': _sellerNotesController.text,
        'submittedAt': _sellerSubmittedAt?.toIso8601String(),
      },
      'legalAcknowledgments': {
        'buyerAcknowledged': _legalAcknowledgmentBuyer,
        'sellerAcknowledged': _legalAcknowledgmentSeller,
      },
      'dataPrivacyConsents': {
        'buyerConsented': _dataPrivacyConsentBuyer,
        'sellerConsented': _dataPrivacyConsentSeller,
      },
    };

    // Generate agreement hash (SHA-256)
    final agreementJson = jsonEncode(_combinedAgreementData);
    final bytes = utf8.encode(agreementJson);
    final hash = sha256.convert(bytes);
    _agreementHash = hash.toString();
    _agreementGeneratedAt = DateTime.now();

    // TODO: Backend integration - Store combined agreement
    // await BackendService.storeCombinedAgreement(_combinedAgreementData, _agreementHash);

    debugPrint('✓ Combined Agreement Generated');
    debugPrint('  Hash: $_agreementHash');
    debugPrint('  Generated At: $_agreementGeneratedAt');
    debugPrint('  Data: ${jsonEncode(_combinedAgreementData)}');

    // Update progress tracker
    // Move to "Agreement & Acknowledgment" -> "Completed"
    _updateProgressTracker();
  }

  void _updateProgressTracker() {
    // TODO: Backend integration - Update transaction status
    // This should trigger the progress tracker to move from:
    // "Agreement & Acknowledgment" -> "Completed"

    final provider = context.read<PreTransactionProvider>();
    // provider.updateStatus(PreTransactionStatus.agreementSigned);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Agreement complete! Both parties have signed.'),
        backgroundColor: ColorConstants.primaryGreen,
        duration: Duration(seconds: 3),
      ),
    );
  }

  // =============================================================================
  // DEPRECATED METHODS - No longer used with new RA 8792 form
  // =============================================================================

  /*
  Map<String, dynamic> _getFormDataFromConfirmation(PreTransactionConfirmation confirmation) {
    // DEPRECATED: This method is no longer needed - form data is now stored in state variables
    // Convert confirmation back to form data structure based on user role
    if (widget.isSeller) {
      // Seller form data mapping
      return {
        'vehicleMatchesListing': confirmation.vehicleIdentityConfirmed,
        'allIssuesDisclosed': confirmation.allIssuesDisclosedAccurately,
        'conditionAccuratelyRepresented': confirmation.conditionAsRepresented,
        'conditionDocuments': confirmation.supportingDocumentsUrls,
        'ownershipDocuments': confirmation.uploadedDocuments,
        'noOutstandingLiens': confirmation.noOutstandingLiensAcknowledged,
        'specialTransferInstructions': confirmation.specialTransferInstructions,
        'shippingMethod': confirmation.shippingMethod?.toString().split('.').last,
        'deliveryLocation': confirmation.deliveryLocation,
        'deliveryInstructions': confirmation.notes,
        'shippingEvidenceDocuments': confirmation.requiredShippingEvidence,
        'agreeToSubmitShippingEvidence': confirmation.shippingEvidenceCommitment,
        'insuranceResponsibilityAcknowledged': confirmation.transitInsuranceAcknowledged,
        'availability': confirmation.inspectionNotes,
        'inspectionMethod': confirmation.inspectionMethod?.toString().split('.').last,
        'willReviewInspectionEvidence': confirmation.sellerInspectionReviewCommitment,
        'inspectionNotes': confirmation.inspectionNotes,
        'disputeResolutionAgreed': confirmation.disputeResolutionProcessAgreed,
        'fraudPoliciesAcknowledged': confirmation.fraudPoliciesAcknowledged,
        'sellerProtections': confirmation.sellerProtectionMeasures,
        'informationAccuracyConfirmed': confirmation.informationAccuracyConfirmed,
        'platformTermsAgreed': confirmation.termsAgreed,
      };
    } else {
      // Buyer form data mapping
      return {
        'priceAndFeesConfirmed': confirmation.vehicleIdentityConfirmed,
        'additionalFees': confirmation.additionalFees,
        'paymentDuration': confirmation.paymentTimelineDays,
        'paymentDurationUnit': 'days',
        'latePaymentPenaltiesAcknowledged': confirmation.latePaymentPenaltyAcknowledged,
        'shippingMethod': confirmation.shippingMethod?.toString().split('.').last,
        'shippingCostResponsibility': confirmation.shippingCostResponsibility?.toString().split('.').last,
        'deliveryLocation': confirmation.deliveryLocation,
        'insuranceResponsibility': confirmation.insuranceResponsibility?.toString().split('.').last,
        'estimatedDeliveryDays': confirmation.estimatedDeliveryDays,
        'inspectionDuration': (confirmation.vehicleInspectionPeriodHours / 24).round(),
        'inspectionDurationUnit': 'days',
        'inspectionMethod': confirmation.inspectionMethod?.toString().split('.').last,
        'acceptanceCriteria': confirmation.acceptanceCriteria,
        'discrepancyProcedure': confirmation.discrepancyProcedure,
        'buyerConfirmationLimit': (confirmation.buyerConfirmationLimitHours / 24).round(),
        'buyerConfirmationLimitUnit': 'days',
        'titleRegistrationAcknowledged': confirmation.titleTransferAcknowledged,
        'noLiensAcknowledged': confirmation.noOutstandingLiensAcknowledged,
        'transferProcessAcknowledged': confirmation.ownershipTransferProcessAcknowledged,
        'discussionsLoggedConfirmed': confirmation.discussionsLoggedAcknowledged,
        'disputeResolutionAgreed': confirmation.disputeResolutionProcessAgreed,
        'fraudPoliciesAcknowledged': confirmation.fraudPoliciesAcknowledged,
        'additionalProtections': confirmation.additionalProtections,
        'platformTermsAgreed': confirmation.termsAgreed,
      };
    }
  }
  */

  Widget _buildOtherPartyFormTab(PreTransaction preTransaction) {
    // Check if other party has submitted their form
    final otherPartySubmitted = widget.isSeller ? _buyerSubmittedAt != null : _sellerSubmittedAt != null;

    if (!otherPartySubmitted) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.isSeller ? Icons.person_outline : Icons.storefront_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Waiting for ${widget.isSeller ? 'Buyer' : 'Seller'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'The ${widget.isSeller ? 'buyer' : 'seller'} hasn\'t submitted their agreement form yet.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final otherPartyName = widget.isSeller ? 'Buyer' : 'Seller';
    final color = widget.isSeller ? Colors.blue : Colors.green;
    final icon = widget.isSeller ? Icons.person : Icons.storefront;

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border(
              bottom: BorderSide(color: color.withOpacity(0.3)),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$otherPartyName Confirmation',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Last updated: ${_mockUpdateCount}s ago',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show other party's submitted form data
                _buildOtherPartyFormData(otherPartyName, icon, color),
              ],
            ),
          ),
        ),
        // Buttons
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showRequestEditDialog(),
                    icon: const Icon(Icons.edit),
                    label: const Text('Request Edit'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: Colors.orange,
                      side: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showAcceptDialog(),
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Accept'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: ColorConstants.primaryGreen,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherPartyFormData(String otherPartyName, IconData icon, Color color) {
    // Display buyer or seller form data based on who the other party is
    if (widget.isSeller) {
      // Show buyer's form data
      return _buildBuyerFormDataCard(icon, color);
    } else {
      // Show seller's form data
      return _buildSellerFormDataCard(icon, color);
    }
  }

  Widget _buildBuyerFormDataCard(IconData icon, Color color) {
    final submittedAt = _buyerSubmittedAt;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 12),
                const Text(
                  'Buyer Agreement Form',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFormDataRow('Inspection Agreement', _getInspectionChoiceLabel(_buyerInspectionChoice)),
            _buildFormDataRow('Handover Location', _getBuyerFullAddress().isNotEmpty ? _getBuyerFullAddress() : 'Not specified'),
            _buildFormDataRow('Target Delivery Date', _buyerTargetDeliveryDate != null ? DateFormat('MMM dd, yyyy').format(_buyerTargetDeliveryDate!) : 'Not specified'),
            _buildFormDataRow('Payment Window', _getPaymentWindowLabel(_buyerPaymentWindow)),
            const Divider(height: 24),
            const Text('Conditions Before Payment:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _buildCheckboxRow('Inspection completed', _buyerConditionInspectionCompleted),
            _buildCheckboxRow('Ownership verified', _buyerConditionOwnershipVerified),
            _buildCheckboxRow('Deed received', _buyerConditionDeedReceived),
            if (_otherConditionsController.text.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Other conditions: ${_otherConditionsController.text}', style: const TextStyle(fontSize: 12)),
            ],
            if (_buyerNotesController.text.isNotEmpty) ...[
              const Divider(height: 24),
              const Text('Notes:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(_buyerNotesController.text, style: const TextStyle(fontSize: 12)),
            ],
            const Divider(height: 24),
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Submitted: ${submittedAt != null ? DateFormat('MMM dd, yyyy • hh:mm a').format(submittedAt) : 'Unknown'}',
                  style: const TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSellerFormDataCard(IconData icon, Color color) {
    final submittedAt = _sellerSubmittedAt;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 12),
                const Text(
                  'Seller Agreement Form',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFormDataRow('Inspection Response', _getInspectionResponseLabel(_sellerInspectionResponse)),
            _buildFormDataRow('Handover Location', _getSellerFullAddress().isNotEmpty ? _getSellerFullAddress() : 'Not specified'),
            _buildFormDataRow('Delivery Date', _sellerDeliveryDate != null ? DateFormat('MMM dd, yyyy').format(_sellerDeliveryDate!) : 'Not specified'),
            if (_deliveryDelayClauseController.text.isNotEmpty)
              _buildFormDataRow('Delivery Delay Clause', _deliveryDelayClauseController.text),
            _buildFormDataRow('Payment Method', _getPaymentMethodLabel(_sellerPaymentMethod ?? '')),
            if (_sellerNotesController.text.isNotEmpty) ...[
              const Divider(height: 24),
              const Text('Notes:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(_sellerNotesController.text, style: const TextStyle(fontSize: 12)),
            ],
            const Divider(height: 24),
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Submitted: ${submittedAt != null ? DateFormat('MMM dd, yyyy • hh:mm a').format(submittedAt) : 'Unknown'}',
                  style: const TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxRow(String label, bool checked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            checked ? Icons.check_box : Icons.check_box_outline_blank,
            size: 18,
            color: checked ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  String _getInspectionChoiceLabel(String? choice) {
    switch (choice) {
      case 'inspected':
        return 'Vehicle inspected and accepted';
      case 'inspection_before_payment':
        return 'Inspection required before payment';
      case 'waives_inspection':
        return 'Waives inspection (buy as-is)';
      default:
        return 'Not specified';
    }
  }

  String _getInspectionResponseLabel(String? response) {
    switch (response) {
      case 'buyer_inspected':
        return 'Buyer already inspected vehicle';
      case 'will_allow':
        return 'Will allow inspection before payment';
      case 'sold_as_is':
        return 'Sold as-is, no inspection allowed';
      default:
        return 'Not specified';
    }
  }

  String _getPaymentWindowLabel(String? window) {
    switch (window) {
      case '24h':
        return 'Within 24 hours after signing';
      case '48h':
        return 'Within 48 hours after signing';
      case '72h':
        return 'Within 72 hours after signing';
      default:
        return 'Not specified';
    }
  }

  Future<void> _showAcceptDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Accept Confirmation?'),
        content: Text(
          'Are you sure you want to accept the ${widget.isSeller ? 'buyer\'s' : 'seller\'s'} confirmation? '
          'This will move the transaction to the next phase.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('Accept'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() {
        _hasConfirmedOtherParty = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.isSeller ? 'Buyer\'s' : 'Seller\'s'} confirmation accepted!'),
          backgroundColor: ColorConstants.primaryGreen,
        ),
      );

      // Mock: Simulate other party confirming me after 3 seconds
      Future.delayed(const Duration(seconds: 3), () async {
        if (mounted) {
          setState(() {
            _otherPartyConfirmedMe = true;
          });

          // Check if both confirmations are done
          if (_hasConfirmedOtherParty && _otherPartyConfirmedMe) {
            await _moveToAdminReview();
          }
        }
      });

      // Switch to Progress tab
      _tabController.animateTo(3);
    }
  }

  Future<void> _moveToAdminReview() async {
    // First approve from user's side
    final provider = context.read<PreTransactionProvider>();
    await provider.approveMutualReview(
      approvedBy: widget.isSeller ? 'seller' : 'buyer',
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Both parties confirmed! Moving to Admin Review...'),
        backgroundColor: Colors.purple,
        duration: Duration(seconds: 2),
      ),
    );

    // Mock: Other party also approves after 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      if (mounted) {
        await provider.approveMutualReview(
          approvedBy: widget.isSeller ? 'buyer' : 'seller',
        );

        // Status should now be pendingAdminReview
        // Mock: Admin review completes after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Admin review complete! Ready for payment.'),
                backgroundColor: ColorConstants.primaryGreen,
                duration: Duration(seconds: 2),
              ),
            );
          }
        });
      }
    });
  }

  Future<void> _showRequestEditDialog() async {
    final fieldController = TextEditingController();
    final reasonController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Edit'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: fieldController,
                decoration: const InputDecoration(
                  labelText: 'Field to Edit',
                  hintText: 'e.g., Delivery Date, Location, etc.',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(
                  labelText: 'Reason for Edit',
                  hintText: 'Explain why this needs to be changed...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (fieldController.text.isNotEmpty && reasonController.text.isNotEmpty) {
                Navigator.pop(context, false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Send Request'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Edit request sent to the other party!'),
          backgroundColor: Colors.orange,
        ),
      );

      // Simulate receiving edit request if current user is buyer
      if (!widget.isSeller) {
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            _showReceivedEditRequestDialog();
          }
        });
      }
    }

    fieldController.dispose();
    reasonController.dispose();
  }

  Future<void> _showReceivedEditRequestDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.edit_notifications, color: Colors.orange),
            SizedBox(width: 12),
            Text('Edit Request Received'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The seller has requested an edit to your confirmation:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Field: Delivery Date',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Reason: Need to reschedule to next week due to shipping availability.',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Please review and update your confirmation in the "My Form" tab.',
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Dismiss'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _tabController.animateTo(1); // Go to My Form tab
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Go to My Form'),
          ),
        ],
      ),
    );
  }

  Future<void> _showMockEditRequestDialog() async {
    // Only show 3 times
    if (_editRequestCount >= 3) {
      // After 3 edits, start the confirmation dialog loop
      if (_confirmationDialogTimer == null || !_confirmationDialogTimer!.isActive) {
        _startConfirmationDialogLoop();
      }
      return;
    }

    _editRequestCount++;

    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.edit_notifications, color: Colors.orange),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Edit Request from ${widget.isSeller ? 'Buyer' : 'Seller'} (#$_editRequestCount)',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The ${widget.isSeller ? 'buyer' : 'seller'} has requested changes to your confirmation:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Field: ${_getEditFieldForCount(_editRequestCount)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Reason: ${_getEditReasonForCount(_editRequestCount)}',
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'You must unlock your form and make the requested changes.',
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Accept & Edit'),
          ),
        ],
      ),
    );

    if (mounted) {
      setState(() {
        _isFormDeactivated = false; // Reactivate form
        _isEditingForm = true; // Enable editing mode
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form unlocked! You can now make changes.'),
          backgroundColor: Colors.orange,
        ),
      );

      // Switch to My Form tab
      _tabController.animateTo(1);

      // Schedule next edit request after 5 seconds (until 3 times)
      if (_editRequestCount < 3) {
        _editRequestTimer?.cancel();
        _editRequestTimer = Timer(const Duration(seconds: 5), () {
          if (mounted) {
            _showMockEditRequestDialog();
          }
        });
      }
    }
  }

  void _startConfirmationDialogLoop() {
    // Start showing the confirmation dialog every 5 seconds
    _confirmationDialogTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        _showOtherPartyConfirmedDialog();
      }
    });
  }

  Future<void> _showOtherPartyConfirmedDialog() async {
    final otherPartyName = widget.isSeller ? 'Buyer' : 'Seller';

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: ColorConstants.primaryGreen),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '$otherPartyName Confirmed Your Form',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The $otherPartyName has confirmed your form submission.',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorConstants.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorConstants.primaryGreen.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: ColorConstants.primaryGreen, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Accept to proceed with the transaction to admin review.',
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('Accept'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      // Stop the timer
      _confirmationDialogTimer?.cancel();

      setState(() {
        _otherPartyConfirmedMe = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaction confirmed! Moving to Admin Review...'),
          backgroundColor: ColorConstants.primaryGreen,
        ),
      );

      // Check if both confirmations are done
      if (_hasConfirmedOtherParty && _otherPartyConfirmedMe) {
        await _moveToAdminReview();
      }

      // Switch to Progress tab
      _tabController.animateTo(3);
    }
  }

  String _getEditFieldForCount(int count) {
    switch (count) {
      case 1:
        return 'Delivery Location';
      case 2:
        return 'Delivery Date';
      case 3:
        return 'Payment Terms';
      default:
        return 'General';
    }
  }

  String _getEditReasonForCount(int count) {
    switch (count) {
      case 1:
        return 'Need to change pickup location to Manila instead of Quezon City.';
      case 2:
        return 'Need to reschedule to next week due to shipping availability.';
      case 3:
        return 'Need to clarify payment timeline and installment options.';
      default:
        return 'General update required.';
    }
  }


  Widget _buildComparisonCard(
    String title,
    PreTransactionConfirmation confirmation,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildConfirmationItem(
              'Submitted By',
              confirmation.userName,
              Icons.person,
            ),
            _buildConfirmationItem(
              'Vehicle Identity Confirmed',
              confirmation.vehicleIdentityConfirmed ? 'Yes' : 'No',
              Icons.check_circle,
            ),
            _buildConfirmationItem(
              'Final Bid Price',
              '₱${_formatCurrency(confirmation.finalBidPrice)}',
              Icons.payment,
            ),
            if (confirmation.deliveryDate != null)
              _buildConfirmationItem(
                'Delivery Date',
                confirmation.deliveryDate!,
                Icons.calendar_today,
              ),
            if (confirmation.deliveryLocation != null)
              _buildConfirmationItem(
                'Delivery Location',
                confirmation.deliveryLocation!,
                Icons.location_on,
              ),
            if (confirmation.notes != null && confirmation.notes!.isNotEmpty)
              _buildConfirmationItem(
                'Notes',
                confirmation.notes!,
                Icons.note,
              ),
          ],
        ),
      ),
    );
  }

  /// RA 8792 Legal Acknowledgment Section
  /// Both parties must independently acknowledge that agreements are legally binding
  Widget _buildLegalAcknowledgmentSection(PreTransaction preTransaction) {
    final isMyAcknowledgment = widget.isSeller
        ? _legalAcknowledgmentSeller
        : _legalAcknowledgmentBuyer;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstants.info.withOpacity(0.05),
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.gavel, color: ColorConstants.primaryGreen, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Legal Acknowledgment (RA 8792)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // RA 8792 Section 8: Electronic signatures are legally binding
          // RA 8792 Section 11: Electronic agreements are admissible as evidence
          CheckboxListTile(
            value: isMyAcknowledgment,
            onChanged: _isFormDeactivated ? null : (value) {
              setState(() {
                if (widget.isSeller) {
                  _legalAcknowledgmentSeller = value ?? false;
                } else {
                  _legalAcknowledgmentBuyer = value ?? false;
                }
              });
            },
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            title: const Text(
              'I acknowledge that this pre-transaction process and any signed agreements are legally binding and admissible under Republic Act No. 8792 (Electronic Commerce Act of 2000).',
              style: TextStyle(fontSize: 13),
            ),
          ),
          if (!isMyAcknowledgment)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 40),
              child: Text(
                'You must acknowledge the legal terms before submitting',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.orange[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFormSubmitButton(PreTransaction preTransaction) {
    final isSubmitted = widget.isSeller ? _sellerSubmittedAt != null : _buyerSubmittedAt != null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: Consumer<PreTransactionProvider>(
            builder: (context, provider, child) {
              if (isSubmitted) {
                // Show Re-edit button if form is already submitted
                return OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isFormDeactivated = false;
                      if (widget.isSeller) {
                        _sellerSubmittedAt = null;
                      } else {
                        _buyerSubmittedAt = null;
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Form unlocked! You can now make changes.'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text(
                    'Re-edit Form',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    foregroundColor: Colors.orange,
                    side: const BorderSide(color: Colors.orange, width: 2),
                  ),
                );
              }

              // Check if form can be submitted
              final canSubmit = widget.isSeller
                  ? _canSubmitSellerForm()
                  : _canSubmitBuyerForm();

              return ElevatedButton(
                onPressed: canSubmit && !provider.isLoading
                    ? () => _submitAgreementForm(provider)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryGreen,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[300],
                ),
                child: provider.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Submit Agreement',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  // =============================================================================
  // NEW SUBMISSION METHODS (RA 8792 Compliant)
  // =============================================================================

  Future<void> _submitAgreementForm(PreTransactionProvider provider) async {
    // Validate data privacy consent
    final dataPrivacyConsent = widget.isSeller ? _dataPrivacyConsentSeller : _dataPrivacyConsentBuyer;
    if (!dataPrivacyConsent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the Data Privacy consent'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate legal acknowledgment
    final legalAck = widget.isSeller ? _legalAcknowledgmentSeller : _legalAcknowledgmentBuyer;
    if (!legalAck) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please acknowledge the legal terms (RA 8792)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isFormDeactivated = true; // Lock the form
    });

    try {
      if (widget.isSeller) {
        // === SELLER SUBMISSION ===
        await _submitSellerAgreement(provider);
      } else {
        // === BUYER SUBMISSION ===
        await _submitBuyerAgreement(provider);
      }

      if (!mounted) return;

      // Set submission timestamp
      setState(() {
        if (widget.isSeller) {
          _sellerSubmittedAt = DateTime.now();
        } else {
          _buyerSubmittedAt = DateTime.now();
        }
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isSeller
                ? '✓ Seller agreement submitted!'
                : '✓ Buyer agreement submitted!',
          ),
          backgroundColor: ColorConstants.primaryGreen,
        ),
      );

      // Check if both parties have submitted -> Generate combined agreement
      if (_buyerSubmittedAt != null && _sellerSubmittedAt != null) {
        _generateCombinedAgreement();
      }

      // Mock: Trigger edit request dialog flow (3 times) after 5 seconds
      _editRequestTimer?.cancel();
      _editRequestTimer = Timer(const Duration(seconds: 5), () {
        if (mounted) {
          _showMockEditRequestDialog();
        }
      });

    } catch (e) {
      if (mounted) {
        setState(() {
          _isFormDeactivated = false; // Unlock on error
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting form: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _submitBuyerAgreement(PreTransactionProvider provider) async {
    // Prepare buyer form data
    final buyerData = {
      'inspectionChoice': _buyerInspectionChoice,
      'handoverLocation': _getBuyerFullAddress(),
      'handoverRegion': _buyerHandoverRegion,
      'handoverProvince': _buyerHandoverProvince,
      'handoverCity': _buyerHandoverCity,
      'handoverBarangay': _buyerHandoverBarangay,
      'handoverLandmark': _buyerHandoverLandmark,
      'targetDeliveryDate': _buyerTargetDeliveryDate?.toIso8601String(),
      'paymentWindow': _buyerPaymentWindow,
      'conditionInspectionCompleted': _buyerConditionInspectionCompleted,
      'conditionOwnershipVerified': _buyerConditionOwnershipVerified,
      'conditionDeedReceived': _buyerConditionDeedReceived,
      'otherConditions': _otherConditionsController.text,
      'notes': _buyerNotesController.text,
      'dataPrivacyConsent': _dataPrivacyConsentBuyer,
      'legalAcknowledgment': _legalAcknowledgmentBuyer,
      'submittedAt': DateTime.now().toIso8601String(),
    };

    // TODO: Backend integration
    // await provider.submitBuyerAgreement(buyerData);
    // await BackendService.storeBuyerAgreement(widget.auctionId, buyerData);

    debugPrint('✓ Buyer Agreement Submitted');
    debugPrint('  Data: ${jsonEncode(buyerData)}');

    // Simulate backend delay
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _submitSellerAgreement(PreTransactionProvider provider) async {
    // Prepare seller form data
    final sellerData = {
      'inspectionResponse': _sellerInspectionResponse,
      'handoverLocation': _getSellerFullAddress(),
      'handoverRegion': _sellerHandoverRegion,
      'handoverProvince': _sellerHandoverProvince,
      'handoverCity': _sellerHandoverCity,
      'handoverBarangay': _sellerHandoverBarangay,
      'handoverLandmark': _sellerHandoverLandmark,
      'deliveryDate': _sellerDeliveryDate?.toIso8601String(),
      'deliveryDelayClause': _deliveryDelayClauseController.text,
      'paymentMethod': _sellerPaymentMethod,
      'otherPaymentMethod': _sellerPaymentMethod == 'others'
          ? _otherPaymentMethodController.text
          : null,
      'notes': _sellerNotesController.text,
      'dataPrivacyConsent': _dataPrivacyConsentSeller,
      'legalAcknowledgment': _legalAcknowledgmentSeller,
      'submittedAt': DateTime.now().toIso8601String(),
    };

    // TODO: Backend integration
    // await provider.submitSellerAgreement(sellerData);
    // await BackendService.storeSellerAgreement(widget.auctionId, sellerData);

    debugPrint('✓ Seller Agreement Submitted');
    debugPrint('  Data: ${jsonEncode(sellerData)}');

    // Simulate backend delay
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // =============================================================================
  // DEPRECATED SUBMISSION METHOD (OLD CODE - NO LONGER USED)
  // =============================================================================

  /*
  Future<void> _submitConfirmation(PreTransactionProvider provider) async {
    // DEPRECATED: This method is no longer needed - replaced by _submitAgreementForm
    if (widget.isSeller) {
      // Handle seller confirmation
      final formData = _sellerFormKey.currentState?.getFormData();
      if (formData == null) return;

      final success = await provider.submitSellerConfirmation(
        sellerId: 'seller456',
        sellerName: 'Pedro Santos',
        formData: formData, // Pass complete form data
      );

      if (!mounted) return;

      if (success) {
        setState(() {
          _isFormDeactivated = true; // Deactivate form (always lock after submit)
          _isEditingForm = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✓ Seller confirmation submitted!'),
            backgroundColor: ColorConstants.primaryGreen,
          ),
        );

        // Mock: Buyer submits their form after 3 seconds
        Future.delayed(const Duration(seconds: 3), () async {
          if (mounted) {
            // Mock buyer form data
            final mockBuyerFormData = {
              'finalBidPrice': widget.winningBid,
              'additionalFees': 5000.0,
              'priceAndFeesConfirmed': true,
              'paymentDuration': 3,
              'paymentDurationUnit': 'days',
              'latePaymentPenaltiesAcknowledged': true,
              'shippingMethod': 'Transporter',
              'shippingCostResponsibility': 'Buyer',
              'deliveryLocation': 'Manila City',
              'insuranceResponsibility': 'Buyer',
              'estimatedDeliveryDays': 7,
              'inspectionDuration': 2,
              'inspectionDurationUnit': 'days',
              'inspectionMethod': 'In-person',
              'acceptanceCriteria': 'Check all mechanical parts',
              'discrepancyProcedure': 'Contact seller immediately',
              'buyerConfirmationLimit': 1,
              'buyerConfirmationLimitUnit': 'days',
              'titleRegistrationAcknowledged': true,
              'noLiensAcknowledged': true,
              'transferProcessAcknowledged': true,
              'discussionsLoggedConfirmed': true,
              'disputeResolutionAgreed': true,
              'fraudPoliciesAcknowledged': true,
              'additionalProtections': '',
              'platformTermsAgreed': true,
              'vehicleIdentityConfirmed': true,
              'deliveryDate': DateTime.now().add(const Duration(days: 7)).toString(),
              'uploadedDocuments': [],
              'termsAgreed': true,
              'notes': '',
            };

            await provider.submitBuyerConfirmation(
              buyerId: 'user123',
              buyerName: 'Juan Dela Cruz',
              formData: mockBuyerFormData,
            );

            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Buyer has submitted their form!'),
                  backgroundColor: Colors.blue,
                ),
              );
            }
          }
        });

        // Schedule mock edit request from buyer after 5 seconds
        _editRequestTimer?.cancel();
        _editRequestTimer = Timer(const Duration(seconds: 5), () {
          if (mounted) {
            _showMockEditRequestDialog();
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.error ?? 'Failed to submit confirmation'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // Get buyer form data
    final formData = _buyerFormKey.currentState?.getFormData();
    if (formData == null) return;

    final success = await provider.submitBuyerConfirmation(
      buyerId: 'user123',
      buyerName: 'Juan Dela Cruz',
      formData: formData, // Pass complete form data
    );

    if (!mounted) return;

    if (success) {
      setState(() {
        _isFormDeactivated = true; // Deactivate form
        _isEditingForm = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Buyer confirmation submitted!'),
          backgroundColor: ColorConstants.primaryGreen,
        ),
      );

      // Mock: Seller submits their form after 3 seconds
      Future.delayed(const Duration(seconds: 3), () async {
        if (mounted) {
          // Mock seller form data
          final mockSellerFormData = {
            'vehicleMatchesListing': true,
            'allIssuesDisclosed': true,
            'conditionAccuratelyRepresented': true,
            'conditionDocuments': [],
            'ownershipDocuments': [],
            'noOutstandingLiens': true,
            'specialTransferInstructions': '',
            'shippingMethod': 'Transporter',
            'deliveryLocation': 'Quezon City',
            'deliveryInstructions': '',
            'shippingEvidenceDocuments': [],
            'agreeToSubmitShippingEvidence': true,
            'insuranceResponsibilityAcknowledged': true,
            'availability': 'Weekdays 9-5',
            'inspectionMethod': 'In-person',
            'willReviewInspectionEvidence': true,
            'inspectionNotes': '',
            'disputeResolutionAgreed': true,
            'fraudPoliciesAcknowledged': true,
            'sellerProtections': '',
            'informationAccuracyConfirmed': true,
            'platformTermsAgreed': true,
            'vehicleIdentityConfirmed': true,
            'handoverDate': DateTime.now().add(const Duration(days: 7)).toString(),
            'handoverLocation': 'Quezon City',
            'uploadedDocuments': [],
            'termsAgreed': true,
            'notes': '',
          };

          await provider.submitSellerConfirmation(
            sellerId: 'seller456',
            sellerName: 'Pedro Santos',
            formData: mockSellerFormData,
          );

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Seller has submitted their form!'),
                backgroundColor: Colors.blue,
              ),
            );
          }
        }
      });

      // Schedule mock edit request from seller after 5 seconds
      _editRequestTimer?.cancel();
      _editRequestTimer = Timer(const Duration(seconds: 5), () {
        if (mounted) {
          _showMockEditRequestDialog();
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? 'Failed to submit confirmation'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  */

  Widget _buildProgressTab(PreTransaction preTransaction) {
    // Check if we're in checkpoint flow (post-admin approval)
    final isInCheckpointFlow = preTransaction.status == PreTransactionStatus.preparing ||
        preTransaction.status == PreTransactionStatus.shipping ||
        preTransaction.status == PreTransactionStatus.delivered ||
        preTransaction.status == PreTransactionStatus.paymentSuccess ||
        preTransaction.status == PreTransactionStatus.transactionComplete;

    if (isInCheckpointFlow) {
      // Show checkpoint-specific UI
      return _buildCheckpointFlowUI(preTransaction);
    }

    // Original pre-transaction flow UI
    final otherPartyConfirmation = widget.isSeller
        ? preTransaction.buyerConfirmation
        : preTransaction.sellerConfirmation;
    final showConfirmationBanner = otherPartyConfirmation != null &&
                                    (!_hasConfirmedOtherParty || !_otherPartyConfirmedMe);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Show confirmation banner based on mutual confirmation state
          if (showConfirmationBanner)
            _buildConfirmationBanner(preTransaction),
          // else if (preTransaction.status == PreTransactionStatus.pendingMutualConfirmation)
          //   _buildCombinedReviewBanner(preTransaction),
          if (showConfirmationBanner || preTransaction.status == PreTransactionStatus.pendingMutualConfirmation)
            const SizedBox(height: 16),

          PreTransactionProgressTracker(
            currentStatus: preTransaction.status,
            isSeller: widget.isSeller,
          ),
          const SizedBox(height: 24),
          _buildProgressTimeline(preTransaction),
          const SizedBox(height: 24),
          _buildTransactionDetails(preTransaction),
        ],
      ),
    );
  }

  Widget _buildCheckpointFlowUI(PreTransaction preTransaction) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PreTransactionProgressTracker(
            currentStatus: preTransaction.status,
            isSeller: widget.isSeller,
          ),
          const SizedBox(height: 24),
          // Show seller checkpoint controls or buyer view-only
          widget.isSeller
              ? _buildSellerCheckpointControls(preTransaction)
              : _buildBuyerCheckpointView(preTransaction),
          const SizedBox(height: 24),
          // Show rating UI if transaction complete
          if (preTransaction.status == PreTransactionStatus.transactionComplete)
            _buildRatingSection(preTransaction),
          const SizedBox(height: 24),
          _buildTransactionDetails(preTransaction),
        ],
      ),
    );
  }

  Widget _buildSellerCheckpointControls(PreTransaction preTransaction) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.update, color: ColorConstants.primaryGreen),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Update Transaction Progress',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Manually update the transaction status as you progress through each checkpoint.',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 24),
            // Checkpoint buttons (preparing is auto-set after admin approval)
            _buildCheckpointButton(
              title: 'Item Shipped',
              subtitle: 'Mark item as shipped to buyer',
              icon: Icons.local_shipping,
              color: Colors.blue,
              isEnabled: preTransaction.status == PreTransactionStatus.preparing,
              currentStatus: PreTransactionStatus.shipping,
              onPressed: () => _updateCheckpointStatus(PreTransactionStatus.shipping),
            ),
            const SizedBox(height: 12),
            _buildCheckpointButton(
              title: 'Item Delivered',
              subtitle: 'Confirm item has been delivered',
              icon: Icons.check_circle,
              color: Colors.purple,
              isEnabled: preTransaction.status == PreTransactionStatus.shipping,
              currentStatus: PreTransactionStatus.delivered,
              onPressed: () => _updateCheckpointStatus(PreTransactionStatus.delivered),
            ),
            const SizedBox(height: 12),
            _buildCheckpointButton(
              title: 'Payment Received',
              subtitle: 'Confirm payment has been received',
              icon: Icons.payments,
              color: ColorConstants.primaryGreen,
              isEnabled: preTransaction.status == PreTransactionStatus.delivered,
              currentStatus: PreTransactionStatus.paymentSuccess,
              onPressed: () => _updateCheckpointStatus(PreTransactionStatus.paymentSuccess),
            ),
            const SizedBox(height: 12),
            _buildCheckpointButton(
              title: 'Complete Transaction',
              subtitle: 'Finalize and complete the transaction',
              icon: Icons.done_all,
              color: ColorConstants.primaryGreen,
              isEnabled: preTransaction.status == PreTransactionStatus.paymentSuccess,
              currentStatus: PreTransactionStatus.transactionComplete,
              onPressed: () => _updateCheckpointStatus(PreTransactionStatus.transactionComplete),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckpointButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isEnabled,
    required PreTransactionStatus currentStatus,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isEnabled ? color.withOpacity(0.5) : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: isEnabled ? color : Colors.grey),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isEnabled ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
          ),
          child: const Text('Update'),
        ),
      ),
    );
  }

  Future<void> _updateCheckpointStatus(PreTransactionStatus newStatus) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.update, color: ColorConstants.primaryGreen),
            SizedBox(width: 12),
            Text('Confirm Status Update'),
          ],
        ),
        content: Text(
          'Are you sure you want to update the transaction status to ${_getCheckpointTitle(newStatus)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final provider = context.read<PreTransactionProvider>();
      final success = await provider.updateCheckpointStatus(newStatus: newStatus);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Status updated to ${_getCheckpointTitle(newStatus)}!'),
            backgroundColor: ColorConstants.primaryGreen,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.error ?? 'Failed to update status'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _getCheckpointTitle(PreTransactionStatus status) {
    switch (status) {
      case PreTransactionStatus.preparing:
        return 'Preparing';
      case PreTransactionStatus.shipping:
        return 'Shipping';
      case PreTransactionStatus.delivered:
        return 'Delivered';
      case PreTransactionStatus.paymentSuccess:
        return 'Payment Success';
      case PreTransactionStatus.transactionComplete:
        return 'Transaction Complete';
      default:
        return 'Unknown';
    }
  }

  Widget _buildBuyerCheckpointView(PreTransaction preTransaction) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.visibility, color: Colors.blue),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Transaction Progress',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Track the seller\'s progress as they prepare and ship your item.',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 24),
            // Show current status info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(_getCheckpointIcon(preTransaction.status), color: Colors.blue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _getCheckpointTitle(preTransaction.status),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getBuyerCheckpointDescription(preTransaction.status),
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Timeline of completed checkpoints
            _buildCheckpointTimeline(preTransaction),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckpointTimeline(PreTransaction preTransaction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Checkpoint History',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (preTransaction.preparingStartedAt != null)
          _buildTimelineItem(
            'Preparing Started',
            preTransaction.preparingStartedAt!,
            Icons.inventory_2,
            true,
          ),
        if (preTransaction.shippingStartedAt != null)
          _buildTimelineItem(
            'Shipping Started',
            preTransaction.shippingStartedAt!,
            Icons.local_shipping,
            true,
          ),
        if (preTransaction.deliveredAt != null)
          _buildTimelineItem(
            'Delivered',
            preTransaction.deliveredAt!,
            Icons.check_circle,
            true,
          ),
        if (preTransaction.paymentSuccessAt != null)
          _buildTimelineItem(
            'Payment Received',
            preTransaction.paymentSuccessAt!,
            Icons.payments,
            true,
          ),
        if (preTransaction.transactionCompletedAt != null)
          _buildTimelineItem(
            'Transaction Complete',
            preTransaction.transactionCompletedAt!,
            Icons.done_all,
            true,
          ),
      ],
    );
  }

  IconData _getCheckpointIcon(PreTransactionStatus status) {
    switch (status) {
      case PreTransactionStatus.preparing:
        return Icons.inventory_2;
      case PreTransactionStatus.shipping:
        return Icons.local_shipping;
      case PreTransactionStatus.delivered:
        return Icons.check_circle;
      case PreTransactionStatus.paymentSuccess:
        return Icons.payments;
      case PreTransactionStatus.transactionComplete:
        return Icons.done_all;
      default:
        return Icons.info;
    }
  }

  String _getBuyerCheckpointDescription(PreTransactionStatus status) {
    switch (status) {
      case PreTransactionStatus.preparing:
        return 'Seller is preparing your item for shipment. You will be notified when it ships.';
      case PreTransactionStatus.shipping:
        return 'Your item is on its way! Track your shipment and expect delivery soon.';
      case PreTransactionStatus.delivered:
        return 'Item has been delivered! Please confirm receipt and proceed with payment.';
      case PreTransactionStatus.paymentSuccess:
        return 'Payment successful! Transaction is being finalized.';
      case PreTransactionStatus.transactionComplete:
        return 'Transaction complete! Please rate your experience with the seller.';
      default:
        return 'Transaction in progress...';
    }
  }

  Widget _buildRatingSection(PreTransaction preTransaction) {
    return Column(
      children: [
        // Show deposit refund for buyer
        if (!widget.isSeller)
          Card(
            elevation: 2,
            color: ColorConstants.primaryGreen.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Deposit Refunded!',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Your bidding deposit has been returned to your account',
                              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ColorConstants.primaryGreen.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Refund Amount',
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '₱1,000.00',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.primaryGreen,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryGreen,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Processed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Deposit returned after transaction completion',
                          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        if (!widget.isSeller) const SizedBox(height: 16),

        // Rating card
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Rate Your ${widget.isSeller ? 'Buyer' : 'Seller'}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Help others by sharing your experience with this ${widget.isSeller ? 'buyer' : 'seller'}.',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showRatingDialog(),
                    icon: const Icon(Icons.rate_review),
                    label: const Text('Leave a Review'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showRatingDialog() async {
    int rating = 0;
    final commentController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Rate ${widget.isSeller ? 'Buyer' : 'Seller'}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          rating = index + 1;
                        });
                      },
                      icon: Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 32,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                    labelText: 'Your Review (Optional)',
                    hintText: 'Share your experience...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: rating > 0
                  ? () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Thank you for your review!'),
                          backgroundColor: ColorConstants.primaryGreen,
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );

    commentController.dispose();
  }

  Widget _buildConfirmationBanner(PreTransaction preTransaction) {
    final otherPartyName = widget.isSeller ? 'Buyer' : 'Seller';

    // If user hasn't confirmed other party yet
    if (!_hasConfirmedOtherParty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorConstants.primaryGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorConstants.primaryGreen.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.rate_review, color: ColorConstants.primaryGreen),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '$otherPartyName Confirmation Ready',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'The $otherPartyName has submitted their confirmation. Please review it in the "$otherPartyName Form" tab and accept to proceed.',
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _tabController.animateTo(2), // Go to Other Party Form tab
                icon: const Icon(Icons.visibility),
                label: Text('Review $otherPartyName Form'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryGreen,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // If user confirmed but other party hasn't confirmed back
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
              const Icon(Icons.hourglass_empty, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Waiting for $otherPartyName Confirmation',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'You have accepted the $otherPartyName\'s confirmation. Waiting for them to confirm your form before proceeding to admin review.',
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
          const SizedBox(height: 12),
          const LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 8),
          Text(
            'This usually takes a few moments...',
            style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  // Widget _buildCombinedReviewBanner(PreTransaction preTransaction) {
  //   final hasUserApproved = widget.isSeller
  //       ? preTransaction.sellerMutualReviewApproved
  //       : preTransaction.buyerMutualReviewApproved;

  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: hasUserApproved
  //           ? Colors.orange.withOpacity(0.1)
  //           : ColorConstants.primaryGreen.withOpacity(0.1),
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(
  //         color: hasUserApproved
  //             ? Colors.orange.withOpacity(0.3)
  //             : ColorConstants.primaryGreen.withOpacity(0.3),
  //       ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Icon(
  //               hasUserApproved ? Icons.hourglass_empty : Icons.info,
  //               color: hasUserApproved ? Colors.orange : ColorConstants.primaryGreen,
  //             ),
  //             const SizedBox(width: 12),
  //             Expanded(
  //               child: Text(
  //                 hasUserApproved
  //                     ? 'Waiting for ${widget.isSeller ? 'Buyer' : 'Seller'}'
  //                     : 'Combined Review Required',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                   color: hasUserApproved ? Colors.orange : ColorConstants.primaryGreen,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           hasUserApproved
  //               ? 'You have approved the combined details. Waiting for the other party to review and approve.'
  //               : 'Both parties have submitted their forms. Please review the combined details and approve to proceed to admin review.',
  //           style: TextStyle(fontSize: 13, color: Colors.grey[700]),
  //         ),
  //         const SizedBox(height: 12),
  //         SizedBox(
  //           width: double.infinity,
  //           child: ElevatedButton.icon(
  //             onPressed: () {
  //               // Navigate to combined review screen
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => CombinedReviewScreen(
  //                     preTransactionId: preTransaction.id,
  //                     isSeller: widget.isSeller,
  //                   ),
  //                 ),
  //               );
  //             },
  //             icon: const Icon(Icons.visibility),
  //             label: const Text('Go to Combined Review'),
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: hasUserApproved ? Colors.orange : ColorConstants.primaryGreen,
  //               foregroundColor: Colors.white,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildFormHeader(PreTransaction preTransaction) {
    final isAlreadySubmitted = widget.isSeller
        ? preTransaction.sellerConfirmation != null
        : preTransaction.buyerConfirmation != null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isAlreadySubmitted
            ? Colors.green.withOpacity(0.1)
            : ColorConstants.primaryGreen.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: isAlreadySubmitted
                ? Colors.green.withOpacity(0.3)
                : ColorConstants.primaryGreen.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isAlreadySubmitted ? Icons.check_circle : Icons.assignment,
            color: isAlreadySubmitted ? Colors.green : ColorConstants.primaryGreen,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAlreadySubmitted
                      ? '${widget.isSeller ? 'Seller' : 'Buyer'} Confirmation Submitted'
                      : '${widget.isSeller ? 'Seller' : 'Buyer'} Confirmation Form',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isAlreadySubmitted
                      ? 'Your confirmation has been submitted. View details below.'
                      : 'Fill out the form below. Your progress is auto-saved.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildConfirmationItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: ColorConstants.primaryGreen),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTimeline(PreTransaction preTransaction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Timeline',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildTimelineItem(
          'Transaction Created',
          preTransaction.createdAt,
          Icons.start,
          true,
        ),
        if (preTransaction.discussionStartedAt != null)
          _buildTimelineItem(
            'Discussion Started',
            preTransaction.discussionStartedAt!,
            Icons.chat,
            true,
          ),
        if (preTransaction.buyerConfirmedAt != null)
          _buildTimelineItem(
            'Buyer Confirmed',
            preTransaction.buyerConfirmedAt!,
            Icons.check_circle,
            true,
          ),
        if (preTransaction.sellerConfirmedAt != null)
          _buildTimelineItem(
            'Seller Confirmed',
            preTransaction.sellerConfirmedAt!,
            Icons.check_circle,
            true,
          ),
        if (preTransaction.mutualConfirmationAt != null)
          _buildTimelineItem(
            'Mutual Confirmation',
            preTransaction.mutualConfirmationAt!,
            Icons.handshake,
            true,
          ),
        if (preTransaction.adminReviewStartedAt != null)
          _buildTimelineItem(
            'Admin Review Started',
            preTransaction.adminReviewStartedAt!,
            Icons.admin_panel_settings,
            true,
          ),
        if (preTransaction.adminReviewCompletedAt != null)
          _buildTimelineItem(
            'Admin Review Completed',
            preTransaction.adminReviewCompletedAt!,
            Icons.verified,
            true,
          ),
        if (preTransaction.readyForPaymentAt != null)
          _buildTimelineItem(
            'Ready for Payment',
            preTransaction.readyForPaymentAt!,
            Icons.payment,
            true,
          ),
      ],
    );
  }

  Widget _buildTimelineItem(String title, DateTime timestamp, IconData icon, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted
                  ? ColorConstants.primaryGreen
                  : Colors.grey[300],
            ),
            child: Icon(icon, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  DateFormat('MMM dd, yyyy h:mm a').format(timestamp),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(PreTransaction preTransaction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transaction Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildDetailItem('Vehicle', preTransaction.carTitle),
        _buildDetailItem('Buyer', preTransaction.buyerName),
        _buildDetailItem('Seller', preTransaction.sellerName),
        _buildDetailItem('Final Bid', '₱${_formatCurrency(preTransaction.finalBidAmount)}'),
        _buildDetailItem('Status', _getStatusLabel(preTransaction.status)),
        if (preTransaction.adminReviewNotes != null)
          _buildDetailItem('Admin Notes', preTransaction.adminReviewNotes!),
        if (preTransaction.cancellationReason != null)
          _buildDetailItem('Cancellation Reason', preTransaction.cancellationReason!),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String _getStatusLabel(PreTransactionStatus status) {
    switch (status) {
      case PreTransactionStatus.inDiscussion:
        return 'In Discussion';
      case PreTransactionStatus.pendingBuyerConfirmation:
        return 'Pending Buyer Confirmation';
      case PreTransactionStatus.pendingSellerConfirmation:
        return 'Pending Seller Confirmation';
      case PreTransactionStatus.pendingAdminReview:
        return 'Pending Admin Review';
      case PreTransactionStatus.adminApproved:
        return 'Admin Approved';
      case PreTransactionStatus.readyForPayment:
        return 'Ready for Payment';
      case PreTransactionStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  // ===== EXISTING WIDGET BUILDERS =====

  Widget _buildHeader(double finalBid) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstants.primaryGreen.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.info, color: ColorConstants.primaryGreen),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Buyer-Seller Discussion',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Final Bid: ₱${_formatCurrency(finalBid)} • Discuss delivery & confirm details',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(List<PreTransactionMessage> messages) {
    if (messages.isEmpty) {
      return const Center(child: Text('No messages yet'));
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(PreTransactionMessage message) {
    final isSystem = message.sender == MessageSender.system;
    // Determine if this message is from the current user
    final isCurrentUser = widget.isSeller
        ? message.sender == MessageSender.seller
        : message.sender == MessageSender.buyer;
    final timeFormat = DateFormat('MMM d, h:mm a');

    if (isSystem) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              message.content,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isCurrentUser
                    ? ColorConstants.primaryGreen
                    : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isCurrentUser ? 16 : 4),
                  bottomRight: Radius.circular(isCurrentUser ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.senderName,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isCurrentUser ? Colors.white70 : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.content,
                    style: TextStyle(
                      fontSize: 14,
                      color: isCurrentUser ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                timeFormat.format(message.timestamp),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('File attachment simulated (demo only)'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            color: ColorConstants.primaryGreen,
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }


  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discussion Phase'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('This is your opportunity to:'),
            SizedBox(height: 12),
            Text('• Discuss delivery arrangements'),
            Text('• Clarify vehicle condition'),
            Text('• Agree on payment method'),
            Text('• Address any questions'),
            SizedBox(height: 12),
            Text('Once ready, proceed to confirmation.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
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

// Form Screen
class _TransactionDetailsFormScreen extends StatefulWidget {
  final bool vehicleDetailsConfirmed;
  final DateTime? selectedDeliveryDate;
  final TextEditingController deliveryLocationController;
  final TextEditingController notesController;
  final bool termsAgreed;
  final List<String> uploadedDocuments;
  final Function(bool) onVehicleDetailsChanged;
  final Function(DateTime) onDeliveryDateChanged;
  final Function(bool) onTermsChanged;
  final Function(String) onDocumentAdded;
  final Function(int) onDocumentRemoved;
  final VoidCallback onReviewPressed;

  const _TransactionDetailsFormScreen({
    required this.vehicleDetailsConfirmed,
    required this.selectedDeliveryDate,
    required this.deliveryLocationController,
    required this.notesController,
    required this.termsAgreed,
    required this.uploadedDocuments,
    required this.onVehicleDetailsChanged,
    required this.onDeliveryDateChanged,
    required this.onTermsChanged,
    required this.onDocumentAdded,
    required this.onDocumentRemoved,
    required this.onReviewPressed,
  });

  @override
  State<_TransactionDetailsFormScreen> createState() => _TransactionDetailsFormScreenState();
}

class _TransactionDetailsFormScreenState extends State<_TransactionDetailsFormScreen> {
  final _picker = ImagePicker();

  Future<void> _selectDeliveryDate() async {
    final now = DateTime.now();
    final firstDate = now.add(const Duration(days: 1));
    final lastDate = now.add(const Duration(days: 60));

    final picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDeliveryDate ?? firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      widget.onDeliveryDateChanged(picked);
    }
  }

  Future<void> _pickDocument() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null) {
      widget.onDocumentAdded(image.path);
    }
  }

  bool _canProceedToReview() {
    return widget.vehicleDetailsConfirmed &&
        widget.selectedDeliveryDate != null &&
        widget.deliveryLocationController.text.isNotEmpty &&
        widget.termsAgreed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fill Out Transaction Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Please provide the details for this transaction',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            // Vehicle Confirmation
            CheckboxListTile(
              value: widget.vehicleDetailsConfirmed,
              onChanged: (value) => widget.onVehicleDetailsChanged(value ?? false),
              title: const Text('I confirm the vehicle details as discussed'),
              subtitle: const Text(
                'I have reviewed the vehicle condition and specs',
                style: TextStyle(fontSize: 12),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 16),

            // Delivery Date
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Delivery Date'),
              subtitle: Text(
                widget.selectedDeliveryDate != null
                    ? DateFormat('MMMM dd, yyyy').format(widget.selectedDeliveryDate!)
                    : 'Select delivery date',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _selectDeliveryDate,
              tileColor: Colors.grey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 16),

            // Delivery Location
            TextFormField(
              controller: widget.deliveryLocationController,
              decoration: const InputDecoration(
                labelText: 'Delivery Location',
                hintText: 'Enter complete address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            // Upload Documents
            OutlinedButton.icon(
              onPressed: _pickDocument,
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload ID / Proof of Address (Optional)'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            if (widget.uploadedDocuments.isNotEmpty) ...[
              const SizedBox(height: 12),
              ...(widget.uploadedDocuments.map((doc) {
                final index = widget.uploadedDocuments.indexOf(doc);
                return ListTile(
                  leading: const Icon(Icons.insert_drive_file, color: ColorConstants.primaryGreen),
                  title: Text('Document ${index + 1}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => widget.onDocumentRemoved(index),
                  ),
                  tileColor: Colors.grey[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }).toList()),
            ],
            const SizedBox(height: 16),

            // Notes
            TextFormField(
              controller: widget.notesController,
              decoration: const InputDecoration(
                labelText: 'Additional Notes (Optional)',
                hintText: 'Any special instructions...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Terms
            CheckboxListTile(
              value: widget.termsAgreed,
              onChanged: (value) => widget.onTermsChanged(value ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                'I agree to the platform terms and conditions',
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 24),

            // Review Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _canProceedToReview() ? widget.onReviewPressed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryGreen,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Review Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// Review Screen
class _TransactionDetailsReviewScreen extends StatelessWidget {
  final bool vehicleDetailsConfirmed;
  final DateTime? selectedDeliveryDate;
  final String deliveryLocation;
  final String notes;
  final List<String> uploadedDocuments;
  final VoidCallback onBack;
  final VoidCallback onConfirm;

  const _TransactionDetailsReviewScreen({
    required this.vehicleDetailsConfirmed,
    required this.selectedDeliveryDate,
    required this.deliveryLocation,
    required this.notes,
    required this.uploadedDocuments,
    required this.onBack,
    required this.onConfirm,
  });

  Widget _buildReviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review & Confirm'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: Consumer<PreTransactionProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Review Transaction Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please review the information before confirming',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),

                _buildReviewItem(
                  'Vehicle Details',
                  vehicleDetailsConfirmed ? 'Confirmed' : 'Not confirmed',
                ),
                _buildReviewItem(
                  'Delivery Date',
                  selectedDeliveryDate != null
                      ? DateFormat('MMMM dd, yyyy').format(selectedDeliveryDate!)
                      : 'Not set',
                ),
                _buildReviewItem(
                  'Delivery Location',
                  deliveryLocation.isEmpty ? 'Not set' : deliveryLocation,
                ),
                _buildReviewItem(
                  'Documents Uploaded',
                  '${uploadedDocuments.length} file(s)',
                ),
                if (notes.isNotEmpty) _buildReviewItem('Notes', notes),

                const SizedBox(height: 24),

                // Confirm Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primaryGreen,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      provider.isLoading ? 'Submitting...' : 'Confirm & Submit',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
}
