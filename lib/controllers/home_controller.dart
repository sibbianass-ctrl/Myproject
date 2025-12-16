import 'package:get/get.dart';
import 'package:my_project/models/sortie.dart';
import 'package:my_project/services/api_service/commands_service.dart';
import 'package:my_project/utils/resources/home/home_strings.dart';
import '../routes/routes.dart';
import '../widgets/loading_dialog.dart';
import 'ordinary_visit_controller.dart';
import 'take_attachment_controller.dart';

class HomeController extends GetxController {
  RxList<Sortie> sorties = <Sortie>[].obs;
  RxBool isLoading = false.obs;

  final TakeAttachmentController _attachmentController =
      Get.put(TakeAttachmentController());
  final OridnaryVisitController _oridnaryVisitController =
      Get.put(OridnaryVisitController());

  Future<void> fillSorties() async {
    Get.dialog(
        LoadingDialog(
          text: HomeStrings.loadingText + '...',
        ),
        barrierDismissible: false);
    sorties.addAll(await CommandsService.getAllPlanifiedSorties());
    Get.back();
  }

  Future<void> refresh() async {
    sorties.clear();
    sorties.addAll(await CommandsService.getAllPlanifiedSorties());
    sorties.refresh();
  }

  moveToOrdinaryPage(int index) async {
    _oridnaryVisitController.sortie.value = sorties[index];
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    _oridnaryVisitController.sortiesCount =
        await CommandsService.getSortiesCount(
            sorties[index].marketId); // get the count of sorties
    Get.back();
    await Get.toNamed(Routes.ordinaryVisitPage);
    sorties.refresh();
  }

  moveToTakeAttachmentPage(int index) async {
    _attachmentController.sortie.value = sorties[index];
    _attachmentController.filteredItems.clear();
    _attachmentController.searchQuery.value = '';
    _attachmentController.filterItems();
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    _attachmentController.sortiesCount = await CommandsService.getSortiesCount(
        sorties[index].marketId); // get the count of sorties
    Get.back();
    await Get.toNamed(Routes.takeAttachmentVisitPage);
    sorties.refresh();
  }
}
