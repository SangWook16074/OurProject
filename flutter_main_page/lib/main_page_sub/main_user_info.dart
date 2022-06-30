import 'package:flutter/material.dart';

class MainPage4 extends StatelessWidget {
  const MainPage4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "회원정보 페이지",
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}
