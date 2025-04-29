import 'package:flutter/material.dart';

class CheckBoxList extends StatelessWidget {
  final String titleText;
  final List<String> items;
  final String selectedValue;
  final Function(String) onChanged;

  const CheckBoxList({
    Key? key,
    required this.titleText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: const TextStyle(fontSize: 12),
        ),
        for (int i = 0; i < items.length; i++)
          RadioListTile(
            dense: true,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            title: Text(
              items[i],
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
            value: i.toString(),
            groupValue:selectedValue,
            onChanged: (val) {
              onChanged(val!);
            },
          ),
      ],
    );
  }
}
