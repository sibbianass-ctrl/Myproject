import '../../models/instruction.dart';
import '../../models/lot_instructions.dart';

List<LotInstructions> parseLotInstructions(List<dynamic> data) {
  // Group instructions by lotId
  Map<String, LotInstructions> groupedData = {};

  for (var item in data) {
    if (item['etat'] == 'REALISE') continue;

    String lotId = item['lotId'];
    String lotName = item['titled'];

    // Create Instruction object
    Instruction instruction = Instruction.fromJson(item);

    // If this lotId already exists, add the instruction to its list
    if (groupedData.containsKey(lotId)) {
      groupedData[lotId]!.instructions.add(instruction);
    } else {
      // Otherwise, create a new LotInstructions object
      groupedData[lotId] = LotInstructions(
        lotId: lotId,
        lotName: lotName,
        instructions: [instruction],
      );
    }
  }

  // Return the grouped data as a list
  return groupedData.values.toList();
}
