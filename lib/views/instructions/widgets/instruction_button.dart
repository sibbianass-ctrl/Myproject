import 'package:flutter/material.dart';
import '../../../utils/resources/global/app_colors.dart';

class InstructionButton extends StatelessWidget {
  final String text;
  final int index;
  final int state;
  final Color color;
  final Function function;
  InstructionButton(
      {super.key,
      required this.text,
      required this.index,
      required this.state,
      required this.color,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
            color: index == state ? color : AppColors.greyLite,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: color)),
        child: Text(
          text,
          style: const TextStyle(fontSize: 10.5),
        ),
      ),
    );
  }
}
