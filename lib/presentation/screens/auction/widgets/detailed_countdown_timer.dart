import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/utils/time_formatter.dart';

/// Detailed countdown timer with REAL-TIME second updates
/// Used ONLY in auction detail screens for precise countdown
/// Grid/List views use optimized 1-minute timer instead
class DetailedCountdownTimer extends StatefulWidget {
  final DateTime endTime;

  const DetailedCountdownTimer({
    super.key,
    required this.endTime,
  });

  @override
  State<DetailedCountdownTimer> createState() => _DetailedCountdownTimerState();
}

class _DetailedCountdownTimerState extends State<DetailedCountdownTimer> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    // Real-time updates every second for detail view
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        _updateRemaining();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateRemaining() {
    setState(() {
      _remaining = widget.endTime.difference(DateTime.now());
    });
  }

  Color _getStatusColor() {
    if (_remaining.isNegative) return Colors.grey;
    if (_remaining.inDays >= 1) return ColorConstants.success;
    if (_remaining.inHours >= 1) return ColorConstants.warning;
    return ColorConstants.error;
  }

  IconData _getStatusIcon() {
    if (_remaining.isNegative) return Icons.timer_off;
    if (_remaining.inHours < 1) return Icons.access_alarm;
    return Icons.timer;
  }

  String _getStatusText() {
    if (_remaining.isNegative) return 'AUCTION ENDED';
    if (_remaining.inMinutes < 1) return 'ENDING SOON';
    if (_remaining.inHours < 1) return 'LAST HOUR';
    if (_remaining.inDays < 1) return 'ENDS TODAY';
    return 'LIVE AUCTION';
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();
    final icon = _getStatusIcon();
    final statusText = _getStatusText();
    final countdownText = TimeFormatter.formatCountdown(_remaining);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.1),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: color.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: color,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Main Timer Display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  countdownText,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: color,
                    letterSpacing: 2,
                    fontFeatures: const [
                      FontFeature.tabularFigures(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Helper Text
            Text(
              _remaining.isNegative
                  ? 'This auction has concluded'
                  : 'Time remaining until auction ends',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
