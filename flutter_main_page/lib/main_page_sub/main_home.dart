import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainPage1 extends StatelessWidget {
  const MainPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "홈 페이지",
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}

Widget _buildTop() {
  return CarouselSlider(
    options: CarouselOptions(height: 400.0),
    items: [1, 2, 3, 4, 5].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: Colors.amber),
              child: Text(
                'text $i',
                style: TextStyle(fontSize: 16.0),
              ));
        },
      );
    }).toList(),
  );
}

Widget _buildBottom() {
  return Text("Top");
}
