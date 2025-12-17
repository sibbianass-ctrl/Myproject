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
import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:my_project/controllers/app_snackbar_controller.dart';
import 'package:my_project/controllers/portfolio_history_controller.dart';
import 'package:my_project/models/sortie.dart';
import 'package:my_project/services/api_service/commands_service.dart';
import '../services/api_service/file_upload_service.dart';
import '../utils/chrono_helper.dart';
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

  // ====== Chrono countdown state ======
  /// Remaining duration for the countdown timer.
  /// null means data is invalid, Duration.zero means time expired.
  final Rxn<Duration> chronoRemaining = Rxn<Duration>();
  Timer? _chronoTimer;

  /// Starts the countdown timer based on delayExecuteDay and dateEffectStart.
  /// Call this after sortie data is loaded.
  void startCountdown() {
    // Cancel any existing timer
    _chronoTimer?.cancel();

    // Check if data is valid
    if (!ChronoHelper.isChronoDataValid(
      delayExecuteDay: sortie.value.delayExecuteDay,
      dateEffectStart: sortie.value.dateEffectStart,
    )) {
      chronoRemaining.value = null;
      return;
    }

    // Calculate initial remaining time
    _updateChronoRemaining();

    // Start periodic timer to update every second
    _chronoTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateChronoRemaining();
    });
  }

  /// Updates the chronoRemaining value based on current time.
  void _updateChronoRemaining() {
    final remaining = ChronoHelper.calculateRemaining(
      delayExecuteDay: sortie.value.delayExecuteDay,
      dateEffectStart: sortie.value.dateEffectStart,
    );
    chronoRemaining.value = remaining;

    // Stop timer if we've reached zero
    if (remaining == Duration.zero) {
      _chronoTimer?.cancel();
    }
  }

  /// Formatted HH:MM:SS string for display.
  String get chronoHMS => ChronoHelper.formatHMS(chronoRemaining.value);

  /// Formatted days remaining string for display.
  String get chronoDaysRemaining =>
      ChronoHelper.formatDaysRemaining(chronoRemaining.value);

  @override
  void onClose() {
    _chronoTimer?.cancel();
    super.onClose();
  }

  // ====== Arabic text getters for chrono info ======

  /// Arabic formatted string for execution delay
  String get delayExecuteTextAr {
    final days = sortie.value.delayExecuteDay;
    if (days == null || days.isEmpty) {
      return 'مدة التنفيذ المتوقعة: غير محددة';
    }
    return 'مدة التنفيذ المتوقعة: $days يوم';
  }

  /// Arabic formatted string for expected start date
  String get prevStartDateTextAr {
    final dateStr = sortie.value.prevStartDate;
    if (dateStr == null || dateStr.isEmpty) {
      return 'تاريخ الانطلاق المتوقع: غير محدد';
    }
    try {
      final date = DateTime.parse(dateStr);
      final formatted = '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';
      return 'تاريخ الانطلاق المتوقع: $formatted';
    } catch (_) {
      return 'تاريخ الانطلاق المتوقع: $dateStr';
    }
  }

  /// Arabic formatted string for effective start date (from Démarrage status)
  String get dateEffectStartTextAr {
    final dateStr = sortie.value.dateEffectStart;
    if (dateStr == null || dateStr.isEmpty) {
      return 'تاريخ الانطلاق الفعلي: غير محدد';
    }
    try {
      final date = DateTime.parse(dateStr);
      final formatted = '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';
      return 'تاريخ الانطلاق الفعلي: $formatted';
    } catch (_) {
      return 'تاريخ الانطلاق الفعلي: $dateStr';
    }
  }

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
    Get.dialog(LoadingDialog(), barrierDismissible: false);

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
