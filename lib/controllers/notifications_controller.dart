import 'package:get/get.dart';
import 'package:my_project/models/notification_model.dart';

class NotificationsController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[
    NotificationModel(
        title: 'Notification 1',
        dateTime: '12/11/2024 12:34',
        body:
            'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development to fill empty spaces in a layout that do not yet have content.'),
    NotificationModel(
        title: 'Notification 2',
        dateTime: '12/11/2024 12:34',
        body:
            'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development to fill empty spaces in a layout that do not yet have content.')
  ].obs;
}
