import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageViewPage extends StatelessWidget {
  String url;
  ImageViewPage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(
          url,
        ),
      ),
    );
  }
}
