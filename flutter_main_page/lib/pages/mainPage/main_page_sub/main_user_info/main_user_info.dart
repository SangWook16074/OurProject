import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';
import 'package:flutter_main_page/pages/AdminPage/add_photo.dart';
import 'package:flutter_main_page/pages/AdminPage/admin_list.dart';
import 'package:flutter_main_page/pages/AdminPage/cmty_manage.dart';
import 'package:flutter_main_page/pages/AdminPage/delete_photo.dart';
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
                      '?????? ????????? ?????????????????????????\n????????? ??????????????? ??????, ????????????, ????????? ?????? ??????????????? ??? ??? ????????????.')
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
                    child: const Text("??????")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("??????")),
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
                children: const [Text('?????? ????????? ?????????????????????????')],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      FirebaseMessaging.instance
                          .subscribeToTopic("connectTopic");
                      prefs.setBool('isSubscribe', true);
                      Navigator.of(context).pop();
                    },
                    child: const Text("??????")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("??????")),
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
              children: const [
                Text('?????? ????????? ?????????????????????? \n????????? ??????????????? ????????? ??? ??? ????????????.')
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    prefs.setInt('index', 1);
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
                  child: const Text("??????")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("??????")),
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
              '????????? ??????',
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
            title: const Text('????????? ??????', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.delete),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyContentUpdatePage(widget.user)));
            },
            title: const Text('????????? ??????', style: TextStyle(fontSize: 20)),
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
              '??????',
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
            title: const Text('???????????????', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.calculate),
          ),
          ListTile(
            onTap: () {
              _createItemDialog();
            },
            title: const Text('?????? ?????? ??????', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.settings),
          ),
          ListTile(
            onTap: () {
              _createDeleteAlarm();
            },
            title: const Text('?????? ?????? ?????????', style: TextStyle(fontSize: 20)),
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
            title: const Text('????????????', style: TextStyle(fontSize: 20)),
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
              '????????? ?????????',
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
            title: const Text('????????? ??????', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.notifications),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => EventManagePage())));
            },
            title: const Text('????????? ??????', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.card_giftcard),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => JobManagePage()));
            },
            title: const Text('???????????? ??????', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.lightbulb),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ComManagePage()));
            },
            title: const Text('???????????? ??????', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.reorder),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminPage()));
            },
            title: const Text('????????? ??????', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.manage_accounts),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddPhotoPage()));
            },
            title: const Text('????????? ?????? ??????', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.add_a_photo),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DeletePhotoPage()));
            },
            title: const Text('????????? ?????? ??????', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.folder_delete),
          ),
        ]);
  }
}
