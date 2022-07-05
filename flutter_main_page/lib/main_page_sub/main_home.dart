// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_main_page/Community_house/com_community.dart';
import 'package:flutter_main_page/Community_house/com_event.dart';
import 'package:flutter_main_page/Community_house/com_info_job.dart';
import 'package:flutter_main_page/Community_house/com_notice.dart';

final items = <Notice>[];

class Notice {
  String title;
  String content;
  String author;
  String authorNumber;
  String time;

  Notice(this.title, this.content, this.author, this.authorNumber, this.time);
}

class MainPage1 extends StatelessWidget {
  const MainPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _buildIcon(context),
        const SizedBox(
          height: 20,
        ),
        _buildTop(),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notice')
                .orderBy('time', descending: true)
                .limit(3)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              final documents = snapshot.data!.docs;
              return Expanded(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: documents.map((doc) => _buildBottom(doc)).toList(),
                ),
              );
            }),
      ],
    ));
  }
}

Widget _buildIcon(BuildContext context) {
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NoticePage()));
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
    options: CarouselOptions(height: 250.0, autoPlay: true),
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

Widget _buildBottom(DocumentSnapshot doc) {
  final notice = Notice(doc['title'], doc['content'], doc['author'],
      doc['authorNumber'], doc['time']);
  return ListTile(
    onTap: () {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => const NoticeViewPage()));
    },
    leading: const Icon(Icons.notification_important),
    title: Text(
      notice.title,
      style: const TextStyle(fontSize: 16),
    ),
    subtitle: Text(
      "작성자 : ${notice.author}",
      style: const TextStyle(fontSize: 12),
    ),
  );
}
