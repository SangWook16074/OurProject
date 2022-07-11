// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_main_page/pages/Community_house/com_community.dart';
import 'package:flutter_main_page/pages/Community_house/com_event.dart';
import 'package:flutter_main_page/pages/Community_house/com_info_job.dart';
import 'package:flutter_main_page/pages/Community_house/com_notice.dart';
import 'package:flutter_main_page/pages/View_pages/notice_view.dart';

final items = <Notice>[];

class Notice {
  String title;
  String content;
  String author;
  String time;

  Notice(this.title, this.content, this.author, this.time);
}

class MainPage1 extends StatefulWidget {
  final String user;
  final bool? isAdmin;
  const MainPage1(this.user, this.isAdmin, {Key? key}) : super(key: key);

  @override
  State<MainPage1> createState() => _MainPage1State();
}

class _MainPage1State extends State<MainPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        _buildIcon(context, widget.user, widget.isAdmin),
        const SizedBox(
          height: 20,
        ),
        _buildTop(),
        const Center(
          child: Text(
            '공지사항',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notice')
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
                return _buildNonItem();
              } else {
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: documents
                      .map((doc) => _buildBottom(doc, context))
                      .toList(),
                );
              }
            }),
      ],
    ));
  }
}

Widget _buildIcon(BuildContext context, String user, bool? isAdmin) {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NoticePage(user, isAdmin)));
            },
            child: Column(
              children: const [
                Icon(
                  Icons.notifications,
                  size: 40,
                ),
                Text('공지사항'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EventPage()));
            },
            child: Column(
              children: const [
                Icon(
                  Icons.card_giftcard,
                  size: 40,
                ),
                Text('학과이벤트'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const InfoJobPage()));
            },
            child: Column(
              children: const [
                Icon(
                  Icons.lightbulb,
                  size: 40,
                ),
                Text('취업정보'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ComPage()));
            },
            child: Column(
              children: const [
                Icon(
                  Icons.reorder,
                  size: 40,
                ),
                Text('익명게시글'),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildTop() {
  return CarouselSlider(
    options: CarouselOptions(height: 220.0, autoPlay: true),
    items: [1, 2, 3, 4, 5].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Center(
                  child: Text(
                'text $i',
                style: const TextStyle(fontSize: 16.0),
              )));
        },
      );
    }).toList(),
  );
}

Widget _buildBottom(DocumentSnapshot doc, BuildContext context) {
  final notice =
      Notice(doc['title'], doc['content'], doc['author'], doc['time']);
  return ListTile(
    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
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
          color: Colors.deepPurple, fontSize: 17, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      "작성자 : ${notice.author}",
      style: const TextStyle(fontSize: 12),
    ),
  );
}

Widget _buildNonItem() {
  return Container(
    height: 280,
    child: const Center(
        child: Text(
      '아직 등록된 공지가 없습니다.',
      style: TextStyle(
          color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
    )),
  );
}
