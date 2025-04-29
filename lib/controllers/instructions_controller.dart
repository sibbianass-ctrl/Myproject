import 'package:get/get.dart';
import 'package:my_project/models/lot_instructions.dart';
import 'package:my_project/utils/resources/instructions/instructions_strings.dart';
import '../models/instruction.dart';
import '../services/api_service/commands_service.dart';
import '../utils/resources/global/app_strings.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/loading_dialog.dart';

class InstructionsController extends GetxController {
  RxList<LotInstructions> lotInstructions = <LotInstructions>[].obs;

  Future<void> fillInstructions() async {
    Get.dialog(
        LoadingDialog(
          text: InstructionsStrings.loadingText + '...',
        ),
        barrierDismissible: false);
    lotInstructions.addAll(await CommandsService.getAllInstructions());
    Get.back();
  }

  Future<void> refresh() async {
    lotInstructions.clear();
    lotInstructions.addAll(await CommandsService.getAllInstructions());
    lotInstructions.refresh();
  }

  Future<void> onValidate(int status, String motif, String meetingId) async {
    final confirmed = await Get.dialog(const ConfirmationDialog(
      title: AppStrings.validateConfirmationTitle,
      content: AppStrings.validateConfirmationMessage,
    ));
    if (confirmed ?? false) {
      Get.dialog(LoadingDialog(), barrierDismissible: false);
      await CommandsService.postInstructionStatus(status, motif, meetingId);
      Get.back();
    }
  }

  Future<void> onEdit(Instruction instruction, String newValue) async {
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    if (await CommandsService.updateInstruction(
        instruction.meetingId, newValue)) {
      instruction.instructionDescription = newValue;
      lotInstructions.refresh();
    }
    Get.back();
  }
}
