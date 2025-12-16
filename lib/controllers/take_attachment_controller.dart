import 'dart:io';
import 'package:get/get.dart';
import 'package:my_project/controllers/app_snackbar_controller.dart';
import 'package:my_project/models/prestation.dart';
import 'package:my_project/services/api_service/file_upload_service.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';
import 'package:my_project/utils/resources/take_attachment_visit/take_attachment_visit_strings.dart';
import '../models/sortie.dart';
import '../services/api_service/commands_service.dart';
import '../utils/visit_utils.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/loading_dialog.dart';
import 'photo_controller.dart';



class TakeAttachmentController extends GetxController {
  Rx<Sortie> sortie = Sortie().obs;
  RxString searchQuery = ''.obs;
  RxList<Prestation> filteredItems = <Prestation>[].obs;
  final PhotoController photoController = Get.put(PhotoController());
  FileUploadService _fileUploadService = FileUploadService();
  List<String> files = <String>[];
  int sortiesCount = 0;

  // Method to filter items based on search query
  void filterItems() {
    // Clear the list if the query is empty
    filteredItems.clear();
    if (searchQuery.value.isNotEmpty) {
      filteredItems.assignAll(
        sortie.value.cardItemsPrestations.where((item) =>
            item.label.toLowerCase().contains(searchQuery.value.toLowerCase())),
      );
    } else {
      filteredItems.addAll(sortie.value.cardItemsPrestations);
    }
  }

  void toggleExpanded(int index) {
    filteredItems[index].isExpanded = !filteredItems[index].isExpanded;
    filteredItems.refresh();
  }

  Future<void> addToQuantityConsumed(Prestation prestation) async {
    final confirmed = await Get.dialog(const ConfirmationDialog(
      title: AppStrings.validateConfirmationTitle,
      content: AppStrings.validateConfirmationMessage,
    ));

    if (confirmed ?? false) {
      double? newQuantity = double.tryParse(prestation.controller.text);

      if (newQuantity != null && newQuantity > 0) {
        // You can refactor this code to best approache
        if (prestation.addToQuantityConsumed(newQuantity)) {
          prestation.controller.text = '';
          prestation.isValidate = true;
          filteredItems.refresh();
          // Call API
          snackbarSuccess(AppStrings.operationSuccessful);
          sortie.value.isPriceListIsValidated = true;
        } else {
          snackbarError(TakeAttachmentVisitStrings.incorrectQuantity);
        }
      } else {
        snackbarError(TakeAttachmentVisitStrings.invalideQuantityDigite);
      }
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

        if (!sortie.value.isPriceListIsValidated) {
          snackbarError(TakeAttachmentVisitStrings.priceListNotValidated);
          return;
        }
        await uploadPhotos();
        Get.dialog(LoadingDialog(), barrierDismissible: false);
        //You can fix this partie where you send just required fields NOT the entire Sortie object
        if (await CommandsService.postTakeAttachmentVisite(
            sortie.value, files)) {
          sortie.value.isValidated = true;

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
