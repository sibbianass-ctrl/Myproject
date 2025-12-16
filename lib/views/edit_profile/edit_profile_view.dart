// // lib/views/edit_profile/edit_profile_view.dart

// import 'package:flutter/material.dart';
// // N'importez PAS 'package:get/get.dart'; ici, nous n'en avons pas besoin.
// import 'package:my_project/services/api_service/auth_service.dart'; // Votre AuthService
// import 'package:my_project/services/user_info_service.dart';

// class EditProfileView extends StatefulWidget {
//   const EditProfileView({super.key});

//   @override
//   State<EditProfileView> createState() => _EditProfileViewState();
// }

// class _EditProfileViewState extends State<EditProfileView> {
//   // --- MODIFICATION ICI ---
//   // Nous récupérons les services en appelant directement le singleton
//   // au lieu d'utiliser Get.find()
//   final UserInfoService _userInfoService = UserInfoService();
//   final AuthService _authService = AuthService();
//   // --- FIN DE LA MODIFICATION ---

//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _nameController;
//   late TextEditingController _phoneController;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     // Pré-remplir les champs avec les données actuelles du service
//     // (Nous gérons les valeurs 'NULL' que vous aviez dans votre image)
//     String name = _userInfoService.responsableName;
//     String phone = _userInfoService.responsablePhoneNumber;

//     _nameController = TextEditingController(text: name == 'NULL' ? '' : name);
//     _phoneController =
//         TextEditingController(text: phone == 'NULL' ? '' : phone);
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }

//   /// Fonction appelée lors de l'appui sur le bouton "Sauvegarder"
//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     // D'après votre UserInfoService, les noms d'attributs sont :
//     // "responsableName" et "responsablePhoneNumber"
//     Map<String, dynamic> attributesToUpdate = {
//       "responsableName": _nameController.text,
//       "responsablePhoneNumber": _phoneController.text,
//     };

//     // 1. Envoyer les modifications à Keycloak
//     bool success = await _authService.updateUserAttributes(attributesToUpdate);

//     if (success) {
//       // 2. Si succès, rafraîchir les données locales
//       await _authService.refreshUserInfo();

//       if (mounted) {
//         Navigator.pop(context); // Revenir à l'écran de profil
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Profil mis à jour avec succès!')),
//         );
//       }
//     } else {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur lors de la mise à jour.')),
//         );
//       }
//     }

//     if (mounted) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Modifier le profil'),
//         actions: [
//           _isLoading
//               ? Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                     strokeWidth: 2.0,
//                   ),
//                 )
//               : IconButton(
//                   icon: Icon(Icons.save),
//                   onPressed: _saveProfile,
//                 ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Nom du responsable',
//                   icon: Icon(Icons.person),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Veuillez entrer un nom';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   labelText: 'Téléphone du responsable',
//                   icon: Icon(Icons.phone),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/views/edit_profile/edit_profile_view.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart'; // Nous avons besoin de Obx
// import 'package:my_project/controllers/profile_controller.dart';

// // <--- MODIFICATION : Devient un StatelessWidget
// class EditProfileView extends StatelessWidget {
//   // <--- AJOUT : Accepte le contrôleur en argument
//   final ProfileController controller;

//   const EditProfileView({
//     super.key,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Modifier le profil'),
//         actions: [
//           // Gère l'état de chargement depuis le contrôleur
//           Obx(
//             () => controller.isLoading.value
//                 ? Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2.0,
//                     ),
//                   )
//                 // : IconButton(
//                 //     icon: Icon(Icons.save),
//                 //     // Appelle saveProfile du contrôleur
//                 //     onPressed: controller.saveProfile,
//                 //   )
//                 : IconButton(
//                     icon: Icon(Icons.save),
//                     onPressed: () async {
//                       final result =
//                           await controller.executeLoginAndUpdateUser();

//                       if (result == true) {
//                         print("Tout OK !");
//                       } else {
//                         print("Erreur : $result");
//                       }
//                     },
//                   ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         // Le Form utilise la clé du contrôleur
//         child: Form(
//           key: controller.formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 // Utilise le contrôleur de texte du ProfileController
//                 controller: controller.nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Nom du responsable',
//                   icon: Icon(Icons.person),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Veuillez entrer un nom';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 // Utilise le contrôleur de texte du ProfileController
//                 controller: controller.phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   labelText: 'Téléphone du responsable',
//                   icon: Icon(Icons.phone),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/profile_controller.dart';

class EditProfileView extends StatelessWidget {
  final ProfileController controller;

  const EditProfileView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le profil'),
        actions: [
          Obx(
            () => controller.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    ),
                  )
                : IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () async {
                      final result =
                          await controller.executeLoginAndUpdateUser();
                      if (result) {
                        Get.snackbar("Succès", "Profil mis à jour !");
                      } else {
                        Get.snackbar("Erreur", "Échec de la mise à jour.");
                      }
                    },
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              // -------------------- First Name --------------------
              TextFormField(
                controller: controller.firstNameController,
                decoration: InputDecoration(
                  labelText: 'Prénom',
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prénom';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // -------------------- Last Name --------------------
              TextFormField(
                controller: controller.lastNameController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  icon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // -------------------- Email --------------------
              TextFormField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // -------------------- Responsable Name --------------------
              TextFormField(
                controller: controller.responsableNameController,
                decoration: InputDecoration(
                  labelText: 'Nom du responsable',
                  icon: Icon(Icons.business),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // -------------------- Nom complet (existant) --------------------
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Nom complet',
                  icon: Icon(Icons.person_add),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // -------------------- Phone (existant) --------------------
              TextFormField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Téléphone',
                  icon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
