import 'package:flutter/material.dart';
// import 'package:flutter_main_page/main_page.dart';

final TextEditingController _textEditingController = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.red[50],
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          color: Colors.red[300],
                          height: 450,
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 50),
                            Container(
                              color: Colors.black,
                              width: 200,
                              height: 200,
                              margin: const EdgeInsets.all(30.0),
                            ),
                            const Text(
                              "인덕대학교",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Text(
                              "정보통신공학과",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0.0, 20.0, 10.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        labelText: "학번",
                                        hintText: "학번을 입력하세요.",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0))),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.redAccent,
                                                width: 2.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0))),
                                        suffixIcon: GestureDetector(
                                          child: const Icon(
                                            Icons.clear,
                                            color: Colors.redAccent,
                                            size: 20,
                                          ),
                                          onTap: () =>
                                              _textEditingController.clear(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextField(
                                      onChanged: (value) {},
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: "비밀번호",
                                        hintText: "비밀번호를 입력하세요.",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0))),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.redAccent,
                                                width: 2.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0))),
                                        suffixIcon: GestureDetector(
                                          child: const Icon(
                                            Icons.clear,
                                            color: Colors.redAccent,
                                            size: 20,
                                          ),
                                          onTap: () =>
                                              _textEditingController.clear(),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            ElevatedButton(
                                //로그인 버튼
                                onPressed: () async {
                                  //회원확인 절차 넣을것임

                                  await Navigator.pushNamed(context, '/main');
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.red[400],
                                    padding: const EdgeInsets.all(16.0),
                                    minimumSize: const Size(400, 25)),
                                child: const Text(
                                  "로그인",
                                  style: TextStyle(
                                      fontSize: 15, letterSpacing: 4.0),
                                )),
                            TextButton(
                              //회원가입 버튼
                              onPressed: () {
                                //회원가입 메소드
                              },
                              style: TextButton.styleFrom(),
                              child: Text(
                                "회원가입",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.red[400]),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
