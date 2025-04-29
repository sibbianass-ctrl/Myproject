import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/resources/global/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: Image.asset(width: 45, Constants.moroccoLogoPath),
      backgroundColor: AppColors.green,
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
