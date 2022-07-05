// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final items = <Notice>[];

class Notice {
  String title;
  String content;
  String author;
  String authorNumber;
  String time;

  Notice(this.title, this.content, this.author, this.authorNumber, this.time);
}

// class NoticeViewPage extends StatefulWidget {
//   const NoticeViewPage({Key? key}) : super(key: key);

//   @override
//   State<NoticeViewPage> createState() => _NoticeViewPageState();
// }

// class _NoticeViewPageState extends State<NoticeViewPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 40,
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: Center(
//               child: const Text(
//                 "공지사항",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           StreamBuilder<QuerySnapshot>(
//               stream:
//                   FirebaseFirestore.instance.collection('notice').snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const CircularProgressIndicator();
//                 }
//                 final documents = snapshot.data!.docs;
//                 return Expanded(
//                   child: ListView(
//                     children:
//                         documents.map((doc) => _buildItemWidget(doc)).toList(),
//                   ),
//                 );
//               }),
//         ],
//       ),
//     ));
//   }

//   Widget _buildItemWidget(DocumentSnapshot doc) {
//     final notice = Notice(doc['title'], doc['content']);
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Container(
//             width: 380,
//             height: 60,
//             padding: const EdgeInsets.all(8.0),
//             margin: const EdgeInsets.all(8.0),
//             child:
//                 // ignore: prefer_const_constructors
//                 Align(
//               alignment: Alignment.topLeft,
//               child: Text(
//                 notice.title,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           Container(
//             width: 380,
//             padding: const EdgeInsets.all(8.0),
//             margin: const EdgeInsets.all(8.0),
//             child:
//                 // ignore: prefer_const_constructors
//                 Align(
//               alignment: Alignment.topLeft,
//               child: Text(
//                 notice.content,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  var search = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "NOTICE",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Column(
            children: [
              TextField(
                controller: search,
                onChanged: (text) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    hintText: "제목 검색",
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    suffixIcon: GestureDetector(
                        child: const Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                          size: 20,
                        ),
                        onTap: () {
                          //제목 포함 내용 찾기 기능
                        }),
                    filled: true,
                    fillColor: Colors.white),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('notice')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    final documents = snapshot.data!.docs;
                    return Expanded(
                      child: ListView(
                        children: documents
                            .map((doc) => _buildItemWidget(doc))
                            .toList(),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //글쓰기 페이지 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WriteNotice()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final notice = Notice(doc['title'], doc['content'], doc['author'],
        doc['authorNumber'], doc['time']);
    return ListTile(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const NoticeViewPage()));
      },
      title: Text(
        notice.title,
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Text(
        "작성자 : ${notice.author}",
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}

class WriteNotice extends StatefulWidget {
  const WriteNotice({Key? key}) : super(key: key);

  @override
  State<WriteNotice> createState() => _WriteNoticeState();
}

class _WriteNoticeState extends State<WriteNotice> {
  var _now = DateTime.now();
  final _title = TextEditingController();
  final _content = TextEditingController();
  final _author = TextEditingController();
  final _authorNumber = TextEditingController();

  void _addNotice(Notice notice) {
    FirebaseFirestore.instance.collection('notice').add({
      'title': "[공지사항] ${notice.title}",
      'content': notice.content,
      'author': notice.author,
      'authorNumber': notice.authorNumber,
      'time': notice.time,
    });
    _title.text = '';
    _content.text = '';
    _author.text = '';
    _authorNumber.text = '';
  }

  @override
  void initState() {
    Timer.periodic((const Duration(seconds: 1)), (v) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "NOTICE",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "작성자학번 : ",
                    style: TextStyle(fontSize: 15),
                  ),
                  Container(
                    width: 275,
                    child: TextField(
                      controller: _authorNumber,
                      onChanged: (text) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                          hintText: "학번",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0))),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0))),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "작성자 : ",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 275,
                    child: TextField(
                      controller: _author,
                      onChanged: (text) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                          hintText: "이름",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0))),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0))),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 360,
              child: TextField(
                controller: _title,
                onChanged: (text) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                    hintText: "글 제목",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 360,
              child: TextField(
                controller: _content,
                maxLength: 300,
                maxLines: 30,
                onChanged: (text) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    ElevatedButton(

                        //글 작성 버튼

                        onPressed: () async {
                          if (_title.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "제목을 입력하세요.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16,
                            );
                          } else if (_content.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "내용을 입력하세요.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16,
                            );
                          } else if (_author.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "작성자를 입력하세요.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16,
                            );
                          } else if (_authorNumber.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "작성자의 학번을 입력하세요.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16,
                            );
                          } else {
                            DocumentSnapshot userInfoData =
                                await FirebaseFirestore.instance
                                    .collection('UserInfo')
                                    .doc(_authorNumber.text)
                                    .get();

                            if (userInfoData['isAdmin'] != true) {
                              Fluttertoast.showToast(
                                msg: "관리자만 작성할 수 있습니다.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 16,
                              );
                            }
                            _addNotice(Notice(
                                _title.text,
                                _content.text,
                                _author.text,
                                _authorNumber.text,
                                _now.toString()));
                            Navigator.pop(context);
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            padding: const EdgeInsets.all(16.0),
                            minimumSize: const Size(130, 25)),
                        child: const Text(
                          "완료",
                          style: TextStyle(fontSize: 20, letterSpacing: 4.0),
                        )),
                    const SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(
                        //회원가입 버튼

                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            padding: const EdgeInsets.all(16.0),
                            minimumSize: const Size(130, 25)),
                        child: const Text(
                          "취소",
                          style: TextStyle(fontSize: 20, letterSpacing: 4.0),
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
