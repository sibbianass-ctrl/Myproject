import 'package:flutter/material.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';
import 'package:my_project/utils/responsive_utils.dart';

class VisitCard extends StatelessWidget {
  final String title;
  final String number;
  final VoidCallback onTap;
  final IconData icon;
  final bool isValidated;

  const VisitCard({
    Key? key,
    required this.title,
    this.icon = Icons.list_alt,
    required this.number,
    required this.onTap,
    this.isValidated = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: getResponsiveIconSize(context, 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: getResponsiveFontSize(context, 10),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${AppStrings.numberLabel}: $number',
                    style: TextStyle(
                      fontSize: getResponsiveFontSize(context, 10),
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (isValidated)
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: getResponsiveIconSize(context, 18),
              )
            else
            Icon(
             Icons.arrow_forward_ios_outlined,
              size: getResponsiveIconSize(context, 16),
            ),
          ],
        ),
      ),
    );
  }
}
