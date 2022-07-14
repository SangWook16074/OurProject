import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/Community_house/com_event.dart';

import '../View_pages/notice_view.dart';

class Event {
  String title;
  String content;
  String author;
  String time;

  Event(this.title, this.author, this.content, this.time);
}

class EventManagePage extends StatefulWidget {
  const EventManagePage({Key? key}) : super(key: key);

  @override
  State<EventManagePage> createState() => _EventManagePageState();
}

class _EventManagePageState extends State<EventManagePage> {
  void _deleteItemDialog(DocumentSnapshot doc) {
    showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [Text('정말로 삭제하시겠습니까?')], 
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _deleteItem(doc);
                    Navigator.of(context).pop();
                  },
                  child: const Text("확인")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("취소")),
            ],
          );
        });
  }

  void _deleteItem(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('event').doc(doc.id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
        backgroundColor: Colors.blue,
        title: const Text(
          "My Content",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('event')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Container(child: const CircularProgressIndicator()));
            }
            final documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return _buildNonEvent();
            } else {
              return ListView(
                shrinkWrap: true,
                children:
                    documents.map((doc) => _buildEventWidget(doc)).toList(),
              );
            }
          }),
    );
  }

  Widget _buildEventWidget(DocumentSnapshot doc) {
    final event =
        Event(doc['title'], doc['author'], doc['content'], doc['time']);
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => NoticeViewPage(
                    event.title, event.content, event.author, event.time))));
      },
      title: Text(
        event.title,
        style: const TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "익명",
        style: const TextStyle(fontSize: 10),
      ),
      trailing: IconButton(
        onPressed: () {
          _deleteItemDialog(doc);
        },
        icon: Icon(Icons.delete),
      ),
    );
  }

  Widget _buildNonEvent() {
    return Center(
      child: Container(
        child: const Center(
          child: Text(
            '등록한 글이 없습니다.',
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}