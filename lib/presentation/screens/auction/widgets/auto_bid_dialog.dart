import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../data/models/auto_bid_config.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../core/constants/bid_increments.dart';
import '../../../../core/utils/bid_validator.dart';

class AutoBidDialog extends StatefulWidget {
  final Auction auction;
  final AutoBidConfig? existingConfig;

  const AutoBidDialog({
    super.key,
    required this.auction,
    this.existingConfig,
  });

  @override
  State<AutoBidDialog> createState() => _AutoBidDialogState();
}

class _AutoBidDialogState extends State<AutoBidDialog> {
  final _controller = TextEditingController();
  double _increment = BidIncrements.twoThousand;
  bool _isActive = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.existingConfig != null) {
      _controller.text = widget.existingConfig!.maxBidAmount.toStringAsFixed(0);
      _increment = widget.existingConfig!.incrementAmount;
      _isActive = widget.existingConfig!.isActive;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateMaxBid(String value) {
    final maxBid = double.tryParse(value.replaceAll(',', ''));
    setState(() {
      if (maxBid != null) {
        _error = BidValidator.validateAutoBid(
          maxBid,
          widget.auction.currentBid,
          widget.auction.buyNowPrice,
        );
      } else {
        _error = null;
      }
    });
  }

  void _save() {
    final maxBid = double.tryParse(_controller.text.replaceAll(',', ''));
    if (maxBid == null || _error != null) return;

    final config = AutoBidConfig(
      maxBidAmount: maxBid,
      incrementAmount: _increment,
      isActive: _isActive,
    );

    Navigator.of(context).pop(config);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_mode, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Auto-Bid Setup',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20, color: Colors.blue[700]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Auto-bid will automatically place bids up to your maximum amount when you\'re outbid.',
                      style: TextStyle(fontSize: 12, color: Colors.blue[700]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Maximum Bid Amount',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: 'Max Amount',
                prefixText: '₱ ',
                errorText: _error,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                helperText: 'Current bid: ₱${_formatCurrency(widget.auction.currentBid)}',
              ),
              onChanged: _validateMaxBid,
            ),
            const SizedBox(height: 20),
            Text(
              'Bid Increment',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: BidIncrements.autoBidIncrements.map((amount) {
                final isSelected = _increment == amount;
                return ChoiceChip(
                  label: Text('₱${_formatCurrency(amount)}'),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _increment = amount;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: Text(
                'Enable Auto-Bid',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                _isActive ? 'Auto-bid is active' : 'Auto-bid is paused',
                style: TextStyle(fontSize: 12),
              ),
              value: _isActive,
              onChanged: (value) {
                setState(() {
                  _isActive = value;
                });
              },
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _error == null && _controller.text.isNotEmpty
                      ? _save
                      : null,
                  child: const Text('Save'),
                ),
              ],
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
