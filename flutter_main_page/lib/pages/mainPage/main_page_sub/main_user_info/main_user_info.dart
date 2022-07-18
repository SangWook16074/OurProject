import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';
import 'package:flutter_main_page/pages/AdminPage/admin_list.dart';
import 'package:flutter_main_page/pages/AdminPage/cmty_manage.dart';
import 'package:flutter_main_page/pages/AdminPage/job_manage.dart';

import 'package:flutter_main_page/pages/AdminPage/notice_manage.dart';

import 'package:flutter_main_page/pages/AdminPage/event_manage.dart';

import 'package:flutter_main_page/pages/loginPage/login_page.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_user_info/main_other_page/calculate.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_user_info/main_other_page/myContentDelete.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_user_info/main_other_page/myContentUpdate.dart';

import 'package:flutter_main_page/pages/mainPage/main_page_sub/user_info_template.dart';

class MainPage4 extends StatefulWidget {
  final String userNumber;
  final String user;
  final String userGrade;
  final String userClass;
  final bool? isAdmin;
  const MainPage4(
      this.userNumber, this.user, this.userGrade, this.userClass, this.isAdmin,
      {Key? key})
      : super(key: key);

  @override
  State<MainPage4> createState() => _MainPage4State();
}

class _MainPage4State extends State<MainPage4> {
  void _createItemDialog() {
    if (prefs.getBool('isSubscribe') == true) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                      '푸시 알림을 해제하시겠습니까? 알림을 해제하시면 공지, 취업정보, 이벤트 등의 등록사항을 볼 수 없습니다.')
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      FirebaseMessaging.instance
                          .unsubscribeFromTopic("connectTopic");
                      prefs.setBool('isSubscribe', false);
                      Navigator.of(context).pop();
                    },
                    child: const Text("확인")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("취소")),
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [Text('푸시 알림을 설정하시겠습니까?')],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      FirebaseMessaging.instance
                          .subscribeToTopic("connectTopic");
                      prefs.setBool('isSubscribe', true);
                      Navigator.of(context).pop();
                    },
                    child: const Text("확인")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("취소")),
              ],
            );
          });
    }
  }

  void _createDeleteAlarm() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [Text('알림 로그를 지우시겠습니까? 한번 지우면 다시는 볼 수 없습니다.')],
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    final instance = FirebaseFirestore.instance;
                    final batch = instance.batch();
                    var collection = instance.collection(
                        'UserInfo/${prefs.getString('userNumber').toString()}/alarmlog');
                    var snapshots = await collection.get();
                    for (var doc in snapshots.docs) {
                      batch.delete(doc.reference);
                    }
                    await batch.commit();
                    Navigator.of(context).pop();
                  },
                  child: const Text("확인")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("취소")),
            ],
          );
        });
  }

  Future<void> _deleteAutoLoginStatus() async {
    prefs.setBool('autoLoginStatus', false);
    prefs.remove('userNumber');
    prefs.remove('user');
    prefs.remove('userGrade');
    prefs.remove('Class');
    prefs.remove('isAdmin');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAdmin == true) {
      return Scaffold(
        body: Center(
          child: ListView(
            children: [
              _buildUserInfo(),
              _buildAdmin(),
              _buildManager(),
              _buildOthers(),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: ListView(
            children: [
              _buildUserInfo(),
              _buildManager(),
              _buildOthers(),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildUserInfo() {
    return (userInfoBox.set_user_info(
        widget.user, widget.userGrade, widget.userClass, widget.userNumber));
  }

  Widget _buildManager() {
    return Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: myColor, width: 3)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              '게시물 관리',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            _buildManageList(),
          ],
        ));
  }

  Widget _buildManageList() {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyContentDeletePage(widget.user)));
            },
            title: const Text('게시물 삭제', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.delete),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyContentUpdatePage(widget.user)));
            },
            title: const Text('게시물 수정', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.update),
          ),
        ]);
  }

  Widget _buildOthers() {
    return Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: myColor, width: 3)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              '기타',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            _buildOthersList(),
          ],
        ));
  }

  Widget _buildOthersList() {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CalculatePage()));
            },
            title: const Text('학점계산기', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.calculate),
          ),
          ListTile(
            onTap: () {
              _createItemDialog();
            },
            title: const Text('푸시 알림 설정', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.settings),
          ),
          ListTile(
            onTap: () {
              _createDeleteAlarm();
            },
            title: const Text('알림 기록 지우기', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.content_paste),
          ),
          ListTile(
            onTap: () async {
              isChecked = false;
              _deleteAutoLoginStatus();

              await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
            },
            title: const Text('로그아웃', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.logout),
          ),
        ]);
  }

  Widget _buildAdmin() {
    return Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: myColor, width: 3)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              '관리자 페이지',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            _buildAdminList(),
          ],
        ));
  }

  Widget _buildAdminList() {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NoticeManagePage()));
            },
            title: const Text('공지글 관리', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.notifications),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => EventManagePage())));
            },
            title: const Text('이벤트 관리', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.card_giftcard),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => JobManagePage()));
            },
            title: const Text('취업정보 관리', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.lightbulb),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ComManagePage()));
            },
            title: const Text('커뮤니티 관리', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.reorder),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminPage()));
            },
            title: const Text('관리자 명단', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.manage_accounts),
          ),
          ListTile(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => AdminPage()));
            },
            title: const Text('이벤트 사진 등록', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.add_a_photo),
          ),
        ]);
  }
}
