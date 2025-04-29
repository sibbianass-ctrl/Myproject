import 'package:flutter/material.dart';
import '../utils/resources/global/app_colors.dart';
import '../utils/resources/global/app_dimensions.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final bool showText;
  final bool isPassword;
  final Color color;
  final Function? onVisible;

  const CustomTextField({
    super.key,
    this.label = '',
    required this.icon,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.color = AppColors.green,
    this.obscureText = false,
    this.isPassword = false,
    this.controller,
    this.showText = true,
    this.onVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showText)
          // Label Text
          SizedBox(
            // width: double.infinity,
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: TextStyle(color: color),
            ),
          ),
        if (showText) const SizedBox(height: 2),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: AppColors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              if (isPassword)
                IconButton(
                  onPressed: () {
                    onVisible!();
                  },
                  icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
