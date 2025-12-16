import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_project/services/user_info_service.dart';

final class ApiEndpoints {
  static String get _apiBaseUrl => dotenv.env['API_BASE_URL_TEST'] ?? '';
  static String get _authUrl => dotenv.env['AUTH_URL'] ?? '';
  static String get _fileURL => dotenv.env['FILE_URL'] ?? '';

  static UserInfoService _userInfoService = UserInfoService();

  //AUTH
  static String get loginEndpoint =>
      '${_authUrl}realms/province_settat/protocol/openid-connect/token';
  static String get getUserRole =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/Info-compte/${_userInfoService.id}';

  //GET
  static String get getUserInfoByToken =>
      '${_authUrl}realms/province_settat/account';
  static String get getTechnician =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/person/${_userInfoService.id}';
  static String get getObjectsList =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/following-up-object';
  static String get getConstatsList =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/observation';
  static String get getRecommendationsList =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/recommendation'; // no fonctionne
  static String get getSortiesList =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/sortie/find-sorties-by-technician-id/${_userInfoService.id}';
  // static String get getInstructions =>
  //     '${_apiBaseUrl}cp-my-project/get-lot-instriction/${_userInfoService.tecId}';
  // static String get getInstructions =>
  //     '${_apiBaseUrl}cp-my-project/get-lot-instriction/6900c91f18cdb89ad4e731f9';
  static String get getInstructions =>
      '${_apiBaseUrl}cp-my-project/get-lot-instriction/';
  static String get getGovernerInstruction =>
      '${_apiBaseUrl}cp-my-project/get-governor-instruction-by-Entreprise-id/${_userInfoService.enterpriseId}?';
  static String get getValidatedSorties =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/sortie/find-sorties-by-technician-id-true/${_userInfoService.id}';
  static String get getSortiesCount =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/count-sortie-validate/';
  static String get getUserById =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/person/${_userInfoService.id}';
  static String get saveNotificationId =>
      '${_apiBaseUrl}cp-my-project/programing-phases/persons';
  static String get getAllLotsByUserId =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/get-lot/${_userInfoService.id}/${_userInfoService.spaceType.name}';
  static String get getLatestPricesList =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/get-lot-validated-bet-or-architect?lotId=';
  static String get getEntreprise =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/enterprise/';
  static String get getSuiteReserved =>
      '${_apiBaseUrl}cp-my-project/get-reserved-suite-status';


  //POST
  static String get saveSuiteReserved =>
      '${_apiBaseUrl}cp-my-project/save-reserved-suite-status';
  static String get postVisite =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/sortie';
  static String get postVisiteArchitectAndBET =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/sortie-entreprise';
  static String get postInstructionStatus =>
      '${_apiBaseUrl}cp-my-project/update-meeting-status/';
  static String get updateInstruction =>
      '${_apiBaseUrl}cp-my-project/update-meeting-description/';
  static String get postValidationPriceList =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/update-sortie/';
  static String get saveGovernorInstruction =>
      '${_apiBaseUrl}cp-my-project/save-governor-instruction';

  // FILE
  static String get uploadFile => '${_fileURL}uploadFile/';

  // نفس IP و port اللي عند صاحبك (بدّلهم إذا مختلفين عندك)
  static String get launchingServiceBaseUrl =>
      'http://172.16.20.233:8130/api';

  static String get downloadFile =>
      '${_fileURL}downloadFileSpecific/my_project/';


}
