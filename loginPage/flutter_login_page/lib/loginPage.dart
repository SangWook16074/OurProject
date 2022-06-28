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
                    "정보통신공학과 학생회",
                    style: TextStyle(
                        fontSize: 40,
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
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
