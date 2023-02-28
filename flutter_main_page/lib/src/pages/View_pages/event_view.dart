import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/src/pages/View_pages/zoom_image.dart';
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
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Text(
                  widget.eventModel.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "[${widget.eventModel.author}]",
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 15),
                ),
                Text(
                  widget.eventModel.time,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
                Divider(
                  color: Colors.grey,
                ),
                (widget.eventModel.url != '')
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).push((Platform.isAndroid)
                              ? MaterialPageRoute(builder: (context) {
                                  return ZoomImage(url: widget.eventModel.url);
                                })
                              : CupertinoPageRoute(builder: (context) {
                                  return ZoomImage(url: widget.eventModel.url);
                                }));
                        },
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: widget.eventModel.url,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.eventModel.url,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) => Container(
                                        color: Colors.black,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ))),
                        ),
                      )
                    : Container(),
                Divider(),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  widget.eventModel.content,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 50,
                  child: this.banner != null
                      ? AdWidget(ad: this.banner!)
                      : Container(),
                ),
                Divider(
                  color: Colors.grey,
                ),
                (Platform.isAndroid)
                    ? SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            //취소 버튼

                            onPressed: () {
                              Navigator.of(context).pop();
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
                                  style: TextStyle(
                                      fontSize: 15, letterSpacing: 4.0),
                                ),
                              ],
                            )),
                      )
                    : SizedBox(
                        width: 200,
                        child: CupertinoButton(
                            //취소 버튼

                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.blueGrey,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.navigate_before),
                                Text(
                                  "이전",
                                  style: TextStyle(
                                      fontSize: 15, letterSpacing: 4.0),
                                ),
                              ],
                            )),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
