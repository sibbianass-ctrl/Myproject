// chrono_card.dart
import 'package:flutter/material.dart';

/// A dynamic countdown CHRONO card that displays remaining time.
/// 
/// This widget displays:
/// - HH:MM:SS countdown (hours:minutes:seconds)
/// - X jours restants (days remaining)
/// 
/// The widget is designed to be used with Obx wrapper in the parent
/// to react to changes in the countdown values.
class ChronoCard extends StatelessWidget {
  /// The formatted time string (e.g., "12 : 34 : 56" or "-- : -- : --")
  final String hmsText;
  
  /// The formatted days remaining text (e.g., "45 jours restants" or "- jours restants")
  final String daysRemainingText;

  const ChronoCard({
    super.key,
    required this.hmsText,
    required this.daysRemainingText,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseDelayChronoCard(
      color: const Color(0xFF26C6DA),
      icon: Icons.timer_outlined,
      title: 'CHRONO',
      center: Text(
        hmsText,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      bottom: Text(
        daysRemainingText,
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}

/// Internal base card widget for consistent styling.
class _BaseDelayChronoCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final Widget center;
  final Widget bottom;

  const _BaseDelayChronoCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.center,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                center,
                const SizedBox(height: 4),
                bottom,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
