import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/services/api_service/api_endpoints.dart';
import 'package:my_project/utils/resources/history/history_strings.dart';
import '../photo_view_page.dart';

class HistoryGallery extends StatelessWidget {
  final List<String> imageUrls;
  HistoryGallery({super.key, required this.imageUrls});
  final String downloadUrl = ApiEndpoints.downloadFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(HistoryStrings.gallertTitle)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 images per row
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => PhotoViewPage(),
                    arguments: downloadUrl + imageUrls[index]);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  downloadUrl + imageUrls[index],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // Image fully loaded
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null, // Show progress if known
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  ), // Show an error icon if image fails to load
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
