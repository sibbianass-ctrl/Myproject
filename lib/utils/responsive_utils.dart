import 'package:flutter/material.dart';

double getResponsiveFontSize(BuildContext context, double baseFontSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  return baseFontSize * (screenWidth / 360.0); // 375px as base width
}


double getResponsiveIconSize(BuildContext context, double baseIconSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  return baseIconSize * (screenWidth / 360.0); // 375px as base width
}