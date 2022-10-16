import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../View_pages/zoom_image.dart';

class MarketItemPage extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final String price;
  final String time;
  final String url;
  const MarketItemPage(
      {Key? key,
      required this.id,
      required this.title,
      required this.content,
      required this.price,
      required this.time,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "전공서 중고마켓",
          style: GoogleFonts.doHyeon(
            textStyle: mainStyle,
          ),
        ),
        iconTheme: IconThemeData.fallback(),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 10.0,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push((Platform.isAndroid)
                        ? MaterialPageRoute(builder: (context) {
                            return ZoomImage(url: url);
                          })
                        : CupertinoPageRoute(builder: (context) {
                            return ZoomImage(url: url);
                          }));
                  },
                  child: Hero(
                      transitionOnUserGestures: true,
                      tag: url,
                      child: Container(
                          width: MediaQuery.of(context).size.width - 30,
                          height: 400,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(24.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: CachedNetworkImage(
                                  imageUrl: url,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Container(
                                    color: Colors.black,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ))))),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // ignore: sort_child_properties_last, prefer_const_constructors
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 0.3,
                      color: Colors.black,
                    ),
                    Container(
                      // ignore: sort_child_properties_last, prefer_const_constructors
                      child: Text(
                        '$price원',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      child: Text(time),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // ignore: sort_child_properties_last, prefer_const_constructors
                  child: Text(content),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '문의하기',
                    style: TextStyle(fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))))
            ],
          ),
        ),
      )),
    );
  }
}
