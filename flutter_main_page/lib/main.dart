import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/message_controller/notice_controller.dart';
import 'package:flutter_main_page/pages/loginPage/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs; //안드로이드만 가능함.
Color myColor = Color(0xFF87C2F3);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance(); // 안드로이드만 가능함.

  runApp(MyApp());
  Fluttertoast.showToast(
      msg: "Hello !",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16);
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding:
          BindingsBuilder.put(() => NotificationController(), permanent: true),
      home: LoginPage(),
    );
  }
}
