import 'package:flutter/material.dart';
import '../../../utils/resources/global/app_colors.dart';

class HomeCardButton extends StatelessWidget {
  final String text;
  final Function onTap;
  const HomeCardButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.greyLite,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 10.5),
        ),
      ),
    );
  }
}
