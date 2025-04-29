import 'package:flutter/material.dart';

import '../../../utils/resources/global/app_colors.dart';
import '../../../utils/resources/global/app_dimensions.dart';

class ProfileSection extends StatelessWidget {
  final String contentText;
  final IconData icon;
  final Function onTap;
  const ProfileSection(
      {super.key,
      required this.contentText,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          color: AppColors.greyLite,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius)),
      child: InkWell(
        onTap: () => onTap(),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.green,
              size: 32,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              contentText,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
