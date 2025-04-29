import 'package:flutter/material.dart';
import '../../../utils/resources/global/app_colors.dart';
import '../../../utils/resources/global/app_dimensions.dart';

class SubCardItem extends StatelessWidget {
  final Size size;
  final String title;
  final double value;
  final String unit;
  const SubCardItem(
      {super.key,
      required this.size,
      required this.title,
      required this.value,
      required this.unit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.26,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 38,
            decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimensions.borderRadius),
                    topRight: Radius.circular(AppDimensions.borderRadius))),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.white),
              ),
            ),
          ),
          Container(
              color: Colors.white,
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text(
                  '${value.toStringAsFixed(2)}\n$unit',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
