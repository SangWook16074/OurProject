import 'package:flutter/material.dart';

class ComPage extends StatefulWidget {
  const ComPage({Key? key}) : super(key: key);

  @override
  State<ComPage> createState() => _ComPageState();
}

class _ComPageState extends State<ComPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Community",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Pacifico',
            ),
          ),
          centerTitle: true,
        ),
        body: const Center(
            child: Text(
          "익명 게시판",
          style: TextStyle(fontSize: 40),
        )));
  }
}
