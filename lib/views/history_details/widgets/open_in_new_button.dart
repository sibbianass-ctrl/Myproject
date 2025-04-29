import 'package:flutter/material.dart';
import '../../../utils/resources/global/app_colors.dart';
import '../../../utils/responsive_utils.dart';

class OpenInNewButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;
  const OpenInNewButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 224, 224, 224),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.green,
              size: getResponsiveIconSize(context, 20),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: getResponsiveFontSize(context, 12),
                ),
              ),
            ),
            Icon(Icons.open_in_new,
             size: getResponsiveIconSize(context, 15),
            ),
          ],
        ),
      ),
    );
  }
}
