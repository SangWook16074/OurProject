// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/Community_house/com_community.dart';
import 'package:flutter_main_page/Community_house/com_event.dart';
import 'package:flutter_main_page/Community_house/com_info_job.dart';

class Event {
  String title;
  String content;
  String author;
  String time;

  Event(this.title, this.content, this.author, this.time);
}

class Job {
  String title;
  String content;
  String author;
  String time;

  Job(this.title, this.content, this.author, this.time);
}

class Com {
  String title;
  String content;
  String author;
  String time;

  Com(this.title, this.content, this.author, this.time);
}

class MainPage2 extends StatefulWidget {
  const MainPage2({Key? key}) : super(key: key);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //글쓰기 페이지 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WritePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
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
          border: Border.all(color: Colors.black, width: 3)),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                width: 280,
                child: Text(
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
                  return const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
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
        Event(doc['title'], doc['content'], doc['author'], doc['time']);
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const NoticeViewPage()));
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
          border: Border.all(color: Colors.black, width: 3)),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                width: 280,
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
                  return const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
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
    final job = Com(doc['title'], doc['content'], doc['author'], doc['time']);
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const NoticeViewPage()));
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
          border: Border.all(color: Colors.black, width: 3)),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                width: 280,
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
                  return const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
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
    final com = Com(doc['title'], doc['content'], doc['author'], doc['time']);
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const NoticeViewPage()));
      },
      title: Text(
        com.title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        "작성자 : ${com.author}",
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}

class WritePage extends StatefulWidget {
  const WritePage({Key? key}) : super(key: key);

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Write Content",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(child: Text("글쓰기 페이지")),
    );
  }
}
