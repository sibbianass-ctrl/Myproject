// delay_card.dart
import 'package:flutter/material.dart';
import 'package:my_project/models/sortie.dart';
import 'package:my_project/views/ordinary_visit/widgets/base_delay_chrono_card.dart';


class DelayCard extends StatelessWidget {
  final Sortie sortie;
  const DelayCard({super.key, required this.sortie});

  DateTime? _parseProgrammed() {
    try {
      // programedDate jayak mn API (ex: '2025-12-03')
      return DateTime.parse(sortie.programedDate);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final start = _parseProgrammed() ?? now;
    // hna ghanftrdo durée projet 300 jour (b7al l’exemple)
    final end = start.add(const Duration(days: 300));

    double percent = 0;
    if (now.isAfter(start)) {
      final total = end.difference(start).inSeconds;
      final used = now.difference(start).inSeconds.clamp(0, total);
      percent = total == 0 ? 0 : (used / total) * 100;
    }
    final remaining = (100 - percent).clamp(0, 100);

    return _BaseDelayChronoCard(
      color: const Color(0xFFFFA726),
      icon: Icons.event,
      title: 'DÉLAI',
      center: Text(
        '${percent.toStringAsFixed(0)} %',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      bottom: Text(
        'Consommé: ${percent.toStringAsFixed(0)}%   Reste: ${remaining.toStringAsFixed(0)}%',
        style: const TextStyle(fontSize: 11),
        textAlign: TextAlign.center,
      ),
    );
  }
}
// tu peux le mettre dans un des deux fichiers (au-dessus) ou fichier séparé
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
