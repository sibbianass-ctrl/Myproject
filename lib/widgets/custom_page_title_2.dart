import 'package:flutter/material.dart';
import '../utils/resources/global/app_colors.dart';
import '../utils/responsive_utils.dart';

class CustomPageTitle2 extends StatelessWidget {
  final Size size;
  final String title;
  const CustomPageTitle2({super.key, required this.size, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: size.width * .8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.green, width: 1),
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: getResponsiveFontSize(context, 16.0),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
