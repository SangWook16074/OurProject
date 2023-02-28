import 'package:fluttertoast/fluttertoast.dart';

class ErrorMessage {
  static toastErrorMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16);
  }
}
