// ignore_for_file: unnecessary_const

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_main_page/navigation_draw.dart';
import 'package:flutter_main_page/src/components/font_text.dart';
import 'package:flutter_main_page/src/pages/AdminPage/add_photo.dart';
import 'package:flutter_main_page/src/pages/AdminPage/notice_manage.dart';
import 'package:flutter_main_page/src/pages/View_pages/event_view.dart';
import 'package:flutter_main_page/src/pages/View_pages/notice_view.dart';
import 'package:flutter_main_page/src/pages/View_pages/zoom_image.dart';
import 'package:flutter_main_page/src/pages/market/com_market.dart';
import 'package:flutter_main_page/src/pages/mainPage/main_alarm.dart';
import 'package:flutter_main_page/src/pages/mainPage/com_notice.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../custom_page_route.dart';
import '../../../main.dart';
import '../AdminPage/cmty_manage.dart';
import '../AdminPage/event_manage.dart';
import '../AdminPage/job_manage.dart';
import '../View_pages/com_view.dart';
import '../others/answer.dart';
import 'com_community.dart';
import 'com_event.dart';

final items = <Notice>[];

class Notice {
  String title;
  String content;
  String author;
  String time;

  Notice(this.title, this.content, this.author, this.time);
}

class Market {
  String title;
  String content;
  String price;
  String time;
  String url;

  Market(this.title, this.content, this.price, this.time, this.url);
}

class Com {
  String title;
  String content;
  String author;
  String time;
  String number;
  int countLike;
  List likedUsersList;
  List hateUsers;
  String? url;

  Com(this.title, this.author, this.content, this.time, this.number,
      this.countLike, this.likedUsersList, this.hateUsers, this.url);
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
    if (!await launchUrl(url,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true, enableDomStorage: true))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.isAdmin == true
          ? _speedDial()
          : null,
      endDrawer: NavigationDrawerWidget(
          userNumber: widget.userNumber,
          user: widget.user,
          isAdmin: widget.isAdmin),
      appBar: AppBar(
        title: Image.asset(
          'assets/Images/app_logo.png',
          height: 30,
          width: 30,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(()=>MainAlarm());
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
          _buildIconNavigator(),
          SizedBox(
            height: 20,
          ),
          _event(),
          SizedBox(
            height: 30,
          ),
          _notice(),
          SizedBox(
            height: 30,
          ),
          _com(),
          SizedBox(
            height: 30,
          ),
          _buildMarket(),
          SizedBox(
            height: 30,
          ),
          _bannerImage(),
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
                child: CircularProgressIndicator.adaptive());
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
                child: CircularProgressIndicator.adaptive());
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
          SizedBox(),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Uri uri = Uri(
                      scheme: 'https',
                      host: 'www.induk.ac.kr',
                      path: '/KR/index.do',
                    );
                    _launchUrl(uri);
                  },
                  icon: Icon(
                    Icons.account_balance,
                    size: 30,
                  )),
              Text(
                '대학홈',
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Uri uri = Uri(
                      scheme: 'https',
                      host: 'portal.induk.ac.kr',
                    );
                    _launchUrl(uri);
                  },
                  icon: Icon(
                    Icons.language,
                    size: 30,
                  )),
              Text(
                '대학포털',
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
          // Column(
          //   children: [
          //     IconButton(
          //         onPressed: () {
          //           Uri uri = Uri(
          //               scheme: 'https',
          //               host: 'www.induk.ac.kr',
          //               path: '/KR/cms/CM_CN01_CON/index.do',
          //               query: '?MENU_SN=812');
          //           _launchUrl(uri);
          //         },
          //         icon: Icon(
          //           Icons.post_add,
          //           size: 30,
          //         )),
          //     Text(
          //       '학과소개',
          //       style: TextStyle(fontSize: 13),
          //     )
          //   ],
          // ),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Uri uri = Uri(scheme: 'https', host: 'jjam.induk.ac.kr');
                    _launchUrl(uri);
                  },
                  icon: Icon(
                    Icons.menu_book,
                    size: 30,
                  )),
              Text(
                '비교과',
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
          SizedBox(),
        ],
      ),
    );
  }

  Widget _buildBannerImage() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('eventImage').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          final documents = snapshot.data!.docs;

          return CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
            ),
            items: documents.map((doc) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push((Platform.isAndroid)
                          ? MaterialPageRoute(builder: (context) {
                              return ZoomImage(url: doc['url']);
                            })
                          : CupertinoPageRoute(builder: (context) {
                              return ZoomImage(url: doc['url']);
                            }));
                    },
                    child: Hero(
                      transitionOnUserGestures: true,
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
    final com = Com(
        doc['title'],
        doc['author'],
        doc['content'],
        doc['time'],
        doc['number'],
        doc['countLike'],
        doc['likedUsersList'],
        doc['hateUsers'],
        doc['url']);
    if (doc['hateUsers'].contains(widget.userNumber)) {
      return Column(
        children: [
          ListTile(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            onTap: () {
              toastMessage('차단된 글은 볼 수 없습니다.');
            },
            title: Text(
              '사용자가 차단한 글',
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      );
    }
    return Column(
      children: [
        ListTile(
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          onTap: () {
            (com.url == '')
                ? Navigator.push(
                    context,
                    (Platform.isAndroid)
                        ? MaterialPageRoute(
                            builder: (context) => ComViewPage(
                                  title: com.title,
                                  content: com.content,
                                  author: '익명',
                                  time: com.time,
                                  id: doc.id,
                                  user: widget.userNumber,
                                  countLike: com.countLike,
                                  likedUsersList: com.likedUsersList,
                                  hateUsers: com.hateUsers,
                                ))
                        : CupertinoPageRoute(
                            builder: (context) => ComViewPage(
                                title: com.title,
                                content: com.content,
                                author: '익명',
                                time: com.time,
                                id: doc.id,
                                user: widget.userNumber,
                                countLike: com.countLike,
                                likedUsersList: com.likedUsersList,
                                hateUsers: com.hateUsers)))
                : Navigator.push(
                    context,
                    (Platform.isAndroid)
                        ? MaterialPageRoute(
                            builder: (context) => ComViewPage(
                                title: com.title,
                                content: com.content,
                                author: '익명',
                                time: com.time,
                                id: doc.id,
                                url: com.url!,
                                user: widget.userNumber,
                                countLike: com.countLike,
                                likedUsersList: com.likedUsersList))
                        : CupertinoPageRoute(
                            builder: (context) => ComViewPage(
                                title: com.title,
                                content: com.content,
                                author: '익명',
                                time: com.time,
                                id: doc.id,
                                url: com.url!,
                                user: widget.userNumber,
                                countLike: com.countLike,
                                likedUsersList: com.likedUsersList)));
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
                (Platform.isAndroid)
                    ? MaterialPageRoute(
                        builder: (context) => NoticeViewPage(notice.title,
                            notice.content, notice.author, notice.time))
                    : CupertinoPageRoute(
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
            return Center(child: CircularProgressIndicator.adaptive());
          }
          final documents = snapshot.data!.docs;

          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: MediaQuery.of(context).size.width,
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
                                Navigator.of(context).push((Platform.isAndroid)
                                    ? MaterialPageRoute(builder: (context) {
                                        return EventViewPage(
                                            title: doc['title'],
                                            content: doc['content'],
                                            author: doc['author'],
                                            time: doc['time'],
                                            url: doc['url']);
                                      })
                                    : CupertinoPageRoute(builder: (context) {
                                        return EventViewPage(
                                            title: doc['title'],
                                            content: doc['content'],
                                            author: doc['author'],
                                            time: doc['time'],
                                            url: doc['url']);
                                      }));
                              },
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

  Widget _buildMarket() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey, width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        '전공서 중고마켓',
                        style: GoogleFonts.doHyeon(
                          textStyle: mainStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('사용하지 않는 전공서를 필요한 학과사람들에게 중고로 판매해보세요!'),
                ElevatedButton.icon(
                    icon: Icon(Icons.arrow_right_alt),
                    onPressed: () {
                      (Platform.isAndroid)
                          ? Navigator.of(context).push(CustomPageRightRoute(
                              child: MarketPage(
                              userNumber: widget.userNumber,
                            )))
                          : Navigator.of(context)
                              .push(CupertinoPageRoute(builder: (context) {
                              return MarketPage(
                                userNumber: widget.userNumber,
                              );
                            }));
                    },
                    label: Text(
                      '마켓으로',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          )),
    );
  }

  Widget _buildMarketItem() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('market')
            .orderBy('time', descending: true)
            .limit(5)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator.adaptive());
          }
          final documents = snapshot.data!.docs;
          if (documents.isEmpty) {
            return _buildNonItem();
          } else {
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children:
                  documents.map((doc) => _MarketItem(doc, context)).toList(),
            );
          }
        });
  }

  Widget _MarketItem(DocumentSnapshot doc, BuildContext context) {
    final market = Market(
        doc['title'], doc['content'], doc['price'], doc['time'], doc['url']);
    return Container(
      child: Column(
        children: [
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            onTap: () {
              // Navigator.push(
              //     context,
              //     (Platform.isAndroid)
              //         ? MaterialPageRoute(
              //             builder: (context) => NoticeViewPage(notice.title,
              //                 notice.content, notice.author, notice.time))
              //         : CupertinoPageRoute(
              //             builder: (context) => NoticeViewPage(notice.title,
              //                 notice.content, notice.author, notice.time)));
            },
            title: Text(
              market.title,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            subtitle: Text(
              "익명 | ${market.time}",
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
  
  Widget _speedDial() {
    return SpeedDial(
              gradientBoxShape: BoxShape.circle,
              spaceBetweenChildren: 10,
              spacing: 10,
              icon: Icons.manage_accounts,
              overlayOpacity: 0.6,
              overlayColor: Colors.black,
              children: [
                _dialChild(Icon(Icons.edit_notifications), '공지관리', NoticeManagePage()),
                _dialChild(Icon(Icons.event_available), '이벤트관리', EventManagePage()),
                _dialChild(Icon(Icons.lightbulb), '취업정보관리', JobManagePage()),
                _dialChild(Icon(Icons.message), '커뮤니티관리', ComManagePage()),
                _dialChild(Icon(Icons.photo_library), '배너사진관리', AddPhotoPage()),
                _dialChild(Icon(Icons.question_answer), 'Q / A관리', QuestionManagePage()),
              ],
            );
  }
  
  SpeedDialChild _dialChild(Icon icon, String label, Widget nextPage) {
    return SpeedDialChild(
                    child: icon,
                    label: label,
                    onTap: () {
                      Get.to(() => nextPage);
                    });
  }
  
  Widget _event() {
    return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  height: MediaQuery.of(context).size.width + 100,
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
                              Expanded(
                                child: FontText(text: '학생회 이벤트', type: FontType.SUB, fontSize: 25,)
                              ),
                              TextButton(
                                  onPressed: () {
                                    (Platform.isAndroid)
                                        ? Navigator.of(context).push(
                                            CustomPageRightRoute(
                                                child: EventPage(widget.user)))
                                        : Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) {
                                            return EventPage(widget.user);
                                          }));
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
          );
  }
  
  Widget _notice() {
    return Padding(
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
                          Expanded(
                            child: Text(
                              '공지사항',
                              style: GoogleFonts.doHyeon(
                                textStyle: mainStyle,
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                (Platform.isAndroid)
                                    ? Navigator.of(context).push(
                                        CustomPageRightRoute(
                                            child:
                                                NoticePage(widget.userNumber)))
                                    : Navigator.of(context).push(
                                        CupertinoPageRoute(builder: (context) {
                                        return NoticePage(widget.userNumber);
                                      }));
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
          );
  }
  
  Widget _com() {
    return Padding(
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
                          Expanded(
                            child: Text(
                              '최근 등록된 글',
                              style: GoogleFonts.doHyeon(
                                textStyle: mainStyle,
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                (Platform.isAndroid)
                                    ? Navigator.of(context).push(
                                        CustomPageRightRoute(
                                            child: ComPage(widget.userNumber)))
                                    : Navigator.of(context).push(
                                        CupertinoPageRoute(builder: (context) {
                                        return ComPage(widget.userNumber);
                                      }));
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
          );
  }
  
  Widget _bannerImage() {
    return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  height: MediaQuery.of(context).size.width + 100,
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
                              Expanded(
                                child: Text(
                                  '학과 소식',
                                  style: GoogleFonts.doHyeon(
                                    textStyle: mainStyle,
                                  ),
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
          );
  }
}
