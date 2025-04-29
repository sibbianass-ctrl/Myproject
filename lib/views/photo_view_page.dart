import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/utils/resources/history/history_strings.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String imageUrl = Get.arguments; // Get clicked image URL

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          loadingBuilder: (context, event) => Center(
            child: CircularProgressIndicator(
              value: event == null
                  ? null
                  : event.cumulativeBytesLoaded /
                      (event.expectedTotalBytes ?? 1),
            ),
          ),
          errorBuilder: (context, error, stackTrace) {
            // If an error occurs while loading the image, show this
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.broken_image, size: 80, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  HistoryStrings.imageFailedToLoad,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 10),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ],
            );
          },
          minScale: PhotoViewComputedScale.contained, // Fit image within screen
          maxScale: PhotoViewComputedScale.covered * 2, // Allow zooming up to 2x
          backgroundDecoration: BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
