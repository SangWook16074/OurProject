import 'package:flutter_main_page/src/controller/auth_controller.dart';
import 'package:get/get.dart';

import '../controller/event_controller.dart';
import '../controller/notice_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(EventController(), permanent: true);
  }
}
