import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';
import '../services/storage_service/secure_storage_service.dart';
import '../services/user_info_service.dart';
import '../utils/resources/global/app_strings.dart';
import '../utils/resources/profile/profile_strings.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/loading_dialog.dart';

class ProfileController extends GetxController {
  final UserInfoService userInfoService = UserInfoService();
  final SecureStorageService secureStorageService = SecureStorageService();
  void logout() {
    Get.dialog(const ConfirmationDialog(
      title: AppStrings.validateConfirmationTitle,
      content: ProfileStrings.logoutConfirmationDialog,
    )).then((isConfirmed) async {
      if (isConfirmed ?? false) {
        Get.dialog(LoadingDialog(), barrierDismissible: false);
        userInfoService.clearUserInfo();
        await Get.deleteAll();
        await secureStorageService.deleteUsername();
        await secureStorageService.deletePassword();
        // Clear image cache
        PaintingBinding.instance.imageCache.clear();
        //Todo: Delete Token from SecureStorage and delete user info
        Get.offAllNamed(Routes.logingPage);
      }
    });
  }
}
