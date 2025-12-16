import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/controllers/app_snackbar_controller.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';

class PhotoController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  RxList<File> photos = <File>[].obs;

  // Method to pick an image from the camera
  Future<void> pickImageFromCamera() async {
    if (photos.length < 3) {
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
        if (pickedFile != null) {

          photos.add(File(pickedFile.path));
          photos.refresh();
        } else {
          Get.snackbar(AppStrings.noPhoto, AppStrings.noPhotoSelected);
        }
      } catch (e) {
        snackbarError(AppStrings.imagePickerError);
      }
    } else {
      snackbarWarrning(AppStrings.takePhotosMaxWarning);
    }
  }


  Future<void> removeByFile(File file) async {
    photos.remove(file);
    await file.delete();
    photos.refresh();
  }

  Future<void> removeAll() async {
    for (var file in photos) {
      await file.delete();
    }
    photos.clear();
    photos.refresh();
  }

}
