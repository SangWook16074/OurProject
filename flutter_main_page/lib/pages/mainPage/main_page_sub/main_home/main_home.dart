// ignore_for_file: unnecessary_const

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_main_page/custom_page_route.dart';
import 'package:flutter_main_page/navigation_draw.dart';
import 'package:flutter_main_page/pages/AdminPage/notice_manage.dart';
import 'package:flutter_main_page/pages/View_pages/notice_view.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_alarm/main_alarm.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/Community_house/com_notice.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../AdminPage/admin_list.dart';
import '../../../AdminPage/cmty_manage.dart';
import '../../../AdminPage/event_manage.dart';
import '../../../AdminPage/job_manage.dart';

final items = <Notice>[];

class Notice {
  String title;
  String content;
  String author;
  String time;

  Notice(this.title, this.content, this.author, this.time);
}

class MainHome extends StatefulWidget {
  final String userNumber;
  final String user;
  final bool isAdmin;
  const MainHome(
      {Key? key,
      required this.user,
      required this.isAdmin,
      required this.userNumber})
      : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: widget.isAdmin == true
            ? SpeedDial(
                gradientBoxShape: BoxShape.circle,
                spaceBetweenChildren: 10,
                spacing: 10,
                icon: Icons.manage_accounts,
                overlayOpacity: 0.6,
                overlayColor: Colors.black,
                children: [
                  SpeedDialChild(
                      child: Icon(Icons.edit_notifications),
                      label: '공지관리',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoticeManagePage()));
                      }),
                  SpeedDialChild(
                      child: Icon(Icons.event_available),
                      label: '이벤트관리',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventManagePage()));
                      }),
                  SpeedDialChild(
                      child: Icon(Icons.lightbulb),
                      label: '취업정보관리',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JobManagePage()));
                      }),
                  SpeedDialChild(
                      child: Icon(Icons.message),
                      label: '커뮤니티 관리',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ComManagePage()));
                      }),
                  SpeedDialChild(
                      child: Icon(Icons.admin_panel_settings),
                      label: '관리자',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPage()));
                      }),
                  SpeedDialChild(
                      child: Icon(Icons.photo_library),
                      label: '배너사진관리',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoticeManagePage()));
                      }),
                ],
              )
            : null,
        drawer: NavigationDrawerWidget(
            userNumber: widget.userNumber,
            user: widget.user,
            isAdmin: widget.isAdmin),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, CustomPageRoute(child: MainAlarm()));
                },
                icon: Icon(
                  Icons.notifications_active,
                ))
          ],
          iconTheme: IconThemeData.fallback(),
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              _buildImage(),
              SizedBox(
                height: 30,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey, width: 2)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Expanded(
                              child: Text(
                                '공지사항',
                                style:
                                    TextStyle(fontSize: 25, fontFamily: 'hoon'),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(CustomPageRoute(
                                      child: NoticePage(widget.user)));
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _buildBottom(),
                    ],
                  )),
            ],
          ),
        ));
  }

  Widget _buildBottom() {
    return StreamBuilder<QuerySnapshot>(
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
                  .map((doc) => _buildItemNotice(doc, context))
                  .toList(),
            );
          }
        });
  }

  Widget _buildImage() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('eventImage').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;

          return CarouselSlider(
            options: CarouselOptions(
              height: 220.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: documents.map((doc) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: doc['url'],
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Container(
                            color: Colors.black,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ));
                },
              );
            }).toList(),
          );
        });
  }

  Widget _buildItemNotice(DocumentSnapshot doc, BuildContext context) {
    final notice =
        Notice(doc['title'], doc['content'], doc['author'], doc['time']);
    return Column(
      children: [
        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NoticeViewPage(notice.title,
                        notice.content, notice.author, notice.time)));
          },
          title: Text(
            notice.title,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
          subtitle: Text(
            "작성자 : ${notice.author}",
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Divider(),
      ],
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
}
