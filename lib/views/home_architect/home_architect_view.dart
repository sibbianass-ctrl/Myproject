import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/home_architect_controller.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';
import 'package:my_project/utils/resources/home_architect/home_architect_strings.dart';
import 'package:my_project/views/home_architect/widgets/custom_visit_card.dart';
import 'package:my_project/widgets/custom_app_bar_2.dart';
import 'package:my_project/widgets/space_title.dart';
import '../../widgets/custom_page_title_2.dart';

class HomeArchitectView extends StatelessWidget {
  HomeArchitectView({super.key});
  final HomeArchitectController _homeArchitectController =
      Get.put(HomeArchitectController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const CustomAppBar2(title: HomeArchitectStrings.pageTitle),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Column(
          children: [
            SpaceTitle(),
            //Title
            CustomPageTitle2(
              size: size,
              title: HomeArchitectStrings.pageTitle,
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
                  onRefresh: () async =>
                      await _homeArchitectController.refreshLots(),
                  child: Obx(
                    () => ListView(
                      children: [
                        if (_homeArchitectController.lots.isEmpty)
                          Center(
                              child: Text(AppStrings.noMarketLabel))
                        else
                          for (int i = 0;
                              i < _homeArchitectController.lots.length;
                              i++)
                            VisitCard(
                                title: _homeArchitectController.lots[i].titled,
                                number:
                                    _homeArchitectController.lots[i].numbMarch,
                                onTap: () {
                                  _homeArchitectController
                                      .moveToOrdinaryPage(i);
                                }),
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
