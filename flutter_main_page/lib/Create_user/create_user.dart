import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import '../database_sub/user_info.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _userName = TextEditingController();
  final _userPass = TextEditingController();
  final _userPassAgain = TextEditingController();
  final _userGrade = TextEditingController();
  final _userClass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.blue[400],
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
                  child: Column(
                    children: [
                      const Text(
                        "본인의 학번을 입력하세요.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _userName,
                        onChanged: (text) {},
                        decoration: InputDecoration(
                            hintText: "학번 ex.2022XXXXX",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            suffixIcon: GestureDetector(
                              child: const Icon(
                                Icons.clear,
                                color: Colors.blueAccent,
                                size: 20,
                              ),
                              onTap: () => _userName.clear(),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "비밀번호를 입력하세요.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "가급적이면 영어 + 숫자 + 특수문자였으면 좋겠어요.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _userPass,
                        obscureText: true,
                        onChanged: (text) {},
                        decoration: InputDecoration(
                            hintText: "비밀번호",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            suffixIcon: GestureDetector(
                              child: const Icon(
                                Icons.clear,
                                color: Colors.blueAccent,
                                size: 20,
                              ),
                              onTap: () => _userPass.clear(),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "한번만 더 입력해줘요.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _userPassAgain,
                        obscureText: true,
                        onChanged: (text) {},
                        decoration: InputDecoration(
                            hintText: "비밀번호 확인",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            suffixIcon: GestureDetector(
                              child: const Icon(
                                Icons.clear,
                                color: Colors.blueAccent,
                                size: 20,
                              ),
                              onTap: () => _userPassAgain.clear(),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "몇학년 인가요?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _userGrade,
                        onChanged: (text) {},
                        decoration: InputDecoration(
                            hintText: "학년",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            suffixIcon: GestureDetector(
                              child: const Icon(
                                Icons.clear,
                                color: Colors.blueAccent,
                                size: 20,
                              ),
                              onTap: () => _userGrade.clear(),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "반이 어떻게 되나요?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _userClass,
                        onChanged: (text) {},
                        decoration: InputDecoration(
                            hintText: "A/B",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            suffixIcon: GestureDetector(
                              child: const Icon(
                                Icons.clear,
                                color: Colors.blueAccent,
                                size: 20,
                              ),
                              onTap: () => _userClass.clear(),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                              //회원가입 버튼

                              onPressed: () async {
                                //회원 추가 항목 넣을거임
                                bool isAdmin = false;
                                if (_userName.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "학번을 입력하세요.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    fontSize: 16,
                                  );
                                } else if (_userPass.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "비밀번호를 입력하세요.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    fontSize: 16,
                                  );
                                } else if (_userPassAgain.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "비밀번호를 확인해야 합니다.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    fontSize: 16,
                                  );
                                } else if (_userGrade.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "학년을 입력해야 합니다.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    fontSize: 16,
                                  );
                                } else if (_userClass.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "반을 입력해야 합니다.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    fontSize: 16,
                                  );
                                } else if (_userPass.text !=
                                    _userPassAgain.text) {
                                  Fluttertoast.showToast(
                                    msg: "비밀번호 확인이 안됩니다.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    fontSize: 16,
                                  );
                                } else {
                                  DocumentSnapshot userinfoData =
                                      await FirebaseFirestore.instance
                                          .collection('UserInfo')
                                          .doc(_userName.text)
                                          .get();

                                  try {
                                    if (userinfoData['userName'] ==
                                        _userName.text) {
                                      Fluttertoast.showToast(
                                        msg: "이미 계정이 있어요.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        fontSize: 16,
                                      );
                                    }
                                  } catch (err) {
                                    await firestore
                                        .collection('UserInfo')
                                        .doc(_userName.text)
                                        .set({
                                      'userName': _userName.text,
                                      'userPass': _userPass.text,
                                      'userGrade': _userGrade.text,
                                      'userClass': _userClass.text,
                                      'isAdmin': isAdmin,
                                    });
                                    Fluttertoast.showToast(
                                      msg: "생성 완료!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      fontSize: 16,
                                    );
                                    final result =
                                        // ignore: use_build_context_synchronously
                                        await Navigator.pushNamed(
                                            context, '/login');
                                    // ignore: avoid_print
                                    print(result);
                                  }
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue[700],
                                  padding: const EdgeInsets.all(16.0),
                                  minimumSize: const Size(130, 25)),
                              child: const Text(
                                "회원가입",
                                style:
                                    TextStyle(fontSize: 15, letterSpacing: 4.0),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              //회원가입 버튼

                              onPressed: () async {
                                final result = await Navigator.pushNamed(
                                    context, '/login');
                                print(result);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue[700],
                                  padding: const EdgeInsets.all(16.0),
                                  minimumSize: const Size(130, 25)),
                              child: const Text(
                                "취소",
                                style:
                                    TextStyle(fontSize: 15, letterSpacing: 4.0),
                              )),
                        ],
                      )
                    ],
                  )),
            ]),
          ),
        ));
  }
}
