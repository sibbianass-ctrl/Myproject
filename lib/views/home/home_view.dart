import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/home_controller.dart';
import 'package:my_project/utils/resources/home/home_strings.dart';
import 'package:my_project/views/home/widgets/home_card_item.dart';
import 'package:my_project/widgets/custom_app_bar.dart';
import 'package:my_project/widgets/custom_page_title.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController _homeController = Get.put(HomeController());

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
              title: HomeStrings.pageTitle,
            ),
            const SizedBox(
              height: 12,
            ),
            // Cards
            Expanded(
              flex: 1,
              child: Scrollbar(
                thumbVisibility: true,
                child: RefreshIndicator(
                  onRefresh: () async => _homeController.refresh(),
                  child: Obx(
                    () => ListView(
                      children: [
                        if (_homeController.sorties.isEmpty)
                          const SizedBox(
                              width: double.infinity,
                              child: Text(
                                HomeStrings.emptyPlanningLabel,
                                textAlign: TextAlign.center,
                              ))
                        else
                          for (int i = 0;
                              i < _homeController.sorties.length;
                              i++)
                            HomeCardItem(
                              title: _homeController.sorties[i].marketName,
                              number: _homeController.sorties[i].marketNumber,
                              date: _homeController.sorties[i].programedDate,
                              index: i + 1,
                              isValidated:
                                  _homeController.sorties[i].isValidated,
                                  
                              onOrdinaryTap: () =>
                                  _homeController.moveToOrdinaryPage(i),
                              onTakeAttachmentTap: () =>
                                  _homeController.moveToTakeAttachmentPage(i),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
