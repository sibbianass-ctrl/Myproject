import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/history_controller.dart';
import 'package:my_project/models/validated_sortie.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';
import 'package:my_project/utils/resources/history/history_strings.dart';
import 'package:my_project/views/history/widgets/validated_sortie_item.dart';
import 'package:my_project/views/history_details/history_details_view.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_page_title.dart';
import 'widgets/custom_switch_button.dart';

class HistoryView extends StatelessWidget {
  HistoryView({super.key});
  final HistoryController _historyController = Get.find<HistoryController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Column(
          children: [
            //Title
            CustomPageTitle(
              size: size,
              title: HistoryStrings.pageTitle,
            ),
            const SizedBox(
              height: 32,
            ),
            // Filter Validated sorties type Button
            CustomSwitchButton(
              leftLabel: AppStrings.ordinary,
              rightLabel: AppStrings.attachment,
              initialValue: _historyController.isOrdinaireSelected.value,
              onChanged: (value) {
                _historyController.isOrdinaireSelected.value = value;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            //History List
            Expanded(
              flex: 1,
              child: Scrollbar(
                thumbVisibility: true,
                child: RefreshIndicator(
                  onRefresh: () async => _historyController.refresh(),
                  child: Obx(
                    () => ListView(
                      children: [
                        if (_historyController.getValidatedSortieByType.isEmpty)
                          const SizedBox(
                              width: double.infinity,
                              child: Text(
                                HistoryStrings.emptyPlanningLabel,
                                textAlign: TextAlign.center,
                              ))
                        else
                          for (ValidatedSortie validatedSortie
                              in _historyController.getValidatedSortieByType)
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => HistoryDetailsView(
                                    validatedSortie: validatedSortie,
                                  ),
                                );
                              },
                              child: ValidatedSortieItem(
                                lotName: validatedSortie.lotName,
                                lotNumber: validatedSortie.lotNumber,
                                validatedDate: validatedSortie.reelDate,
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

