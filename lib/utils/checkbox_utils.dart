import 'resources/global/app_strings.dart';

class CheckboxUtils {
  static String getWorkStateValueByAPIValue(String apiVlaue) =>
      apiVlaue == 'TRAVAUX_EN_COURS'
          ? AppStrings.workOnState
          : AppStrings.workOffState;

  static String getWorkStateAPIValueByValue(String value) =>
      value == '0' ? 'TRAVAUX_EN_COURS' : 'TRAVAUX_EN_ARRET';

  static String getWorkRateValueByAPIValue(String apiVlaue) {
    switch (apiVlaue) {
      case 'BONNE':
        return AppStrings.workGoodState;
      case 'MEDIOCRE':
        return AppStrings.workMediocreState;
    }
    return AppStrings.workMediumState;
  }

  static String getWorkRateAPIValueByValue(String value) {
    switch (value) {
      case '0':
        return 'BONNE';
      case '2':
        return 'MEDIOCRE';
    }
    return 'MOYENNE';
  }
}
