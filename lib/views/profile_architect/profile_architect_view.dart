import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/profile_controller.dart';
import 'package:my_project/utils/constants.dart';
import 'package:my_project/views/profile/widgets/profile_section.dart';
import 'package:my_project/widgets/copyright_text.dart';
import '../../utils/resources/global/app_strings.dart';
import '../../utils/resources/profile/profile_strings.dart';
import '../../utils/responsive_utils.dart';
import '../../widgets/custom_app_bar_2.dart';
import '../../widgets/custom_page_title_2.dart';
import '../../widgets/space_title.dart';

class ProfileArchitectView extends StatelessWidget {
  ProfileArchitectView({super.key});
  final ProfileController _profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const CustomAppBar2(
        title: '',
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Column(
          children: [
            SpaceTitle(),
            //Title
           CustomPageTitle2(
              size: size,
              title: ProfileStrings.pageTitle,
            ),
            const SizedBox(
              height: 64,
            ),
            //Content --------------
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  //User info
                  Row(
                    children: [
                      Image.asset(
                          width: 53, height: 53, Constants.profileImgPath),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _profileController.userInfoService.userFullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            _profileController.userInfoService.username,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                  //Divider
                  const Divider(),
                  const SizedBox(
                    height: 12,
                  ),
                  ProfileSection(
                    contentText:
                        '${ProfileStrings.responsableNameSectionLabel}: ${_profileController.userInfoService.responsableName}',
                    icon: Icons.person,
                    onTap: () {},
                  ),
                  ProfileSection(
                    contentText:
                        '${ProfileStrings.responsableTelSectionLabel}: ${_profileController.userInfoService.responsablePhoneNumber}',
                    icon: Icons.phone,
                    onTap: () {},
                  ),
                  ProfileSection(
                    contentText: ProfileStrings.settingsLabel,
                    icon: Icons.settings,
                    onTap: () {},
                  ),
                  ProfileSection(
                    contentText: ProfileStrings.logOutLabel,
                    icon: Icons.power_settings_new_sharp,
                    onTap: _profileController.logout,
                  ),
                ],
              ),
            ),
            //------------------------
            const CopyrightText(),
            SizedBox(
                width: double.infinity,
                child: Text(
                  AppStrings.versionLabel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 10.0),
                  ),
                )),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
