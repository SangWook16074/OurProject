import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/loginPage/login_page.dart';
import 'package:flutter_main_page/main.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/user_info_template.dart';

class MainPage4 extends StatefulWidget {
  final String userNumber;
  final String user;
  final String userGrade;
  final String userClass;
  final bool? isAdmin;
  const MainPage4(
      this.userNumber, this.user, this.userGrade, this.userClass, this.isAdmin,
      {Key? key})
      : super(key: key);

  @override
  State<MainPage4> createState() => _MainPage4State();
}

class _MainPage4State extends State<MainPage4> {
  var _index = 0;
  var subjects = [];
  var points = [];
  var grades = [];

  Future<void> _deleteAutoLoginStatus() async {
    prefs.setBool('autoLoginStatus', false);
    prefs.remove('userNumber');
    prefs.remove('user');
    prefs.remove('userGrade');
    prefs.remove('Class');
    prefs.remove('isAdmin');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildUserInfo(),
        ElevatedButton(
            onPressed: (() async {
              isChecked = false;
              _deleteAutoLoginStatus();

              await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
            }),
            child: const Text("로그아웃")),
        //_buildCalculator(),
      ],
    );
  }

  Widget _buildUserInfo() {

    return ListView(
      shrinkWrap: true,
      children: [
        Center(child: Text('내 정보',style: TextStyle(color: Colors.blue,fontSize: 20))),
        userInfoBox.set_user_info(user, userGrade, userClass, userNumber)
      ]  
      );

  }

  // Widget _buildCalculator() {
  //   const int cnt = 1;
  //   final controller =
  //       EditController(subjects[_index], points[_index], grades[_index]);
  //   return Container(
  //     padding: const EdgeInsets.all(8.0),
  //     margin: const EdgeInsets.all(8.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(25),
  //       border: Border.all(color: Colors.black, width: 3),
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Expanded(
  //               child: Text(
  //                 '학점 계산기',
  //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
  //           ],
  //         ),
  //         ListTile(
  //           title: Row(
  //             children: [
  //               (
  //                 TextField(
  //                 style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 controller: controller.subject,
  //                 onChanged: (text) {
  //                   setState(() {});
  //                 },
  //                 decoration: const InputDecoration(
  //                     hintText: "과목",
  //                     hintStyle:
  //                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                     contentPadding:
  //                         EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  //                     filled: true,
  //                     fillColor: Colors.white),
  //               ),

  //               ),

  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
                  
