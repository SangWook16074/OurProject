// ignore_for_file: unused_field, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:flutter_main_page/main_page.dart';

var isChecked = false;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _textEditingControllerUser = TextEditingController();
  final _textEditingControllerPassWd = TextEditingController();

  bool isValid() {
    return (_textEditingControllerPassWd.text.isEmpty);
  }

  @override
  void dispose() {
    _textEditingControllerUser.dispose();
    _textEditingControllerPassWd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.blue[400],
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      color: Colors.black,
                      width: 200,
                      height: 200,
                      margin: const EdgeInsets.all(30.0),
                    ), //로고 넣을 것임.
                    const Text(
                      "Induk Univ.",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Pacifico',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Text(
                      "Information and Communication",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Pacifico',
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: _textEditingControllerUser,
                              onChanged: (text) {},
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.account_circle),
                                  hintText: "학번을 입력하세요.",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent, width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))),
                                  suffixIcon: GestureDetector(
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.blueAccent,
                                      size: 20,
                                    ),
                                    onTap: () =>
                                        _textEditingControllerUser.clear(),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextField(
                              controller: _textEditingControllerPassWd,
                              onChanged: (text) {},
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  hintText: "비밀번호를 입력하세요.",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent, width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))),
                                  suffixIcon: GestureDetector(
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.blueAccent,
                                      size: 20,
                                    ),
                                    onTap: () =>
                                        _textEditingControllerPassWd.clear(),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                          ],
                        )),
                    ElevatedButton(
                        //로그인 버튼

                        onPressed: () async {
                          //회원확인 절차 넣을것임
                          if (_textEditingControllerPassWd.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "비밀번호를 입력하세요.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16,
                            );
                          } else {
                            DocumentSnapshot userInfoData =
                                await FirebaseFirestore.instance
                                    .collection('UserInfo')
                                    .doc(_textEditingControllerUser.text)
                                    .get();

                            if (_textEditingControllerPassWd.text !=
                                userInfoData['userPass']) {
                              Fluttertoast.showToast(
                                msg: "비밀번호가 다릅니다.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 16,
                              );
                            } else {
                              final result =
                                  // ignore: use_build_context_synchronously
                                  await Navigator.pushNamed(context, '/main');
                              print(result);
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            padding: const EdgeInsets.all(16.0),
                            minimumSize: const Size(355, 25)),
                        child: const Text(
                          "로그인",
                          style: TextStyle(fontSize: 15, letterSpacing: 4.0),
                        )),
                    TextButton(
                      //회원가입 버튼
                      onPressed: () {
                        final result = Navigator.pushNamed(context, '/creat');
                        print(result);
                      },
                      style: TextButton.styleFrom(),
                      child: const Text(
                        "회원가입",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
