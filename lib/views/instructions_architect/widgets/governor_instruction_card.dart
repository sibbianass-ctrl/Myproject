import 'package:flutter/material.dart';
import 'package:my_project/utils/responsive_utils.dart';

class GovernorInstructionCard extends StatelessWidget {
  final String title;
  final String description;
  const GovernorInstructionCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 4 , horizontal: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, 12),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, 10),
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
