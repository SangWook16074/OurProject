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
import 'package:flutter_main_page/pages/View_pages/zoom_image.dart';
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
  String? url;

  Com(this.title, this.author, this.content, this.time, this.number,
      this.countLike, this.likedUsersList, this.url);
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
                Navigator.push(
                    context, CustomPageRightRoute(child: MainAlarm()));
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
          // Padding(
          //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          //   child: Container(
          //       padding: const EdgeInsets.all(8.0),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(25),
          //           border: Border.all(color: Colors.grey, width: 1)),
          //       child: ClipRRect(
          //         child: Column(
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.only(left: 8.0),
          //               child: Row(
          //                 mainAxisSize: MainAxisSize.max,
          //                 children: [
          //                   const Expanded(
          //                     child: Text(
          //                       '정보통신공학과',
          //                       style:
          //                           TextStyle(fontSize: 25, fontFamily: 'hoon'),
          //                     ),
          //                   ),
          //                   TextButton(
          //                       onPressed: () {
          //                         Navigator.of(context).push(CustomPageRoute(
          //                             child: NoticePage(widget.userNumber)));
          //                       },
          //                       child: Text(
          //                         '더보기',
          //                         style: TextStyle(color: Colors.blueGrey),
          //                       ))
          //                 ],
          //               ),
          //             ),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             _buildImage(),
          //             _buildText(context),
          //           ],
          //         ),
          //       )),
          // ),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  height: 500,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey, width: 1)),
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
                                  '학생회 이벤트',
                                  style: TextStyle(
                                      fontSize: 25, fontFamily: 'hoon'),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        CustomPageRightRoute(
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
                padding: const EdgeInsets.only(top: 70.0),
                child: _buildEvent(),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey, width: 1)),
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
                                Navigator.of(context).push(CustomPageRightRoute(
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
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Expanded(
                            child: Text(
                              '최근 등록된 글',
                              style:
                                  TextStyle(fontSize: 25, fontFamily: 'hoon'),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(CustomPageRightRoute(
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
            height: 30,
          ),

          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  height: 320,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey, width: 1)),
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
                                  '학과 소식',
                                  style: TextStyle(
                                      fontSize: 25, fontFamily: 'hoon'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: _buildBannerImage(),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      child: Image.asset('assets/title.png'),
    );
  }

  Widget _buildText(BuildContext context) {
    return ExpansionTile(
      title: Text(
        '학과 소개',
        style: TextStyle(fontSize: 15),
      ),
      children: [
        Row(
          children: [
            Text(
              '교육 목표',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            '4차 산업혁명시대에 알맞는 산학일체형 직업교육을 실시함으로서 현장실무능력 제고와 취업분야 및 창업분야를 학생 스스로 선별할 수 있는 능력 배양을 교육목표로 한다.'),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              '교육 방침',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            '가. 전문 중견 기술인으로서의 투철한 직업관 고취\n나. ICT 융합 기술분야에특성화된 심화전공 교육과정을 운영하여 현장실무능력 제고\n다. 전공과 관련된 현장실무과정을 고려한 특성화된 전문 기술교육을 운영함으로써 산학일체형 직업 교육 및 현장 실무능력 제고\n라. 교육의 질을 높여 국제화 산업사회의 특성에 맞는 글로컬 전문인력 배출\n마. 4차 산업혁명에 발맞추어 ICT 융합기술 기반 인재를 양성하기 위한 전문교육을 실시하여 학생 스스로 미래 지향형 취업 분야 선택 및 창업 유도'),
      ],
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

  Widget _buildBannerImage() {
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
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
            ),
            items: documents.map((doc) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ZoomImage(url: doc['url']);
                      }));
                    },
                    child: Hero(
                      tag: doc['url'],
                      child: Container(
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
                          )),
                    ),
                  );
                },
              );
            }).toList(),
          );
        });
  }

  Widget _buildItemCom(DocumentSnapshot doc, BuildContext context) {
    final com = Com(doc['title'], doc['author'], doc['content'], doc['time'],
        doc['number'], doc['countLike'], doc['likedUsersList'], doc['url']);
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
                        url: (com.url != null) ? com.url : null,
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
          trailing: (doc['url'] != '')
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: 70,
                        child: CachedNetworkImage(
                          imageUrl: doc['url']!,
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) => Container(
                            color: Colors.black,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      )))
              : null,
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
        stream: FirebaseFirestore.instance
            .collection('event')
            .orderBy('url')
            .where('url', isNotEqualTo: "")
            .orderBy('time', descending: true)
            .snapshots(),
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
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ZoomImage(url: doc['url']);
                                }));
                              },
                              child: Hero(
                                tag: doc['url'],
                                child: Container(
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
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              doc['title'],
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
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
