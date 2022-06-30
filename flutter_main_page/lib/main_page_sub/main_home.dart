import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainPage1 extends StatelessWidget {
  const MainPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildTop(),
        _buildBottom(),
      ],
    );
  }
}

Widget _buildTop() {
  return CarouselSlider(
    options: CarouselOptions(height: 200.0, autoPlay: true),
    items: [1, 2, 3, 4, 5].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(color: Colors.amber),
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
      leading: Icon(Icons.notification_important),
      title: Text("[공지사항] 공지사항 제목"),
    );
  });

  return ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: items,
  );
}
