import 'package:flutter/material.dart';

import '../utils/resources/global/app_strings.dart';
import '../utils/responsive_utils.dart';

class CopyrightText extends StatelessWidget {
  const CopyrightText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        AppStrings.copyright,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: getResponsiveFontSize(context, 10.0),
            color: Colors.black),
      ),
    );
  }
}
