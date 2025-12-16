// // // // import 'dart:io';
// // // // import 'package:get/get.dart';
// // // // import 'package:my_project/controllers/app_snackbar_controller.dart';
// // // // import 'package:my_project/models/sortie.dart';
// // // // import 'package:my_project/services/api_service/commands_service.dart';
// // // // import '../services/api_service/file_upload_service.dart';
// // // // import '../utils/resources/global/app_strings.dart';
// // // // import '../utils/visit_utils.dart';
// // // // import '../widgets/confirmation_dialog.dart';
// // // // import '../widgets/loading_dialog.dart';
// // // // import 'photo_controller.dart';
// // // //
// // // // class OridnaryVisitController extends GetxController {
// // // //   Rx<Sortie> sortie = Sortie().obs;
// // // //   final PhotoController photoController = Get.put(PhotoController());
// // // //   FileUploadService _fileUploadService = FileUploadService();
// // // //   List<String> files = <String>[];
// // // //   int sortiesCount = 0;
// // // //
// // // //   List<String> getSelectedObjectsIds() {
// // // //     return sortie.value.objects
// // // //         .where((checkbox) => checkbox['state'] == true)
// // // //         .map<String>((checkbox) => checkbox['id'])
// // // //         .toList();
// // // //   }
// // // //
// // // //   List<String> getSelectedConstatsIds() {
// // // //     return sortie.value.constats
// // // //         .where((checkbox) => checkbox['state'] == true)
// // // //         .map<String>((checkbox) => checkbox['id'])
// // // //         .toList();
// // // //   }
// // // //
// // // //   List<String> getSelectedRecomedationsIds() {
// // // //     return sortie.value.recommendations
// // // //         .where((checkbox) => checkbox['state'] == true)
// // // //         .map<String>((checkbox) => checkbox['id'])
// // // //         .toList();
// // // //   }
// // // //
// // // //   void clearData() {
// // // //     for (Map<String, dynamic> cbx in sortie.value.objects) {
// // // //       cbx['state'] = false;
// // // //     }
// // // //     for (Map<String, dynamic> cbx in sortie.value.constats) {
// // // //       cbx['state'] = false;
// // // //     }
// // // //     for (Map<String, dynamic> cbx in sortie.value.recommendations) {
// // // //       cbx['state'] = false;
// // // //     }
// // // //   }
// // // //
// // // //   void confirmValidation() async {
// // // //     final confirmed = await Get.dialog(const ConfirmationDialog(
// // // //       title: AppStrings.validateConfirmationTitle,
// // // //       content: AppStrings.validateConfirmationMessage,
// // // //     ));
// // // //
// // // //     if (confirmed ?? false) {
// // // //       if (VisitUtils.verificationForm(
// // // //           sortie.value.workStateValue, sortie.value.workRateValue)) {
// // // //         if (photoController.photos.isEmpty) {
// // // //           snackbarError(AppStrings.noPhotosError);
// // // //           return;
// // // //         }
// // // //         await uploadPhotos();
// // // //         Get.dialog(LoadingDialog(), barrierDismissible: false);
// // // //
// // // //         if (await CommandsService.postOrdinaryVisite(
// // // //             sortie.value,
// // // //             getSelectedObjectsIds(),
// // // //             getSelectedConstatsIds(),
// // // //             getSelectedRecomedationsIds(),
// // // //             files)) {
// // // //           sortie.value.isValidated = true;
// // // //           sortie.refresh();
// // // //
// // // //           photoController.photos.clear();
// // // //           await photoController.removeAll();
// // // //           Get.back();
// // // //         } else {
// // // //           snackbarError(AppStrings.errorWhilePosting);
// // // //         }
// // // //         Get.back();
// // // //       }
// // // //     }
// // // //   }
// // // //
// // // //   Future<bool> uploadPhotos() async {
// // // //     Get.dialog(
// // // //         LoadingDialog(
// // // //           text: AppStrings.uploadingPhotos,
// // // //         ),
// // // //         barrierDismissible: false);
// // // //     for (File file in photoController.photos) {
// // // //       String? photoName = await _fileUploadService.uploadFile(file);
// // // //       if (photoName == null) return false;
// // // //       files.add(photoName.toString());
// // // //     }
// // // //     Get.back();
// // // //     return true;
// // // //   }
// // // // }
// // //
// // //
// // // import 'dart:io';
// // // import 'package:get/get.dart';
// // // import 'package:my_project/controllers/app_snackbar_controller.dart';
// // // import 'package:my_project/models/sortie.dart';
// // // import 'package:my_project/services/api_service/commands_service.dart';
// // // import '../services/api_service/file_upload_service.dart';
// // // import '../utils/resources/global/app_strings.dart';
// // // import '../utils/visit_utils.dart';
// // // import '../widgets/confirmation_dialog.dart';
// // // import '../widgets/loading_dialog.dart';
// // // import 'photo_controller.dart';
// // //
// // // class OridnaryVisitController extends GetxController {
// // //   Rx<Sortie> sortie = Sortie().obs;
// // //   final PhotoController photoController = Get.put(PhotoController());
// // //   FileUploadService _fileUploadService = FileUploadService();
// // //   List<String> files = <String>[];
// // //   int sortiesCount = 0;
// // //
// // //   List<String> getSelectedObjectsIds() {
// // //     return sortie.value.objects
// // //         .where((checkbox) => checkbox['state'] == true)
// // //         .map<String>((checkbox) => checkbox['id'])
// // //         .toList();
// // //   }
// // //
// // //   List<String> getSelectedConstatsIds() {
// // //     return sortie.value.constats
// // //         .where((checkbox) => checkbox['state'] == true)
// // //         .map<String>((checkbox) => checkbox['id'])
// // //         .toList();
// // //   }
// // //
// // //   List<String> getSelectedRecomedationsIds() {
// // //     return sortie.value.recommendations
// // //         .where((checkbox) => checkbox['state'] == true)
// // //         .map<String>((checkbox) => checkbox['id'])
// // //         .toList();
// // //   }
// // //
// // //   void clearData() {
// // //     for (Map<String, dynamic> cbx in sortie.value.objects) {
// // //       cbx['state'] = false;
// // //     }
// // //     for (Map<String, dynamic> cbx in sortie.value.constats) {
// // //       cbx['state'] = false;
// // //     }
// // //     for (Map<String, dynamic> cbx in sortie.value.recommendations) {
// // //       cbx['state'] = false;
// // //     }
// // //   }
// // //
// // //   void confirmValidation() async {
// // //     final confirmed = await Get.dialog(const ConfirmationDialog(
// // //       title: AppStrings.validateConfirmationTitle,
// // //       content: AppStrings.validateConfirmationMessage,
// // //     ));
// // //
// // //     if (confirmed ?? false) {
// // //       if (VisitUtils.verificationForm(
// // //           sortie.value.workStateValue, sortie.value.workRateValue)) {
// // //         if (photoController.photos.isEmpty) {
// // //           snackbarError(AppStrings.noPhotosError);
// // //           return;
// // //         }
// // //         await uploadPhotos();
// // //         Get.dialog(LoadingDialog(), barrierDismissible: false);
// // //
// // //         if (await CommandsService.postOrdinaryVisite(
// // //           sortie.value,
// // //           getSelectedObjectsIds(),
// // //           getSelectedConstatsIds(),
// // //           getSelectedRecomedationsIds(),
// // //           files,
// // //         )) {
// // //           sortie.value.isValidated = true;
// // //           sortie.refresh();
// // //
// // //           photoController.photos.clear();
// // //           await photoController.removeAll();
// // //           Get.back();
// // //         } else {
// // //           snackbarError(AppStrings.errorWhilePosting);
// // //         }
// // //         Get.back();
// // //       }
// // //     }
// // //   }
// // //
// // //   Future<bool> uploadPhotos() async {
// // //     Get.dialog(
// // //       LoadingDialog(
// // //         text: AppStrings.uploadingPhotos,
// // //       ),
// // //       barrierDismissible: false,
// // //     );
// // //
// // //     files.clear();
// // //     sortie.value.photos.clear();
// // //
// // //     for (File file in photoController.photos) {
// // //       String? photoName = await _fileUploadService.uploadFile(file);
// // //       if (photoName == null) return false;
// // //       files.add(photoName.toString());
// // //       sortie.value.photos.add(photoName.toString());
// // //     }
// // //
// // //     sortie.refresh();
// // //     Get.back();
// // //     return true;
// // //   }
// // // }
// // import 'dart:io';
// // import 'package:get/get.dart';
// // import 'package:my_project/controllers/app_snackbar_controller.dart';
// // import 'package:my_project/controllers/portfolio_history_controller.dart';
// // import 'package:my_project/models/sortie.dart';
// // import 'package:my_project/services/api_service/commands_service.dart';
// // import 'package:my_project/views/portfolio/portfolio_validated_details_view.dart';
// // import '../services/api_service/file_upload_service.dart';
// // import '../utils/resources/global/app_strings.dart';
// // import '../utils/visit_utils.dart';
// // import '../widgets/confirmation_dialog.dart';
// // import '../widgets/loading_dialog.dart';
// // import 'photo_controller.dart';
// //
// // class OridnaryVisitController extends GetxController {
// //   Rx<Sortie> sortie = Sortie().obs;
// //   final PhotoController photoController = Get.put(PhotoController());
// //   final FileUploadService _fileUploadService = FileUploadService();
// //   List<String> files = <String>[];
// //   int sortiesCount = 0;
// //
// //   List<String> getSelectedObjectsIds() {
// //     return sortie.value.objects
// //         .where((checkbox) => checkbox['state'] == true)
// //         .map<String>((checkbox) => checkbox['id'])
// //         .toList();
// //   }
// //
// //   List<String> getSelectedConstatsIds() {
// //     return sortie.value.constats
// //         .where((checkbox) => checkbox['state'] == true)
// //         .map<String>((checkbox) => checkbox['id'])
// //         .toList();
// //   }
// //
// //   List<String> getSelectedRecomedationsIds() {
// //     return sortie.value.recommendations
// //         .where((checkbox) => checkbox['state'] == true)
// //         .map<String>((checkbox) => checkbox['id'])
// //         .toList();
// //   }
// //
// //   void clearData() {
// //     for (Map<String, dynamic> cbx in sortie.value.objects) {
// //       cbx['state'] = false;
// //     }
// //     for (Map<String, dynamic> cbx in sortie.value.constats) {
// //       cbx['state'] = false;
// //     }
// //     for (Map<String, dynamic> cbx in sortie.value.recommendations) {
// //       cbx['state'] = false;
// //     }
// //   }
// //
// //   void confirmValidation() async {
// //     final confirmed = await Get.dialog(const ConfirmationDialog(
// //       title: AppStrings.validateConfirmationTitle,
// //       content: AppStrings.validateConfirmationMessage,
// //     ));
// //
// //     if (confirmed ?? false) {
// //       if (VisitUtils.verificationForm(
// //         sortie.value.workStateValue,
// //         sortie.value.workRateValue,
// //       )) {
// //         if (photoController.photos.isEmpty) {
// //           snackbarError(AppStrings.noPhotosError);
// //           return;
// //         }
// //
// //         await uploadPhotos();
// //         Get.dialog(LoadingDialog(), barrierDismissible: false);
// //
// //         final ok = await CommandsService.postOrdinaryVisite(
// //           sortie.value,
// //           getSelectedObjectsIds(),
// //           getSelectedConstatsIds(),
// //           getSelectedRecomedationsIds(),
// //           files,
// //         );
// //
// //         if (ok) {
// //           // نحدّث حالة sortie المحلية
// //           sortie.value.isValidated = true;
// //           sortie.refresh();
// //
// //           // نفرّغ الصور من الكاش
// //           photoController.photos.clear();
// //           await photoController.removeAll();
// //
// //           // 1) نحدّث historique
// //           final historyController = Get.put(PortfolioHistoryController());
// //           await historyController.loadValidatedSorties();
// //
// //           // 2) نمشي مباشرة للـ PortfolioValidatedDetailsView
// //           final lotNumber = sortie.value.marketNumber ?? '';
// //           final lotName   = sortie.value.marketName ?? '';
// //
// //           Get.off(() => PortfolioValidatedDetailsView(
// //             lotNumber: lotNumber,
// //             lotName: lotName,
// //           ));
// //         } else {
// //           snackbarError(AppStrings.errorWhilePosting);
// //           // Get.back(); // إغلاق LoadingDialog
// //         }
// //
// //         // إذا النجاح تعاملنا معه فوق بـ Get.off، هنا نضمن فقط إغلاق أي Dialog باقي
// //         if (Get.isDialogOpen == true) {
// //           // Get.back();
// //         }
// //       }
// //     }
// //   }
// //
// //   Future<bool> uploadPhotos() async {
// //     Get.dialog(
// //       LoadingDialog(
// //         text: AppStrings.uploadingPhotos,
// //       ),
// //       barrierDismissible: false,
// //     );
// //
// //     files.clear();
// //     sortie.value.photos.clear();
// //
// //     for (File file in photoController.photos) {
// //       String? photoName = await _fileUploadService.uploadFile(file);
// //       if (photoName == null) {
// //         Get.back();
// //         return false;
// //       }
// //       files.add(photoName);
// //       sortie.value.photos.add(photoName);
// //     }
// //
// //     sortie.refresh();
// //     Get.back();
// //     return true;
// //   }
// // }
// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:my_project/controllers/app_snackbar_controller.dart';
// import 'package:my_project/controllers/portfolio_history_controller.dart';
// import 'package:my_project/models/sortie.dart';
// import 'package:my_project/services/api_service/commands_service.dart';
// import '../services/api_service/file_upload_service.dart';
// import '../utils/resources/global/app_strings.dart';
// import '../utils/visit_utils.dart';
// import '../widgets/confirmation_dialog.dart';
// import '../widgets/loading_dialog.dart';
// import 'photo_controller.dart';
//
// class OridnaryVisitController extends GetxController {
//   Rx<Sortie> sortie = Sortie().obs;
//   final PhotoController photoController = Get.put(PhotoController());
//   final FileUploadService _fileUploadService = FileUploadService();
//   List<String> files = <String>[];
//   int sortiesCount = 0;
//
//   List<String> getSelectedObjectsIds() {
//     return sortie.value.objects
//         .where((checkbox) => checkbox['state'] == true)
//         .map<String>((checkbox) => checkbox['id'])
//         .toList();
//   }
//
//   List<String> getSelectedConstatsIds() {
//     return sortie.value.constats
//         .where((checkbox) => checkbox['state'] == true)
//         .map<String>((checkbox) => checkbox['id'])
//         .toList();
//   }
//
//   List<String> getSelectedRecomedationsIds() {
//     return sortie.value.recommendations
//         .where((checkbox) => checkbox['state'] == true)
//         .map<String>((checkbox) => checkbox['id'])
//         .toList();
//   }
//
//   void clearData() {
//     for (Map<String, dynamic> cbx in sortie.value.objects) {
//       cbx['state'] = false;
//     }
//     for (Map<String, dynamic> cbx in sortie.value.constats) {
//       cbx['state'] = false;
//     }
//     for (Map<String, dynamic> cbx in sortie.value.recommendations) {
//       cbx['state'] = false;
//     }
//   }
//
//   void confirmValidation() async {
//     final confirmed = await Get.dialog(const ConfirmationDialog(
//       title: AppStrings.validateConfirmationTitle,
//       content: AppStrings.validateConfirmationMessage,
//     ));
//
//     if (confirmed ?? false) {
//       if (VisitUtils.verificationForm(
//         sortie.value.workStateValue,
//         sortie.value.workRateValue,
//       )) {
//         if (photoController.photos.isEmpty) {
//           snackbarError(AppStrings.noPhotosError);
//           return;
//         }
//
//         await uploadPhotos();
//         Get.dialog(LoadingDialog(), barrierDismissible: false);
//
//         final ok = await CommandsService.postOrdinaryVisite(
//           sortie.value,
//           getSelectedObjectsIds(),
//           getSelectedConstatsIds(),
//           getSelectedRecomedationsIds(),
//           files,
//         );
//
//         if (ok) {
//           // تحديث sortie المحلية
//           sortie.value.isValidated = true;
//           sortie.refresh();
//
//           // تفريغ الصور
//           photoController.photos.clear();
//           await photoController.removeAll();
//
//           // تحديث historique/portfolio في الخلفية
//           final historyController = Get.put(PortfolioHistoryController());
//           await historyController.loadValidatedSorties();
//
//           // إغلاق الـ LoadingDialog والبقاء في نفس الشاشة
//           if (Get.isDialogOpen == true) {
//             Get.back();
//           }
//           snackbarSuccess('Sortie validée avec succès');
//         } else {
//           snackbarError(AppStrings.errorWhilePosting);
//           if (Get.isDialogOpen == true) {
//             Get.back();
//           }
//         }
//       }
//     }
//   }
//
//   Future<bool> uploadPhotos() async {
//     Get.dialog(
//       LoadingDialog(
//         text: AppStrings.uploadingPhotos,
//       ),
//       barrierDismissible: false,
//     );
//
//     files.clear();
//     sortie.value.photos.clear();
//
//     for (File file in photoController.photos) {
//       String? photoName = await _fileUploadService.uploadFile(file);
//       if (photoName == null) {
//         Get.back();
//         return false;
//       }
//       files.add(photoName);
//       sortie.value.photos.add(photoName);
//     }
//
//     sortie.refresh();
//     Get.back();
//     return true;
//   }
// }
import 'dart:io';
import 'package:get/get.dart';
import 'package:my_project/controllers/app_snackbar_controller.dart';
import 'package:my_project/controllers/portfolio_history_controller.dart';
import 'package:my_project/models/sortie.dart';
import 'package:my_project/services/api_service/commands_service.dart';
import '../services/api_service/file_upload_service.dart';
import '../utils/resources/global/app_strings.dart';
import '../utils/visit_utils.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/loading_dialog.dart';
import 'photo_controller.dart';

class OridnaryVisitController extends GetxController {
  Rx<Sortie> sortie = Sortie().obs;
  final PhotoController photoController = Get.put(PhotoController());
  final FileUploadService _fileUploadService = FileUploadService();
  List<String> files = <String>[];
  int sortiesCount = 0;

  // ----- Helpers للـ IDs المختارة -----

  List<String> getSelectedObjectsIds() {
    return sortie.value.objects
        .where((checkbox) => checkbox['state'] == true)
        .map<String>((checkbox) => checkbox['id'])
        .toList();
  }

  List<String> getSelectedConstatsIds() {
    return sortie.value.constats
        .where((checkbox) => checkbox['state'] == true)
        .map<String>((checkbox) => checkbox['id'])
        .toList();
  }

  List<String> getSelectedRecomedationsIds() {
    return sortie.value.recommendations
        .where((checkbox) => checkbox['state'] == true)
        .map<String>((checkbox) => checkbox['id'])
        .toList();
  }

  void clearData() {
    for (Map<String, dynamic> cbx in sortie.value.objects) {
      cbx['state'] = false;
    }
    for (Map<String, dynamic> cbx in sortie.value.constats) {
      cbx['state'] = false;
    }
    for (Map<String, dynamic> cbx in sortie.value.recommendations) {
      cbx['state'] = false;
    }
  }

  // ----- Validation de la visite ordinaire -----

  void confirmValidation() async {
    final confirmed = await Get.dialog(const ConfirmationDialog(
      title: AppStrings.validateConfirmationTitle,
      content: AppStrings.validateConfirmationMessage,
    ));

    if (!(confirmed ?? false)) return;

    // Vérification formulaire (état / cadence)
    if (!VisitUtils.verificationForm(
      sortie.value.workStateValue,
      sortie.value.workRateValue,
    )) {
      return;
    }

    // Photos obligatoires
    if (photoController.photos.isEmpty) {
      snackbarError(AppStrings.noPhotosError);
      return;
    }

    // Upload des photos
    final uploaded = await uploadPhotos();
    if (!uploaded) return;

    // Loading global pendant l'appel API
    Get.dialog( LoadingDialog(), barrierDismissible: false);

    final ok = await CommandsService.postOrdinaryVisite(
      sortie.value,
      getSelectedObjectsIds(),
      getSelectedConstatsIds(),
      getSelectedRecomedationsIds(),
      files,
    );

    if (ok) {
      // 1) تحديث sortie المحلية
      sortie.value.isValidated = true;
      sortie.refresh();

      // 2) تفريغ الصور من الكاش
      photoController.photos.clear();
      await photoController.removeAll();

      // 3) تحديث historique/portfolio فالكواليس
      final historyController = Get.put(PortfolioHistoryController());
      await historyController.loadValidatedSorties();

      // 4) إغلاق الـ LoadingDialog والبقاء في نفس الشاشة
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      snackbarSuccess('Sortie validée avec succès');
    } else {
      snackbarError(AppStrings.errorWhilePosting);
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }

  // ----- Upload des photos -----

  Future<bool> uploadPhotos() async {
    Get.dialog(
      LoadingDialog(
        text: AppStrings.uploadingPhotos,
      ),
      barrierDismissible: false,
    );

    files.clear();
    sortie.value.photos.clear();

    for (File file in photoController.photos) {
      final String? photoName = await _fileUploadService.uploadFile(file);
      if (photoName == null) {
        // erreur upload => fermer dialog et stopper
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        snackbarError(AppStrings.errorWhilePosting);
        return false;
      }
      files.add(photoName);
      sortie.value.photos.add(photoName);
    }

    sortie.refresh();

    if (Get.isDialogOpen == true) {
      Get.back();
    }
    return true;
  }
}
