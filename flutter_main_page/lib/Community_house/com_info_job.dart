import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Job {
  String title;
  String content;
  String author;
  String time;

  Job(this.title, this.content, this.author, this.time);
}

class InfoJobPage extends StatefulWidget {
  const InfoJobPage({Key? key}) : super(key: key);

  @override
  State<InfoJobPage> createState() => _InfoJobPageState();
}

class _InfoJobPageState extends State<InfoJobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "information of JOB",
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
                      .collection('job')
                      .orderBy('time', descending: true)
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
                      return _buildNonJob();
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
    final job = Job(doc['title'], doc['content'], doc['author'], doc['time']);
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => NoticeViewPage(
        //             notice.title, notice.content, notice.author, notice.time)));
      },
      title: Text(
        job.title,
        style: const TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "작성자 : ${job.author}",
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  Widget _buildNonJob() {
    return Center(
      child: Container(
        height: 500,
        child: const Center(
          child: Text(
            '아직 등록된 취업정보가 없습니다.',
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
