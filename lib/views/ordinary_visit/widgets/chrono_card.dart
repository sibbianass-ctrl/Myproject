// chrono_card.dart
import 'package:flutter/material.dart';
import 'package:my_project/models/sortie.dart';

class ChronoCard extends StatelessWidget {
  final Sortie sortie;
  const ChronoCard({super.key, required this.sortie});

  DateTime? _parseProgrammed() {
    try {
      return DateTime.parse(sortie.programedDate);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final start = _parseProgrammed() ?? DateTime.now();
    final now = DateTime.now();
    final diff = now.difference(start);

    final days = diff.inDays;
    final hours = diff.inHours.remainder(24);
    final minutes = diff.inMinutes.remainder(60);
    final seconds = diff.inSeconds.remainder(60);

    final hms =
        '${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';

    return _BaseDelayChronoCard(
      color: const Color(0xFF26C6DA),
      icon: Icons.refresh,
      title: 'CHRONO',
      center: Text(
        hms,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      bottom: Text(
        '$days jours d’exécution',
        style: const TextStyle(fontSize: 11),
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
