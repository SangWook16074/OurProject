import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

class Chat {
  String chat;
  String time;
  String author;

  Chat(this.chat, this.time, this.author);
}

class ComViewPage extends StatefulWidget {
  final String title;
  final String content;
  final String author;
  final String time;
  final String? id;
  final String? user;
  const ComViewPage(
      {Key? key,
      required this.title,
      required this.content,
      required this.author,
      required this.time,
      this.id,
      this.user})
      : super(key: key);

  @override
  State<ComViewPage> createState() => _ComViewPageState();
}

class _ComViewPageState extends State<ComViewPage> {
  var _now;
  final _chat = TextEditingController();

  void _addChat(String chat, String time, String author) {
    var db = FirebaseFirestore.instance.collection("com");

    db.doc(widget.id).collection('chat').add({
      "chat": chat,
      "time": time,
      "author": author,
    });
    toastMessage('댓글이 등록되었습니다');
    _chat.text = '';
  }

  void _deleteChatDialog(DocumentSnapshot doc) {
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
              children: const [Text('정말로 삭제하시겠습니까?')],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _deleteChat(doc.id);
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

  void _deleteChat(String id) {
    var db = FirebaseFirestore.instance.collection("com");

    db.doc(widget.id).collection('chat').doc(id).delete();
    Fluttertoast.showToast(
      msg: "댓글이 삭제되었습니다.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
    );
  }

  BannerAd? banner;

  @override
  void initState() {
    super.initState();
    banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: UNIT_ID[Platform.isIOS ? 'ios' : 'android']!,
        listener: BannerAdListener(),
        request: AdRequest())
      ..load();
  }

  @override
  dispose() {
    _chat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.white,
        title: const Text(
          "익명글",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontFamily: 'hoon',
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          title: Text(
                            widget.author,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            widget.time,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        ListTile(
                          title: Text(
                            widget.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text(
                            widget.content,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 50,
                          child: this.banner != null
                              ? AdWidget(ad: banner!)
                              : Container(),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Container(
                          child: Text("악의적인 목적의 비난, 비방글은 관리자에 의해 삭제될 수 있습니다."),
                        ),
                      ],
                    ),
                  ),
                  _buildComChat(),
                ],
              ),
            ),
            _buildChatSend(),
          ],
        ),
      ),
    );
  }

  Widget _buildComChat() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('com/${widget.id}/chat')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              height: 280,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final documents = snapshot.data!.docs;
          if (documents.isEmpty) {
            return _buildNonChat();
          } else {
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: documents.map((doc) => _buildChat(doc)).toList(),
            );
          }
        });
  }

  Widget _buildChat(DocumentSnapshot doc) {
    final chat = Chat(doc['chat'], doc['time'], doc['author']);

    if (doc['author'] == widget.user) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),
        child: ListTile(
          title: Column(
            children: [
              Row(
                children: [
                  Text(
                    chat.author.contains(widget.user!) ? "나" : "익명",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    chat.chat,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Text(chat.time),
          trailing: IconButton(
            icon: Icon(
              Icons.highlight_off,
              color: Colors.red,
            ),
            onPressed: () {
              _deleteChatDialog(doc);
            },
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),
        child: ListTile(
          title: Column(
            children: [
              Row(
                children: [
                  Text(
                    chat.author.contains(widget.user!) ? "나" : "익명",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    chat.chat,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Text(chat.time),
        ),
      );
    }
  }

  Widget _buildNonChat() {
    return ListTile(
      title: Center(child: Text('등록된 댓글이 없습니다')),
    );
  }

  Widget _buildChatSend() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextField(
              controller: _chat,
              onChanged: (text) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: '댓글을 입력하세요', filled: true, fillColor: Colors.white),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          ElevatedButton(
            //취소 버튼

            onPressed: () async {
              if (_chat.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: "내용을 입력하세요.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  fontSize: 16,
                );
              } else {
                setState(() {
                  _now = DateFormat('yyyy-MM-dd - HH:mm:ss')
                      .format(DateTime.now());
                });
                _addChat(_chat.text, _now.toString(), widget.user!);
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blueGrey,
            ),
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
