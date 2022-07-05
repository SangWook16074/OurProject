import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "EVENT",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Pacifico',
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: Text(
          "이벤트 게시판",
          style: TextStyle(fontSize: 40),
        )));
  }
}
