// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class NoticeWrite {
  String title;
  String content;
  String time;

  NoticeWrite(this.title, this.content, this.time);
}

class WriteNotice extends StatefulWidget {
  final String user;
  final bool? isAdmin;
  WriteNotice(this.user, this.isAdmin, {Key? key}) : super(key: key);

  @override
  State<WriteNotice> createState() => _WriteNoticeState();
}

class _WriteNoticeState extends State<WriteNotice> {
  var _now;
  final _title = TextEditingController();
  final _content = TextEditingController();

  Future<bool> callOnFcmApiSendPushNotifications(
      {required String title, required String body}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "to": "/topics/connectTopic",
      "notification": {
        "title": title,
        "body": body,
      },
      "data": {
        
        "type": '0rder',
        "id": '28',
        "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAA4skJqo4:APA91bFmXAZAeG3JGPd5Dym_iILSxUTAwi1mQwxOCz9CuQG9wvAB2Y1lnT_CZv_uOFuWJtpFm3QomTu28sE9C9jWEi1nz3QVTEzL7Ym765LQoTtG9aqYkHYV83fW87P0_mj3eNpPtw5M' // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error');
      // on failure do sth
      return false;
    }
  }

  void _createItemDialog(NoticeWrite notice, String user) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('공지를 등록하시겠습니까? 등록된 공지는 내정보 페이지에서 관리할 수 있습니다.')
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    callOnFcmApiSendPushNotifications(
                          title: '새 공지사항이 등록되었습니다.', body: notice.title);

                    _addNotice(notice, user);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text("확인")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("취소")),
            ],
          );
        });
  }

  void _addNotice(NoticeWrite notice, String user) {
    FirebaseFirestore.instance.collection('notice').add({
      'title': "[공지사항] ${notice.title}",
      'content': notice.content,
      'author': user,
      'time': notice.time,
    });
    Fluttertoast.showToast(
      msg: "새 공지가 등록되었습니다.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
    );
    _title.text = '';
    _content.text = '';
  }

  @override
  void initState() {
    Timer.periodic((const Duration(seconds: 1)), (v) {
      if (mounted) {
        setState(() {
          _now = DateFormat('yyyy-MM-dd - HH:mm:ss').format(DateTime.now());
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
      backgroundColor: Colors.white,
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
        actions: [
          IconButton(
              onPressed: () {
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
                } else {
                  _createItemDialog(
                      NoticeWrite(_title.text, _content.text, _now.toString()),
                      widget.user);
                }
              },
              icon: Icon(Icons.check))
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: [
            Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                ),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    TextField(
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      minLines: 1,
                      maxLines: 10,
                      controller: _title,
                      onChanged: (text) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                          hintText: "제목",
                          hintStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      minLines: 15,
                      maxLines: 100,
                      controller: _content,
                      onChanged: (text) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                          hintText: "내용을 입력하세요",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
