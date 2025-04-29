import 'package:flutter/material.dart';

import '../../../utils/resources/global/app_colors.dart';
import '../../../utils/resources/global/app_dimensions.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String dateTime;
  final String body;
  const NotificationCard(
      {super.key,
      required this.title,
      required this.dateTime,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.greyLite,
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                dateTime,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          Container(margin: const EdgeInsets.all(8.0), child: Text(body))
        ],
      ),
    );
  }
}
