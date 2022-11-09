import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/loginPage/login_page.dart';
import 'package:flutter_main_page/pages/market/market_chat_page.dart';

class MarketChatPage extends StatefulWidget {
  final String userNumber;
  const MarketChatPage({Key? key, required this.userNumber}) : super(key: key);

  @override
  State<MarketChatPage> createState() => _MarketChatPageState();
}

class _MarketChatPageState extends State<MarketChatPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .where('listner', arrayContains: widget.userNumber)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  var id = snapshot.data!.docs[index].id.toString();

                  return _buildChatItem(
                    id,
                  );
                });
          }
          return _buildNonItem();
        });
  }

  Widget _buildChatItem(
    String id,
  ) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push((Platform.isAndroid)
            ? MaterialPageRoute(builder: (context) {
                return ChatViewPage(
                  chatID: id,
                );
              })
            : CupertinoPageRoute(builder: (context) {
                return ChatViewPage(
                  chatID: id,
                );
              }));
      },
      title: Text(id),
    );
  }

  Widget _buildNonItem() {
    return Container(
      child: Text(
        '등록된 채팅이 없습니다.',
      ),
    );
  }
}
