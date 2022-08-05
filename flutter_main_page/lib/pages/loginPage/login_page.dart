import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';
import 'package:flutter_main_page/pages/loginPage/Create_user/create_user.dart';
import '../mainPage/main_page_sub/main_home/main_home.dart';

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
  int currentStep = 0;
  late bool autoLoginStatus;
  late String userNumber;
  late String user;
  late bool isAdmin;
  final _textEditingControllerUser = TextEditingController();
  final _textEditingControllerPassWd = TextEditingController();

  @override
  void initState() {
    super.initState();
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
  void dispose() {
    _textEditingControllerUser.dispose();
    _textEditingControllerPassWd.dispose();
    _textEditingControllerPassWd.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (prefs.getBool('autoLoginStatus') == true) {
      return MainHome(
          userNumber: prefs.getString('userNumber').toString(),
          user: prefs.getString('user').toString(),
          isAdmin: prefs.getBool('isAdmin')!);
    } else {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(children: [
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 250),
                      //로고 넣을 것임.
                      const Text(
                        "인덕대학교",
                        style: TextStyle(
                            fontSize: 60,
                            fontFamily: 'Dokdo',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const Text(
                        "Information and Communication",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Pacifico',
                            color: Colors.black),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                          child: Column(
                            children: [
                              TextField(
                                controller: _textEditingControllerUser,
                                keyboardType: TextInputType.number,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.account_circle),
                                    hintText: "학번을 입력하세요.",
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0))),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0))),
                                    suffixIcon: GestureDetector(
                                      child: const Icon(
                                        Icons.clear,
                                        color: Colors.black,
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
                                onChanged: (text) {
                                  setState(() {});
                                },
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
                                          color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0))),
                                    suffixIcon: GestureDetector(
                                      child: const Icon(
                                        Icons.clear,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      onTap: () =>
                                          _textEditingControllerPassWd.clear(),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white),
                              ),
                              Row(
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
                                        color: Colors.black,
                                        letterSpacing: (4.0)),
                                  )
                                ],
                              )
                            ],
                          )),
                      ElevatedButton(
                          //로그인 버튼

                          onPressed: () async {
                            //회원확인 절차 넣을것임
                            if (_textEditingControllerUser.text.isEmpty) {
                              toastMessage("학번을 입력하세요.");
                              return;
                            }
                            if (_textEditingControllerPassWd.text.isEmpty) {
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
                              if (_textEditingControllerPassWd.text !=
                                  userInfoData['userPass']) {
                                toastMessage("비밀번호가 다릅니다.");
                                return;
                              }
                              if (isChecked == true) {
                                _updateAutoLoginStatus(isChecked);
                                _saveUserData(
                                    userInfoData['userNumber'],
                                    userInfoData['userName'],
                                    userInfoData['isAdmin']);
                              }

                              prefs.setString(
                                  'userNumber', userInfoData['userNumber']);
                              prefs.setInt('index', prefs.getInt('index') ?? 1);

                              toastMessage("환영합니다!");

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainHome(
                                          userNumber: userInfoData.id,
                                          user: userInfoData['userName'],
                                          isAdmin: userInfoData['isAdmin'])));

                              _textEditingControllerUser.clear();
                              _textEditingControllerPassWd.clear();
                            } catch (err) {
                              toastMessage("에러타입 : $err\n잠시후에 다시 시도해주세요.");
                            }
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              padding: const EdgeInsets.all(16.0),
                              minimumSize: const Size(355, 25)),
                          child: const Text(
                            "로그인",
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 4.0,
                                color: Colors.black),
                          )),
                      TextButton(
                        //회원가입 버튼
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateUserPage()));
                        },
                        style: TextButton.styleFrom(),
                        child: const Text(
                          "회원가입",
                          style: TextStyle(fontSize: 15, color: Colors.black),
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
}
