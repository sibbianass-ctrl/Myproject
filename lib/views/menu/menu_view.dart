import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/navigation_menu_controller.dart';
import 'package:my_project/utils/resources/menu/menu_strings.dart';
import 'package:my_project/views/history/history_view.dart';
import 'package:my_project/views/home/home_view.dart';
import 'package:my_project/views/instructions/instructions_view.dart';
import 'package:my_project/views/menu/widgets/navigation_destination_item.dart';
import 'package:my_project/views/notifications/notifications_view.dart';
import 'package:my_project/views/profile/profile_view.dart';

class MenuView extends StatelessWidget {
  MenuView({super.key});
  final _menuController = Get.put(NavigationMenuController());
  final List<Map<String, dynamic>> navigationDestinationItems = [
    {'ic': Icons.home, 'label': MenuStrings.home, 'widget': HomeView()},
    {
      'ic': Icons.history,
      'label': MenuStrings.history,
      'widget': HistoryView()
    },
    {
      'ic': Icons.checklist_outlined,
      'label': MenuStrings.instructions,
      'widget': InstructionsView()
    },
    {
      'ic': Icons.notifications_none_sharp,
      'label': MenuStrings.notifications,
      'widget': NotificationsView()
    },
    {
      'ic': Icons.account_circle_outlined,
      'label': MenuStrings.profile,
      'widget': ProfileView()
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
