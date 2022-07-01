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
    const MainPage1(),
    const MainPage2(),
    const MainPage3(),
    const MainPage4(),
  ];

  @override
  Widget build(BuildContext context) {
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
