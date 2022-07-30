import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';
import 'package:flutter_main_page/pages/loginPage/login_page.dart';

Future<void> _deleteAutoLoginStatus() async {
  prefs.setBool('autoLoginStatus', false);
  prefs.remove('userNumber');
  prefs.remove('user');
  prefs.remove('userGrade');
  prefs.remove('Class');
  prefs.remove('isAdmin');
}

class userInfoBox extends StatelessWidget {
  String userNumber = '';
  String user = '';
  String userGrade = '';
  String userClass = '';

  userInfoBox({Key? key}) : super(key: key);
  userInfoBox.set_user_info(
      this.user, this.userGrade, this.userClass, this.userNumber);

  @override
  Widget build(BuildContext context) {
    return (Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: myColor, width: 3),
        // color: Color.fromRGBO(73, 169, 242, 10)
      ),
      //안에 들어갈 디자인 입니다.
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 100,
                ),

                Column(
                  children: [
                    SizedBox(
                      child: Text(
                        '${this.user}',
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      '${this.userNumber}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),

                //일단 냅다 주석 처리
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.logout),
                      color: Color.fromRGBO(104, 103, 103, 100),
                      onPressed: () async {
                        isChecked = false;
                        _deleteAutoLoginStatus();

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
          ]),
      // ],
    )
        // )
        );
  }
}
