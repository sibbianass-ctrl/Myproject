// // lib/services/api_service/documents_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:my_project/services/api_endpoints.dart';
// import 'package:my_project/services/api_service/api_endpoints.dart';
//
// class DocumentsService {
//   final Dio _dio = Dio();
//
//   // ---------- CONFIG ----------
//   final String launchingUrl =
//       'http://172.16.20.125:8130/api/s-launching-phase';
//   final String programmingUrl =
//       'http://172.16.20.125:8110/api/s-planning-programming-phase';
//   final String followingUpUrl =
//       'http://172.16.20.125:8140/api/s-following-up-phase';
//   final String fileBaseUrl = 'http://172.16.20.125:8200';
//   final String appName = 'my_project';
//
//   // =========================================================
//   // CPS
//   // =========================================================
//
//   Future<String?> _getCpsFileName(String lotId) async {
//     final String dataUrl =
//         '${ApiEndpoints.launchingServiceBaseUrl}/s-launching-phase/lots/$lotId';
//     debugPrint('🚀 Get CPS info from: $dataUrl');
//
//     try {
//       final response = await _dio.get(dataUrl);
//       debugPrint('ℹ️ CPS info status: ${response.statusCode}');
//       debugPrint('ℹ️ CPS info data: ${response.data}');
//
//       if (response.statusCode == 200) {
//         final data = response.data as Map<String, dynamic>;
//         final String? fileName = data['cps'] as String?;
//         if (fileName != null &&
//             fileName.isNotEmpty &&
//             fileName.toLowerCase() != 'null') {
//           return fileName;
//         }
//       }
//       return null;
//     } on DioException catch (e) {
//       debugPrint('❌ CPS info error: ${e.response?.statusCode} ${e.message}');
//       return null;
//     }
//   }
//
//   /// URL نهائي للـ CPS
//   Future<String?> getCpsDownloadUrl(String lotId) async {
//     final fileName = await _getCpsFileName(lotId);
//     if (fileName == null) return null;
//     return buildDownloadUrl(fileName);
//   }
//
//   // =========================================================
//   // PERMIS DE CONSTRUIRE
//   // =========================================================
//
//   Future<String?> getPermitDownloadUrl(String lotId) async {
//     debugPrint('🚀 STARTING PERMIT FETCH for Lot: $lotId');
//
//     try {
//       final String lotUrl = '$launchingUrl/lots/$lotId';
//       final lotResponse = await _dio.get(lotUrl);
//       debugPrint('📦 PERMIT LOT status = ${lotResponse.statusCode}');
//       if (lotResponse.statusCode != 200) return null;
//
//       final lotData = lotResponse.data as Map<String, dynamic>;
//       final String? launchingId = lotData['launchingId'];
//       debugPrint('🔑 PERMIT launchingId = $launchingId');
//       if (launchingId == null) return null;
//
//       final String launchUrl = '$launchingUrl/launching/$launchingId';
//       final launchResponse = await _dio.get(launchUrl);
//       debugPrint('📦 PERMIT LAUNCH status = ${launchResponse.statusCode}');
//       if (launchResponse.statusCode != 200) return null;
//
//       final launchData = launchResponse.data as Map<String, dynamic>;
//       final String? componentId = launchData['componentId'];
//       debugPrint('🔑 PERMIT componentId = $componentId');
//       if (componentId == null) return null;
//
//       final String progUrl =
//           '$programmingUrl/programming-phases/by-component-id/$componentId';
//       final progResponse = await _dio.get(progUrl);
//       debugPrint('📦 PERMIT PROG status = ${progResponse.statusCode}');
//       debugPrint('📦 PERMIT PROG data   = ${progResponse.data}');
//       if (progResponse.statusCode != 200) return null;
//
//       final progData = progResponse.data as Map<String, dynamic>;
//
//       String? fileName;
//       if (progData['constructionPermit'] != null) {
//         fileName =
//         progData['constructionPermit']['attachedDocuments'] as String?;
//       }
//
//       if (fileName == null ||
//           fileName.isEmpty ||
//           fileName.toLowerCase() == 'null') {
//         return null;
//       }
//
//       return buildDownloadUrl(fileName);
//     } catch (e) {
//       debugPrint('💥 EXCEPTION (Permit): $e');
//       return null;
//     }
//   }
//
//   // =========================================================
//   // ORDRES DE SERVICE
//   // =========================================================
//
//   Future<List<Map<String, String>>> fetchOsList(String lotId) async {
//     debugPrint('🚀 STARTING OS FETCH for Lot: $lotId');
//     List<Map<String, String>> osList = [];
//
//     try {
//       final String url =
//           '$followingUpUrl/following-up/findFollowingUpByLotId/$lotId';
//       debugPrint('📡 OS URL = $url');
//
//       final response = await _dio.get(url);
//       debugPrint('📦 OS status = ${response.statusCode}');
//       debugPrint('📦 OS data   = ${response.data}');
//
//       if (response.statusCode == 200) {
//         final data = response.data as Map<String, dynamic>;
//         if (data['followUpDetails'] != null) {
//           for (final item in data['followUpDetails']) {
//             final map = item as Map<String, dynamic>;
//             final String? fileName = map['documentName'] as String?;
//             if (fileName == null || fileName.isEmpty) continue;
//
//             String label = 'Document Inconnu';
//             if (map['statusOrderService'] != null &&
//                 map['statusOrderService']['status'] != null) {
//               label = map['statusOrderService']['status'] as String;
//             } else if (map['type'] != null) {
//               label = map['type'] as String;
//             }
//
//             osList.add({
//               'label': label,
//               'fileName': fileName,
//               'date': map['dateEffect']?.toString() ?? 'Date inconnue',
//             });
//           }
//         }
//       }
//     } catch (e) {
//       debugPrint('💥 EXCEPTION (OS list): $e');
//     }
//
//     debugPrint('✅ Found ${osList.length} OS documents.');
//     return osList;
//   }
//
//   /// تبني URL لتحميل أي ملف من اسمو
//   String buildDownloadUrl(String fileName) {
//     return '$fileBaseUrl/api/file/downloadFileSpecific/$appName/$fileName';
//   }
// }



//
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_project/services/api_endpoints.dart';
import 'package:my_project/services/api_service/api_endpoints.dart';

class DocumentsService {
  final Dio _dio = Dio();

  // ---------- CONFIG ----------
  final String launchingUrl =
      'http://172.16.20.233:8130/api/s-launching-phase';
  final String programmingUrl =
      'http://172.16.20.233:8110/api/s-planning-programming-phase';
  final String followingUpUrl =
      'http://172.16.20.233:8140/api/s-following-up-phase';
  final String fileBaseUrl = 'http://172.16.20.233:8200';
  final String appName = 'my_project';

  // =========================================================
  // CPS
  // =========================================================

  Future<String?> _getCpsFileName(String lotId) async {
    final String dataUrl =
        '${ApiEndpoints.launchingServiceBaseUrl}/s-launching-phase/lots/$lotId';
    debugPrint('🚀 Get CPS info from: $dataUrl');

    try {
      final response = await _dio.get(dataUrl);
      debugPrint('ℹ️ CPS info status: ${response.statusCode}');
      debugPrint('ℹ️ CPS info data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final String? fileName = data['cps'] as String?;
        if (fileName != null &&
            fileName.isNotEmpty &&
            fileName.toLowerCase() != 'null') {
          return fileName;
        }
      }
      return null;
    } on DioException catch (e) {
      debugPrint('❌ CPS info error: ${e.response?.statusCode} ${e.message}');
      return null;
    }
  }

  Future<String?> getCpsDownloadUrl(String lotId) async {
    final fileName = await _getCpsFileName(lotId);
    if (fileName == null) return null;
    return buildDownloadUrl(fileName);
  }

  // =========================================================
  // PERMIS DE CONSTRUIRE
  // =========================================================

  Future<String?> getPermitDownloadUrl(String lotId) async {
    debugPrint('🚀 STARTING PERMIT FETCH for Lot: $lotId');

    try {
      final String lotUrl = '$launchingUrl/lots/$lotId';
      final lotResponse = await _dio.get(lotUrl);
      debugPrint('📦 PERMIT LOT status = ${lotResponse.statusCode}');
      if (lotResponse.statusCode != 200) return null;

      final lotData = lotResponse.data as Map<String, dynamic>;
      final String? launchingId = lotData['launchingId'];
      debugPrint('🔑 PERMIT launchingId = $launchingId');
      if (launchingId == null) return null;

      final String launchUrl = '$launchingUrl/launching/$launchingId';
      final launchResponse = await _dio.get(launchUrl);
      debugPrint('📦 PERMIT LAUNCH status = ${launchResponse.statusCode}');
      if (launchResponse.statusCode != 200) return null;

      final launchData = launchResponse.data as Map<String, dynamic>;
      final String? componentId = launchData['componentId'];
      debugPrint('🔑 PERMIT componentId = $componentId');
      if (componentId == null) return null;

      final String progUrl =
          '$programmingUrl/programming-phases/by-component-id/$componentId';
      final progResponse = await _dio.get(progUrl);
      debugPrint('📦 PERMIT PROG status = ${progResponse.statusCode}');
      debugPrint('📦 PERMIT PROG data   = ${progResponse.data}');
      if (progResponse.statusCode != 200) return null;

      final progData = progResponse.data as Map<String, dynamic>;

      String? fileName;
      if (progData['constructionPermit'] != null) {
        fileName =
        progData['constructionPermit']['attachedDocuments'] as String?;
      }

      if (fileName == null ||
          fileName.isEmpty ||
          fileName.toLowerCase() == 'null') {
        return null;
      }

      return buildDownloadUrl(fileName);
    } catch (e) {
      debugPrint('💥 EXCEPTION (Permit): $e');
      return null;
    }
  }

  // =========================================================
  // ORDRES DE SERVICE
  // =========================================================

  Future<List<Map<String, String>>> fetchOsList(String lotId) async {
    debugPrint('🚀 STARTING OS FETCH for Lot: $lotId');
    List<Map<String, String>> osList = [];

    try {
      final String url =
          '$followingUpUrl/following-up/findFollowingUpByLotId/$lotId';
      debugPrint('📡 OS URL = $url');

      final response = await _dio.get(url);
      debugPrint('📦 OS status = ${response.statusCode}');
      debugPrint('📦 OS data   = ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data['followUpDetails'] != null) {
          for (final item in data['followUpDetails']) {
            final map = item as Map<String, dynamic>;
            final String? fileName = map['documentName'] as String?;
            if (fileName == null || fileName.isEmpty) continue;

            String label = 'Document Inconnu';
            if (map['statusOrderService'] != null &&
                map['statusOrderService']['status'] != null) {
              label = map['statusOrderService']['status'] as String;
            } else if (map['type'] != null) {
              label = map['type'] as String;
            }

            osList.add({
              'label': label,
              'fileName': fileName,
              'date': map['dateEffect']?.toString() ?? 'Date inconnue',
            });
          }
        }
      }
    } catch (e) {
      debugPrint('💥 EXCEPTION (OS list): $e');
    }

    debugPrint('✅ Found ${osList.length} OS documents.');
    return osList;
  }

  String buildDownloadUrl(String fileName) {
    return '$fileBaseUrl/api/file/downloadFileSpecific/$appName/$fileName';
  }
}
