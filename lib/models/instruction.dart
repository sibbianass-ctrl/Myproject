import 'package:my_project/utils/instructions_status_utils.dart';

class Instruction {
  String id;
  String meetingId;
  String instruction;
  String instructionDescription;
  int state;

  Instruction(
      {required this.id,
      required this.meetingId,
      required this.instruction,
      required this.instructionDescription,
      this.state = -1});

  // Factory method to create an Instruction from a map
  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
        id: json['instructionId'].toString(),
        meetingId: json['id'],
        instruction: json['instruction'],
        instructionDescription: json['instructionDescription'] ?? 'null',
        // If Null by default is encours
        state: InstructionsStatusUtils.getInstructionStatusByAPIValue(
            json['etat'] ?? 'ENCOURS'));
  }
}
