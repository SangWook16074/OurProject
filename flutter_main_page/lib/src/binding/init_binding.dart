import 'package:flutter_main_page/src/controller/error_controller.dart';
import 'package:flutter_main_page/src/controller/login_controller.dart';
import 'package:get/get.dart';

import '../controller/notice_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController(), permanent: true);
    Get.put(ErrorController(), permanent: true);
    Get.put(LoginController(), permanent: true);
  }
  
}