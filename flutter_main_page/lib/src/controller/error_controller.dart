import 'package:fluttertoast/fluttertoast.dart';

mixin ErrorMessage {
  toastErrorMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16);
  }
}
