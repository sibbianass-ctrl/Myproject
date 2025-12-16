// import '../enums/visit_type_enum.dart';
// import 'prestation.dart';
//
// class ValidatedSortie {
//   final String lotId;
//   String lotName;
//   String lotNumber;
//   String planningDate;
//   String reelDate;
//   String siteState;
//   String workRate;
//   int progressRate;
//   VisitTypeEnum visitType;
//   List<Prestation> cardItemsPrestations;
//   List<String> photos;
//
//   ValidatedSortie(
//
//       {
//       required this.lotName,
//       required this.lotId,
//       required this.lotNumber,
//       required this.planningDate,
//       required this.reelDate,
//       required this.siteState,
//       required this.progressRate,
//       required this.cardItemsPrestations,
//       required this.visitType,
//       required this.workRate,
//       required this.photos});
// }
import '../enums/visit_type_enum.dart';
import 'prestation.dart';

class ValidatedSortie {
  final String lotId;
  String lotName;
  String lotNumber;
  String planningDate;
  String reelDate;
  String siteState;
  String workRate;
  int progressRate;
  VisitTypeEnum visitType;
  List<Prestation> cardItemsPrestations;
  List<String> photos;

  // NEW: القوائم المختارة
  List<String> selectedObjectsLabels;
  List<String> selectedConstatsLabels;
  List<String> selectedRecommendationsLabels;

  ValidatedSortie({
    required this.lotId,
    required this.lotName,
    required this.lotNumber,
    required this.planningDate,
    required this.reelDate,
    required this.siteState,
    required this.workRate,
    required this.progressRate,
    required this.visitType,
    required this.cardItemsPrestations,
    required this.photos,
    this.selectedObjectsLabels = const [],
    this.selectedConstatsLabels = const [],
    this.selectedRecommendationsLabels = const [],
  });
}
