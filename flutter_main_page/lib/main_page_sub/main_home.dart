import 'package:flutter/material.dart';

class MainPage1 extends StatelessWidget {
  const MainPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "홈 페이지",
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}
