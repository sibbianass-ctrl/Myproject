import 'package:flutter/material.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';

class LoadingDialog extends StatelessWidget {
  final String text;
  LoadingDialog(
      {super.key, this.text = '${AppStrings.loadingDialogLabel} ...'});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
