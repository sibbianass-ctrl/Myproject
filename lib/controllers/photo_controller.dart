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
          // path : /data/user/0/com.example.my_project/cache/9057ea89-50f6-4fce-aff6-7633e503812a7538873435372774969.jp
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

  // void removeByIndex(int index) {
  //   photos.removeAt(index);
  //   photos.refresh();
  // }

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

  // Method to upload the image to the server
  // Future<void> uploadImage() async {
  //   if (selectedImage.value == null) {
  //     Get.snackbar("No Image", "Please select an image to upload.");
  //     return;
  //   }

  //   try {
  //     final dio = Dio();
  //     final formData = FormData.fromMap({
  //       'file': await MultipartFile.fromFile(
  //         selectedImage.value!.path,
  //         filename: selectedImage.value!.path.split('/').last,
  //       ),
  //     });

  //     final response = await dio.post(
  //       'https://example.com/upload', // Replace with your API endpoint
  //       data: formData,
  //     );

  //     if (response.statusCode == 200) {
  //       Get.snackbar("Success", "Image uploaded successfully!");
  //     } else {
  //       Get.snackbar("Error", "Failed to upload image: ${response.statusMessage}");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Error during upload: $e");
  //   }
  // }
}
