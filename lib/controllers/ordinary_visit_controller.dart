
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

  // ====== DÉLAI Card Getters (French, no Arabic) ======

  /// Real start date (dateEffectStart from Démarrage status)
  String get realStartText =>
      ChronoHelper.formatDateString(sortie.value.dateEffectStart);

  /// Real end date (dateEffectStart + delayExecuteDay)
  String get realEndText => ChronoHelper.formatEndDate(
        startDateStr: sortie.value.dateEffectStart,
        delayExecuteDay: sortie.value.delayExecuteDay,
      );

  /// Planned start date (prevStartDate from Lot API)
  String get plannedStartText =>
      ChronoHelper.formatDateString(sortie.value.prevStartDate);

  /// Planned end date (prevStartDate + delayExecuteDay)
  String get plannedEndText => ChronoHelper.formatEndDate(
        startDateStr: sortie.value.prevStartDate,
        delayExecuteDay: sortie.value.delayExecuteDay,
      );

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
