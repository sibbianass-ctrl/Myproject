import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_project/routes/routes.dart';
import 'package:my_project/services/api_service/auth_service.dart';
import 'package:my_project/services/api_service/commands_service.dart';
import 'package:my_project/services/storage_service/secure_storage_service.dart';
import 'package:my_project/services/user_info_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../enums/auth_enum.dart';
import '../enums/space_type.dart';
import '../utils/resources/global/app_strings.dart';
import '../utils/resources/login/login_strings.dart';
import '../widgets/loading_dialog.dart';
import 'app_snackbar_controller.dart';

class LoginController extends GetxController {
  UserInfoService userInfoService = UserInfoService();
  AuthService _authService = AuthService();
  RxBool isPasswordVisible = true.obs;
  SecureStorageService _secureStorageService = SecureStorageService();
  bool isRememberMe = false;
  String? userId;

  @override
  void onInit() {
    super.onInit();
    getPlayerId();
  }

  Future<void> getPlayerId() async {
    await Future.delayed(
        Duration(seconds: 3)); // Wait for OneSignal to initialize

    userId = OneSignal.User.pushSubscription.id;
    log('Getting Player ID : $userId');
  }

  Future<void> login(String username, String password) async {
    Get.dialog(LoadingDialog(), barrierDismissible: false);

    switch (await _authService.login(username, password)) {
      case AuthEnum.loginCorrect:
        if (isRememberMe) {
          await _secureStorageService.saveUsername(username);
          await _secureStorageService.savePassword(password);
        }
        if (userId != null && userId!.trim().isNotEmpty && userInfoService.spaceType == SpaceType.province) {
          await CommandsService.saveNotification(userId!);
        }
       
        Get.back();
        Get.offNamed(Routes.startPage);
        break;
      case AuthEnum.loginIncorrect:
        Get.back();
        snackbarError(LoginStrings.passwordIcorrect);
        break;
      case AuthEnum.connectionError:
        Get.back();
        snackbarError(AppStrings.checkConnection);
        break;
      default:
        Get.back();
        snackbarError(AppStrings.error);
    }
  }
}
