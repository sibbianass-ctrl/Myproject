// // lib/controllers/lot_documents_controller.dart
// import 'package:get/get.dart';
// import 'package:my_project/models/lot_document.dart';
// import 'package:my_project/services/api_service/commands_service.dart';
//
// class LotDocumentsController extends GetxController {
//   RxList<LotDocument> documents = <LotDocument>[].obs;
//   RxBool isLoading = false.obs;
//
//   Future<void> loadDocuments(String lotId) async {
//     isLoading.value = true;
//     documents.value = await CommandsService.programmingDocuments(lotId);
//     isLoading.value = false;
//   }
// }

// lib/controllers/lot_documents_controller.dart
import 'package:get/get.dart';
import 'package:my_project/models/programming_file.dart';
import 'package:my_project/services/api_service/commands_service.dart';

// class LotDocumentsController extends GetxController {
//   Rx<ProgrammingFileModel?> programmingFile = Rx<ProgrammingFileModel?>(null);
//   RxBool isLoading = false.obs;
//
//   get documents => null;
//
//   Future<void> loadDocuments(String componentId) async {
//     isLoading.value = true;
//     programmingFile.value =
//     await CommandsService.getProgrammingDocuments(componentId);
//     isLoading.value = false;
//   }
// }
