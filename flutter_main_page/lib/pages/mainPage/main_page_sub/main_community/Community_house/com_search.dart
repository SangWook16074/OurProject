import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final String topic;
  const SearchPage({Key? key, required this.topic}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  Widget _buildNonItem() {
    return const SizedBox(
      height: 280,
      child: Center(
          child: Text(
        '검색결과가 없습니다.',
        style: TextStyle(
            color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
      )),
    );
  }
}
