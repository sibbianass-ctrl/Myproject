import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/notifications_controller.dart';
import 'package:my_project/models/notification_model.dart';
import 'package:my_project/utils/resources/notifications/notifications_strings.dart';
import 'package:my_project/views/notifications/widgets/notification_card.dart';
import 'package:my_project/widgets/copyright_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_page_title.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({super.key});
  final NotificationsController _notificationsController =
      Get.put(NotificationsController());
      
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: size.width * .08),
        child: Column(
          children: [
            //Title
            CustomPageTitle(
              size: size,
              title: NotificationsStrings.pageTitle,
            ),
            const SizedBox(
              height: 32,
            ),
            //Content
            Expanded(
              child: ListView(
                children: [
                  if (_notificationsController.notifications.isEmpty)
                    const SizedBox(
                        width: double.infinity,
                        child: Text(
                          NotificationsStrings.emptyNotificationLabel,
                          textAlign: TextAlign.center,
                        ))
                  else
                    for (NotificationModel notification
                        in _notificationsController.notifications)
                      NotificationCard(
                        title: notification.title,
                        dateTime: notification.dateTime,
                        body: notification.body,
                      )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: const CopyrightText(),
            )
          ],
        ),
      ),
    );
  }
}
