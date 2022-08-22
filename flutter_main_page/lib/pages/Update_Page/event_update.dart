import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Event {
  String title;
  String content;
  String author;
  String time;

  Event(this.title, this.author, this.content, this.time);
}

class EventUpdatePage extends StatefulWidget {
  final String docID;
  final String title;
  final String content;
  const EventUpdatePage(this.docID, this.title, this.content, {Key? key})
      : super(key: key);

  @override
  State<EventUpdatePage> createState() => _EventUpdatePageState();
}

class _EventUpdatePageState extends State<EventUpdatePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  void _updateContent(String docID, String title, String content) {
    FirebaseFirestore.instance
        .collection('event')
        .doc(docID)
        .update({"title": title, "content": content});
    _titleController.text = '';
    _contentController.text = '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.white,
        title: const Text(
          "이벤트 수정",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontFamily: 'hoon',
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (_titleController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "제목을 입력하세요.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    fontSize: 16,
                  );
                } else if (_contentController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "내용을 입력하세요.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    fontSize: 16,
                  );
                } else {
                  //수정하기
                  _updateContent(widget.docID, _titleController.text,
                      _contentController.text);
                  Fluttertoast.showToast(
                    msg: "수정이 완료되었습니다.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    fontSize: 16,
                  );

                  Navigator.pop(context);
                }
              },
              icon: Icon(Icons.check)),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
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
                      controller: _titleController,
                      onChanged: (text) {},
                      decoration: const InputDecoration(
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
                      controller: _contentController,
                      onChanged: (text) {},
                      decoration: const InputDecoration(
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
