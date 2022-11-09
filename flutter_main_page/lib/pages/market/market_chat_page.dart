import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/chat_bubble.dart';
import 'package:flutter_main_page/main.dart';

enum MenuItem { item1, item2 }

class ChatViewPage extends StatefulWidget {
  final String chatID;
  const ChatViewPage({Key? key, required this.chatID}) : super(key: key);

  @override
  State<ChatViewPage> createState() => _ChatViewPageState();
}

class _ChatViewPageState extends State<ChatViewPage> {
  TextEditingController _chat = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            (Platform.isIOS)
                ? IconButton(
                    onPressed: () {
                      buildIosPopUp();
                    },
                    icon: Icon(Icons.menu))
                : AndroidPopUp(),
          ],
          iconTheme: IconThemeData.fallback(),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            _buildChatBody(),
            _buildChatBottom(),
          ],
        ),
      ),
    );
  }

  void chatSend(String message) {
    var db =
        FirebaseFirestore.instance.collection('chat/${widget.chatID}/messages');
    db.add({'message': message, 'time': Timestamp.now(), 'userID': user!.uid});
  }

  Widget _buildChatBody() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chat/${widget.chatID}/messages')
              .orderBy(
                'time',
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                var data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return ChatBubble(
                    message: data['message'],
                    isMe: data['userID'].toString() == user!.uid);
              },
            );
          }),
    );
  }

  Widget _buildChatBottom() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
                maxLines: null,
                controller: _chat,
                decoration: InputDecoration(
                  hintText: '메시지 입력',
                )),
          ),
          SizedBox(
            width: 1,
          ),
          ElevatedButton(
            onPressed: () {
              if (_chat.text == '') {
                toastMessage('메시지를 입력하세요');
                return;
              }

              chatSend(_chat.text);
              setState(() {
                _chat.text = '';
              });
            },
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void _createItemDialog(String id, List hateUsers) {
    (Platform.isAndroid)
        ? showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [Text('대화방을 나가시겠습니까?')],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
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
            })
        : showCupertinoDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [Text('대화방을 나가시겠습니까?')],
                ),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text("확인")),
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("취소")),
                ],
              );
            });
  }

  Future<void> IosShowItemPopUp() async {
    final int? number = await showCupertinoModalPopup(
        context: context, builder: buildShowItemActionSheet);

    switch (number) {
      case 1:
        break;
      case 2:
        break;
      default:
    }
  }

  PopupMenuButton<MenuItem> AndroidPopUp() {
    return PopupMenuButton<MenuItem>(
      icon: Icon(Icons.menu),
      onSelected: (value) {
        if (value == MenuItem.item1) {}
        if (value == MenuItem.item2) {}
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text('거래 완료'),
          value: MenuItem.item1,
        ),
        PopupMenuItem(
          child: Text('대화방 나가기'),
          value: MenuItem.item2,
        ),
      ],
    );
  }

  void buildIosPopUp() {
    IosShowItemPopUp();
  }

  Widget buildShowItemActionSheet(BuildContext context) {
    return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop(1);
            },
            child: Text('거래완료'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop(2);
            },
            child: Text('대화방 나가기'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            '취소',
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ));
  }

  Widget buildNoShowItemActionSheet(BuildContext context) {
    return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop(1);
            },
            child: Text('차단해제'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            '취소',
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ));
  }
}
