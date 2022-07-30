import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/message_controller/notice_controller.dart';
import 'package:flutter_main_page/pages/loginPage/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

late SharedPreferences prefs; //안드로이드만 가능함.
Color myColor = Color(0xFF87C2F3);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  prefs = await SharedPreferences.getInstance();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  if (message.notification != null) {
    var db = FirebaseFirestore.instance.collection("UserInfo");

    db
        .doc(prefs.getString('userNumber').toString())
        .collection('alarmlog')
        .add({
      "alarm": message.notification!.body,
      "index": prefs.getInt('index'),
      "status": false,
    });

    _addIndex();
  }
}

Future<void> _addIndex() async {
  var number = await prefs.getInt("index")! + 1;
  await prefs.setInt('index', number);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance(); // 안드로이드만 가능함.

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: const Text(
            "Induk Univ.",
            style: TextStyle(
                fontSize: 40,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: Colors.blue,
          nextScreen: LoginPage()),
    );
  }
}
