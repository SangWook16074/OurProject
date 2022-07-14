// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously, avoid_unnecessary_containers

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/Community_house/com_noticeWrite.dart';
import 'package:flutter_main_page/pages/View_pages/notice_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Notice {
  String title;
  String content;
  String author;
  String time;

  Notice(this.title, this.content, this.author, this.time);
}

class NoticePage extends StatefulWidget {
  final String user;
  final bool? isAdmin;
  const NoticePage(this.user, this.isAdmin, {Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  var search = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAdmin == true) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "NOTICE",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Pacifico',
            ),
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: ListView(
              children: [
                TextField(
                  controller: search,
                  onChanged: (text) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      hintText: "제목 검색",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      suffixIcon: GestureDetector(
                          child: const Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                          onTap: () {
                            //제목 포함 내용 찾기 기능
                          }),
                      filled: true,
                      fillColor: Colors.white),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('notice')
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Container(
                                height: 250,
                                width: 250,
                                child: const CircularProgressIndicator()));
                      }
                      final documents = snapshot.data!.docs;
                      if (documents.isEmpty) {
                        return _buildNonItem();
                      } else {
                        return ListView(
                          shrinkWrap: true,
                          children: documents
                              .map((doc) => _buildItemWidget(doc))
                              .toList(),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //글쓰기 페이지 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WriteNotice(widget.user)),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "NOTICE",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Pacifico',
            ),
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: ListView(
              children: [
                TextField(
                  controller: search,
                  onChanged: (text) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      hintText: "제목 검색",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      suffixIcon: GestureDetector(
                          child: const Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                          onTap: () {
                            //제목 포함 내용 찾기 기능
                          }),
                      filled: true,
                      fillColor: Colors.white),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('notice')
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Container(
                                height: 250,
                                width: 250,
                                child: const CircularProgressIndicator()));
                      }
                      final documents = snapshot.data!.docs;
                      if (documents.isEmpty) {
                        return _buildNonItem();
                      } else {
                        return ListView(
                          shrinkWrap: true,
                          children: documents
                              .map((doc) => _buildItemWidget(doc))
                              .toList(),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final notice =
        Notice(doc['title'], doc['content'], doc['author'], doc['time']);
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoticeViewPage(
                    notice.title, notice.content, notice.author, notice.time)));
      },
      leading: const Icon(
        Icons.notifications,
        color: Colors.deepPurple,
      ),
      title: Text(
        notice.title,
        style: const TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "작성자 : ${notice.author}",
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  Widget _buildNonItem() {
    return Center(
      child: Container(
        height: 500,
        child: const Center(
          child: Text(
            '아직 등록된 공지가 없습니다.',
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
