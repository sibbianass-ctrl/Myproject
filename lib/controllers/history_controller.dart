import 'package:get/get.dart';
import 'package:my_project/models/validated_sortie.dart';
import 'package:my_project/utils/resources/history/history_strings.dart';
import '../enums/visit_type_enum.dart';
import '../services/api_service/commands_service.dart';
import '../widgets/loading_dialog.dart';

class HistoryController extends GetxController {
  RxList<ValidatedSortie> validatedSorties = <ValidatedSortie>[].obs;
  RxBool isOrdinaireSelected = true.obs;

  List<ValidatedSortie> get getValidatedSortieByType => validatedSorties
      .where((element) =>
          element.visitType ==
          (isOrdinaireSelected.value
              ? VisitTypeEnum.ordinary
              : VisitTypeEnum.take_attachment))
      .toList();

  Future<void> fillHistory() async {
    Get.dialog(
        LoadingDialog(
          text: HistoryStrings.loadingText + '...',
        ),
        barrierDismissible: false);
    validatedSorties.addAll(await CommandsService.getAllValidatedSorties());
    // TODO: Temporary solution to sort the validatedSorties by realDate
    _sortValidatedSortiesByDate();
    Get.back();
  }


  Future<void> refresh() async {
    validatedSorties.clear();
    validatedSorties.addAll(await CommandsService.getAllValidatedSorties());
    _sortValidatedSortiesByDate();
    validatedSorties.refresh();
  }

  void _sortValidatedSortiesByDate() {
    validatedSorties.sort((a, b) {
      DateTime dateA = DateTime.parse(a.reelDate);
      DateTime dateB = DateTime.parse(b.reelDate);
      return dateB.compareTo(dateA); // Sort in descending order (recent first)
    });
  }
}
