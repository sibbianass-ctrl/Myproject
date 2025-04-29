import 'dart:io';
import 'package:get/get.dart';
import 'package:my_project/controllers/app_snackbar_controller.dart';
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
  FileUploadService _fileUploadService = FileUploadService();
  List<String> files = <String>[];

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

  void confirmValidation() async {
    final confirmed = await Get.dialog(const ConfirmationDialog(
      title: AppStrings.validateConfirmationTitle,
      content: AppStrings.validateConfirmationMessage,
    ));

    if (confirmed ?? false) {
      if (VisitUtils.verificationForm(
          sortie.value.workStateValue, sortie.value.workRateValue)) {
        if (photoController.photos.isEmpty) {
          snackbarError(AppStrings.noPhotosError);
          return;
        }
        await uploadPhotos();
        Get.dialog(LoadingDialog(), barrierDismissible: false);
        // uploading photos
        //You can fix this partie where you send just required fields NOT the holl Sortie object
        if (await CommandsService.postOrdinaryVisite(
            sortie.value,
            getSelectedObjectsIds(),
            getSelectedConstatsIds(),
            getSelectedRecomedationsIds(),
            files)) {
          sortie.value.isValidated = true;
          sortie.refresh();

          photoController.photos.clear();
          await photoController.removeAll();
          Get.back();
        } else {
          snackbarError(AppStrings.errorWhilePosting);
        }
        Get.back();
      }
    }
  }

  Future<bool> uploadPhotos() async {
    Get.dialog(
        LoadingDialog(
          text: AppStrings.uploadingPhotos,
        ),
        barrierDismissible: false);
    for (File file in photoController.photos) {
      String? photoName = await _fileUploadService.uploadFile(file);
      if (photoName == null) return false;
      files.add(photoName.toString());
    }
    Get.back();
    return true;
  }
}
