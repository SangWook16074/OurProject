import 'package:flutter/material.dart';

class InfoJobPage extends StatefulWidget {
  const InfoJobPage({Key? key}) : super(key: key);

  @override
  State<InfoJobPage> createState() => _InfoJobPageState();
}

class _InfoJobPageState extends State<InfoJobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "information of JOB",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Pacifico',
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: Text(
          "취업정보 게시판",
          style: TextStyle(fontSize: 40),
        )));
  }
}
