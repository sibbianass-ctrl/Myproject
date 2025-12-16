import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  
  final ValueChanged<bool?> onChanged;
  final Map<String,dynamic> item;
  CustomCheckbox({
    super.key,
    required this.item,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        item['isChecked'] = !item['isChecked'];
        onChanged(item['isChecked']);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: item['isChecked'],
            onChanged: (bool? value) {
              item['isChecked'] = value ?? false;
              onChanged(item['isChecked']);
            
            },
            checkColor: Colors.white,
          ),
          GestureDetector(
            onTap: () {
              item['isChecked'] = !item['isChecked'];
              onChanged(item['isChecked']);
              
            },
            child: Text(
              item['label'],
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
