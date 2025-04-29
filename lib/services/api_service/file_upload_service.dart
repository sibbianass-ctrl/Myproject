import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:my_project/services/api_service/api_endpoints.dart';

class FileUploadService {
  final Dio _dio = Dio();
  Future<String?> uploadFile(File file) async {
    try {
      // Prepare the form data
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last, // Extract file name
        ),
        'appname': 'my_project',
      });

      //POST request
      final response = await _dio.post(
        ApiEndpoints.uploadFile,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('File uploaded successfully: ${response.data}',
            name: 'UploadingFile');
        return response.data['fileName'];
      } else {
        log('Failed to upload file: ${response.statusMessage}',
            name: 'UploadingFile');
      }
    } catch (e) {
      log('Error uploading file: $e', name: 'UploadingFile');
    }
    return null;
  }
}
