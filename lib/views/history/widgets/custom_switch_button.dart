import 'package:flutter/material.dart';
import 'package:my_project/utils/resources/global/app_colors.dart';
import 'package:my_project/utils/responsive_utils.dart';

class CustomSwitchButton extends StatefulWidget {
  final String leftLabel;
  final String rightLabel;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CustomSwitchButton({
    Key? key,
    required this.leftLabel,
    required this.rightLabel,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSwitchButtonState createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  late bool isLeftSelected;

  @override
  void initState() {
    super.initState();
    isLeftSelected = widget.initialValue;
  }

  void toggleSwitch(bool isLeft) {
    setState(() {
      isLeftSelected = isLeft;
    });
    widget.onChanged(isLeftSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 3,
              offset: Offset(1, 2),
            ),
          ]),
      child: Row(
        children: [
          _buildOption(widget.leftLabel, true, isLeftSelected),
          _buildOption(widget.rightLabel, false, isLeftSelected),
        ],
      ),
    );
  }

  Widget _buildOption(String label, bool isLeft, bool isSelected) {
    bool isActive = (isLeft == isSelected);
    return Expanded(
      child: GestureDetector(
        onTap: () => toggleSwitch(isLeft),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.green : Colors.grey[300],
            borderRadius: BorderRadius.horizontal(
              left: isLeft ? const Radius.circular(20) : Radius.zero,
              right: !isLeft ? const Radius.circular(20) : Radius.zero,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            label,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, 12),
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
