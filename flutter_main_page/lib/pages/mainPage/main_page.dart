import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_alarm/main_alarm.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/Community_house/com_community.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/main_community.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_home/main_home.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_user_info/main_user_info.dart';

class MainPage extends StatefulWidget {
  final String userNumber;
  final String user;
  final String userGrade;
  final String userClass;
  final bool? isAdmin;
  const MainPage(
      this.userNumber, this.user, this.userGrade, this.userClass, this.isAdmin,
      {Key? key})
      : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _index = 0; //0, 1, 2
  var infos = [];

  @override
  Widget build(BuildContext context) {
    final pages = [
      MainPage1(widget.user, widget.isAdmin),
      MainPage2(widget.user, widget.isAdmin, widget.userNumber),
      const MainPage3(),
      MainPage4(widget.userNumber, widget.user, widget.userGrade,
          widget.userClass, widget.isAdmin),
      ComPage(widget.userNumber),    
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Information and Communication",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pacifico',
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            label: '홈',
            icon: Icon(Icons.home),
          ),
          const BottomNavigationBarItem(
              label: '커뮤니티', icon: Icon(Icons.assignment)),
          const BottomNavigationBarItem(
            label: '알림',
            icon: Icon(Icons.alarm),
          ),
          const BottomNavigationBarItem(
              label: '내정보', icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }
}
