import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/custom_checkbox_controller.dart';

class CustomCheckbox extends StatelessWidget {
  final String labelText;
  final ValueChanged<bool?> onChanged;
  final CustomCheckboxController controller =
      Get.put(CustomCheckboxController());

  CustomCheckbox({
    super.key,
    required this.labelText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.toggleCheckbox();
        onChanged(controller.isChecked.value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() => Checkbox(
                value: controller.isChecked.value,
                onChanged: (bool? value) {
                  
                  controller.setCheckbox(value ?? false);
                  onChanged(controller.isChecked.value);
                 
                },
                checkColor: Colors.white,
              )),
          GestureDetector(
            onTap: () {
              controller.toggleCheckbox();
              onChanged(controller.isChecked.value);
            },
            child: Text(
              labelText,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
