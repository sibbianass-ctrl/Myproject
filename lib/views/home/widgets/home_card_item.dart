import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/utils/app_strings_utils.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';
import 'package:my_project/utils/resources/home/home_dimensions.dart';
import 'package:my_project/views/home/widgets/home_card_button.dart';
import 'package:my_project/views/home/widgets/validated_text_label.dart';
import '../../../utils/resources/global/app_colors.dart';
import '../../../utils/resources/home/home_strings.dart';
import '../../../widgets/confirmation_dialog.dart';

class HomeCardItem extends StatelessWidget {
  final String title;
  final String number;
  final String date;
  final int index;
  final bool isValidated;
  final Function onOrdinaryTap;
  final Function onTakeAttachmentTap;
  const HomeCardItem({
    super.key,
    required this.title,
    required this.number,
    required this.date,
    required this.index,
    required this.isValidated,
    required this.onOrdinaryTap,
    required this.onTakeAttachmentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(width: .3, color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(HomeDimensions.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Index
          Expanded(
            flex: 1,
            child: Container(
              height: 146,
              decoration: const BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(HomeDimensions.cardBorderRadius),
                  bottomLeft: Radius.circular(HomeDimensions.cardBorderRadius),
                ),
              ),
              child: Center(
                child: Text(
                  index.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // Card Info
          Expanded(
            flex: 8,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.dialog(ConfirmationDialog(
                      title: AppStrings.market,
                      content: title,
                      yesButtonTitle: AppStrings.ok,
                      noButtonTitle: '',
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStringsUtils.truncateWithEllipsis(title, 25),
                        // title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      if (isValidated)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 16,
                          ),
                        )
                    ],
                  ),
                ),
                Text(
                  '${AppStrings.dateLabel} : $date',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  '${AppStrings.numberLabel} : $number',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(
                  height: 32,
                ),
                if (isValidated)
                  ValidatedTextLabel(text: HomeStrings.validationSortieDone)
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeCardButton(
                        text: HomeStrings.cardButtonTextOrdinaryLabel,
                        onTap: () => onOrdinaryTap(),
                      ),
                      HomeCardButton(
                        text: HomeStrings.cardButtonTextattAchementLabel,
                        onTap: () => onTakeAttachmentTap(),
                      ),
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
