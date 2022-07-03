import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/Community_house/com_community.dart';
import 'package:flutter_main_page/Community_house/com_event.dart';
import 'package:flutter_main_page/Community_house/com_info_job.dart';
import 'package:flutter_main_page/Community_house/com_notice.dart';
import 'package:flutter_main_page/Create_user/create_user.dart';
import 'package:flutter_main_page/login_page.dart';
import 'package:flutter_main_page/main_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
  Fluttertoast.showToast(
      msg: "Hello !",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16);
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  var isAutoLogin = false;
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isAutoLogin = false) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/main': (context) => const MainPage(),
          '/creat': (context) => const CreateUserPage(),
          '/notice': (context) => const NoticePage(),
          // '/event': (context) => const EventPage(),
          // '/infoJob': (context) => const InfoJobPage(),
          // '/community': (context) => const CommunityPage(),
        },
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/main': (context) => const MainPage(),
          '/creat': (context) => const CreateUserPage(),
          '/notice': (context) => const NoticePage(),
          '/event': (context) => const EventPage(),
          '/infoJob': (context) => const InfoJobPage(),
          '/community': (context) => const ComPage(),
        },
      );
    }
    ;
  }
}
