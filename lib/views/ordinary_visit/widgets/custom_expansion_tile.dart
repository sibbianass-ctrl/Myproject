import 'package:flutter/material.dart';
import '../../../utils/resources/global/app_colors.dart';
import '../../../utils/resources/oridnary_visit/oridnary_visit_strings.dart';

class CustomExpansionTile extends StatelessWidget {
  final List<Map<String, dynamic>> objects;
  final Function onChanged;
  const CustomExpansionTile(
      {super.key, required this.objects, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        OridnaryVisitStrings.expansionTile,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12),
      ),
      shape: const Border(),
      collapsedBackgroundColor: AppColors.grey,
      backgroundColor: AppColors.greyLite,
      children: [
        // You can fix this widget
        // Remove ListView.builder and replace it by for loop to itirate on _controller.checkboxes
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: objects.length,
          itemBuilder: (context, index) {
            var checkboxItem = objects[index];
            return CheckboxListTile(
              title: Text(
                checkboxItem["label"],
                style: const TextStyle(fontSize: 13),
              ),
              value: checkboxItem["state"],
              onChanged: (bool? value) {
                checkboxItem["state"] = value;
                onChanged();
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        ),
      ],
    );
  }
}
