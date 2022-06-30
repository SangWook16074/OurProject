import 'package:flutter/material.dart';

class MainPage2 extends StatelessWidget {
  const MainPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "커뮤니티 페이지",
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}
