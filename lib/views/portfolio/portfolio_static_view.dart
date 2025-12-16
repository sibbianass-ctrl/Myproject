// // lib/views/profile/portfolio_static_view.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:my_project/controllers/home_controller.dart';
// import 'package:my_project/views/profile/portfolio_lot_menu_view..dart'
//     show PortfolioLotMenuView;
// import 'package:my_project/widgets/custom_app_bar.dart';
// import 'package:my_project/widgets/custom_page_title.dart';
//
// class PortfolioStaticView extends StatelessWidget {
//   PortfolioStaticView({super.key});
//
//   final HomeController _homeController = Get.find<HomeController>();
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body: Container(
//         width: double.infinity,
//         margin: EdgeInsets.symmetric(horizontal: size.width * .05),
//         child: Column(
//           children: [
//             CustomPageTitle(size: size, title: 'mon portfolio'),
//             const SizedBox(height: 12),
//             Expanded(
//               child: Obx(() {
//                 // إذا عندك isLoading فـ HomeController، يمكنك استعمالو؛
//                 // إذا ما كاينش، حيد هاد الشرط.
//                 if (_homeController.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 final sorties = _homeController.sorties;
//
//                 if (sorties.isEmpty) {
//                   return const Center(
//                     child: Text('Aucune sortie pour le moment.'),
//                   );
//                 }
//
//                 // نجمع جميع marchés من sorties (بدون تكرار)
//                 final Map<String, Map<String, String>> lotsMap = {}; // number -> {id, name}
//
//                 for (final s in sorties) {
//                   lotsMap[s.marketNumber] = {
//                     'id': s.marketId,
//                     'name': s.marketName,
//                   };
//                 }
//
//                 final lots = lotsMap.entries.map((e) {
//                   return {
//                     'number': e.key,
//                     'id': e.value['id'] ?? '',
//                     'name': e.value['name'] ?? '',
//                   };
//                 }).toList();
//
//                 return ListView.builder(
//                   itemCount: lots.length,
//                   itemBuilder: (context, index) {
//                     final lot = lots[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 2,
//                       child: ListTile(
//                         title: Text(
//                           lot['name'] ?? '',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         subtitle: Text('N°: ${lot['number']}'),
//                         trailing:
//                         const Icon(Icons.arrow_forward_ios, size: 16),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => PortfolioLotMenuView(
//                                 lotNumber: lot['number']!,
//                                 lotName: lot['name']!,
//                                 lotId: lot['id']!, // نفس id اللي استعملناه فـ CPS
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/home_controller.dart';
import 'package:my_project/controllers/portfolio_history_controller.dart';
import 'package:my_project/views/portfolio/portfolio_lot_menu_view..dart'
    show PortfolioLotMenuView;
import 'package:my_project/widgets/custom_app_bar.dart';
import 'package:my_project/widgets/custom_page_title.dart';

class PortfolioStaticView extends StatelessWidget {
  PortfolioStaticView({super.key});

  final HomeController _homeController = Get.find<HomeController>();
  final PortfolioHistoryController _historyController =
  Get.find<PortfolioHistoryController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Column(
          children: [
            CustomPageTitle(size: size, title: 'mon portfolio'),
            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                // نعتابر أي واحد فيهم كيحمل isLoading، وإلا حيد الشرط اللي ما تحتاجوش
                if (_homeController.isLoading.value ||
                    _historyController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 1) marchés من sorties ديال planning
                final sorties = _homeController.sorties;

                // 2) marchés من sorties validées (historique)
                final validated = _historyController.validatedSorties;

                if (sorties.isEmpty && validated.isEmpty) {
                  return const Center(
                    child: Text('Aucun marché pour le moment.'),
                  );
                }

                // Map باش ندمجو بجوج: number -> {id, name}
                final Map<String, Map<String, String>> lotsMap = {};

                // من planning (HomeController)
                for (final s in sorties) {
                  lotsMap[s.marketNumber] = {
                    'id': s.marketId,
                    'name': s.marketName,
                  };
                }

                // من historique (PortfolioHistoryController)
                for (final v in validated) {
                  lotsMap[v.lotNumber] = {
                    'id': v.lotId,
                    'name': v.lotName,
                  };
                }

                final lots = lotsMap.entries.map((e) {
                  return {
                    'number': e.key,
                    'id': e.value['id'] ?? '',
                    'name': e.value['name'] ?? '',
                  };
                }).toList();

                return ListView.builder(
                  itemCount: lots.length,
                  itemBuilder: (context, index) {
                    final lot = lots[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: ListTile(
                        title: Text(
                          lot['name'] ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text('N°: ${lot['number']}'),
                        trailing:
                        const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PortfolioLotMenuView(
                                lotNumber: lot['number']!,
                                lotName: lot['name']!,
                                lotId: lot['id']!,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
