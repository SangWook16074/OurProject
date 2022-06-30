import 'package:flutter/material.dart';
import 'package:flutter_main_page/main_page_sub/main_alarm.dart';
import 'package:flutter_main_page/main_page_sub/main_home.dart';
import 'package:flutter_main_page/main_page_sub/main_user_info.dart';
import 'package:flutter_main_page/main_page_sub/main_community.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _index = 0; //0, 1, 2
  final _pages = [
    MainPage1(),
    MainPage2(),
    MainPage3(),
    MainPage4(),
    // MainPage3(),
    // MainPage4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "제목",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red[400],
        items: [
          BottomNavigationBarItem(
            label: '홈',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(label: '커뮤니티', icon: Icon(Icons.assignment)),
          BottomNavigationBarItem(
            label: '알람',
            icon: Icon(Icons.alarm),
          ),
          BottomNavigationBarItem(
              label: '내정보', icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }
}
