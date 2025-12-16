import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_project/firebase_options.dart';
import 'package:my_project/routes/routes.dart';
import 'package:my_project/utils/resources/global/app_colors.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';
import 'package:my_project/views/splash_screen_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'services/api_service/config/http_client.dart';
import 'utils/responsive_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "config/.env");
  HttpOverrides.global = MyHttpOverrides();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e, st) {
    debugPrint('Firebase initialization error: $e');
    debugPrint('$st');
  }

  try {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("d8cb3bc9-aded-47e4-9166-26966c8c2a1a");
    OneSignal.Notifications.requestPermission(true);
  } catch (e, st) {
    debugPrint('OneSignal initialization error: $e');
    debugPrint('$st');
  }
  runApp(const MyApp());
}

// MVC + GetX

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      routes: publicRoutes(context),
      initialRoute: '/',
      theme: ThemeData(
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
          useMaterial3: true,
          navigationBarTheme: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (Set<WidgetState> states) {
                // Selected label style in navigation bar
                return TextStyle(fontSize: getResponsiveFontSize(context, 10));
              },
            ),
          )),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreenView(),
        );
      },
    );
  }
}
