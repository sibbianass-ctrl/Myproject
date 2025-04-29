import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/enums/auth_enum.dart';
import 'package:my_project/routes/routes.dart';
import 'package:my_project/services/storage_service/secure_storage_service.dart';
import 'package:my_project/utils/constants.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';
import '../services/api_service/auth_service.dart';

// Clear cache code if needed in the future to remove the photos or find a better way to remove the photos like : remove it when the user go back
// import 'package:path_provider/path_provider.dart';

// Future<void> clearCache() async {
//   try {
//     final tempDir = await getTemporaryDirectory();
//     if (tempDir.existsSync()) {
//       tempDir.deleteSync(recursive: true);
//       print("Cache cleared successfully!");
//     }
//   } catch (e) {
//     print("Error clearing cache: $e");
//   }
// }

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  //You can find the better aproach
  bool isNotFilled = true;
  move() async {
    isNotFilled = false;
    SecureStorageService secureStorageService = SecureStorageService();
    String? username = await secureStorageService.readUsername();
    String? password = await secureStorageService.readPassword();
    if (username != null && password != null) {
      AuthService _authService = AuthService();
      if (await _authService.login(username, password) ==
          AuthEnum.loginCorrect) {
        Get.offNamed(Routes.startPage);
      } else {
        await secureStorageService.deleteUsername();
        await secureStorageService.deletePassword();
        Get.offNamed(Routes.logingPage);
      }
    } else {
      Get.offNamed(Routes.logingPage);
    }
  }

  // late Size size;
  @override
  Widget build(BuildContext context) {
    //You can find the better approach
    if (isNotFilled) move();
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(width: 100, height: 100, Constants.appLogo),
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: context.height * 0.8),
              child: Text(
                AppStrings.versionLabel,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
