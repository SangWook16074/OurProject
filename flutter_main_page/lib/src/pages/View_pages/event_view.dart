import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/src/components/event_image.dart';
import 'package:flutter_main_page/src/pages/View_pages/zoom_image.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../main.dart';
import '../../data/model/event_model.dart';

class EventViewPage extends StatefulWidget {
  final EventModel eventModel;
  const EventViewPage({
    Key? key,
    required this.eventModel,
  }) : super(key: key);

  @override
  State<EventViewPage> createState() => _EventViewPageState();
}

class _EventViewPageState extends State<EventViewPage> {
  BannerAd? banner;

  @override
  void initState() {
    super.initState();
    banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: UNIT_ID[Platform.isIOS ? 'ios' : 'android']!,
        listener: BannerAdListener(),
        request: AdRequest())
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              Divider(
                color: Colors.grey,
              ),
              _image(),
              Divider(),
              const SizedBox(
                height: 40,
              ),
              _body(),
              SizedBox(
                height: 40,
              ),
              _adBox(),
              Divider(
                color: Colors.grey,
              ),
              _btn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.eventModel.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "[${widget.eventModel.author}]",
              style: const TextStyle(color: Colors.blueGrey, fontSize: 15),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              widget.eventModel.time,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _image() {
    return (widget.eventModel.url != '')
        ? GestureDetector(
            onTap: () => Get.to(() => ZoomImage(url: widget.eventModel.url)),
            child: Hero(
                transitionOnUserGestures: true,
                tag: widget.eventModel.url,
                child: EventImage(url: widget.eventModel.url)),
          )
        : Container();
  }

  Widget _body() {
    return Text(
      widget.eventModel.content,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }

  Widget _adBox() {
    return Container(
      height: 50,
      child: this.banner != null ? AdWidget(ad: this.banner!) : Container(),
    );
  }

  Widget _btn() {
    return (Platform.isAndroid)
        ? SizedBox(
            width: 200,
            child: ElevatedButton(
                //취소 버튼

                onPressed: () {
                  Get.back();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: const EdgeInsets.all(16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.navigate_before),
                    Text(
                      "이전",
                      style: TextStyle(fontSize: 15, letterSpacing: 4.0),
                    ),
                  ],
                )),
          )
        : SizedBox(
            width: 200,
            child: CupertinoButton(
                //취소 버튼

                onPressed: () {
                  Get.back();
                },
                color: Colors.blueGrey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.navigate_before),
                    Text(
                      "이전",
                      style: TextStyle(fontSize: 15, letterSpacing: 4.0),
                    ),
                  ],
                )),
          );
  }
}
