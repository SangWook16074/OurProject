import 'package:flutter/material.dart';
import 'package:flutter_main_page/main_page_sub/main_home.dart';
import 'package:flutter_main_page/main_page_sub/main_user_info.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _index = 0; //0, 1, 2
  var _pages = [
    MainPage1(),
    MainPage2(),
    //MainPage3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            label: '홈',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "내정보",
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
