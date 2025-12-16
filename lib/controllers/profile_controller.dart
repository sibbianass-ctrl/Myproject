// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../routes/routes.dart';
// // import '../services/storage_service/secure_storage_service.dart';
// // import '../services/user_info_service.dart';
// // import '../utils/resources/global/app_strings.dart';
// // import '../utils/resources/profile/profile_strings.dart';
// // import '../widgets/confirmation_dialog.dart';
// // import '../widgets/loading_dialog.dart';

// // class ProfileController extends GetxController {
// //   final UserInfoService userInfoService = UserInfoService();
// //   final SecureStorageService secureStorageService = SecureStorageService();
// //   void logout() {
// //     Get.dialog(const ConfirmationDialog(
// //       title: AppStrings.validateConfirmationTitle,
// //       content: ProfileStrings.logoutConfirmationDialog,
// //     )).then((isConfirmed) async {
// //       if (isConfirmed ?? false) {
// //         Get.dialog(LoadingDialog(), barrierDismissible: false);
// //         userInfoService.clearUserInfo();
// //         await Get.deleteAll();
// //         await secureStorageService.deleteUsername();
// //         await secureStorageService.deletePassword();
// //         // Clear image cache
// //         PaintingBinding.instance.imageCache.clear();
// //         //Todo: Delete Token from SecureStorage and delete user info
// //         Get.offAllNamed(Routes.logingPage);
// //       }
// //     });
// //   }
// // }

// // lib/controllers/profile_controller.dart

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:my_project/services/api_service/api_endpoints.dart';
// import '../routes/routes.dart';
// import '../services/storage_service/secure_storage_service.dart';
// import '../services/user_info_service.dart';
// // <--- AJOUT : Importer le service d'authentification
// import '../services/api_service/auth_service.dart';
// import '../utils/resources/global/app_strings.dart';
// import '../utils/resources/profile/profile_strings.dart';
// import '../widgets/confirmation_dialog.dart';
// import '../widgets/loading_dialog.dart';

// class ProfileController extends GetxController {
//   // Services
//   final UserInfoService userInfoService = UserInfoService();
//   final SecureStorageService secureStorageService = SecureStorageService();
//   // <--- AJOUT : Instance du service d'authentification
//   final AuthService authService = AuthService();

//   // <--- AJOUT : Contrôleurs pour le formulaire de modification
//   late TextEditingController nameController;
//   late TextEditingController phoneController;
//   final formKey = GlobalKey<FormState>();

//   // <--- AJOUT : État de chargement pour la sauvegarde
//   var isLoading = false.obs;

//   // <--- AJOUT : Variables "Observables" pour l'UI
//   // Celles-ci vont contenir les données de l'utilisateur et
//   // mettre à jour l'écran de profil automatiquement.
//   var userFullName = ''.obs;
//   var username = ''.obs;
//   var responsableName = ''.obs;
//   var responsablePhoneNumber = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     // Charger les données utilisateur au démarrage du contrôleur
//     _loadUserDataFromService();
//     // Initialiser les contrôleurs de texte
//     nameController = TextEditingController();
//     phoneController = TextEditingController();
//   }

//   @override
//   void onClose() {
//     // Toujours nettoyer les contrôleurs
//     nameController.dispose();
//     phoneController.dispose();
//     super.onClose();
//   }

//   /// <--- AJOUT : Charge les données de UserInfoService dans les variables observables
//   void _loadUserDataFromService() {
//     userFullName.value = userInfoService.userFullName;
//     username.value = userInfoService.username;
//     responsableName.value = userInfoService.responsableName;
//     responsablePhoneNumber.value = userInfoService.responsablePhoneNumber;
//   }

//   /// <--- AJOUT : Prépare les champs d'édition avant d'ouvrir la page
//   void initEditFields() {
//     // Gère le cas où la valeur est "NULL" de l'API
//     nameController.text =
//         responsableName.value == 'NULL' ? '' : responsableName.value;
//     phoneController.text = responsablePhoneNumber.value == 'NULL'
//         ? ''
//         : responsablePhoneNumber.value;
//   }

//   /// <--- AJOUT : Fonction pour sauvegarder le profil
//   // Future<void> saveProfile() async {
//   //   if (!formKey.currentState!.validate()) {
//   //     return; // Formulaire non valide
//   //   }

//   //   isLoading(true);

//   //   Map<String, dynamic> attributesToUpdate = {
//   //     // Assurez-vous que ces clés sont EXACTEMENT celles de Keycloak
//   //     "responsableName": nameController.text,
//   //     "responsablePhoneNumber": phoneController.text,
//   //   };

//   //   // 1. Appeler l'API
//   //   bool success = await authService.updateUserAttributes(attributesToUpdate);

//   //   if (success) {
//   //     // 2. Rafraîchir les données utilisateur locales
//   //     await authService.refreshUserInfo();

//   //     // 3. Re-charger les données dans nos variables observables
//   //     _loadUserDataFromService();

//   //     // 4. Revenir à l'écran de profil
//   //     Get.back(); // Ferme l'écran d'édition
//   //     Get.snackbar("Succès", "Profil mis à jour.");
//   //   } else {
//   //     Get.snackbar("Erreur", "La mise à jour a échoué.");
//   //   }

//   //   isLoading(false);
//   // }

//   // lib/controllers/profile_controller.dart

//   /// <--- COPIEZ ET REMPLACEZ CETTE FONCTION ENTIÈRE
//   // DANS lib/controllers/profile_controller.dart
// // REMPLACEZ CETTE FONCTION :*

//   Future<bool> executeLoginAndUpdateUser() async {
//     try {
//       print("🔵 [1] Début executeLoginAndUpdateUser()");

//       // -------------------- LOGIN --------------------
//       print("🔵 [2] Envoi requête LOGIN → ${ApiEndpoints.loginEndpoint}");

//       final urlLogin = Uri.parse(
//           "http://172.16.20.217:9000/realms/master/protocol/openid-connect/token");

//       final loginBody = {
//         'grant_type': 'password',
//         'client_id': 'admin-cli',
//         'username': "admin",
//         'password': "admin",
//       };

//       final loginHeaders = {
//         'Content-Type': 'application/x-www-form-urlencoded',
//       };

//       print("➡️  LOGIN headers: $loginHeaders");
//       print("➡️  LOGIN body: $loginBody");

//       final loginResponse = await http.post(
//         urlLogin,
//         headers: loginHeaders,
//         body: loginBody,
//       );

//       print("⬅️  LOGIN status code: ${loginResponse.statusCode}");
//       print("⬅️  LOGIN response: ${loginResponse.body}");

//       if (loginResponse.statusCode != 200) {
//         print("❌ [LOGIN ERROR] Status Code: ${loginResponse.statusCode}");
//         return false;
//       }

//       final loginData = json.decode(loginResponse.body);
//       final token = loginData['access_token'];

//       print("🔑 TOKEN: $token");

//       if (token == null) {
//         print("❌ Aucun token reçu !");
//         return false;
//       }

//       // -------------------- PUT UPDATE USER --------------------
//       final urlUpdate = Uri.parse(
//         "http://172.16.20.217:9000/admin/realms/province_settat/users/ccfbfa66-69b9-4c54-8fd9-9d04a2381f05",
//       );

//       print("🔵 [3] Envoi PUT update → $urlUpdate");

//       final updateHeaders = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       };

//       print("➡️  PUT headers: $updateHeaders");

//       final data = {
//         "firstName": "jjjjjjjjjjjj",
//         "lastName": "jjjjjjjj",
//         "email": "jjjjj@hhh.com",
//         "emailVerified": false,
//         "attributes": {
//           "responsableName": ["jjjjjjj"]
//         }
//       };

//       print("➡️  PUT JSON BODY: ${jsonEncode(data)}");

//       final updateResponse = await http.put(
//         urlUpdate,
//         headers: updateHeaders,
//         body: jsonEncode(data),
//       );

//       print("⬅️  PUT status code: ${updateResponse.statusCode}");
//       print("⬅️  PUT response: ${updateResponse.body}");

//       if (updateResponse.statusCode == 200 ||
//           updateResponse.statusCode == 204) {
//         print("✅ Mise à jour réussie !");
//         return true;
//       }

//       print(
//           "❌ [PUT ERROR] Status ${updateResponse.statusCode} → ${updateResponse.body}");
//       return false;
//     } catch (e, stack) {
//       print("🔥 Exception capturée: $e");
//       print("🔥 Stack trace: $stack");
//       return false;
//     }
//   }

//   Future<void> saveProfile() async {
//     if (!formKey.currentState!.validate()) {
//       return; // Formulaire non valide
//     }

//     isLoading(true);

//     String newName = nameController.text;
//     String newPhone = phoneController.text;

//     // 1. Appeler l'API (Notez le nom de la fonction)
//     bool success = await authService.updateUserProfile(newName, newPhone);

//     if (success) {
//       // 2. Rafraîchir les données utilisateur locales
//       await authService.refreshUserInfo();

//       // 3. Re-charger les données dans nos variables observables
//       _loadUserDataFromService();

//       // 4. Revenir à l'écran de profil
//       Get.back(); // Ferme l'écran d'édition
//       Get.snackbar("Succès", "Profil mis à jour.");
//     } else {
//       Get.snackbar("Erreur", "La mise à jour a échoué.");
//     }

//     isLoading(false);
//   }

//   // C'est votre fonction de déconnexion originale (inchangée)
//   void logout() {
//     Get.dialog(const ConfirmationDialog(
//       title: AppStrings.validateConfirmationTitle,
//       content: ProfileStrings.logoutConfirmationDialog,
//     )).then((isConfirmed) async {
//       if (isConfirmed ?? false) {
//         Get.dialog(LoadingDialog(), barrierDismissible: false);
//         userInfoService.clearUserInfo();
//         await Get.deleteAll();
//         await secureStorageService.deleteUsername();
//         await secureStorageService.deletePassword();
//         // Clear image cache
//         PaintingBinding.instance.imageCache.clear();
//         //Todo: Delete Token from SecureStorage and delete user info
//         Get.offAllNamed(Routes.logingPage);
//       }
//     });
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../services/storage_service/secure_storage_service.dart';
import '../services/user_info_service.dart';
import '../services/api_service/auth_service.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/loading_dialog.dart';
import '../routes/routes.dart';
import '../utils/resources/global/app_strings.dart';
import '../utils/resources/profile/profile_strings.dart';

class ProfileController extends GetxController {
  // Services
  final UserInfoService userInfoService = UserInfoService();
  final SecureStorageService secureStorageService = SecureStorageService();
  final AuthService authService = AuthService();

  // Form controllers
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController responsableNameController;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  // Observables pour UI
  var userFullName = ''.obs;
  var username = ''.obs;
  var responsableName = ''.obs;
  var responsablePhoneNumber = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;

  VoidCallback? get saveProfile => null;

  @override
  void onInit() {
    super.onInit();
    // Initialize text controllers
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    responsableNameController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();

    // Load user data
    _loadUserDataFromService();
    _initEditFields();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    responsableNameController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void _loadUserDataFromService() {
    userFullName.value = userInfoService.userFullName;
    username.value = userInfoService.username;
    responsableName.value = userInfoService.responsableName;
    responsablePhoneNumber.value = userInfoService.responsablePhoneNumber;
    firstName.value = userInfoService.firstName;
    lastName.value = userInfoService.lastName;
    email.value = userInfoService.email;
  }

  /// Initialise les champs de modification
  void _initEditFields() {
    firstNameController.text = firstName.value == 'NULL' ? '' : firstName.value;
    lastNameController.text = lastName.value == 'NULL' ? '' : lastName.value;
    emailController.text = email.value == 'NULL' ? '' : email.value;
    responsableNameController.text =
        responsableName.value == 'NULL' ? '' : responsableName.value;
    nameController.text =
        userFullName.value == 'NULL' ? '' : userFullName.value;
    phoneController.text = responsablePhoneNumber.value == 'NULL'
        ? ''
        : responsablePhoneNumber.value;
  }

  /// Execute PUT sur Keycloak avec tous les champs du formulaire
  Future<bool> executeLoginAndUpdateUser() async {
    if (!formKey.currentState!.validate()) {
      return false; // Formulaire invalide
    }

    isLoading(true);
    try {
      // Login pour récupérer token
      final urlLogin = Uri.parse(
          "http://172.16.20.217:9000/realms/master/protocol/openid-connect/token");
      final loginBody = {
        'grant_type': 'password',
        'client_id': 'admin-cli',
        'username': "admin",
        'password': "admin",
      };
      final loginHeaders = {
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      final loginResponse =
          await http.post(urlLogin, headers: loginHeaders, body: loginBody);

      if (loginResponse.statusCode != 200) return false;
      final loginData = json.decode(loginResponse.body);
      final token = loginData['access_token'];
      if (token == null) return false;

      // PUT update user
      final urlUpdate = Uri.parse(
        "http://172.16.20.217:9000/admin/realms/province_settat/users/ccfbfa66-69b9-4c54-8fd9-9d04a2381f05",
      );

      final updateHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final data = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": emailController.text,
        "emailVerified": false,
        "attributes": {
          "responsableName": [responsableNameController.text],
          "responsablePhoneNumber": [phoneController.text],
          "fullName": [nameController.text],
        },
      };

      final updateResponse = await http.put(
        urlUpdate,
        headers: updateHeaders,
        body: jsonEncode(data),
      );

      if (updateResponse.statusCode == 200 ||
          updateResponse.statusCode == 204) {
        // Mettre à jour localement
        await authService.refreshUserInfo();
        _loadUserDataFromService();
        isLoading(false);
        return true;
      } else {
        print(
            "Erreur PUT: ${updateResponse.statusCode} → ${updateResponse.body}");
        isLoading(false);
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      isLoading(false);
      return false;
    }
  }

  // Logout (inchangé)
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
        PaintingBinding.instance.imageCache.clear();
        Get.offAllNamed(Routes.logingPage);
      }
    });
  }

  void initEditFields() {}
}
