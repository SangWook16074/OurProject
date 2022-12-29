import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/mainPage/main_home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  final String user;
  final bool isAdmin;
  final String userNumber;
  const OnBoardingPage(
      {Key? key,
      required this.user,
      required this.isAdmin,
      required this.userNumber})
      : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  var isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              if (index == 4) {
                setState(() {
                  isLastPage = true;
                });
              } else {
                setState(() {
                  isLastPage = false;
                });
              }
            },
            children: [
              _buildFirstPage(
                  urlImage: 'assets/Images/title.png',
                  title: '환영합니다!',
                  subtitle: '인덕정통에 가입하신것을 진심으로 환영합니다.'),
              _buildPage(
                  urlImage: 'assets/Images/page2.png',
                  title: '학생회 이벤트',
                  subtitle: '총학생회와 정보통신공학과 학생회가 진행하는 다양한 이벤트를 한눈에 볼 수 있습니다.'),
              _buildPage(
                  urlImage: 'assets/Images/page3.png',
                  title: '간단한 소통',
                  subtitle: '익명게시판을 통해 모르는 정보를 묻고, 친구들과 다양한 생각과 아이디어를 공유해보세요.'),
              _buildPage(
                  urlImage: 'assets/Images/page4.png',
                  title: '간단한 이동',
                  subtitle: '메인페이지 아이콘을 클릭하면 교내 서비스가 있는 다양한 페이지로 이동할 수 있습니다!'),
              _buildPage(
                  urlImage: 'assets/Images/page5.png',
                  title: '발전을 위해',
                  subtitle: '더 개선되고 다양한 서비스를 위해서 학생여러분들의 다양한 의견을 꼭 남겨주세요!'),
            ],
          ),
        ),
        bottomSheet: (isLastPage == true)
            ? TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blueGrey,
                  minimumSize: Size.fromHeight(80),
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                  Navigator.of(context).pushReplacement((Platform.isAndroid)
                      ? MaterialPageRoute(builder: (context) {
                          return MainHome(
                              user: widget.user,
                              isAdmin: widget.isAdmin,
                              userNumber: widget.userNumber);
                        })
                      : CupertinoPageRoute(builder: (context) {
                          return MainHome(
                              user: widget.user,
                              isAdmin: widget.isAdmin,
                              userNumber: widget.userNumber);
                        }));
                },
                child: Text(
                  '시작하기',
                  style:
                      GoogleFonts.doHyeon(textStyle: TextStyle(fontSize: 30)),
                ))
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.jumpToPage(4);
                        },
                        child: Text('SKIP')),
                    Center(
                        child: SmoothPageIndicator(
                      controller: controller,
                      count: 5,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.blueGrey),
                      onDotClicked: (index) {
                        controller.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                    )),
                    TextButton(
                        onPressed: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: Text('NEXT'))
                  ],
                ),
              ));
  }

  Widget _buildFirstPage(
      {required String urlImage,
      required String title,
      required String subtitle}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100, left: 8, right: 8, bottom: 8),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  urlImage,
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    subtitle,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage({
    required String urlImage,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 8, right: 8, bottom: 8),
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  subtitle,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Image.asset(
                urlImage,
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
