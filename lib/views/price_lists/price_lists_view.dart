import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/utils/resources/global/price_list/price_list_strings.dart';
import '../../controllers/home_architect_controller.dart';
import '../../utils/resources/global/app_strings.dart';
import '../../widgets/custom_app_bar_2.dart';
import '../../widgets/custom_page_title_2.dart';
import '../../widgets/space_title.dart';
import '../home_architect/widgets/custom_visit_card.dart';

class PriceListsView extends StatelessWidget {
  PriceListsView({super.key});
  final HomeArchitectController _homeArchitectController =
      Get.put(HomeArchitectController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const CustomAppBar2(title: PriceListStrings.pageTitle),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Column(
          children: [
            SpaceTitle(),
            //Title
            CustomPageTitle2(
              size: size,
              title: PriceListStrings.pageTitle,
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
                          Center(child: Text(AppStrings.noMarketLabel))
                        else
                          for (int i = 0;
                              i < _homeArchitectController.lots.length;
                              i++)
                            VisitCard(
                                title: _homeArchitectController.lots[i].titled,
                                number:
                                    _homeArchitectController.lots[i].numbMarch,
                                icon: Icons.table_chart_outlined,
                                onTap: () => _homeArchitectController
                                    .moveToPricesListPage(i)),
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
