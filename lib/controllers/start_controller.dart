import 'package:get/get.dart';
import 'package:my_project/controllers/history_controller.dart';
import 'package:my_project/controllers/home_architect_controller.dart';
import 'package:my_project/enums/space_type.dart';
import 'package:my_project/controllers/portfolio_history_controller.dart'; // <-- جديد
import '../routes/routes.dart';
import '../services/user_info_service.dart';
import 'home_controller.dart';
import 'instructions_controller.dart';

class StartController {
  final HomeController _homeController = Get.put(HomeController());
  final InstructionsController _instructionsController =
  Get.put(InstructionsController());
  final HistoryController _historyController = Get.put(HistoryController());
  // Space Architect
  final HomeArchitectController _homeArchitectController =
  Get.put(HomeArchitectController());
  final UserInfoService userInfoService = UserInfoService();

  // Portfolio historique
  final PortfolioHistoryController _portfolioHistoryController =
  Get.put(PortfolioHistoryController());

  startButtonTaped() async {
    if (userInfoService.spaceType == SpaceType.province) {
      await _homeController.fillSorties();
      await _instructionsController.fillInstructions();
      await _historyController.fillHistory();
      await _portfolioHistoryController.loadValidatedSorties(); // هندخلو historique
      Get.offNamed(Routes.menuPage);
    } else if (userInfoService.spaceType == SpaceType.architecte) {
      await _homeArchitectController.fillLots();
      Get.offNamed(Routes.menuArchitect);
    } else if (userInfoService.spaceType == SpaceType.bet) {
      await _homeArchitectController.fillLots();
      Get.offNamed(Routes.menuArchitect);
    }
  }
}



// import 'package:get/get.dart';
// import 'package:my_project/controllers/history_controller.dart';
// import 'package:my_project/controllers/home_architect_controller.dart';
// import 'package:my_project/enums/space_type.dart';
// import '../routes/routes.dart';
// import '../services/user_info_service.dart';
// import 'home_controller.dart';
// import 'instructions_controller.dart';
//
// class StartController {
//   final HomeController _homeController = Get.put(HomeController());
//   final InstructionsController _instructionsController =
//       Get.put(InstructionsController());
//   final HistoryController _historyController = Get.put(HistoryController());
//   // Space Architect
//   final HomeArchitectController _homeArchitectController =
//       Get.put(HomeArchitectController());
//   final UserInfoService userInfoService = UserInfoService();
//
//
//   startButtonTaped() async {
//
//     if (userInfoService.spaceType == SpaceType.province) {
//       await _homeController.fillSorties();
//       await _instructionsController.fillInstructions();
//       await _historyController.fillHistory();
//       Get.offNamed(Routes.menuPage);
//     } else if (userInfoService.spaceType == SpaceType.architecte) {
//       await _homeArchitectController.fillLots();
//
//       Get.offNamed(Routes.menuArchitect);
//     } else if (userInfoService.spaceType == SpaceType.bet) {
//       await _homeArchitectController.fillLots();
//       Get.offNamed(Routes.menuArchitect);
//     }
//   }
// }

//
// import 'package:get/get.dart';
// import 'package:my_project/controllers/history_controller.dart';
// import 'package:my_project/controllers/home_architect_controller.dart';
// import 'package:my_project/enums/space_type.dart';
// import '../routes/routes.dart';
// import '../services/user_info_service.dart';
// import 'home_controller.dart';
// import 'instructions_controller.dart';
//
// class StartController {
//   final HomeController _homeController = Get.put(HomeController());
//   final InstructionsController _instructionsController =
//   Get.put(InstructionsController());
//   final HistoryController _historyController = Get.put(HistoryController());
//   final HomeArchitectController _homeArchitectController =
//   Get.put(HomeArchitectController());
//   final UserInfoService userInfoService = UserInfoService();
//
//   startButtonTaped() async {
//     // 🧩 Debug info
//     print('[DEBUG] Start button pressed');
//     print('[DEBUG] spaceType = ${userInfoService.spaceType}');
//
//     if (userInfoService.spaceType == SpaceType.province) {
//       print('[INFO] Province space detected → loading home data...');
//       await _homeController.fillSorties();
//       await _instructionsController.fillInstructions();
//       await _historyController.fillHistory();
//       Get.offNamed(Routes.menuPage);
//     } else if (userInfoService.spaceType == SpaceType.architecte) {
//       print('[INFO] Architect space detected → loading lots...');
//       await _homeArchitectController.fillLots();
//       Get.offNamed(Routes.menuArchitect);
//     } else if (userInfoService.spaceType == SpaceType.bet) {
//       print('[INFO] BET space detected → loading lots...');
//       await _homeArchitectController.fillLots();
//       Get.offNamed(Routes.menuArchitect);
//     } else {
//       print('[ERROR] Unknown or null spaceType → cannot navigate!');
//     }
//   }
// }
