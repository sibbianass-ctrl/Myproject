import 'package:flutter/material.dart';

class BaseDelayChronoCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final Widget center;
  final Widget bottom;

  const BaseDelayChronoCard({
    super.key,
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
