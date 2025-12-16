import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/views/home_architect/home_architect_view.dart';
import 'package:my_project/views/instructions_architect/instructions_architect_view.dart';
import 'package:my_project/views/price_lists/price_lists_view.dart';
import 'package:my_project/views/profile_architect/profile_architect_view.dart';
import '../../controllers/navigation_menu_controller.dart';
import '../../utils/resources/menu/menu_strings.dart';
import '../menu/widgets/navigation_destination_item.dart';

class MenuArchitectView extends StatelessWidget {
  MenuArchitectView({super.key});
  final _menuController = Get.put(NavigationMenuController());
  final List<Map<String, dynamic>> navigationDestinationItems = [
    {
      'ic': Icons.home,
      'label': MenuStrings.visits,
      'widget': HomeArchitectView()
    },
    // {
    //   'ic': Icons.history,
    //   'label': MenuStrings.history,
    //   'widget': HistoryView()
    // },
    {
      'ic': Icons.table_chart_outlined,
      'label': MenuStrings.priceList,
      'widget': PriceListsView()
    },
    {
      'ic': Icons.checklist,
      'label': MenuStrings.instructions,
      'widget': InstructionsArchitectView()
    },
    {
      'ic': Icons.account_circle_outlined,
      'label': MenuStrings.profile,
      'widget': ProfileArchitectView()
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.25),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: NavigationBar(
              height: 70,
              onDestinationSelected: (index) =>
                  _menuController.currentPageIndex = index,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              animationDuration: const Duration(milliseconds: 300),
              destinations: [
                for (Map item in navigationDestinationItems)
                  NavigationDestinationItem(
                    iconData: item['ic'],
                    label: item['label'],
                  )
              ],
              selectedIndex: _menuController.currentPageIndex,
            ),
          ),
          body: [
            for (Map item in navigationDestinationItems) item['widget']
          ][_menuController.currentPageIndex],
        ));
  }
}
