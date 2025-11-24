import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/constants/auction_durations.dart';

class AuctionSettings {
  final double startingPrice;
  final double reservePrice;
  final int durationDays;
  final double? buyNowPrice;

  AuctionSettings({
    required this.startingPrice,
    required this.reservePrice,
    required this.durationDays,
    this.buyNowPrice,
  });
}

class AuctionSettingsDialog extends StatefulWidget {
  final AuctionSettings? initialSettings;
  final double? suggestedPrice;

  const AuctionSettingsDialog({
    super.key,
    this.initialSettings,
    this.suggestedPrice,
  });

  @override
  State<AuctionSettingsDialog> createState() => _AuctionSettingsDialogState();
}

class _AuctionSettingsDialogState extends State<AuctionSettingsDialog> {
  final _startingPriceController = TextEditingController();
  final _reservePriceController = TextEditingController();
  final _buyNowPriceController = TextEditingController();

  int _selectedDuration = AuctionDurations.threeDays;
  bool _hasBuyNow = false;
  String? _error;

  @override
  void initState() {
    super.initState();

    if (widget.initialSettings != null) {
      _startingPriceController.text = widget.initialSettings!.startingPrice.toStringAsFixed(0);
      _reservePriceController.text = widget.initialSettings!.reservePrice.toStringAsFixed(0);
      _selectedDuration = widget.initialSettings!.durationDays;
      if (widget.initialSettings!.buyNowPrice != null) {
        _hasBuyNow = true;
        _buyNowPriceController.text = widget.initialSettings!.buyNowPrice!.toStringAsFixed(0);
      }
    } else if (widget.suggestedPrice != null) {
      final suggested = widget.suggestedPrice!;
      _startingPriceController.text = (suggested * 0.7).toStringAsFixed(0);
      _reservePriceController.text = (suggested * 0.9).toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _startingPriceController.dispose();
    _reservePriceController.dispose();
    _buyNowPriceController.dispose();
    super.dispose();
  }

  void _save() {
    final startingPrice = double.tryParse(_startingPriceController.text.replaceAll(',', ''));
    final reservePrice = double.tryParse(_reservePriceController.text.replaceAll(',', ''));
    final buyNowPrice = _hasBuyNow
        ? double.tryParse(_buyNowPriceController.text.replaceAll(',', ''))
        : null;

    if (startingPrice == null || reservePrice == null) {
      setState(() => _error = 'Please enter valid prices');
      return;
    }

    if (startingPrice >= reservePrice) {
      setState(() => _error = 'Reserve price must be higher than starting price');
      return;
    }

    if (_hasBuyNow && (buyNowPrice == null || buyNowPrice <= reservePrice)) {
      setState(() => _error = 'Buy now price must be higher than reserve price');
      return;
    }

    final settings = AuctionSettings(
      startingPrice: startingPrice,
      reservePrice: reservePrice,
      durationDays: _selectedDuration,
      buyNowPrice: buyNowPrice,
    );

    Navigator.of(context).pop(settings);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.gavel, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Auction Settings',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              if (_error != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _error!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              Text(
                'Starting Price',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _startingPriceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  prefixText: '₱ ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  helperText: 'Minimum bid to start the auction',
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Reserve Price',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _reservePriceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  prefixText: '₱ ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  helperText: 'Minimum price you\'re willing to accept',
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Auction Duration',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: AuctionDurations.availableDurations.map((days) {
                  final isSelected = _selectedDuration == days;
                  return ChoiceChip(
                    label: Text(AuctionDurations.getDurationLabel(days)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedDuration = days);
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              SwitchListTile(
                title: Text(
                  'Buy Now Option',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text('Allow buyers to purchase immediately', style: TextStyle(fontSize: 12)),
                value: _hasBuyNow,
                onChanged: (value) {
                  setState(() => _hasBuyNow = value);
                },
                contentPadding: EdgeInsets.zero,
              ),

              if (_hasBuyNow) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _buyNowPriceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: 'Buy Now Price',
                    prefixText: '₱ ',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    helperText: 'Price for instant purchase',
                  ),
                ),
              ],

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
                    onPressed: _save,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
