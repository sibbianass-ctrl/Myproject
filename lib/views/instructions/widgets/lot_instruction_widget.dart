import 'package:flutter/material.dart';
import 'package:my_project/utils/responsive_utils.dart';
import 'package:my_project/views/instructions/widgets/instruction_widget.dart';

class LotInstructionWidget extends StatelessWidget {
  final String name;
  final List<InstructionWidget> instructions;
  const LotInstructionWidget(
      {super.key, required this.name, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(3)),
      child: ExpansionTile(
        title: Text(
          name,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: getResponsiveFontSize(context, 12)),
        ),
        shape: const Border(),
        collapsedBackgroundColor: const Color.fromARGB(255, 245, 255, 244),
        backgroundColor: const Color.fromARGB(255, 232, 240, 236),
        children: instructions,
      ),
    );
  }
}
