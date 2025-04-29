import 'package:flutter/material.dart';

class CustomDataColumn extends DataColumn {
  CustomDataColumn({
    required String labelText,
    TextAlign textAlign = TextAlign.center,
    TextStyle? textStyle,
  }) : super(
          label: Text(
            labelText,
            textAlign: textAlign,
            style: textStyle ?? const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
}
