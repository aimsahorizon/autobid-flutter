import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/utils/time_formatter.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime endTime;
  final TextStyle? textStyle;

  const CountdownTimer({
    super.key,
    required this.endTime,
    this.textStyle,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _updateRemaining();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateRemaining() {
    setState(() {
      _remaining = widget.endTime.difference(DateTime.now());
    });
  }

  Color _getColor() {
    if (_remaining.isNegative) return Colors.grey;
    if (_remaining.inDays >= 1) return Colors.green;
    if (_remaining.inHours >= 1) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final text = TimeFormatter.formatCountdown(_remaining);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _remaining.isNegative ? Icons.timer_off : Icons.timer,
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
