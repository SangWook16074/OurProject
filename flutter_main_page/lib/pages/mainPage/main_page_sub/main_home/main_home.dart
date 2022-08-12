// ignore_for_file: unnecessary_const

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_main_page/custom_page_route.dart';
import 'package:flutter_main_page/navigation_draw.dart';
import 'package:flutter_main_page/pages/AdminPage/add_photo.dart';
import 'package:flutter_main_page/pages/AdminPage/notice_manage.dart';
import 'package:flutter_main_page/pages/View_pages/notice_view.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_alarm/main_alarm.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/Community_house/com_notice.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../AdminPage/cmty_manage.dart';
import '../../../AdminPage/event_manage.dart';
import '../../../AdminPage/job_manage.dart';
import '../../../View_pages/com_view.dart';
import '../../../answer.dart';
import '../main_community/Community_house/com_community.dart';
import '../main_community/Community_house/com_event.dart';

final items = <Notice>[];

class Notice {
  String title;
  String content;
  String author;
  String time;

  Notice(this.title, this.content, this.author, this.time);
}

class Com {
  String title;
  String content;
  String author;
  String time;
  String number;
  int countLike;
  List likedUsersList;

  Com(this.title, this.author, this.content, this.time, this.number,
      this.countLike, this.likedUsersList);
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
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw 'Could not launch $url';
    }
  }

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
                    child: Icon(Icons.photo_library),
                    label: '배너사진관리',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddPhotoPage()));
                    }),
                SpeedDialChild(
                    child: Icon(Icons.question_answer),
                    label: 'Q / A 관리',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionManagePage()));
                    }),
              ],
            )
          : null,
      endDrawer: NavigationDrawerWidget(
          userNumber: widget.userNumber,
          user: widget.user,
          isAdmin: widget.isAdmin),
      appBar: AppBar(
        title: Image.asset(
          'assets/app_logo.png',
          height: 30,
          width: 30,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, CustomPageRoute(child: MainAlarm()));
              },
              icon: Icon(
                Icons.notifications_active,
              )),
          Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(
                  Icons.menu,
                ));
          })
        ],
        iconTheme: IconThemeData.fallback(),
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          //_buildIconNavigator(),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  height: 460,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Expanded(
                                child: Text(
                                  '학과 이벤트',
                                  style: TextStyle(
                                      fontSize: 25, fontFamily: 'hoon'),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(CustomPageRoute(
                                        child: EventPage(widget.user)));
                                  },
                                  child: Text(
                                    '더보기',
                                    style: TextStyle(color: Colors.blueGrey),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: _buildEvent(),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
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
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(CustomPageRoute(
                                    child: NoticePage(widget.userNumber)));
                              },
                              child: Text(
                                '더보기',
                                style: TextStyle(color: Colors.blueGrey),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildNotice(),
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
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
                              '커뮤니티',
                              style:
                                  TextStyle(fontSize: 25, fontFamily: 'hoon'),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(CustomPageRoute(
                                    child: ComPage(widget.userNumber)));
                              },
                              child: Text(
                                '더보기',
                                style: TextStyle(color: Colors.blueGrey),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildCom(),
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildNotice() {
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

  Widget _buildCom() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('com')
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
              children:
                  documents.map((doc) => _buildItemCom(doc, context)).toList(),
            );
          }
        });
  }

  Widget _buildIconNavigator() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                Uri uri = Uri(
                  scheme: 'https',
                  host: 'www.induk.ac.kr',
                );
                _launchUrl(uri);
              },
              icon: Icon(
                Icons.home_rounded,
                size: 40,
              )),
        ],
      ),
    );
  }

  // Widget _buildImage() {
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: FirebaseFirestore.instance.collection('eventImage').snapshots(),
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return Center(child: CircularProgressIndicator());
  //         }
  //         final documents = snapshot.data!.docs;

  //         return CarouselSlider(
  //           options: CarouselOptions(
  //             height: 220.0,
  //             autoPlay: true,
  //             enlargeCenterPage: false,
  //           ),
  //           items: documents.map((doc) {
  //             return Builder(
  //               builder: (BuildContext context) {
  //                 return Container(
  //                     width: MediaQuery.of(context).size.width,
  //                     margin: const EdgeInsets.symmetric(horizontal: 5.0),
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                       child: CachedNetworkImage(
  //                         imageUrl: doc['url'],
  //                         fit: BoxFit.fill,
  //                         placeholder: (context, url) => Container(
  //                           color: Colors.black,
  //                         ),
  //                         errorWidget: (context, url, error) =>
  //                             Icon(Icons.error),
  //                       ),
  //                     ));
  //               },
  //             );
  //           }).toList(),
  //         );
  //       });
  // }

  Widget _buildItemCom(DocumentSnapshot doc, BuildContext context) {
    final com = Com(doc['title'], doc['content'], doc['author'], doc['time'],
        doc['number'], doc['countLike'], doc['likedUsersList']);
    return Column(
      children: [
        ListTile(
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ComViewPage(
                        title: com.title,
                        content: com.content,
                        author: '익명',
                        time: com.time,
                        id: doc.id,
                        user: widget.userNumber)));
          },
          title: Text(
            com.title,
            style: const TextStyle(
                fontSize: 17,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "익명 | ${com.time}",
            style: const TextStyle(fontSize: 10),
          ),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
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
            "${notice.author} | ${notice.time}",
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
        '아직 등록된 글이 없습니다.',
        style: TextStyle(
            color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget _buildEvent() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('event').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;

          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: 400,
              enlargeCenterPage: true,
            ),
            items: documents.map((doc) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                      border: Border.all(width: 1, color: Colors.black12),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: (doc['url'] != '')
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: CachedNetworkImage(
                                      imageUrl: doc['url'],
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) => Container(
                                        color: Colors.black,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Container(
                                      color: Colors.amber,
                                    )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              doc['title'],
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w300),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        });
  }
}
