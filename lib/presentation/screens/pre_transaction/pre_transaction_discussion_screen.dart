import 'dart:async';
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
import 'embedded_buyer_form.dart';
import 'embedded_seller_form.dart';
import 'combined_review_screen.dart';

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
  final _deliveryLocationController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isInitialized = false;
  bool _vehicleDetailsConfirmed = false;
  DateTime? _selectedDeliveryDate;
  bool _termsAgreed = false;
  final List<String> _uploadedDocuments = [];

  // Tab controller for 4 tabs: Chat, Form, Other Party Form, Progress
  late TabController _tabController;
  int _currentTabIndex = 0;

  // Form state keys for buyer/seller forms
  final GlobalKey<EmbeddedBuyerFormState> _buyerFormKey = GlobalKey<EmbeddedBuyerFormState>();
  final GlobalKey<EmbeddedSellerFormState> _sellerFormKey = GlobalKey<EmbeddedSellerFormState>();
  DateTime? _lastAutoSave;

  // Editing state
  bool _isEditingForm = false;

  // Mock update timer for other party form
  Timer? _mockUpdateTimer;
  int _mockUpdateCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_onTabChanged);
    _initializePreTransaction();
    _startMockUpdateTimer();
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
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    _deliveryLocationController.dispose();
    _notesController.dispose();
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
    final confirmation = widget.isSeller
        ? preTransaction.sellerConfirmation
        : preTransaction.buyerConfirmation;

    // If already submitted and not editing, show confirmation details
    if (!_isEditingForm && confirmation != null) {
      return Column(
        children: [
          _buildFormHeader(preTransaction),
          Expanded(
            child: _buildSubmittedConfirmationView(confirmation),
          ),
        ],
      );
    }

    // Show embedded form with submit button (with initial data if editing)
    Map<String, dynamic>? initialData;
    if (_isEditingForm && confirmation != null) {
      initialData = _getFormDataFromConfirmation(confirmation);
    }

    return Column(
      children: [
        _buildFormHeader(preTransaction),
        Expanded(
          child: widget.isSeller
              ? EmbeddedSellerForm(
                  key: _sellerFormKey,
                  finalBidAmount: widget.winningBid,
                  onFormChanged: _onFormChanged,
                  initialData: initialData,
                )
              : EmbeddedBuyerForm(
                  key: _buyerFormKey,
                  finalBidAmount: widget.winningBid,
                  onFormChanged: _onFormChanged,
                  initialData: initialData,
                ),
        ),
        _buildFormSubmitButton(preTransaction),
      ],
    );
  }

  Map<String, dynamic> _getFormDataFromConfirmation(PreTransactionConfirmation confirmation) {
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

  Widget _buildOtherPartyFormTab(PreTransaction preTransaction) {
    final otherPartyConfirmation = widget.isSeller
        ? preTransaction.buyerConfirmation
        : preTransaction.sellerConfirmation;

    if (otherPartyConfirmation == null) {
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
              'The ${widget.isSeller ? 'buyer' : 'seller'} hasn\'t submitted their confirmation yet.',
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
              children: [
                _buildComparisonCard(
                  '$otherPartyName Confirmation',
                  otherPartyConfirmation,
                  icon,
                  color,
                ),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.isSeller ? 'Buyer\'s' : 'Seller\'s'} confirmation accepted!'),
          backgroundColor: ColorConstants.primaryGreen,
        ),
      );
    }
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
                Navigator.pop(context, true);
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

  Widget _buildFormSubmitButton(PreTransaction preTransaction) {
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
              final canSubmit = widget.isSeller
                  ? (_sellerFormKey.currentState?.canSubmit() ?? false)
                  : (_buyerFormKey.currentState?.canSubmit() ?? false);

              return ElevatedButton(
                onPressed: canSubmit && !provider.isLoading
                    ? () => _submitConfirmation(provider)
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
                        'Submit Confirmation',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _submitConfirmation(PreTransactionProvider provider) async {
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
          _isEditingForm = false; // Clear editing flag
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✓ Seller confirmation submitted! Waiting for buyer...'),
            backgroundColor: ColorConstants.primaryGreen,
          ),
        );
        // Switch to Progress tab to see the update
        _tabController.animateTo(2);
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
        _isEditingForm = false; // Clear editing flag
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Buyer confirmation submitted! Waiting for seller...'),
          backgroundColor: ColorConstants.primaryGreen,
        ),
      );
      // Switch to Progress tab to see the update
      _tabController.animateTo(2);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? 'Failed to submit confirmation'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildProgressTab(PreTransaction preTransaction) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Combined review notification
          if (preTransaction.status == PreTransactionStatus.pendingMutualConfirmation)
            _buildCombinedReviewBanner(preTransaction),
          if (preTransaction.status == PreTransactionStatus.pendingMutualConfirmation)
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

  Widget _buildCombinedReviewBanner(PreTransaction preTransaction) {
    final hasUserApproved = widget.isSeller
        ? preTransaction.sellerMutualReviewApproved
        : preTransaction.buyerMutualReviewApproved;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: hasUserApproved
            ? Colors.orange.withOpacity(0.1)
            : ColorConstants.primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasUserApproved
              ? Colors.orange.withOpacity(0.3)
              : ColorConstants.primaryGreen.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasUserApproved ? Icons.hourglass_empty : Icons.info,
                color: hasUserApproved ? Colors.orange : ColorConstants.primaryGreen,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  hasUserApproved
                      ? 'Waiting for ${widget.isSeller ? 'Buyer' : 'Seller'}'
                      : 'Combined Review Required',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: hasUserApproved ? Colors.orange : ColorConstants.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            hasUserApproved
                ? 'You have approved the combined details. Waiting for the other party to review and approve.'
                : 'Both parties have submitted their forms. Please review the combined details and approve to proceed to admin review.',
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigate to combined review screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CombinedReviewScreen(
                      preTransactionId: preTransaction.id,
                      isSeller: widget.isSeller,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.visibility),
              label: const Text('Go to Combined Review'),
              style: ElevatedButton.styleFrom(
                backgroundColor: hasUserApproved ? Colors.orange : ColorConstants.primaryGreen,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildSubmittedConfirmationView(PreTransactionConfirmation confirmation) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildConfirmationItem(
            'Submitted By',
            confirmation.userName,
            Icons.person,
          ),
          _buildConfirmationItem(
            'Submitted At',
            DateFormat('MMM dd, yyyy h:mm a').format(confirmation.confirmedAt),
            Icons.schedule,
          ),
          const Divider(height: 32),
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
          if (confirmation.uploadedDocuments.isNotEmpty)
            _buildConfirmationItem(
              'Uploaded Documents',
              '${confirmation.uploadedDocuments.length} file(s)',
              Icons.attach_file,
            ),
          if (confirmation.notes != null && confirmation.notes!.isNotEmpty) ...[
            const Divider(height: 32),
            const Text(
              'Additional Notes',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                confirmation.notes!,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
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
