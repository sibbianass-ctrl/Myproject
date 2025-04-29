import 'package:flutter/material.dart';
import '../utils/resources/global/app_colors.dart';
import '../utils/responsive_utils.dart';

class CustomPageTitle extends StatelessWidget {
  final Size size;
  final String title;
  const CustomPageTitle({super.key, required this.size, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: size.width * .8,
      decoration: BoxDecoration(
          color: AppColors.greyLite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ]),
      padding: EdgeInsets.symmetric( vertical: 16),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style:  TextStyle(fontSize: getResponsiveFontSize(context,18), fontWeight: FontWeight.bold),
      ),
    );
  }
}
