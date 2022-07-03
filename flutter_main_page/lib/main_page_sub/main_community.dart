import 'dart:ffi';

import 'package:flutter/material.dart';

class Posting {
  String title;
  String content;

  Posting(this.title, this.content);
}

class MainPage2 extends StatefulWidget {
  const MainPage2({Key? key}) : super(key: key);

  @override
  State<MainPage2> createState() => _MainPage2State();
}

class _MainPage2State extends State<MainPage2> {
  final _items = [];

  var _postingController = TextEditingController();

  @override
  void dispose() {
    _postingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _buildIcon(),
            _buildNot(),
            _buildEvent(),
            _buildInfo(),
            _buildCom(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Icon(
                    Icons.notifications,
                    size: 40,
                  ),
                  Text('공지사항'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Icon(
                    Icons.favorite,
                    size: 40,
                  ),
                  Text('학과이벤트'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Icon(
                    Icons.thumb_up,
                    size: 40,
                  ),
                  Text('취업정보'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Icon(
                    Icons.reorder,
                    size: 40,
                  ),
                  Text('익명게시글'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNot() {
    return Text("notice");
  }

  Widget _buildEvent() {
    return Text("Event");
  }

  Widget _buildInfo() {
    return Text("Info of JOB");
  }

  Widget _buildCom() {
    return Text("Community");
  }
}
