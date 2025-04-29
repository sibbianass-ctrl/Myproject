import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/resources/global/app_strings.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String yesButtonTitle;
  final String noButtonTitle;
  const ConfirmationDialog(
      {super.key,
      required this.title,
      required this.content,
      this.yesButtonTitle = AppStrings.yes,
      this.noButtonTitle = AppStrings.cancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text(
            noButtonTitle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () => Get.back(result: true),
          child: Text(
            yesButtonTitle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
