import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_main_page/Community_house/com_community.dart';
import 'package:flutter_main_page/Community_house/com_event.dart';
import 'package:flutter_main_page/Community_house/com_info_job.dart';
import 'package:flutter_main_page/Community_house/com_notice.dart';

class MainPage1 extends StatelessWidget {
  const MainPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        _buildIcon(context),
        SizedBox(
          height: 20,
        ),
        _buildTop(),
        _buildBottom(),
      ],
    ));
  }
}

Widget _buildIcon(BuildContext context) {
  return Column(
    children: [
      SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NoticePage()));
            },
            child: Column(
              children: [
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
                  MaterialPageRoute(builder: (context) => EventPage()));
            },
            child: Column(
              children: [
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
                  MaterialPageRoute(builder: (context) => InfoJobPage()));
            },
            child: Column(
              children: [
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ComPage()));
            },
            child: Column(
              children: [
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
    options: CarouselOptions(height: 300.0, autoPlay: true),
    items: [1, 2, 3, 4, 5].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
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

Widget _buildBottom() {
  final items = List.generate(10, (i) {
    return const ListTile(
      leading: Icon(Icons.notifications),
      title: Text("[공지사항] 공지사항 제목"),
    );
  });

  return ListView(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: items,
  );
}
