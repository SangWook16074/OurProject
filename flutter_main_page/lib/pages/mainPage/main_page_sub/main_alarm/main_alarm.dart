import 'package:flutter/material.dart';

class MainPage3 extends StatelessWidget {
  const MainPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Container(
            width: 380,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: const Text(
              "알림 메시지",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            "알람 페이지",
            style: TextStyle(fontSize: 40),
          ),
        ],
      )),
    );
  }
}
