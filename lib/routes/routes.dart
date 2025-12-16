import 'package:flutter/material.dart';
import 'package:my_project/views/architect_visit_form/Architect_visit_form_view.dart';
import 'package:my_project/views/menu_architect/menu_architect_view.dart';
import 'package:my_project/views/ordinary_visit/ordinary_visit_view.dart';
import 'package:my_project/views/take_attachment/take_attachment_view.dart';
import '../views/home/home_view.dart';
import '../views/instruction_architect_details/instruction_architect_details_view.dart';
import '../views/login_view.dart';
import '../views/splash_screen_view.dart';
import '../views/start_view.dart';
import '../views/menu/menu_view.dart';


class Routes {
  static const String logingPage = '/login';
  static const String startPage = '/start';
  static const String homePage = '/home';
  static const String menuPage = '/menu';
  static const String ordinaryVisitPage = '/ordinary_visit';
  static const String takeAttachmentVisitPage = '/take_attachment';
  // Architect Routes
  static const String menuArchitect = '/menu_architect';
  static const String architectVisitForm = '/architect_visit_form';
  // static const String priceListsPageArchitect = '/price_lists_page_architect';
  static const String governorInstructionDetails =
      '/governor_instruction_details';

      static const String editProfile = '/edit-profile';
}

Map<String, WidgetBuilder> publicRoutes(BuildContext context) {
  return {
    "/": (context) => const SplashScreenView(),
    Routes.logingPage: (context) => const LoginView(),
    Routes.startPage: (context) => StartView(),
    Routes.homePage: (context) => HomeView(),
    Routes.menuPage: (context) => MenuView(),
    Routes.ordinaryVisitPage: (context) => OrdinaryVisitView(),
    Routes.takeAttachmentVisitPage: (context) => TakeAttachmentView(),
    // Architect Routes
    Routes.menuArchitect: (context) => MenuArchitectView(),
    Routes.architectVisitForm: (context) => ArchitectVisitFormView(),
    // Routes.priceListsPageArchitect: (context) => PriceListArchitectView(),
    Routes.governorInstructionDetails: (context) =>
        InstructionArchitectDetailsView(),
  };
}
