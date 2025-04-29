import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';

void snackbarError(String message) {
  Get.snackbar(
    AppStrings.error,
    message,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}

void snackbarSuccess(String message) {
  Get.snackbar(
    AppStrings.succes,
    message,
    backgroundColor: Colors.green,
    colorText: Colors.white,
  );
}

 void snackbarWarrning(String message) {
  Get.snackbar(
    AppStrings.warning,
    message,
    backgroundColor: Colors.orange[600],
    colorText: Colors.white,
  );
}