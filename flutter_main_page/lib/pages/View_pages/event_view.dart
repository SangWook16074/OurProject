import 'package:flutter/material.dart';

class EventViewPage extends StatefulWidget {
  final String title;
  final String content;
  final String author;
  final String time;
  const EventViewPage(this.title, this.content, this.author, this.time,
      {Key? key})
      : super(key: key);

  @override
  State<EventViewPage> createState() => _EventViewPageState();
}

class _EventViewPageState extends State<EventViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
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
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "[${widget.author}]",
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 15),
                ),
                Text(
                  widget.time,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
                Divider(
                  color: Colors.grey,
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
                SizedBox(
                  height: 40,
                ),
                Divider(
                  color: Colors.grey,
                ),
                ElevatedButton(
                    //취소 버튼

                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "목록",
                          style: TextStyle(fontSize: 15, letterSpacing: 4.0),
                        ),
                        Icon(Icons.reorder),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
