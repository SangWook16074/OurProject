import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Chat {
  String chat;
  String time;

  Chat(this.chat, this.time);
}

class ComViewPage extends StatefulWidget {
  final String title;
  final String content;
  final String author;
  final String time;
  final String id;
  const ComViewPage(this.title, this.content, this.author, this.time, this.id,
      {Key? key})
      : super(key: key);

  @override
  State<ComViewPage> createState() => _ComViewPageState();
}

class _ComViewPageState extends State<ComViewPage> {
  var _now;
  final _chat = TextEditingController();

  void _addChat(String chat, String time) {
    var db = FirebaseFirestore.instance.collection("com");

    db.doc(widget.id).collection('chat').add({
      "chat": chat,
      "time": time,
    });
    Fluttertoast.showToast(
      msg: "새 댓글이 등록되었습니다.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
    );
    _chat.text = '';
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
  dispose() {
    _chat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Content",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
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
                          title: Row(
                            children: [
                              Icon(
                                Icons.account_box_rounded,
                                size: 40,
                                color: Colors.blueAccent,
                              ),
                              Text(
                                widget.author,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            widget.time,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey),
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
            .orderBy('time', descending: true)
            .limit(5)
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
    final chat = Chat(doc['chat'], doc['time']);

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
                Icon(
                  Icons.account_box_rounded,
                  size: 30,
                  color: Colors.blueAccent,
                ),
                Text(
                  widget.author,
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
                _addChat(_chat.text, _now.toString());
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
