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
      body: Text("커뮤니티 페이지"),
    );
  }
}
