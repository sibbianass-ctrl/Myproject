import 'package:my_project/services/user_info_service.dart';

class GovernorInstruction {
  final String id;
  final String titled;
  final String instruction;
  final String lotId;
  final String lotNumber;
  final String reservedSuiteStatus;
  final dynamic caseDestinataire;
  final String govInstruction;
  final String instructionDate;
  final String planningId;
  final List<dynamic> reservedSuite;
  bool isValidated = false;

  GovernorInstruction({
    required this.id,
    required this.titled,
    required this.instruction,
    required this.lotId,
    required this.lotNumber,
    required this.reservedSuiteStatus,
    required this.govInstruction,
    required this.instructionDate,
    required this.planningId,
    this.caseDestinataire,
    required this.reservedSuite,
  });

  factory GovernorInstruction.fromJson(Map<String, dynamic> json) {
    return GovernorInstruction(
      id: json['id'] ?? '',
      lotId: json['lot']['id'] ?? '',
      titled: json['lot']['titled'] ?? '',
      lotNumber: json['lot']['numbMarch'] ?? '',
      instruction: json['instruction'] ?? '',
      reservedSuiteStatus: (json['reservedSuite'] as List).isNotEmpty
          ? ((json['reservedSuite'] as List).last)['reservedSuiteStatus']
              ['status']
          : 'Il n\'y a pas de suite réservée',
      govInstruction: json['govInstruction'] ?? '',
      instructionDate: json['instructionDate'],
      planningId: json['planningId'] ?? '',
      caseDestinataire: json['caseDestinataire'] ?? '',
      reservedSuite: json['reservedSuite'] ?? [],
    );
  }

  Map<String, dynamic> toJson(
      Map<String, dynamic> selectedSuitReserved, String details) {
    UserInfoService userInfoService = UserInfoService();
    reservedSuite.add({
      "details": details,
      "date": DateTime.now().toIso8601String(),
      "executedDate": null,
      "reservedSuiteStatus": {
        "id": selectedSuitReserved['id'],
        "status": selectedSuitReserved['label'],
      },
      "userId": userInfoService.id,
    });

    Map<String, dynamic> data = {
      'id': id,
      'lotId': lotId,
      'caseDestinataire': caseDestinataire,
      'govInstruction': govInstruction,
      'instructionDate': instructionDate,
      'instruction': instruction,
      'planningId': planningId,
      'reservedSuite': reservedSuite,
    };

    return data;
  }
}
