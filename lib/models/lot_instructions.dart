import 'package:my_project/models/instruction.dart';

class LotInstructions {
  String lotId;
  String lotName;
  List<Instruction> instructions;

  LotInstructions(
      {required this.lotId,
      required this.lotName,
      required this.instructions});
}
