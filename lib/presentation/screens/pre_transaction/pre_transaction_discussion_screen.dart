import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/pre_transaction_provider.dart';
import '../../../data/models/pre_transaction_message_model.dart';
import '../../../core/constants/color_constants.dart';

class PreTransactionDiscussionScreen extends StatefulWidget {
  final String auctionId;
  final String carTitle;
  final double winningBid;

  const PreTransactionDiscussionScreen({
    super.key,
    required this.auctionId,
    required this.carTitle,
    required this.winningBid,
  });

  @override
  State<PreTransactionDiscussionScreen> createState() => _PreTransactionDiscussionScreenState();
}

class _PreTransactionDiscussionScreenState extends State<PreTransactionDiscussionScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final _deliveryLocationController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isInitialized = false;
  bool _vehicleDetailsConfirmed = false;
  DateTime? _selectedDeliveryDate;
  bool _termsAgreed = false;
  final List<String> _uploadedDocuments = [];

  @override
  void initState() {
    super.initState();
    _initializePreTransaction();
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
      sender: MessageSender.buyer,
      senderName: 'Juan Dela Cruz', // Mock buyer name
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
        title: Text('Discussion: ${widget.carTitle}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _showInfoDialog();
            },
          ),
        ],
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
                        Text(
                          'Failed to load discussion',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

                return Column(
                  children: [
                    _buildTransactionAgreementBanner(),
                    _buildHeader(preTransaction.finalBidAmount),
                    Expanded(
                      child: _buildMessageList(preTransaction.messages),
                    ),
                    _buildInputField(),
                  ],
                );
              },
            ),
    );
  }

  Widget _buildTransactionAgreementBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ColorConstants.primaryGreen.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(color: ColorConstants.primaryGreen.withOpacity(0.3)),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.assignment,
            color: ColorConstants.primaryGreen,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Ready to confirm? Fill out transaction details',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => _navigateToConfirmationForm(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Open Form',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

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
    final isBuyer = message.sender == MessageSender.buyer;
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
      alignment: isBuyer ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: isBuyer ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isBuyer
                    ? ColorConstants.primaryGreen
                    : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isBuyer ? 16 : 4),
                  bottomRight: Radius.circular(isBuyer ? 4 : 16),
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
                      color: isBuyer ? Colors.white70 : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.content,
                    style: TextStyle(
                      fontSize: 14,
                      color: isBuyer ? Colors.white : Colors.black87,
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

  void _navigateToConfirmationForm() async {
    await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => _TransactionDetailsFormScreen(
          vehicleDetailsConfirmed: _vehicleDetailsConfirmed,
          selectedDeliveryDate: _selectedDeliveryDate,
          deliveryLocationController: _deliveryLocationController,
          notesController: _notesController,
          termsAgreed: _termsAgreed,
          uploadedDocuments: _uploadedDocuments,
          onVehicleDetailsChanged: (value) => setState(() => _vehicleDetailsConfirmed = value),
          onDeliveryDateChanged: (date) => setState(() => _selectedDeliveryDate = date),
          onTermsChanged: (value) => setState(() => _termsAgreed = value),
          onDocumentAdded: (doc) => setState(() => _uploadedDocuments.add(doc)),
          onDocumentRemoved: (index) => setState(() => _uploadedDocuments.removeAt(index)),
          onReviewPressed: () => _navigateToReview(),
        ),
      ),
    );
  }

  void _navigateToReview() async {
    Navigator.pop(context); // Close form screen

    await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => _TransactionDetailsReviewScreen(
          vehicleDetailsConfirmed: _vehicleDetailsConfirmed,
          selectedDeliveryDate: _selectedDeliveryDate,
          deliveryLocation: _deliveryLocationController.text,
          notes: _notesController.text,
          uploadedDocuments: _uploadedDocuments,
          onBack: () => _navigateToConfirmationForm(),
          onConfirm: () => _submitConfirmation(context.read<PreTransactionProvider>()),
        ),
      ),
    );
  }

  Future<void> _submitConfirmation(PreTransactionProvider provider) async {
    final success = await provider.submitBuyerConfirmation(
      buyerId: 'user123',
      buyerName: 'Juan Dela Cruz',
      vehicleDetailsConfirmed: _vehicleDetailsConfirmed,
      deliveryDate: DateFormat('yyyy-MM-dd').format(_selectedDeliveryDate!),
      deliveryLocation: _deliveryLocationController.text.trim(),
      uploadedDocuments: _uploadedDocuments,
      termsAgreed: _termsAgreed,
      notes: _notesController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
      setState(() {
        _vehicleDetailsConfirmed = false;
        _selectedDeliveryDate = null;
        _deliveryLocationController.clear();
        _notesController.clear();
        _uploadedDocuments.clear();
        _termsAgreed = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Confirmation submitted! Waiting for seller...'),
          backgroundColor: ColorConstants.primaryGreen,
        ),
      );

      // Navigate to status screen
      context.pushReplacement(
        '/preTransactionStatus/${widget.auctionId}?carTitle=${Uri.encodeComponent(widget.carTitle)}&winningBid=${widget.winningBid}',
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
