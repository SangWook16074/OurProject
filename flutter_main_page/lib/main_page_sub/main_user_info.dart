import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/login_page.dart';
import 'package:flutter_main_page/main.dart';

class MainPage4 extends StatefulWidget {
  final String userNumber;
  final String user;
  final String userGrade;
  final String userClass;
  final bool isAdmin;
  const MainPage4(
      this.userNumber, this.user, this.userGrade, this.userClass, this.isAdmin,
      {Key? key})
      : super(key: key);

  @override
  State<MainPage4> createState() => _MainPage4State();
}

class _MainPage4State extends State<MainPage4> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildUserInfo(),
        ElevatedButton(
            onPressed: (() {
              MyApp().isAutoLogin = false;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
            }),
            child: const Text("로그아웃"))
      ],
    );
  }

  Widget _buildUserInfo() {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          width: 380,
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.black, width: 3),
          ),
          child: Column(
            children: [
              Center(
                child: Text(
                  "사용자정보",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Icon(
                Icons.account_circle_rounded,
                size: 60,
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    '이름 : ${widget.user}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    '학번 : ${widget.userNumber}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    '학년 : ${widget.userGrade}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    '반 : ${widget.userClass}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
