import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/photo_controller.dart';
import '../utils/constants.dart';

class PhotoPicker extends StatelessWidget {
  final PhotoController photoController;

  const PhotoPicker({super.key, required this.photoController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Add Photo Button
          InkWell(
            onTap: () => photoController.pickImageFromCamera(),
            child: Image.asset(
              Constants.addPhotoPath,
              width: 64,
            ),
          ),
          const SizedBox(height: 32),

          // Display Photos
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Display picked images
                  for (File file in photoController.photos)
                    SizedBox(
                      width: 64,
                      height: 64,
                      child: Stack(
                        children: [
                          // Display photo
                          Image.file(
                            file,
                            fit: BoxFit.cover,
                            width: 64,
                            height: 64,
                          ),

                          // Remove photo icon
                          Positioned(
                            top: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () => photoController.removeByFile(file),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                child: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Empty photo hints
                  for (int i = 0; i < 3 - photoController.photos.length; i++)
                    Image.asset(
                      Constants.photoHintPath,
                      width: 64,
                    ),
                ],
              )),
        ],
      ),
    );
  }
}
