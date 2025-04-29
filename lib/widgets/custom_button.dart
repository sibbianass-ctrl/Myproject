import 'package:flutter/material.dart';
import 'package:my_project/utils/resources/global/app_colors.dart';
import 'package:my_project/utils/resources/global/app_dimensions.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double fontSize;
  final Color backgroundColor;

  const CustomButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.backgroundColor = AppColors.green,
      this.fontSize = 18.0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Green background
        foregroundColor: Colors.white, // White text
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        ),
        // Padding inside the button
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
      ),
      child: Text(
        buttonText,
        style:  TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
