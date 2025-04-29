import 'package:get/get.dart';
import 'package:my_project/models/dtos/get/lot_dto.dart';
import 'package:my_project/services/api_service/commands_service.dart';
import '../models/prestation.dart';
import '../utils/resources/global/app_strings.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/loading_dialog.dart';

class PriceListArchitectViewController extends GetxController {
  late LotDto lot;

  List<Prestation> prestations = [];

  Future<void> validate() async {
    final confirmed = await Get.dialog(const ConfirmationDialog(
      title: AppStrings.validateConfirmationTitle,
      content: AppStrings.validateConfirmationMessage,
    ));
      Get.dialog(LoadingDialog(), barrierDismissible: false);
    if (confirmed ?? false) {
      await _sendValidation('ACCEPTE');
      Get.back();
    }
    Get.back();
  }

  Future<void> refuse() async {
    final confirmed = await Get.dialog(const ConfirmationDialog(
      title: AppStrings.validateConfirmationTitle,
      content: AppStrings.validateConfirmationMessage,
    ));
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    if (confirmed ?? false) {
      await _sendValidation('REFUSEE');
      Get.back();
    }
    Get.back();
  }

  Future<void> _sendValidation(String value) async {
    await CommandsService.postValidationPriceList(
      prestations[0].sortieId,
      'validatedByArchitect=' + value,
    );
  }
}
