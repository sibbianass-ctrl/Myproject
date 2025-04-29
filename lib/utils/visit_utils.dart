import 'package:my_project/utils/resources/global/app_strings.dart';

import '../controllers/app_snackbar_controller.dart';

class VisitUtils {
  static bool verificationForm(String workStateValue, String workRateValue) {
    if (workStateValue.isEmpty ||
        workRateValue.isEmpty) {
      snackbarError(AppStrings.workStateAndRateSelectedValueError);
      return false;
    }

    return true;
  }
}