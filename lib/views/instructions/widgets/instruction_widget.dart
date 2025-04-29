import 'package:flutter/material.dart';
import 'package:my_project/utils/resources/global/app_colors.dart';
import 'package:my_project/utils/resources/instructions/instructions_strings.dart';
import 'package:my_project/widgets/custom_text_field.dart';

class InstructionWidget extends StatelessWidget {
  final String label;
  final String title;
  final TextEditingController textEditingController = TextEditingController();
  final Function onEdit;
  final Function(String motif) onValidate;
  // You can specify this lit just InstructionButton
  final List<Widget> buttons;
  InstructionWidget(
      {super.key,
      required this.title,
      required this.label,
      required this.buttons,
      required this.onEdit,
      required this.onValidate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Text(
                '⬤ ${title}',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(onPressed: () => onEdit(), icon: Icon(Icons.edit))
          ],
        ),
        Container(
            margin: EdgeInsets.only(left: 8, bottom: 16),
            child: Text(
              '━ $label',
              style: TextStyle(fontSize: 12),
            )),
        // buttons ------------------------------------------
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buttons,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 8, bottom: 4),
                child: CustomTextField(
                  controller: textEditingController,
                  icon: Icons.info_outline,
                  color: Colors.grey,
                  hintText: InstructionsStrings.motif,
                  showText: false,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: AppColors.greyLite,
                    borderRadius: BorderRadius.circular(8)),
                child: IconButton(
                    onPressed: () => onValidate(textEditingController.text),
                    icon: Icon(Icons.send)))
          ],
        ),
      ],
    );
  }
}
