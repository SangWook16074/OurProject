import 'package:flutter/material.dart';

class NoticeViewPage extends StatefulWidget {
  final String title;
  final String content;
  final String author;
  final String time;
  const NoticeViewPage(this.title, this.content, this.author, this.time,
      {Key? key})
      : super(key: key);

  @override
  State<NoticeViewPage> createState() => _NoticeViewPageState();
}

class _NoticeViewPageState extends State<NoticeViewPage> {
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
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Colors.black, width: 3)),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  "[${widget.author}]",
                  style: const TextStyle(color: Colors.blue, fontSize: 20),
                ),
                Text(
                  widget.time,
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  widget.content,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "확인",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
