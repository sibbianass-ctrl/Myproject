import 'package:flutter/material.dart';
import 'package:my_project/utils/resources/history/history_strings.dart';
import '../../../utils/resources/global/app_colors.dart';
import '../../../utils/responsive_utils.dart';

class ValidatedSortieItem extends StatelessWidget {
  final String lotName;
  final String lotNumber;
  final String validatedDate;

  const ValidatedSortieItem(
      {super.key,
      required this.lotName,
      required this.lotNumber,
      required this.validatedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0, right: 8.0),
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 15),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    lotName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: getResponsiveFontSize(context, 12),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.verified,
                  color: AppColors.green,
                  size: getResponsiveIconSize(context, 16),
                ),
              ],
            ),
            Text(
              'N°: $lotNumber',
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, 10),
              ),
            ),
            Text(
              '${HistoryStrings.validatedAt}: $validatedDate',
              style: TextStyle(
                  fontSize: getResponsiveFontSize(context, 10),
                  color: const Color.fromARGB(255, 136, 136, 136)),
            )
          ],
        ),
      ),
    );
  }
}
