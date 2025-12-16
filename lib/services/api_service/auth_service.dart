// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:my_project/enums/auth_enum.dart';
// import 'package:my_project/enums/space_type.dart';
// import 'package:my_project/services/api_service/api_endpoints.dart';
// import 'package:my_project/services/check_connection.dart';
// import 'package:my_project/services/user_info_service.dart';

// class AuthService {
//   UserInfoService _userInfoService = UserInfoService();

//   Future<AuthEnum> login(String username, String password) async {
//     if (!await checkConnection()) AuthEnum.connectionError;
//     try {
//       // Define the URL
//       final url = Uri.parse(ApiEndpoints.loginEndpoint);

//       // Define query parameters
//       final body = {
//         'grant_type': 'password',
       
//         'client_id': 'my-project-client',
//         'username': username,
//         'password': password,
       
//       };

//       // Define headers
//       final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

//       // Make POST request
//       final response = await http.post(
//         url,
//         headers: headers,
//         body: body,
//       );

//       // Handle response
//       if (response.statusCode == 401) {
//         return AuthEnum.loginIncorrect;
//       }

//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         final token = responseData['access_token'];
//         await _getUserInfoByToken(token);
//         // Constants.token = token;
//         return AuthEnum.loginCorrect;
//       }

//       // If status code is not 200 or 401, return unknown error
//       return AuthEnum.unknownError;
//     } catch (e) {
//       log('Error: $e');
//       return AuthEnum.unknownError;
//     }
//   }

//   Future<bool> _getUserInfoByToken(String token) async {
//     log('calling getUserInfoByToken ... ', name: ' --- Trace ---');
//     try {
//       // Define the URL
//       final url = Uri.parse(ApiEndpoints.getUserInfoByToken);

//       // Define headers
//       final headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       };

//       // Make GET request
//       final response = await http.get(url, headers: headers);

//       // Check the status code
//       if (response.statusCode == 200) {
//         // Parse and log the response data
//         final responseData = json.decode(response.body);
//         // Assuming UserInfoService handles saving the user info

//         // Save user info to shared preferences or wherever needed
//         // userInfoService.saveUserInfo(responseData);
//         log('Body : ${response.body}', name: 'Body');
//         _userInfoService.fromJson(responseData);
//         log(_userInfoService.toString(), name: 'profile');
//         log('Finish calling getUserInfoByToken ', name: ' --- Trace ---');
//         await _getUserRole();
//         return true;
//       } else {
//         // Log unexpected status codes or errors
//         log('Error: ${response.statusCode} ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       // Log any exceptions
//       log('Exception: $e');
//       return false;
//     }
//   }

//   _getEntrepriseId(String id) async {
//     // Define the URL
//     final url = Uri.parse(ApiEndpoints.getEntreprise + id);
//     // Define headers
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     log(ApiEndpoints.getEntreprise + id, name: 'entreprise URL');
//     final response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       _userInfoService.fromJsonEntreprise(responseData);
//       log('ResponseData: $responseData', name: 'Response');

//       log(_userInfoService.toString(), name: 'profile');
//     } else {
//       log('Error: ${response.statusCode} ${response.body}');
//       return null;
//     }
//   }

//   _getTechnicianId() async {
//     log('calling getTechnicianId ... ', name: ' --- Trace ---');
//     // Define the URL
//     final url = Uri.parse(ApiEndpoints.getTechnician);
//     // Define headers
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     final response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       _userInfoService.tecId = responseData['id'];
//       log(_userInfoService.toString(), name: '=== Finish Tracing ===');
//     } else {
//       log('Error: ${response.statusCode} ${response.body}');
//       return null;
//     }
//   }

//   Future<void> _getUserRole() async {
//     log('calling getUserRole ... ', name: ' --- Trace ---');
//     // Define the URL
//     final url = Uri.parse(ApiEndpoints.getUserRole);
//     // Define headers
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     log(ApiEndpoints.getUserRole, name: 'role URL');
//     final response = await http.get(url, headers: headers);
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       String enterpriseId = responseData['enterpriseId'].toString();
//       _userInfoService.enterpriseId = enterpriseId;
//       log('enterpriseId: $enterpriseId', name: 'Enterprise ID');
//       log(responseData['administration'].toString(), name: '--- ROLE ---');

//       if (responseData['administration'] == 'province') {
//         _userInfoService.spaceType = SpaceType.province;
//         await _getTechnicianId();
//       } else if (responseData['administration'] == 'architecte') {
//         _userInfoService.spaceType = SpaceType.architecte;
//         log('enterpriseId: $enterpriseId', name: 'Enterprise ID');
//         await _getEntrepriseId(enterpriseId);
//       } else if (responseData['administration'] == 'bet') {
//         _userInfoService.spaceType = SpaceType.bet;
//         await _getEntrepriseId(enterpriseId);
//       }
//     } else {
//       log('Error: ${response.statusCode} ${response.body}', name: 'role');
//     }
//   }
// }
// (Nom de votre fichier : lib/services/api_service/api.service.dart)
///////////////////////////////////////// C U R R E N T   W O R K I N G //////////////////////////
///////////////////////////////////////// C U R R E N T   W O R K I N G //////////////////////////
///////////////////////////////////////// C U R R E N T   W O R K I N G //////////////////////////
///////////////////////////////////////// C U R R E N T   W O R K I N G //////////////////////////
///////////////////////////////////////// C U R R E N T   W O R K I N G //////////////////////////
///////////////////////////////////////// C U R R E N T   W O R K I N G //////////////////////////
///////////////////////////////////////// C U R R E N T   W O R K I N G //////////////////////////
///////////////////////////////////////// C U R R E N T   W O R K I N G //////////////////////////
///////////////////////////////////////// C U R R E N T   W O R K I N G //////////////////////////
///////////////////////////////////////// C U R R E N T   W O R K I N G //////////////////////////
///////////////////////////////////////// C U R R E N T   W O R K I N G //////////////////////////
// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:my_project/enums/auth_enum.dart';
// import 'package:my_project/enums/space_type.dart';
// import 'package:my_project/services/api_service/api_endpoints.dart';
// import 'package:my_project/services/check_connection.dart';
// import 'package:my_project/services/user_info_service.dart';

// class AuthService {
//   UserInfoService _userInfoService = UserInfoService();

//   Future<AuthEnum> login(String username, String password) async {
//     if (!await checkConnection()) AuthEnum.connectionError;
//     try {
//       // Define the URL
//       final url = Uri.parse(ApiEndpoints.loginEndpoint);

//       // Define query parameters
//       final body = {
//         'grant_type': 'password',
//         'client_id': 'my-project-client',
//         'username': username,
//         'password': password,
//       };

//       // Define headers
//       final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

//       // Make POST request
//       final response = await http.post(
//         url,
//         headers: headers,
//         body: body,
//       );

//       // Handle response
//       if (response.statusCode == 401) {
//         return AuthEnum.loginIncorrect;
//       }

//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         final token = responseData['access_token'];

//         // <--- AJOUT 1 : Stocker le token dans le service
//         _userInfoService.token = token;
//         // (Rappel : N'oubliez pas d'ajouter `String? token;` dans votre classe UserInfoService)

//         await _getUserInfoByToken(token);
//         // Constants.token = token;
//         return AuthEnum.loginCorrect;
//       }

//       // If status code is not 200 or 401, return unknown error
//       return AuthEnum.unknownError;
//     } catch (e) {
//       log('Error: $e');
//       return AuthEnum.unknownError;
//     }
//   }

//   Future<bool> _getUserInfoByToken(String token) async {
//     log('calling getUserInfoByToken ... ', name: ' --- Trace ---');
//     try {
//       // Define the URL
//       final url = Uri.parse(ApiEndpoints.getUserInfoByToken);

//       // Define headers
//       final headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       };

//       // Make GET request
//       final response = await http.get(url, headers: headers);

//       // Check the status code
//       if (response.statusCode == 200) {
//         // Parse and log the response data
//         final responseData = json.decode(response.body);
//         // Assuming UserInfoService handles saving the user info

//         // Save user info to shared preferences or wherever needed
//         // userInfoService.saveUserInfo(responseData);
//         log('Body : ${response.body}', name: 'Body');
//         _userInfoService.fromJson(responseData);
//         log(_userInfoService.toString(), name: 'profile');
//         log('Finish calling getUserInfoByToken ', name: ' --- Trace ---');
//         await _getUserRole();
//         return true;
//       } else {
//         // Log unexpected status codes or errors
//         log('Error: ${response.statusCode} ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       // Log any exceptions
//       log('Exception: $e');
//       return false;
//     }
//   }

//   // <--- AJOUT 2 : Nouvelle fonction pour rafraîchir les infos
//   Future<bool> refreshUserInfo() async {
//     if (_userInfoService.token == null) {
//       log('Token is null, cannot refresh user info');
//       return false;
//     }
//     log('Refreshing user info...');
//     return await _getUserInfoByToken(_userInfoService.token!);
//   }

//   // <--- AJOUT 3 : Nouvelle fonction pour mettre à jour le profil Keycloak
//   Future<bool> updateUserAttributes(Map<String, dynamic> attributes) async {
//     if (_userInfoService.token == null) {
//       log('Token is null, cannot update attributes');
//       return false;
//     }

//     // Dériver l'URL de base de Keycloak de votre endpoint de login
//     // "https://.../realms/.../protocol/openid-connect/token" -> "https://.../realms/.../account"
//     final String accountApiEndpoint = ApiEndpoints.loginEndpoint
//         .replaceAll('/protocol/openid-connect/token', '/account');

//     final body = json.encode({
//       "attributes": attributes,
//     });

//     try {
//       final response = await http.post(
//         Uri.parse(accountApiEndpoint),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${_userInfoService.token}', // Utiliser le token stocké
//         },
//         body: body,
//       );

//       if (response.statusCode == 200 || response.statusCode == 204) {
//         log('User attributes updated successfully');
//         return true;
//       } else {
//         log('Failed to update attributes: ${response.statusCode} ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       log('Error updating user attributes: $e');
//       return false;
//     }
//   }

//   // (VOTRE CODE ORIGINAL REPREND ICI)
//   _getEntrepriseId(String id) async {
//     // Define the URL
//     final url = Uri.parse(ApiEndpoints.getEntreprise + id);
//     // Define headers
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     log(ApiEndpoints.getEntreprise + id, name: 'entreprise URL');
//     final response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       _userInfoService.fromJsonEntreprise(responseData);
//       log('ResponseData: $responseData', name: 'Response');

//       log(_userInfoService.toString(), name: 'profile');
//     } else {
//       log('Error: ${response.statusCode} ${response.body}');
//       return null;
//     }
//   }

//   _getTechnicianId() async {
//     log('calling getTechnicianId ... ', name: ' --- Trace ---');
//     // Define the URL
//     final url = Uri.parse(ApiEndpoints.getTechnician);
//     // Define headers
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     final response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       _userInfoService.tecId = responseData['id'];
//       log(_userInfoService.toString(), name: '=== Finish Tracing ===');
//     } else {
//       log('Error: ${response.statusCode} ${response.body}');
//       return null;
//     }
//   }

//   Future<void> _getUserRole() async {
//     log('calling getUserRole ... ', name: ' --- Trace ---');
//     // Define the URL
//     final url = Uri.parse(ApiEndpoints.getUserRole);
//     // Define headers
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     log(ApiEndpoints.getUserRole, name: 'role URL');
//     final response = await http.get(url, headers: headers);
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       String enterpriseId = responseData['enterpriseId'].toString();
//       _userInfoService.enterpriseId = enterpriseId;
//       log('enterpriseId: $enterpriseId', name: 'Enterprise ID');
//       log(responseData['administration'].toString(), name: '--- ROLE ---');

//       if (responseData['administration'] == 'province') {
//         _userInfoService.spaceType = SpaceType.province;
//         await _getTechnicianId();
//       } else if (responseData['administration'] == 'architecte') {
//         _userInfoService.spaceType = SpaceType.architecte;
//         log('enterpriseId: $enterpriseId', name: 'Enterprise ID');
//         await _getEntrepriseId(enterpriseId);
//       } else if (responseData['administration'] == 'bet') {
//         _userInfoService.spaceType = SpaceType.bet;
//         await _getEntrepriseId(enterpriseId);
//       }
//     } else {
//       log('Error: ${response.statusCode} ${response.body}', name: 'role');
//     }
//   }
// }

// lib/services/api_service/auth_service.dart

// lib/services/api_service/auth_service.dart

// lib/services/api_service/auth_service.dart

// lib/services/api_service/auth_service.dart

// lib/services/api_service/auth_service.dart

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

  get currentUser => null;

  Future<AuthEnum> login(String username, String password) async {
    if (!await checkConnection()) AuthEnum.connectionError;
    try {
      // (Votre code de login original - INCHANGÉ)
      final url = Uri.parse(ApiEndpoints.loginEndpoint);
      final body = {
        'grant_type': 'password',
        'client_id': 'my-project-client',
        'username': username,
        'password': password,
      };
      final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      if (response.statusCode == 401) {
        return AuthEnum.loginIncorrect;
      }
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['access_token'];
        _userInfoService.token = token;
        await _getUserInfoByToken(token);
        return AuthEnum.loginCorrect;
      }
      return AuthEnum.unknownError;
    } catch (e) {
      log('Error: $e');
      return AuthEnum.unknownError;
    }
  }

  Future<bool> _getUserInfoByToken(String token) async {
    // (Votre code _getUserInfoByToken original - INCHANGÉ)
    log('calling getUserInfoByToken ... ', name: ' --- Trace ---');
    try {
      final url = Uri.parse(ApiEndpoints.getUserInfoByToken);
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        log('Body : ${response.body}', name: 'Body');
        _userInfoService.fromJson(responseData);
        log(_userInfoService.toString(), name: 'profile');
        log('Finish calling getUserInfoByToken ', name: ' --- Trace ---');
        await _getUserRole();
        return true;
      } else {
        log('Error: ${response.statusCode} ${response.body}');
        return false;
      }
    } catch (e) {
      log('Exception: $e');
      return false;
    }
  }

  Future<bool> refreshUserInfo() async {
    // (Votre code refreshUserInfo original - INCHANGÉ)
    if (_userInfoService.token == null) {
      log('Token is null, cannot refresh user info');
      return false;
    }
    log('Refreshing user info...');
    return await _getUserInfoByToken(_userInfoService.token!);
  }

// -----------------------------------------------------------------
// --- C'EST LA SEULE SECTION QUI A ÉTÉ CORRIGÉE ---
// -----------------------------------------------------------------
  Future<bool> updateUserProfile(
      String responsableName, String responsablePhoneNumber) async {
    if (_userInfoService.token == null) {
      log('Token is null, cannot update');
      return false;
    }

    // --- CORRECTION 1 : Le VRAI Endpoint (Keycloak Admin API) ---
    // Nous le construisons à partir de votre ApiEndpoints.loginEndpoint
    
    // 1. Trouver l'URL de base de l'authentification (ex: "http://172.16.20.217:8080/auth")
    final String authBaseUrl = ApiEndpoints.loginEndpoint
        .substring(0, ApiEndpoints.loginEndpoint.indexOf('/realms/'));

    // 2. Construire l'URL de l'API Admin
    final String adminApiEndpoint =
        '${authBaseUrl}/admin/realms/province_settat/users/${_userInfoService.id}';
    
    log('Attempting to update user at Keycloak Admin API: $adminApiEndpoint');

    // --- CORRECTION 2 : Le bon "Body" ---
    // C'est le format JSON que l'API Admin de Keycloak attend.
    List<String> nameParts = _userInfoService.userFullName.split(' ');
    String firstName = nameParts.first;
    String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    
    final body = json.encode({
      "id": _userInfoService.id,
      "username": _userInfoService.username,
      "firstName": firstName,
      "lastName": lastName,
      "attributes": {
        "responsableName": [responsableName],
        "responsablePhoneNumber": [responsablePhoneNumber],
      }
    });

    try {
      // --- CORRECTION 3 : La bonne méthode (PUT) ---
      final response = await http.put(
        Uri.parse(adminApiEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_userInfoService.token}',
        },
        body: body,
      );
      // --- FIN DE LA CORRECTION ---

      // L'API Admin répond avec 204 (No Content) en cas de succès
      if (response.statusCode == 200 ||
          response.statusCode == 204 ||
          response.statusCode == 201) {
        log('User profile updated successfully via Keycloak Admin API');
        return true;
      } else {
        // Si cela échoue, nous verrons l'erreur (ex: 403 Forbidden)
        log('Failed to update user profile: ${response.statusCode} ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error calling updateUserProfile: $e');
      return false;
    }
  }
// -----------------------------------------------------------------
// --- LE RESTE DE VOTRE FICHIER EST INCHANGÉ ---
// -----------------------------------------------------------------

  _getEntrepriseId(String id) async {
    // (Votre code original - INCHANGÉ)
    final url = Uri.parse(ApiEndpoints.getEntreprise + id);
    final headers = {
      'Content-Type': 'application/json',
    };
    log(ApiEndpoints.getEntreprise + id, name: 'entreprise URL');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _userInfoService.fromJsonEntreprise(responseData);
      log('ResponseData: $responseData', name: 'Response');
      log(_userInfoService.toString(), name: 'profile');
    } else {
      log('Error: ${response.statusCode} ${response.body}');
      return null;
    }
  }

  _getTechnicianId() async {
    // (Votre code original - INCHANGÉ)
    log('calling getTechnicianId ... ', name: ' --- Trace ---');
    final url = Uri.parse(ApiEndpoints.getTechnician);
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
    // (Votre code original - INCHANGÉ)
    log('calling getUserRole ... ', name: ' --- Trace ---');
    final url = Uri.parse(ApiEndpoints.getUserRole);
    final headers = {
      'Content-Type': 'application/json',
    };
    log(ApiEndpoints.getUserRole, name: 'role URL');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String enterpriseId = responseData['enterpriseId'].toString();
      _userInfoService.enterpriseId = enterpriseId;
      log('enterpriseId: $enterpriseId', name: 'Enterprise ID');
      log(responseData['administration'].toString(), name: '--- ROLE ---');

      if (responseData['administration'] == 'province') {
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

  void clearUserInfo() {}
}