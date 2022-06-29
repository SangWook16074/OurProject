import 'package:flutter/material.dart';
import 'package:flutter_main_page/login_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Text(
            "메인화면",
            style: TextStyle(fontSize: 40),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: Text("로그인 화면으로"),
            style: TextButton.styleFrom(backgroundColor: Colors.red[400]),
          )
        ],
      ),
    ));
  }
}
