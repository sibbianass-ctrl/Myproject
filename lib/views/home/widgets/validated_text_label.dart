import 'package:flutter/material.dart';

class ValidatedTextLabel extends StatelessWidget {
  final String text;
  final double textSize;
  const ValidatedTextLabel({super.key, required this.text, this.textSize = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: textSize, color: Colors.white),
      ),
    );
  }
}
