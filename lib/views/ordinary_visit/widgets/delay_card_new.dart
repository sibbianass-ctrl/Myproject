// delay_card.dart
import 'package:flutter/material.dart';

/// A dynamic DELAI card that displays real and planned dates.
///
/// This widget displays:
/// - Left side: Real dates (from Demarrage status)
/// - Right side: Planned dates (from Lot API)
///
/// The widget is designed to be used with Obx wrapper in the parent
/// to react to changes in date values.
class DelayCard extends StatelessWidget {
  /// Real start date formatted (dd/MM/yyyy or '-')
  final String realStartText;

  /// Real end date formatted (dd/MM/yyyy or '-')
  final String realEndText;

  /// Planned start date formatted (dd/MM/yyyy or '-')
  final String plannedStartText;

  /// Planned end date formatted (dd/MM/yyyy or '-')
  final String plannedEndText;

  const DelayCard({
    super.key,
    required this.realStartText,
    required this.realEndText,
    required this.plannedStartText,
    required this.plannedEndText,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with icon and title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA726),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.event, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 8),
              const Text(
                'DELAI',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFA726),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Two columns: Real dates (left) | Planned dates (right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left column: Real dates
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dates reelles',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _DateRow(label: 'Debut:', value: realStartText),
                    const SizedBox(height: 2),
                    _DateRow(label: 'Fin:', value: realEndText),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Vertical divider
              Container(
                width: 1,
                height: 50,
                color: Colors.grey.shade300,
              ),
              const SizedBox(width: 8),
              // Right column: Planned dates
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dates prevues',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _DateRow(label: 'Debut:', value: plannedStartText),
                    const SizedBox(height: 2),
                    _DateRow(label: 'Fin:', value: plannedEndText),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Internal widget for displaying a label-value date row.
class _DateRow extends StatelessWidget {
  final String label;
  final String value;

  const _DateRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black54,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
