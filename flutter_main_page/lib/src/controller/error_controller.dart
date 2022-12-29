import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

mixin ErrorMessage {
  toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16);
  }
}

class ErrorController extends GetxController {
  emptyTextError(Map controllers) {
    for (TextEditingController controller in controllers.keys) {
      if (controller.text.isEmpty) {
        toastMessage('${controllers[controller]} 확인요망');
        return;
      }
    }
  }
}