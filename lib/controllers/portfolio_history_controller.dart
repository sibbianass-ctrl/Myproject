// // lib/controllers/portfolio_history_controller.dart
// import 'package:get/get.dart';
// import 'package:my_project/models/validated_sortie.dart';
// import 'package:my_project/services/api_service/commands_service.dart';
//
// class PortfolioHistoryController extends GetxController {
//   RxList<ValidatedSortie> validatedSorties = <ValidatedSortie>[].obs;
//   RxBool isLoading = false.obs;
//
//   Future<void> loadValidatedSorties() async {
//     isLoading.value = true;
//     validatedSorties.value = await CommandsService.getAllValidatedSorties();
//     isLoading.value = false;
//   }
// }


import 'package:get/get.dart';
import 'package:my_project/models/validated_sortie.dart';
import 'package:my_project/services/api_service/commands_service.dart';

class PortfolioHistoryController extends GetxController {
  RxList<ValidatedSortie> validatedSorties = <ValidatedSortie>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadValidatedSorties(); // أول مرة كيدخل للكنترولر كنحمّلو الداتا
  }

  Future<void> loadValidatedSorties() async {
    isLoading.value = true;
    validatedSorties.value = await CommandsService.getAllValidatedSorties();
    isLoading.value = false;
  }
}
