import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/View_pages/com_view.dart';

class Com {
  String title;
  String content;
  String author;
  String time;

  Com(this.title, this.author, this.content, this.time);
}

class MyContentDeletePage extends StatefulWidget {
  final String user;
  MyContentDeletePage(this.user, {Key? key}) : super(key: key);

  @override
  State<MyContentDeletePage> createState() => _MyContentDeletePageState();
}

class _MyContentDeletePageState extends State<MyContentDeletePage> {
  void _deleteItemDialog(DocumentSnapshot doc) {
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
                    _deleteItem(doc);
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

  void _deleteItem(DocumentSnapshot doc) async {
    FirebaseFirestore.instance.collection('com').doc(doc.id).delete();
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection = instance.collection('com/${doc.id}/chat');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.white,
        title: const Text(
          "내가 쓴 글",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontFamily: 'hoon',
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('com')
              .where('number', isEqualTo: widget.user)
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Container(child: const CircularProgressIndicator()));
            }
            final documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return _buildNonEvent();
            } else {
              return ListView(
                shrinkWrap: true,
                children:
                    documents.map((doc) => _buildEventWidget(doc)).toList(),
              );
            }
          }),
    );
  }

  Widget _buildEventWidget(DocumentSnapshot doc) {
    final com = Com(doc['title'], doc['author'], doc['content'], doc['time']);
    return Column(
      children: [
        ListTile(
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ComViewPage(
                        title: com.title,
                        content: com.content,
                        author: com.author,
                        time: com.time,
                        id: doc.id,
                        user: widget.user)));
          },
          title: Text(
            com.title,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "익명",
            style: const TextStyle(fontSize: 10),
          ),
          trailing: IconButton(
            onPressed: () {
              _deleteItemDialog(doc);
            },
            icon: Icon(Icons.delete),
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget _buildNonEvent() {
    return Center(
      child: Container(
        child: const Center(
          child: Text(
            '등록한 글이 없습니다.',
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
