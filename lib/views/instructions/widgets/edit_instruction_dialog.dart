import 'package:flutter/material.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';

Future<void> editInstructionDialog({
  required BuildContext context,
  required String title,
  required String initialValue,
  required Function(String newValue) onValidate,
}) async {
  TextEditingController _controller = TextEditingController(text: initialValue);

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: _controller,
          maxLines: 5, // Allows for multi-line input
          // keyboardType: TextInputType.multiline, // Shows multi-line keyboard
          decoration: const InputDecoration(
            labelText: AppStrings.modify,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              String updatedValue = _controller.text;
              onValidate(updatedValue); // Call the validation callback
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(AppStrings.validate),
          ),
        ],
      );
    },
  );
}
