import 'package:flutter/material.dart';

class MarketChatPage extends StatefulWidget {
  final String userNumber;
  const MarketChatPage({Key? key, required this.userNumber}) : super(key: key);

  @override
  State<MarketChatPage> createState() => _MarketChatPageState();
}

class _MarketChatPageState extends State<MarketChatPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('마켓 채팅'),
      ),
    );
  }
}
