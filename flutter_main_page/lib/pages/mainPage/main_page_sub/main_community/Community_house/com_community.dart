import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/View_pages/notice_view.dart';
import 'package:flutter_main_page/pages/mainPage/main_page.dart';

class Com {
  String title;
  String content;
  String author;
  String time;
  int isLike;
  int countLike;

  Com(this.title, this.author, this.content, this.time, this.isLike,
      this.countLike);
}

class ComPage extends StatefulWidget {
  const ComPage({Key? key}) : super(key: key);

  @override
  State<ComPage> createState() => _ComPageState();
}

class _ComPageState extends State<ComPage> {


  // void _updateContent(String docID, int num) {
  //   FirebaseFirestore.instance
  //       .collection('com')
  //       .doc(docID)
  //       .update({"isLike" : num});
  // }


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
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('com')
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return _loading();
              }
              final documents = snapshot.data!.docs;
              if (documents.isEmpty) {
                return _buildNonEvent();
              } else {
                return ListView(
                  shrinkWrap: true,
                  children:
                      documents.map((doc) => _buildItemWidget(doc)).toList(),
                );
              }
            }),
      ),
    );
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final document = doc.data() as Map<String, dynamic>;
    final com = new Com(
      document['title'],
      document['author'],
      document['content'],
      document['time'],
      document['isLike'],
      document['countLike'] ?? 0,
    );
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NoticeViewPage(com.title, com.content, '익명', com.time)));
      },
      title: Text(
        com.title,
        style: const TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "익명",
        style: const TextStyle(fontSize: 10),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(com.countLike.toString()),
          IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                if (com.isLike == 1) {
                  com.isLike = 0;
                  setState(() {
                    --com.countLike;
                  });
                } else if (com.isLike == 0) {
                  com.isLike = 1;
                  setState(() {
                    ++com.countLike;
                  });
                }
                _updatecountLike(doc.id, com.countLike);
                _updateisLike(doc.id, com.isLike);
              }),
        ],
      ),
    );
  }

  Widget _buildNonEvent() {
    return Center(
      child: Container(
        height: 500,
        child: const Center(
          child: Text(
            '아직 등록된 이벤트가 없습니다.',
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _loading() {
    return Center(child: CircularProgressIndicator());
  }

  void _updateisLike(String docID, int flag) {
    FirebaseFirestore.instance
        .collection('com')
        .doc(docID)
        .update({'isLike': flag});
  }

  void _updatecountLike(String docID, int count) {
    FirebaseFirestore.instance
        .collection('com')
        .doc(docID)
        .set({'countLike': count}, SetOptions(merge: true));
  }
}
