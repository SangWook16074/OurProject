import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';
import 'package:flutter_main_page/pages/AdminPage/admin_list.dart';

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
    return userInfoBox.set_user_info(
        widget.user, widget.userGrade, widget.userClass, widget.userNumber);
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
            onTap: () {},
            title: const Text('취업정보 관리', style: TextStyle(fontSize: 20)),
            trailing: const Icon(Icons.lightbulb),
          ),
          ListTile(
            onTap: () {},
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
