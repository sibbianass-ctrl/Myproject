import 'package:flutter/material.dart';
import 'package:my_project/utils/responsive_utils.dart';

class NavigationDestinationItem extends StatelessWidget {
  final IconData iconData;
  final String label;

  const NavigationDestinationItem({
    super.key,
    required this.iconData,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Icon(
        iconData,
        size: getResponsiveIconSize(context, 20),
      ),
      label: label,
    );
  }
}
