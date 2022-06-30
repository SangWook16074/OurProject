import 'package:flutter/material.dart';

import 'package:flutter_main_page/login_page.dart';
import 'package:flutter_main_page/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}
