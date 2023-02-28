import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/src/components/custom_text_field.dart';
import 'package:flutter_main_page/src/components/font_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';

class ResetPassPage extends StatefulWidget {
  const ResetPassPage({Key? key}) : super(key: key);

  @override
  State<ResetPassPage> createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _userNumber = TextEditingController();
  final _email = TextEditingController();

  Future checkUserInfo(String userNumber, String email) async {
    if (_userNumber.text.isEmpty) {
      toastMessage('학번을 입력하세요');
      return;
    }
    if (_email.text.isEmpty) {
      toastMessage('이메일을 입력하세요');
      return;
    }

    DocumentSnapshot check = await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(userNumber)
        .get();

    if (!check.exists) {
      toastMessage('존재하지 않는 학번입니다');
      return;
    }
    if (check['email'] != email) {
      toastMessage('이메일 주소가 일치하지 않습니다');
      return;
    }

    resetPassword(email);
  }

  Future resetPassword(String email) async {
    (Platform.isAndroid)
        ? showDialog(
            context: context,
            barrierDismissible: false,
            builder: ((context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }))
        : showCupertinoDialog(
            context: context,
            barrierDismissible: false,
            builder: ((context) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }));
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      toastMessage('이메일이 발송되었습니다.');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      toastMessage('잠시 후에 다시 시도해주세요');
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _userNumber.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
                  child: Column(
                    children: [
                      _title(),
                      SizedBox(
                        height: 30,
                      ),
                      _resetTextField(),
                      SizedBox(
                        height: 20,
                      ),
                      _btns(),
                    ],
                  )),
            ),
          ),
        ));
  }
  
  Widget _title() {
    return Column(
      children: [
        FontText(
          type: FontType.SUB,
          text: '비밀번호 재설정',
          fontSize: 25,
        ),
        Text(
          "입력한 정보가 맞다면,",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        Text(
          "비밀번호 재설정을 위한 이메일이 발송됩니다.",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
  
  Widget _resetTextField() {
    return Column(
      children: [
        CustomTextField(
          controller: _userNumber,
          type: TextInputType.number,
          hintText: '학번',
        ),
        SizedBox(
          height: 20,
        ),
        CustomTextField(
          controller: _email,
          type: TextInputType.emailAddress,
          hintText: 'E-mail',
        ),            
      ],
    );
  }
  
  Widget _btns() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              (Platform.isAndroid)
                  ? ElevatedButton(
                      onPressed: () {
                        checkUserInfo(
                            _userNumber.text, _email.text);
                      },
                      child: Text('확인'))
                  : SizedBox(
                      height: 40,
                      child: CupertinoButton.filled(
                          padding: EdgeInsets.all(0.0),
                          minSize: 80.0,
                          onPressed: () {
                            checkUserInfo(
                                _userNumber.text, _email.text);
                          },
                          child: Text('확인')),
                    ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 80,
                child: (Platform.isAndroid)
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          '취소',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : SizedBox(
                        height: 40,
                        child: CupertinoButton(
                          padding: EdgeInsets.all(0.0),
                          minSize: 80.0,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            '취소',
                            style:
                                TextStyle(color: Colors.blueGrey),
                          ),
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          );
  }
}
