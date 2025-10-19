import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../core/constants/bid_increments.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/utils/bid_validator.dart';
import '../../../widgets/card_payment_dialog.dart';

class BidInputWidget extends StatefulWidget {
  final Auction auction;
  final Function(double) onBidPlaced;

  const BidInputWidget({
    super.key,
    required this.auction,
    required this.onBidPlaced,
  });

  @override
  State<BidInputWidget> createState() => _BidInputWidgetState();
}

class _BidInputWidgetState extends State<BidInputWidget> {
  final _controller = TextEditingController();
  String? _error;
  double? _bidAmount;
  bool _hasPaidDeposit = false; // Track deposit payment status

  static const double depositAmount = 1000.0;
  static const double biddingFee = 500.0;
  static const double totalDepositFee = depositAmount + biddingFee; // 1500 PHP

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CardPaymentDialog(
        title: 'Bidding Deposit & Fee',
        amount: totalDepositFee,
        description: 'Deposit: ₱${_formatCurrency(depositAmount)} + Bidding Fee: ₱${_formatCurrency(biddingFee)}',
        onPaymentSuccess: () {
          setState(() {
            _hasPaidDeposit = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✓ Payment successful! You can now place bids.'),
              backgroundColor: ColorConstants.primaryGreen,
            ),
          );
        },
      ),
    );
  }

  void _updateBidAmount(String value) {
    setState(() {
      _bidAmount = double.tryParse(value.replaceAll(',', ''));
      if (_bidAmount != null) {
        _error = BidValidator.validateBid(_bidAmount!, widget.auction);
      } else {
        _error = null;
      }
    });
  }

  void _setQuickBid(double increment) {
    final amount = widget.auction.currentBid + increment;
    _controller.text = _formatCurrency(amount);
    _updateBidAmount(amount.toString());
  }

  void _placeBid() {
    if (_bidAmount == null || _error != null) return;

    widget.onBidPlaced(_bidAmount!);
    _controller.clear();
    setState(() {
      _bidAmount = null;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final minBid = BidValidator.getMinimumBid(widget.auction);

    // Show payment requirement banner if deposit not paid
    if (!_hasPaidDeposit) {
      return Card(
        color: Colors.orange.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lock, color: Colors.orange[700], size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Required to Bid',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[900],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pay deposit & bidding fee to participate in this auction',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[700],
                          ),
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
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deposit',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '₱${_formatCurrency(depositAmount)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text('+', style: TextStyle(fontSize: 18)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bidding Fee',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '₱${_formatCurrency(biddingFee)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text('=', style: TextStyle(fontSize: 18)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '₱${_formatCurrency(totalDepositFee)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _showPaymentDialog,
                  icon: const Icon(Icons.payment),
                  label: const Text(
                    'Pay to Unlock Bidding',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Deposit will be refunded if you don\'t win the auction',
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // Regular bidding interface (after payment)
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Place Your Bid',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 14, color: ColorConstants.primaryGreen),
                      const SizedBox(width: 4),
                      Text(
                        'Verified',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Minimum bid: ₱${_formatCurrency(minBid)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: 'Bid Amount',
                prefixText: '₱ ',
                errorText: _error,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: _bidAmount != null && _error == null
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : null,
              ),
              onChanged: _updateBidAmount,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: BidIncrements.quickBidIncrements.map((increment) {
                return OutlinedButton(
                  onPressed: () => _setQuickBid(increment),
                  child: Text('+₱${_formatCurrency(increment)}'),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _bidAmount != null && _error == null ? _placeBid : null,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Place Bid',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
