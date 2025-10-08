import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/payment_methods.dart';
import '../../../data/models/transaction_model.dart';
import '../../providers/payment_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/payment/mock_payment_sheet.dart';
import 'widgets/payment_method_card.dart';
import 'widgets/payment_summary.dart';

class PaymentScreen extends StatefulWidget {
  final String auctionId;
  final String carTitle;
  final double winningBid;

  const PaymentScreen({
    super.key,
    required this.auctionId,
    required this.carTitle,
    required this.winningBid,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _referenceController = TextEditingController();
  final _picker = ImagePicker();
  bool _termsAccepted = false;

  @override
  void initState() {
    super.initState();
    _createTransaction();
  }

  @override
  void dispose() {
    _referenceController.dispose();
    super.dispose();
  }

  Future<void> _createTransaction() async {
    final provider = context.read<PaymentProvider>();
    await provider.createTransaction(
      auctionId: widget.auctionId,
      carId: 'CAR001',
      buyerId: 'user123',
      sellerId: 'seller456',
      buyerName: 'Juan Dela Cruz',
      sellerName: 'Pedro Santos',
      carTitle: widget.carTitle,
      amount: widget.winningBid,
    );
  }

  Future<void> _pickPaymentProof() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null && mounted) {
      context.read<PaymentProvider>().setPaymentProof(image);
    }
  }

  Future<void> _submitPayment() async {
    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final provider = context.read<PaymentProvider>();

    if (provider.selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a payment method'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    provider.setPaymentReference(_referenceController.text.trim());

    final success = await provider.submitPayment();

    if (!mounted) return;

    if (success && provider.currentTransaction != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Payment submitted! Funds held in escrow.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to transaction detail to track escrow status
      context.go('/transaction/${provider.currentTransaction!.id}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? 'Failed to submit payment'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _showMockPaymentSheet() async {
    final success = await MockPaymentSheet.show(
      context: context,
      amount: widget.winningBid,
      carTitle: widget.carTitle,
      merchantName: 'AutoBID',
    );

    if (success == true && mounted) {
      // Process the payment through existing escrow flow
      final provider = context.read<PaymentProvider>();

      // Set payment method to card
      provider.setSelectedPaymentMethod(PaymentMethods.card);
      provider.setPaymentReference('CARD-${DateTime.now().millisecondsSinceEpoch}');

      final escrowSuccess = await provider.submitPayment();

      if (!mounted) return;

      if (escrowSuccess) {
        final transactionId = provider.currentTransaction?.id;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Payment processed! Funds held in escrow.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to transaction detail
        if (transactionId != null) {
          context.go('/transaction/$transactionId');
        } else {
          context.go('/home');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment for ${widget.carTitle}'),
        centerTitle: true,
      ),
      body: Consumer<PaymentProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.currentTransaction == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.currentTransaction == null) {
            return const Center(child: Text('Failed to create transaction'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCarSummary(),
                const SizedBox(height: 24),
                PaymentSummary(amount: widget.winningBid),
                const SizedBox(height: 24),

                // Quick Pay with Card (New Mock Stripe-like UI)
                _buildQuickPayCard(),
                const SizedBox(height: 24),

                // Divider with "OR"
                _buildOrDivider(),
                const SizedBox(height: 24),

                // Traditional Payment Methods
                _buildPaymentMethodSection(provider),
                if (provider.selectedPaymentMethod != null &&
                    provider.selectedPaymentMethod!.type ==
                        PaymentMethodType.bankTransfer) ...[
                  const SizedBox(height: 24),
                  _buildBankDetails(),
                  const SizedBox(height: 24),
                  _buildUploadProofSection(provider),
                ],
                const SizedBox(height: 24),
                _buildReferenceField(),
                const SizedBox(height: 24),
                _buildTermsCheckbox(),
                const SizedBox(height: 24),
                CustomButton(
                  text: provider.isLoading
                      ? 'Processing...'
                      : 'Submit Payment',
                  onPressed: provider.isLoading ? null : _submitPayment,
                ),
              ],
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
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.directions_car,
              color: Colors.grey[400],
              size: 40,
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Auction Won',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.primaryGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection(PaymentProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Payment Method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...PaymentMethods.allMethods.map((method) {
          final isSelected = provider.selectedPaymentMethod?.type == method.type;
          return PaymentMethodCard(
            method: method,
            isSelected: isSelected,
            onTap: () => provider.setSelectedPaymentMethod(method),
          );
        }),
      ],
    );
  }

  Widget _buildBankDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bank Account Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 12),
          ...PaymentMethods.bankDetails.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[900],
                    ),
                  ),
                  Text(
                    'Account: ${entry.value['accountNumber']}',
                    style: TextStyle(fontSize: 13, color: Colors.blue[900]),
                  ),
                  Text(
                    'Name: ${entry.value['accountName']}',
                    style: TextStyle(fontSize: 13, color: Colors.blue[900]),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildUploadProofSection(PaymentProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Payment Proof',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _pickPaymentProof,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  provider.paymentProof != null
                      ? Icons.check_circle
                      : Icons.upload_file,
                  color: provider.paymentProof != null
                      ? ColorConstants.primaryGreen
                      : Colors.grey[400],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    provider.paymentProof != null
                        ? 'Proof uploaded'
                        : 'Tap to upload receipt or screenshot',
                    style: TextStyle(
                      color: provider.paymentProof != null
                          ? ColorConstants.primaryGreen
                          : Colors.grey[600],
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

  Widget _buildReferenceField() {
    return TextField(
      controller: _referenceController,
      decoration: const InputDecoration(
        labelText: 'Payment Reference Number',
        hintText: 'Enter reference/transaction number',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.receipt_long),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return CheckboxListTile(
      value: _termsAccepted,
      onChanged: (value) {
        setState(() {
          _termsAccepted = value ?? false;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text(
        'I agree to the Terms and Conditions and understand that my payment will be held in escrow until delivery confirmation',
        style: TextStyle(fontSize: 13),
      ),
    );
  }

  Widget _buildQuickPayCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorConstants.primaryGreen,
            ColorConstants.primaryGreen.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.primaryGreen.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _showMockPaymentSheet,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.credit_card,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Pay with Card',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Secure & instant • Powered by escrow',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.9),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[300])),
      ],
    );
  }
}
