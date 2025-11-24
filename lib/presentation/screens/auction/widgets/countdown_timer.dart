import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/time_formatter.dart';
import '../../../providers/countdown_provider.dart';

/// Optimized countdown timer using global Riverpod provider
/// Replaces individual timers with single global timer
class CountdownTimer extends ConsumerStatefulWidget {
  final DateTime endTime;
  final TextStyle? textStyle;

  const CountdownTimer({
    super.key,
    required this.endTime,
    this.textStyle,
  });

  @override
  ConsumerState<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends ConsumerState<CountdownTimer> {
  late final String _id;

  @override
  void initState() {
    super.initState();
    // Generate unique ID for this countdown
    _id = '${widget.endTime.millisecondsSinceEpoch}_${identityHashCode(this)}';

    // Register with global countdown provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(countdownProvider.notifier).register(_id, widget.endTime);
    });
  }

  @override
  void dispose() {
    // Unregister from global provider
    ref.read(countdownProvider.notifier).unregister(_id);
    super.dispose();
  }

  Color _getColor(Duration remaining) {
    if (remaining.isNegative) return Colors.grey;
    if (remaining.inDays >= 1) return Colors.green;
    if (remaining.inHours >= 1) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    // Watch only this specific countdown
    final remaining = ref.watch(countdownByIdProvider(_id)) ??
                     widget.endTime.difference(DateTime.now());

    final color = _getColor(remaining);
    // OPTIMIZED: Use optimized formatter for grid/list views
    // Shows hours OR minutes only (no seconds)
    // Shows "< 1m" when less than 1 minute
    // Matches 1-minute refresh interval
    final text = TimeFormatter.formatCountdownOptimized(remaining);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          remaining.isNegative ? Icons.timer_off : Icons.timer,
          color: color,
          size: widget.textStyle?.fontSize ?? 16,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: widget.textStyle?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ) ?? TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
