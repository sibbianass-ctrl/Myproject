import 'package:flutter/material.dart';
import 'package:my_project/utils/responsive_utils.dart';

class LabeledContainer extends StatelessWidget {
  final String labelText;
  final Widget child;

  const LabeledContainer({
    Key? key,
    required this.labelText,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
      labelStyle:  TextStyle(fontSize: getResponsiveFontSize(context, 12), fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: child,
    );
  }
}
