import 'package:get/get.dart';
import 'package:my_project/controllers/app_snackbar_controller.dart';
import 'package:my_project/controllers/architect_visit_from_controller.dart';
import 'package:my_project/controllers/price_list_architect_view_controller.dart';
import 'package:my_project/models/dtos/get/lot_dto.dart';
import 'package:my_project/utils/resources/price_list/price_list_strings.dart';
import '../routes/routes.dart';
import '../services/api_service/commands_service.dart';
import '../utils/resources/home/home_strings.dart';
import '../views/price_list/price_list_architect_view.dart';
import '../widgets/loading_dialog.dart';

class HomeArchitectController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<LotDto> lots = <LotDto>[].obs;

  final ArchitectVisitFromController _architectVisitFormController =
      Get.put(ArchitectVisitFromController());
  final PriceListArchitectViewController _priceListArchitectViewController =
      Get.put(PriceListArchitectViewController());

  // fill Lots
  Future<void> fillLots() async {
    Get.dialog(
        LoadingDialog(
          text: HomeStrings.loadingText + '...',
        ),
        barrierDismissible: false);
    lots.addAll(await CommandsService.getAllLotByUserId());
    Get.back();
  }

  // refresh lots
  Future<void> refreshLots() async {
    lots.clear();
    lots.addAll(await CommandsService.getAllLotByUserId());
    lots.refresh();
  }

  moveToOrdinaryPage(int index) async {
    _architectVisitFormController.sortie.value.clear();
    _architectVisitFormController.sortie.value.setLot(lots[index]);

    Get.dialog(LoadingDialog(), barrierDismissible: false);

    _architectVisitFormController.sortie.value.objects
        .addAll(await CommandsService.getObjectsList(lots[index].id));
    _architectVisitFormController.sortie.value.constats
        .addAll(await CommandsService.getConstatsList(lots[index].id));
    _architectVisitFormController.sortie.value.recommendations
        .addAll(await CommandsService.getRecommendationsList(lots[index].id));
    Get.back();
    await Get.toNamed(Routes.architectVisitForm);
  }

  moveToPricesListPage(int index) async {
    _priceListArchitectViewController.lot = lots[index];
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    _priceListArchitectViewController.prestations =
        await CommandsService.getLatestPricesList(lots[index].id,
            'Architect'); //TODO: FIX : Check if we sent just architect or also bet
    Get.back();
    if (_priceListArchitectViewController.prestations.isEmpty) {
      snackbarWarrning(PriceListStrings.noPriceList);
    } else {
      Get.to(() => PriceListArchitectView());
    }
  }
}
