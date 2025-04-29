import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:my_project/enums/auth_enum.dart';
import 'package:my_project/enums/space_type.dart';
import 'package:my_project/services/api_service/api_endpoints.dart';
import 'package:my_project/services/check_connection.dart';
import 'package:my_project/services/user_info_service.dart';

class AuthService {
  UserInfoService _userInfoService = UserInfoService();

  // void ignoreCertificate() {
  //   // allow self-signed certificate
  //   (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
  //     final client = HttpClient();
  //     client.badCertificateCallback = (cert, host, port) => false;
  //     return client;
  //   };
  // }

  // Future<AuthEnum> login1(String username, String password) async {
  //   ignoreCertificate();
  //   // try {
  //   // Query parameters
  //   final queryParams = {
  //     'grant_type': 'password',
  //     'client_id': 'my-project-client',
  //     'username': username,
  //     'password': password,
  //   };
  //   final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  //   // Making POST request
  //   final response = await _dio.post(
  //     'https://10.0.91.4/auth/realms/province/protocol/openid-connect/token',
  //     options: Options(headers: headers),
  //     queryParameters: queryParams,
  //     data: '', // Empty body since data is in query parameters
  //   );
  //   if (response.statusCode == 401) {
  //     return AuthEnum.loginIncorrect;
  //   }
  //   Constants.token = response.data['access_token'];
  //   log(Constants.token, name: 'token');
  //   // await _secureStorageService.saveToken(Constants.token);
  //   //get user info from API by token
  //   // await _getUserInfoByToken(Constants.token);
  //   return AuthEnum.loginCorrect;
  //   // } on DioException catch (e) {
  //   //   log('Error: ${e.response?.statusCode} ${e.response?.data}');
  //   //   return AuthEnum.unknownError;
  //   // }
  // }

  Future<AuthEnum> login(String username, String password) async {
    if (!await checkConnection()) AuthEnum.connectionError;
    try {
      // Define the URL
      final url = Uri.parse(ApiEndpoints.loginEndpoint);

      // Define query parameters
      final body = {
        'grant_type': 'password',
        'client_id': 'my-project-client',
        'username': username,
        'password': password,
      };

      // Define headers
      final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

      // Make POST request
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      // Handle response
      if (response.statusCode == 401) {
        return AuthEnum.loginIncorrect;
      }

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['access_token'];
        await _getUserInfoByToken(token);
        // Constants.token = token;
        return AuthEnum.loginCorrect;
      }

      // If status code is not 200 or 401, return unknown error
      return AuthEnum.unknownError;
    } catch (e) {
      log('Error: $e');
      return AuthEnum.unknownError;
    }
  }

  Future<bool> _getUserInfoByToken(String token) async {
    log('calling getUserInfoByToken ... ', name: ' --- Trace ---');
    try {
      // Define the URL
      final url = Uri.parse(ApiEndpoints.getUserInfoByToken);

      // Define headers
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Make GET request
      final response = await http.get(url, headers: headers);

      // Check the status code
      if (response.statusCode == 200) {
        // Parse and log the response data
        final responseData = json.decode(response.body);
        // Assuming UserInfoService handles saving the user info

        // Save user info to shared preferences or wherever needed
        // userInfoService.saveUserInfo(responseData);

        _userInfoService.fromJson(responseData);
        log(_userInfoService.toString(), name: 'profile');
        log('Finish calling getUserInfoByToken ', name: ' --- Trace ---');
        await _getUserRole();
        return true;
      } else {
        // Log unexpected status codes or errors
        log('Error: ${response.statusCode} ${response.body}');
        return false;
      }
    } catch (e) {
      // Log any exceptions
      log('Exception: $e');
      return false;
    }
  }

  _getEntrepriseId(String id) async {
    // Define the URL
    final url = Uri.parse(ApiEndpoints.getEntreprise + id);
    // Define headers
    final headers = {
      'Content-Type': 'application/json',
    };
    log(ApiEndpoints.getEntreprise + id, name: 'entreprise URL');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _userInfoService.fromJsonEntreprise(responseData);
      log(_userInfoService.toString(), name: 'profile');
    } else {
      log('Error: ${response.statusCode} ${response.body}');
      return null;
    }
  }

  _getTechnicianId() async {
    log('calling getTechnicianId ... ', name: ' --- Trace ---');
    // Define the URL
    final url = Uri.parse(ApiEndpoints.getTechnician);
    // Define headers
    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _userInfoService.tecId = responseData['id'];
      log(_userInfoService.toString(), name: '=== Finish Tracing ===');
    } else {
      log('Error: ${response.statusCode} ${response.body}');
      return null;
    }
  }

  Future<void> _getUserRole() async {
    log('calling getUserRole ... ', name: ' --- Trace ---');
    // Define the URL
    final url = Uri.parse(ApiEndpoints.getUserRole);
    // Define headers
    final headers = {
      'Content-Type': 'application/json',
    };
    log(ApiEndpoints.getUserRole, name: 'role URL');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String enterpriseId = responseData['enterpriseId'].toString();

      log(responseData['administration'].toString(), name: '--- ROLE ---');

      if (responseData['administration'] == 'Province de Berkane') {
        _userInfoService.spaceType = SpaceType.province;
        await _getTechnicianId();
      } else if (responseData['administration'] == 'architecte') {
        _userInfoService.spaceType = SpaceType.architecte;
        log('enterpriseId: $enterpriseId', name: 'Enterprise ID');
        await _getEntrepriseId(enterpriseId);
      } else if (responseData['administration'] == 'bet') {
        _userInfoService.spaceType = SpaceType.bet;
        await _getEntrepriseId(enterpriseId);
      }
    } else {
      log('Error: ${response.statusCode} ${response.body}', name: 'role');
    }
  }
}
