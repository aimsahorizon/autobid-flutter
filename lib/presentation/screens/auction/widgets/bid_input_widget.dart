import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../core/constants/bid_increments.dart';
import '../../../../core/utils/bid_validator.dart';

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Place Your Bid',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Minimum bid: ₱${_formatCurrency(minBid)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _bidAmount != null && _error == null ? _placeBid : null,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
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
