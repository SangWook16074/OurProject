import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

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
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) {
          return Center(
            child: CircularProgressIndicator(),
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
        backgroundColor: Color.fromARGB(255, 242, 239, 239),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
                  child: Column(
                    children: [
                      Text(
                        "비밀번호 재설정",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontFamily: 'hoon'),
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
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: _userNumber,
                        onChanged: (text) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            hintText: "학번",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            suffixIcon: GestureDetector(
                              child: const Icon(
                                Icons.clear,
                                color: Colors.blueGrey,
                                size: 20,
                              ),
                              onTap: () => _userNumber.clear(),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        onChanged: (text) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            hintText: "E-mail",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            suffixIcon: GestureDetector(
                              child: const Icon(
                                Icons.clear,
                                color: Colors.blueGrey,
                                size: 20,
                              ),
                              onTap: () => _email.clear(),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                checkUserInfo(_userNumber.text, _email.text);
                              },
                              child: Text('확인')),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
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
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }
}
