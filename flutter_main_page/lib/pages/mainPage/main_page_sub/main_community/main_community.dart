// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';
import 'package:flutter_main_page/pages/View_pages/notice_view.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/Community_house/com_community.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/Community_house/com_event.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/Community_house/com_info_job.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/FAB/expandable_FAB.dart';

class Content {
  String title;
  String content;
  String author;
  String time;

  Content(this.title, this.content, this.author, this.time);
}

class MainPage2 extends StatefulWidget {
  final String user;
  final bool? isAdmin;
  const MainPage2(this.user, this.isAdmin, {Key? key}) : super(key: key);

  @override
  State<MainPage2> createState() => _MainPage2State();
}

class _MainPage2State extends State<MainPage2> {
  final _postingController = TextEditingController();


  

  @override
  void dispose() {
    _postingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            _buildEvent(),
            _buildJob(),
            _buildCom(),
          ],
        ),
      ),
      floatingActionButton: ExpandableFab(widget.user, widget.isAdmin),
    );
  }

  Widget _buildNonEvent() {
    return const SizedBox(
      height: 280,
      child: Center(
          child: Text(
        '아직 등록된 이벤트가 없습니다.',
        style: TextStyle(
            color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget _buildNonJob() {
    return const SizedBox(
      height: 280,
      child: Center(
          child: Text(
        '아직 등록된 취업정보가 없습니다.',
        style: TextStyle(
            color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget _buildNonCom() {
    return const SizedBox(
      height: 280,
      child: Center(
          child: Text(
        '아직 등록된 게시물이 없습니다.',
        style: TextStyle(
            color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget _buildEvent() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: myColor, width: 3)),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: const Text(
                  '학과 이벤트',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EventPage()));
                },
                child: const Text(
                  '더보기 >',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('event')
                  .orderBy('time', descending: true)
                  .limit(5)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(
                    height: 280,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final documents = snapshot.data!.docs;
                if (documents.isEmpty) {
                  return _buildNonEvent();
                } else {
                  return ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children:
                        documents.map((doc) => _buildItemEvent(doc)).toList(),
                  );
                }
              }),
        ],
      ),
    );
  }

  Widget _buildItemEvent(DocumentSnapshot doc) {
    final event =
        Content(doc['title'], doc['content'], doc['author'], doc['time']);
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoticeViewPage(
                    event.title, event.content, event.author, event.time)));
      },
      title: Text(
        event.title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        "작성자 : ${event.author}",
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _buildJob() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: myColor, width: 3)),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Expanded(
                child: Text(
                  '취업 정보',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InfoJobPage()));
                },
                child: const Text(
                  '더보기 >',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('job')
                  .orderBy('time', descending: true)
                  .limit(5)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(
                    height: 280,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final documents = snapshot.data!.docs;
                if (documents.isEmpty) {
                  return _buildNonJob();
                } else {
                  return ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children:
                        documents.map((doc) => _buildItemJob(doc)).toList(),
                  );
                }
              }),
        ],
      ),
    );
  }

  Widget _buildItemJob(DocumentSnapshot doc) {
    final job =
        Content(doc['title'], doc['content'], doc['author'], doc['time']);
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoticeViewPage(
                    job.title, job.content, job.author, job.time)));
      },
      title: Text(
        job.title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        "작성자 : ${job.author}",
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _buildCom() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: myColor, width: 3)),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Expanded(
                child: Text(
                  '익명 게시판',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ComPage()));
                },
                child: const Text(
                  '더보기 >',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('com')
                  .orderBy('time', descending: true)
                  .limit(5)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(
                    height: 280,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final documents = snapshot.data!.docs;
                if (documents.isEmpty) {
                  return _buildNonCom();
                } else {
                  return ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children:
                        documents.map((doc) => _buildItemCom(doc)).toList(),
                  );
                }
              }),
        ],
      ),
    );
  }

  Widget _buildItemCom(DocumentSnapshot doc) {
    final com =
        Content(doc['title'], doc['content'], doc['author'], doc['time']);
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NoticeViewPage(com.title, com.content, "익명", com.time)));
      },
      title: Text(
        com.title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        "익명",
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
