import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';

class MainPage4 extends StatefulWidget {
  const MainPage4({Key? key}) : super(key: key);

  @override
  State<MainPage4> createState() => _MainPage4State();
}

class _MainPage4State extends State<MainPage4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: (() {
                MyApp().isAutoLogin = false;
                Navigator.pushNamed(context, '/login');
              }),
              child: const Text("로그아웃"))
        ],
      ),
    );
  }
}
