import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

Future<bool> checkConnection() async {
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());

  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.wifi)) {
    try {
      final response = await Dio().get(
        'https://www.google.com',
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false; // No actual internet access
    }
  }
  return false; // No network connection
}
