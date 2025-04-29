import 'package:get/get.dart';
import 'package:my_project/controllers/history_controller.dart';
import 'package:my_project/controllers/home_architect_controller.dart';
import 'package:my_project/enums/space_type.dart';
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

  startButtonTaped() async {
    // await _homeController.fillData();
    // await _homeArchitectController.fillData();
    // await _instructionsController.fillData();
    // await _historyController.fillData();
    // Get.offNamed(Routes.menuArchitect);

    if (userInfoService.spaceType == SpaceType.province) {
      await _homeController.fillSorties();
      await _instructionsController.fillInstructions();
      await _historyController.fillHistory();
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
