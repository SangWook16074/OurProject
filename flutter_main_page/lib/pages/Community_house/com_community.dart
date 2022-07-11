import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Com {
  String title;
  String content;
  String time;

  Com(this.title, this.content, this.time);
}

class ComPage extends StatefulWidget {
  const ComPage({Key? key}) : super(key: key);

  @override
  State<ComPage> createState() => _ComPageState();
}

class _ComPageState extends State<ComPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Community",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: ListView(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('com')
                      .orderBy('time', descending: true)
                      .limit(5)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Container(
                              height: 250,
                              width: 250,
                              child: const CircularProgressIndicator()));
                    }
                    final documents = snapshot.data!.docs;
                    if (documents.isEmpty) {
                      return _buildNonEvent();
                    } else {
                      return ListView(
                        shrinkWrap: true,
                        children: documents
                            .map((doc) => _buildItemWidget(doc))
                            .toList(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final com = Com(doc['title'], doc['content'], doc['time']);
    return SizedBox(
      height: 500,
      child: ListTile(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => NoticeViewPage(
          //             notice.title, notice.content, notice.author, notice.time)));
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
      ),
    );
  }

  Widget _buildNonEvent() {
    return Center(
      child: Container(
        height: 500,
        child: const Center(
          child: Text(
            '아직 등록된 이벤트가 없습니다.',
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
