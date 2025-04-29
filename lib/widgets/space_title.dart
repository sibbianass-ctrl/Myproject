import 'package:flutter/material.dart';
import 'package:my_project/enums/space_type.dart';

import '../services/user_info_service.dart';
import '../utils/resources/global/app_colors.dart';

class SpaceTitle extends StatelessWidget {
  // final String title;
  SpaceTitle({
    super.key,
  });
  final UserInfoService _userInfoService = UserInfoService();
  Color color() => _userInfoService.spaceType == SpaceType.architecte
      ? AppColors.architectSpaceColor
      : AppColors.betSpaceColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 16,
            color: color(),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
              _userInfoService.spaceType == SpaceType.architecte
                  ? 'Espace Architecte'
                  : 'Espace BET',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        Expanded(
          child: Container(
            height: 16,
            color: color(),
          ),
        )
      ],
    );
  }
}
