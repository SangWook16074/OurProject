import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';
import 'package:flutter_main_page/src/components/custom_text_field.dart';
import 'package:flutter_main_page/src/components/font_text.dart';
import 'package:flutter_main_page/src/pages/loginPage/create_user.dart';
import 'package:flutter_main_page/src/pages/loginPage/reset_pass.dart';
import 'package:flutter_main_page/src/pages/others/introduce.dart';
import '../mainPage/main_home.dart';

bool isChecked = false;
// import 'package:flutter_main_page/main_page.dart';
late bool autoLoginStatus;
late String userNumber;
late String user;
late bool isAdmin;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  late bool autoLoginStatus;
  late String userNumber;
  late String user;
  late bool isAdmin;
  late TextEditingController _textEditingControllerUser;
  late TextEditingController _textEditingControllerPassWd;
  final showHome = prefs.getBool('showHome') ?? false;



  Future login() async {

    if (_textEditingControllerUser.text.isEmpty) {
      toastMessage("학번을 입력하세요.");
      return;
    }
    if (_textEditingControllerPassWd
        .text.isEmpty) {
      toastMessage("비밀번호를 입력하세요.");
      return;
    }

    try {
      final String user =
          _textEditingControllerUser.text;
      DocumentSnapshot userInfoData =
          await FirebaseFirestore.instance
              .collection('UserInfo')
              .doc(user)
              .get();

      if (!userInfoData.exists) {
        toastMessage("가입하지 않은 학번입니다.");
        return;
      }
      await _auth
          .signInWithEmailAndPassword(
              email: userInfoData['email'],
              password:
                  _textEditingControllerPassWd
                      .text)
          .then((value) {
        if (value.user!.emailVerified == false) {
          toastMessage('이메일 인증을 완료해주세요!');
          return;
        }

        if (isChecked == true) {
          _updateAutoLoginStatus(isChecked);
          _saveUserData(
              userInfoData['userNumber'],
              userInfoData['userName'],
              userInfoData['isAdmin']);
          return;
        }

        prefs.setString('userNumber',
            userInfoData['userNumber']);
        prefs.setInt(
            'index', prefs.getInt('index') ?? 1);

        _textEditingControllerUser.clear();
        _textEditingControllerPassWd.clear();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => showHome
                    ? MainHome(
                        userNumber:
                            userInfoData.id,
                        user: userInfoData[
                            'userName'],
                        isAdmin: userInfoData[
                            'isAdmin'])
                    : OnBoardingPage(
                        userNumber:
                            userInfoData.id,
                        user: userInfoData[
                            'userName'],
                        isAdmin: userInfoData[
                            'isAdmin'])),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        toastMessage('비밀번호가 다릅니다');
        return;
      }

      toastMessage('잠시 후에 다시 시도해주세요');
    }
  }
  Future<void> _updateAutoLoginStatus(bool boolean) async {
    if (boolean == true) {
      prefs.setBool('autoLoginStatus', true);
    } else {
      prefs.setBool('autoLoginStatus', false);
    }
  }

  Future<void> _saveUserData(String number, String name, bool boolean) async {
    prefs.setString('userNumber', number);
    prefs.setString('user', name);

    prefs.setBool('isAdmin', boolean);
  }
  
  @override
  void initState() {
    super.initState();
    _textEditingControllerUser = TextEditingController();
    _textEditingControllerPassWd = TextEditingController();

    Map<TextEditingController, String> controllers = {
      _textEditingControllerUser : '이름',
      _textEditingControllerPassWd : '비밀번호',
    };
  }
  

  @override
  void dispose() {
    _textEditingControllerUser.dispose();
    _textEditingControllerPassWd.dispose();
    _textEditingControllerPassWd.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (prefs.getBool('autoLoginStatus') == true) {
      return showHome
          ? MainHome(
              userNumber: prefs.getString('userNumber').toString(),
              user: prefs.getString('user').toString(),
              isAdmin: prefs.getBool('isAdmin')!)
          : OnBoardingPage(
              userNumber: prefs.getString('userNumber').toString(),
              user: prefs.getString('user').toString(),
              isAdmin: prefs.getBool('isAdmin')!);
    } else {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _pageTop(),
                      const SizedBox(height: 50),
                      _loginTextField(),
                      _autoLoginCheckBox(),
                      _loginBtn(),
                      _joinBtn(),
                      SizedBox(
                        height: 20,
                      ),
                      _appBottom(),
                    ],
                  ),
                ),
              ),
            ),
          ));
    }
  }
  
  Widget _pageTop() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          child: Image.asset('assets/Images/app_logo.png'),
        ),
        SizedBox(
          height: 10,
        ),
        FontText(
          type: FontType.MAIN,
          text: "인덕대학교",
          fontSize: 60,
        ),
          
        const Text(
          "Information and Communication",
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Pacifico',
              color: Colors.black),
        ),
      ],
    );
  }
  
  Widget _loginTextField() {
    return Column(
      children: [
        CustomTextField(
          controller: _textEditingControllerUser,
          type: TextInputType.number,
          hintText: '학번을 입력하세요',
          prefixIcon: Icon(Icons.account_circle),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomTextField(
          controller: _textEditingControllerPassWd,
          hintText: '비밀버호를 입력하세요',
          isPrivate: true,
          prefixIcon: Icon(Icons.lock),
        ),
      ],
    );
  }
  
  Widget _autoLoginCheckBox() {
    return Row(
            children: [
              Checkbox(
                  value: isChecked,
                  activeColor: Colors.white,
                  checkColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text(
                "자동로그인",
                style: TextStyle(
                    color: Colors.black, letterSpacing: (4.0)),
              )
            ],
          );
  }
  
  Widget _loginBtn() {
    return SizedBox(
            width: 355,
            child: (Platform.isAndroid)
                ? ElevatedButton(
                    //로그인 버튼

                    onPressed: login,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Text(
                      "로그인",
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 4.0,
                          color: Colors.white),
                    ))
                : CupertinoButton(
                    //로그인 버튼

                    onPressed: login,
                    color: Colors.blueGrey,
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      "로그인",
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 4.0,
                          color: Colors.white),
                    )),
          );
  }
  
  Widget _joinBtn() {
    return TextButton(
            //회원가입 버튼
            onPressed: () {
              Navigator.push(
                  context,
                  (Platform.isAndroid)
                      ? MaterialPageRoute(
                          builder: (context) =>
                              const CreateUserPage())
                      : CupertinoPageRoute(
                          builder: (context) =>
                              const CreateUserPage()));
            },
            style: TextButton.styleFrom(),
            child: const Text(
              "회원가입",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          );
  }
  
  Widget _appBottom() {
    return Row(
            children: [
              const Text(
                "비밀번호를 잊으셨나요?",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      (Platform.isAndroid)
                          ? MaterialPageRoute(
                              builder: (context) => ResetPassPage())
                          : CupertinoPageRoute(
                              builder: (context) =>
                                  ResetPassPage()));
                },
                style: TextButton.styleFrom(),
                child: const Text(
                  "Help",
                  style:
                      TextStyle(fontSize: 15, color: Colors.blue),
                ),
              ),
            ],
          );
  }
}
