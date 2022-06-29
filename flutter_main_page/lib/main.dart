import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.red[300],
                height: 300,
              ),
              Column(
                children: [
                  Container(
                    color: Colors.black,
                    width: 125,
                    height: 125,
                    margin: const EdgeInsets.all(30.0),
                  ),
                  Text(
                    "인덕대학교",
                    style: TextStyle(
                        fontSize: 40,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "정보통신공학과",
                    style: TextStyle(
                        fontSize: 40,
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "학번을 입력하세요."),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "비밀번호를 입력하세요."),
                  ),
                  ElevatedButton(
                    //로그인 버튼
                    onPressed: () {
                      //로그인 메소드
                    },
                    child: Text(
                      "로그인",
                      style: TextStyle(fontSize: 15, letterSpacing: 4.0),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        padding: EdgeInsets.all(16.0),
                        minimumSize: Size(400, 25)),
                  ),
                  TextButton(
                    //회원가입 버튼
                    onPressed: () {
                      //회원가입 메소드
                    },
                    child: Text(
                      "회원가입",
                      style: TextStyle(fontSize: 15, color: Colors.red[400]),
                    ),
                    style: TextButton.styleFrom(),
                  )
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
