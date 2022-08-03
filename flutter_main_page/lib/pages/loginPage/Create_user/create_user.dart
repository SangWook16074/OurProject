// ignore_for_file: use_build_context_synchronously

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
  final _userNumber = TextEditingController();
  final _userPass = TextEditingController();
  final _userPassAgain = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromARGB(255, 242, 239, 239),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.black,
                    ), // 나중에 로고
                    SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "아이디",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'hoon',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _userName,
                      onChanged: (text) {},
                      decoration: InputDecoration(
                          hintText: "이름 ex.홍길동",
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
                            onTap: () => _userName.clear(),
                          ),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "학번",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'hoon',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _userNumber,
                      onChanged: (text) {},
                      decoration: InputDecoration(
                          hintText: "학번 ex.2022XXXXX",
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
                    const SizedBox(height: 30),
                    const Text(
                      "비밀번호",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'hoon',
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      "영어 + 숫자 + 특수문자",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
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
                            onTap: () => _userPass.clear(),
                          ),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "비밀번호 재입력",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'hoon',
                        color: Colors.black,
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
                            onTap: () => _userPassAgain.clear(),
                          ),
                          filled: true,
                          fillColor: Colors.white),
                    ),

                    const SizedBox(
                      height: 30,
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
                          } else if (_userPass.text != _userPassAgain.text) {
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
                                    .doc(_userNumber.text)
                                    .get();

                            try {
                              if (userinfoData.exists) {
                                Fluttertoast.showToast(
                                  msg: "이미 계정이 있어요.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  fontSize: 16,
                                );
                              } else {
                                await firestore
                                    .collection('UserInfo')
                                    .doc(_userNumber.text)
                                    .set({
                                  'userName': _userName.text,
                                  'userNumber': _userNumber.text,
                                  'userPass': _userPass.text,
                                  'isAdmin': isAdmin,
                                });
                                Fluttertoast.showToast(
                                  msg: "생성 완료!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  fontSize: 16,
                                );
                                Navigator.pop(context);
                              }
                            } catch (err) {
                              Fluttertoast.showToast(
                                msg: "에러 타입 : $err",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 16,
                              );
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            padding: const EdgeInsets.all(16.0),
                            minimumSize: const Size(130, 25)),
                        child: const Text(
                          "회원가입",
                          style: TextStyle(fontSize: 15, letterSpacing: 4.0),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )),
          ),
        ));
  }
}
