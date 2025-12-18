# 🏢 ESPACE BET - COMPREHENSIVE DOCUMENTATION

## 1. OVERVIEW
**Espace BET** (Bureau d'Études Techniques) is a dedicated user role/space in the my_project Flutter application. It's one of three user types: **Province**, **Architecte**, and **BET**.

---

## 2. ARCHITECTURE & ENUM DEFINITION

### File: lib/enums/space_type.dart
```dart
enum SpaceType {
  province,    // Province technician users
  architecte,  // Architect users
  bet,         // BET (Technical Study Bureau) users
  unknown,     // Default/unassigned users
}
```

---

## 3. AUTHENTICATION & ROLE ASSIGNMENT

### File: lib/services/api_service/auth_service.dart
When user logs in, the role is determined:

```dart
Future<void> _getUserRole() async {
  log('calling getUserRole ... ', name: ' --- Trace ---');
  final url = Uri.parse(ApiEndpoints.getUserRole);
  final headers = {'Content-Type': 'application/json'};
  log(ApiEndpoints.getUserRole, name: 'role URL');
  
  final response = await http.get(url, headers: headers);
  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    String enterpriseId = responseData['enterpriseId'].toString();
    _userInfoService.enterpriseId = enterpriseId;
    log('enterpriseId: $enterpriseId', name: 'Enterprise ID');
    log(responseData['administration'].toString(), name: '--- ROLE ---');

    if (responseData['administration'] == 'province') {
      _userInfoService.spaceType = SpaceType.province;
      await _getTechnicianId();
    } else if (responseData['administration'] == 'architecte') {
      _userInfoService.spaceType = SpaceType.architecte;
      log('enterpriseId: $enterpriseId', name: 'Enterprise ID');
      await _getEntrepriseId(enterpriseId);
    } else if (responseData['administration'] == 'bet') {
      _userInfoService.spaceType = SpaceType.bet;
      await _getEntrepriseId(enterpriseId);  // Fetch enterprise data
    }
  } else {
    log('Error: ${response.statusCode} ${response.body}', name: 'role');
  }
}
```

**Key Points:**
- Role determined by `responseData['administration']` value
- If value is `'bet'`, space type set to `SpaceType.bet`
- Enterprise ID fetched immediately after role assignment
- Enterprise data loaded via `_getEntrepriseId(enterpriseId)`

---

## 4. USER INFO SERVICE

### File: lib/services/user_info_service.dart
Singleton service storing BET user information:

```dart
class UserInfoService {
  static final UserInfoService _instance = UserInfoService._internal();
  
  factory UserInfoService() {
    return _instance;
  }

  // User Properties
  String? token;
  String id = '';
  String tecId = '';
  String userFullName = '';
  String username = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String responsableName = '';
  String responsablePhoneNumber = '';
  SpaceType spaceType = SpaceType.unknown;
  String enterpriseId = '';

  // For BET users, populate from enterprise data
  void fromJsonEntreprise(data) {
    userFullName = data['name'];
    username = 'ICE: ' + data['ice'] + ' - IFF: ' + data['iff'];
  }

  @override
  String toString() {
    return 'UserInfoService(id: $id, userFullName: $userFullName, username: $username, role: ${spaceType.name})';
  }
}
```

**For BET Users:**
- `spaceType` = `SpaceType.bet`
- `enterpriseId` = Associated enterprise ID
- `username` = Formatted as "ICE: [value] - IFF: [value]"
- `userFullName` = Enterprise name

---

## 5. NAVIGATION & ROUTING

### File: lib/controllers/start_controller.dart
BET navigation flow after login:

```dart
class StartController {
  final HomeController _homeController = Get.put(HomeController());
  final InstructionsController _instructionsController = Get.put(InstructionsController());
  final HistoryController _historyController = Get.put(HistoryController());
  final HomeArchitectController _homeArchitectController = Get.put(HomeArchitectController());
  final UserInfoService userInfoService = UserInfoService();

  startButtonTaped() async {
    if (userInfoService.spaceType == SpaceType.province) {
      // Province flow...
      await _homeController.fillSorties();
      await _instructionsController.fillInstructions();
      await _historyController.fillHistory();
      await _portfolioHistoryController.loadValidatedSorties();
      Get.offNamed(Routes.menuPage);
      
    } else if (userInfoService.spaceType == SpaceType.architecte) {
      // Architect flow - loads lots
      await _homeArchitectController.fillLots();
      Get.offNamed(Routes.menuArchitect);
      
    } else if (userInfoService.spaceType == SpaceType.bet) {
      // BET flow - SAME AS ARCHITECT
      await _homeArchitectController.fillLots();
      Get.offNamed(Routes.menuArchitect);  // Uses architect menu
    }
  }
}
```

**Navigation Points:**
- BET users use `HomeArchitectController` (same as Architect)
- BET users navigate to `Routes.menuArchitect` 
- BET users load lots via `fillLots()` method
- **BET and Architect share the same UI navigation**

---

## 6. MENU STRUCTURE

### File: lib/views/menu_architect/menu_architect_view.dart
Both Architect and BET users see this menu:

```dart
class MenuArchitectView extends StatelessWidget {
  final List<Map<String, dynamic>> navigationDestinationItems = [
    {
      'ic': Icons.home,
      'label': MenuStrings.visits,
      'widget': HomeArchitectView()
    },
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
}
```

**Menu Items for BET Users:**
1. **Visites (Home)** - Browse and manage lots/markets
2. **Bordereau des Prix (Price List)** - View price schedules
3. **Instructions** - Governor instructions management
4. **Profile** - User profile & settings

---

## 7. SHARED VIEWS WITH ARCHITECT

### Views Used by BET Users:

| Feature | File Path | Purpose |
|---------|-----------|---------|
| **Home/Lots** | lib/views/home_architect/home_architect_view.dart | Display markets/lots for visit creation |
| **Menu** | lib/views/menu_architect/menu_architect_view.dart | Main navigation between features |
| **Visit Form** | lib/views/architect_visit_form/Architect_visit_form_view.dart | Create/submit visit reports |
| **Price List** | lib/views/price_lists/price_lists_view.dart | View price schedules |
| **Instructions** | lib/views/instructions_architect/instructions_architect_view.dart | View & manage instructions |
| **Profile** | lib/views/profile_architect/profile_architect_view.dart | User profile management |

### Empty BET-Specific Placeholder Files (Not Implemented):
- lib/views/home_bet/home_bet_view.dart - **EMPTY**
- lib/views/price_lists_bet/price_lists_view_bet.dart - **EMPTY**
- lib/views/profile_bet/profile_view_bet.dart - **EMPTY**

---

## 8. CONTROLLERS

### HomeArchitectController
File: lib/controllers/home_architect_controller.dart

```dart
class HomeArchitectController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<LotDto> lots = <LotDto>[].obs;

  final ArchitectVisitFromController _architectVisitFormController =
      Get.put(ArchitectVisitFromController());
  final PriceListArchitectViewController _priceListArchitectViewController =
      Get.put(PriceListArchitectViewController());

  // Fill Lots - Called on app startup
  Future<void> fillLots() async {
    Get.dialog(LoadingDialog(text: HomeStrings.loadingText + '...'), 
               barrierDismissible: false);
    lots.addAll(await CommandsService.getAllLotByUserId());
    Get.back();
  }

  // Refresh lots - Pull-to-refresh
  Future<void> refreshLots() async {
    lots.clear();
    lots.addAll(await CommandsService.getAllLotByUserId());
    lots.refresh();
  }

  // Navigate to visit form
  moveToOrdinaryPage(int index) async {
    _architectVisitFormController.sortie.value.clear();
    _architectVisitFormController.sortie.value.setLot(lots[index]);

    Get.dialog(LoadingDialog(), barrierDismissible: false);

    _architectVisitFormController.sortie.value.objects
        .addAll(await CommandsService.getObjectsList(lots[index].id));
    _architectVisitFormController.sortie.value.constats
        .addAll(await CommandsService.getConstatsList(lots[index].id));
    _architectVisitFormController.sortie.value.recommendations
        .addAll(await CommandsService.getRecommendationsList(lots[index].id));
    Get.back();
    await Get.toNamed(Routes.architectVisitForm);
  }

  // Navigate to price list
  moveToPricesListPage(int index) async {
    _priceListArchitectViewController.lot = lots[index];
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    _priceListArchitectViewController.prestations =
        await CommandsService.getLatestPricesList(lots[index].id, 'Architect');
    Get.back();
    if (_priceListArchitectViewController.prestations.isEmpty) {
      snackbarWarrning(PriceListStrings.noPriceList);
    } else {
      Get.to(() => PriceListArchitectView());
    }
  }
}
```

**Key Methods:**
- `fillLots()` - Loads all lots for the user
- `refreshLots()` - Refreshes lot list (pull-to-refresh)
- `moveToOrdinaryPage()` - Opens visit form for a specific lot
- `moveToPricesListPage()` - Opens price list view

---

## 9. API ENDPOINTS

### File: lib/services/api_service/api_endpoints.dart

```dart
final class ApiEndpoints {
  static String get _apiBaseUrl => dotenv.env['API_BASE_URL_TEST'] ?? '';
  static String get _authUrl => dotenv.env['AUTH_URL'] ?? '';
  static String get _fileURL => dotenv.env['FILE_URL'] ?? '';

  static UserInfoService _userInfoService = UserInfoService();

  // ===== ENDPOINTS FOR BET USERS =====

  // GET ENDPOINTS
  static String get getAllLotsByUserId =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/get-lot/${_userInfoService.id}/${_userInfoService.spaceType.name}';
  
  static String get getLatestPricesList =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/get-lot-validated-bet-or-architect?lotId=';
  
  static String get getObjectsList =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/following-up-object';
  
  static String get getConstatsList =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/observation';
  
  static String get getRecommendationsList =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/recommendation';
  
  static String get getGovernerInstruction =>
      '${_apiBaseUrl}cp-my-project/get-governor-instruction-by-Entreprise-id/${_userInfoService.enterpriseId}?';
  
  static String get getFollowingUpPhasesByLotId =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/by-lot-id/';

  // POST ENDPOINTS
  static String get postVisiteArchitectAndBET =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/sortie-entreprise';
  
  static String get postValidationPriceList =>
      '${_apiBaseUrl}cp-my-project/following-up-phases/update-sortie/';
  
  static String get updateInstruction =>
      '${_apiBaseUrl}cp-my-project/update-meeting-description/';

  // FILE ENDPOINTS
  static String get uploadFile => '${_fileURL}uploadFile/';
  static String get downloadFile => '${_fileURL}downloadFileSpecific/my_project/';
}
```

**Key Points:**
- `getAllLotsByUserId` includes `spaceType.name` (will be "bet" for BET users)
- `getLatestPricesList` accepts `architectedOrBet` parameter
- `postVisiteArchitectAndBET` endpoint handles both Architect and BET submissions
- `getGovernerInstruction` filters by `enterpriseId` (BET enterprise)

---

## 10. DATA SUBMISSION - BET VISIT POSTING

### File: lib/services/api_service/commands_service.dart

```dart
static Future<bool> postOrdinaryVisiteArchitect(
    Sortie sortie,
    List<String> selectedObjectsIds,
    List<String> selectedConstatsIds,
    List<String> selectedRecomedationsIds,
    List<String> files) async {
  if (!await _checkConnection()) return false;
  
  var body = {
    "lotId": sortie.marketId,
    "userId": _userInfo.id,
    "planningDate": sortie.programedDate,
    "reelDate": DateTime.now().toString().split(' ').first,
    "visitType": [SortieType.ordinary],
    "followingUpObjects": [
      for (String id in selectedObjectsIds) {"id": id}
    ],
    "progressRate": sortie.progressRate.toInt(),
    "siteState": CheckboxUtils.getWorkStateAPIValueByValue(sortie.workStateValue),
    "workRate": CheckboxUtils.getWorkRateAPIValueByValue(sortie.workRateValue),
    "recommendations": [
      for (String id in selectedRecomedationsIds) {"id": id}
    ],
    "observations": [
      for (String id in selectedConstatsIds) {"id": id}
    ],
    "validate": true,
    "attachedDocument": files,
  };
  
  try {
    final response = await _dio.post(ApiEndpoints.postVisiteArchitectAndBET, data: body);
    if (![200, 201, 204].contains(response.statusCode)) {
      snackbarError(AppStrings.errorWhilePosting);
      return false;
    }
  } on DioException catch (e) {
    snackbarError("APP ERROR : ${e.response?.statusCode}");
    return false;
  }
  return true;
}
```

**Visit Submission Data Structure:**
- `lotId` - Market ID
- `userId` - BET user ID
- `planningDate` - Scheduled date
- `reelDate` - Actual visit date
- `visitType` - Type of visit (ordinary, take attachment)
- `followingUpObjects` - Selected work objects
- `progressRate` - Work progress percentage
- `siteState` - Site condition (in progress, stopped)
- `workRate` - Work pace (good, medium, poor)
- `recommendations` - Selected recommendations
- `observations` - Selected observations/findings
- `validate` - Always true
- `attachedDocument` - Photos/files

---

## 11. VALIDATION STATUS TRACKING

### BET Visit Validation Fields

```dart
// In postTakeAttachmentVisite method
var body = {
  // ... other fields ...
  "validatedByArchitect": "ENCOURS",    // Status: In Progress
  "validatedByBet": "ENCOURS",          // Status: In Progress (BET validation)
  "validate": true,
  "attachedDocument": files,
};
```

**Validation Statuses:**
- `ENCOURS` = In Progress / Pending
- Separate tracking for Architect and BET validation
- Allows for independent review workflows

---

## 12. UI DISPLAY - SPACE TITLE

### File: lib/widgets/space_title.dart

```dart
class SpaceTitle extends StatelessWidget {
  final UserInfoService _userInfoService = UserInfoService();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 16,
            color: AppColors.green,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
              _userInfoService.spaceType == SpaceType.architecte
                  ? 'Espace Architecte'
                  : 'Espace BET',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        Expanded(
          child: Container(
            height: 16,
            color: AppColors.green,
          ),
        )
      ],
    );
  }
}
```

**Display Logic:**
- If spaceType is `architecte` → Shows "Espace Architecte"
- Otherwise (for BET) → Shows "Espace BET"
- Green accent bars on both sides

---

## 13. ARCHITECT VISIT FORM CONTROLLER

### File: lib/controllers/architect_visit_from_controller.dart

```dart
class ArchitectVisitFromController extends GetxController {
  Rx<Sortie> sortie = Sortie().obs;
  final PhotoController photoController = Get.put(PhotoController());
  FileUploadService _fileUploadService = FileUploadService();
  List<String> files = <String>[];

  List<String> getSelectedObjectsIds() {
    return sortie.value.objects
        .where((checkbox) => checkbox['state'] == true)
        .map<String>((checkbox) => checkbox['id'])
        .toList();
  }

  List<String> getSelectedConstatsIds() {
    return sortie.value.constats
        .where((checkbox) => checkbox['state'] == true)
        .map<String>((checkbox) => checkbox['id'])
        .toList();
  }

  List<String> getSelectedRecomedationsIds() {
    return sortie.value.recommendations
        .where((checkbox) => checkbox['state'] == true)
        .map<String>((checkbox) => checkbox['id'])
        .toList();
  }

  void clearData() {
    for (Map<String, dynamic> cbx in sortie.value.objects) {
      cbx['state'] = false;
    }
    for (Map<String, dynamic> cbx in sortie.value.constats) {
      cbx['state'] = false;
    }
    for (Map<String, dynamic> cbx in sortie.value.recommendations) {
      cbx['state'] = false;
    }
  }
}
```

**Functionality:**
- Manages visit form data
- Collects selected objects, findings, recommendations
- Handles photo/file uploads
- Clears selections after submission

---

## 14. DATA FLOW DIAGRAM

```
Login
  ↓
AuthService._getUserRole()
  ↓ (if administration == 'bet')
SpaceType.bet assigned
  ↓
_getEntrepriseId() called
  ↓
UserInfoService populated
  ↓
StartController.startButtonTaped()
  ↓
HomeArchitectController.fillLots()
  ↓
CommandsService.getAllLotByUserId()
  (URL includes spaceType.name = "bet")
  ↓
MenuArchitectView displayed
  ↓
User selects lot
  ↓
ArchitectVisitFormView opens
  ↓
User fills form (objects, observations, recommendations, photos)
  ↓
CommandsService.postOrdinaryVisiteArchitect()
  ↓
POST to /sortie-entreprise with validation data
  ↓
"validatedByBet": "ENCOURS"
```

---

## 15. KEY DIFFERENCES: BET vs ARCHITECT

| Aspect | Architect | BET |
|--------|-----------|-----|
| **Menu** | MenuArchitectView | MenuArchitectView (shared) |
| **Home View** | HomeArchitectView | HomeArchitectView (shared) |
| **Price List Query Param** | `'Architect'` | `'Architect'` (TODO: needs fixing) |
| **Validation Field** | `validatedByArchitect` | `validatedByBet` |
| **Enterprise Data** | Yes (fetched) | Yes (fetched) |
| **Lots Endpoint** | spaceType.name = "architecte" | spaceType.name = "bet" |
| **UI Label** | "Espace Architecte" | "Espace BET" |
| **Dedicated Views** | Shared | Empty placeholder files exist |

---

## 16. TODO/ISSUES IDENTIFIED

1. **Price List Parameter** (HomeArchitectController):
   ```dart
   // TODO: FIX : Check if we sent just architect or also bet
   _priceListArchitectViewController.prestations =
       await CommandsService.getLatestPricesList(lots[index].id, 'Architect');
   ```
   - Currently always sends 'Architect' for both roles
   - Should differentiate between 'Architect' and 'BET'

2. **Empty BET Views**:
   - `home_bet_view.dart` - Not implemented
   - `price_lists_view_bet.dart` - Not implemented
   - `profile_view_bet.dart` - Not implemented
   - Currently BET users share Architect views

3. **Validation Status**:
   - Uses `ENCOURS` for both fields
   - No clear documentation on valid status values

---

## 17. ROUTES CONFIGURATION

### File: lib/routes/routes.dart

```dart
class Routes {
  static const String logingPage = '/login';
  static const String startPage = '/start';
  static const String homePage = '/home';
  static const String menuPage = '/menu';
  static const String menuArchitect = '/menu_architect';  // Used by BET
  static const String architectVisitForm = '/architect_visit_form';  // Used by BET
  static const String ordinaryVisitPage = '/ordinary_visit';
  static const String takeAttachmentVisitPage = '/take_attachment';
}

Map<String, WidgetBuilder> publicRoutes(BuildContext context) {
  return {
    Routes.menuArchitect: (context) => MenuArchitectView(),
    Routes.architectVisitForm: (context) => ArchitectVisitFormView(),
    // ... other routes ...
  };
}
```

---

## 18. SUMMARY TABLE

| Component | Value | File |
|-----------|-------|------|
| **Enum Value** | `SpaceType.bet` | lib/enums/space_type.dart |
| **Authentication Check** | `administration == 'bet'` | lib/services/api_service/auth_service.dart |
| **User Info Storage** | `UserInfoService` singleton | lib/services/user_info_service.dart |
| **Main Navigation** | `MenuArchitectView` | lib/views/menu_architect/menu_architect_view.dart |
| **Home/Lots View** | `HomeArchitectView` | lib/views/home_architect/home_architect_view.dart |
| **Visit Form** | `ArchitectVisitFormView` | lib/views/architect_visit_form/Architect_visit_form_view.dart |
| **Price Lists** | `PriceListsView` | lib/views/price_lists/price_lists_view.dart |
| **Instructions** | `InstructionsArchitectView` | lib/views/instructions_architect/instructions_architect_view.dart |
| **Profile** | `ProfileArchitectView` | lib/views/profile_architect/profile_architect_view.dart |
| **Controller** | `HomeArchitectController` | lib/controllers/home_architect_controller.dart |
| **API Endpoints** | Multiple (see section 9) | lib/services/api_service/api_endpoints.dart |
| **Data Submission** | `postOrdinaryVisiteArchitect()` | lib/services/api_service/commands_service.dart |
| **UI Label** | "Espace BET" | lib/widgets/space_title.dart |

---

## END OF DOCUMENTATION

All information about Espace BET has been compiled. You can easily copy everything from this file.
