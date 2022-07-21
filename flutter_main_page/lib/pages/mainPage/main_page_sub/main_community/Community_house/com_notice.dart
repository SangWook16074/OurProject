// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/View_pages/notice_view.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/Community_house/com_noticeWrite.dart';

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
        body: Column(
          children: [
            _buildNoticeItemTrue(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              //글쓰기 페이지 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        WriteNotice(widget.user, widget.isAdmin)),
              );
            },
            child: const Icon(Icons.border_color)),
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
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        ),
        body: _buildNoticeItemFalse(),
      );
    }
  }

  Widget _buildNoticeItemTrue() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notice')
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final documents = snapshot.data!.docs;
              if (documents.isEmpty) {
                return _buildNonItem();
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

  Widget _buildNoticeItemFalse() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
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
                  children:
                      documents.map((doc) => _buildItemWidget(doc)).toList(),
                );
              }
            }),
      ),
    );
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final notice = Notice(
      doc['title'],
      doc['content'],
      doc['author'],
      doc['time'],
    );
    return Column(
      children: [
        ListTile(
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NoticeViewPage(notice.title,
                        notice.content, notice.author, notice.time)));
          },
          leading: const Icon(
            Icons.notifications,
            color: Colors.deepPurple,
          ),
          title: Text(
            "[공지사항] ${notice.title}",
            style: const TextStyle(
                fontSize: 20,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "작성자 : ${notice.author}",
            style: const TextStyle(fontSize: 10),
          ),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
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
