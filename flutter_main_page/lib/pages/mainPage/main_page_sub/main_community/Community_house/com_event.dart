import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/View_pages/notice_view.dart';

class Event {
  String title;
  String content;
  String author;
  String time;
  int countLike;
  List likedUsersList;

  Event(this.title, this.content, this.author, this.time, this.countLike,
      this.likedUsersList);
}

class EventPage extends StatefulWidget {
  final String userNumber;
  EventPage(this.userNumber, {Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "EVENT",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('event')
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return _loading();
              }
              final documents = snapshot.data!.docs;
              if (documents.isEmpty) {
                return _buildNonEvent();
              } else {
                return ListView(
                  shrinkWrap: true,
                  children:
                      documents.map((doc) => _buildItemWidget(doc)).toList(),
                );
              }
            }),
      ),
    );
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final document = doc.data() as Map<String, dynamic>;
    final event = new Event(
        document['title'],
        document['content'],
        document['author'],
        document['time'],
        document['countLike'] ?? 0,
        document['likedUsersList'] ?? []);
    return Column(
      children: [
        ListTile(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NoticeViewPage(event.title,
                          event.content, event.author, event.time)));
            },
            title: Text(
              "[이벤트] ${event.title}",
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "작성자 : ${event.author}",
              style: const TextStyle(fontSize: 10),
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(event.countLike.toString()),
              IconButton(
                  icon: Icon(Icons.favorite,
                      color: event.likedUsersList.contains(widget.userNumber)
                          ? Colors.red
                          : Colors.grey),
                  onPressed: () {
                    _updatelikedUsersList(
                        doc.id, widget.userNumber, event.likedUsersList);
                    _updatecountLike(doc.id, event.likedUsersList);
                  }),
            ])),
        Divider(
          color: Colors.grey,
        )
      ],
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

  Widget _loading() {
    return Center(child: CircularProgressIndicator());
  }
}

void _updatecountLike(String docID, List likedUsersList) {
  FirebaseFirestore.instance
      .collection('event')
      .doc(docID)
      .set({'countLike': likedUsersList.length}, SetOptions(merge: true));
}

_updatelikedUsersList(String docID, String userNumber, List usersList) {
  FirebaseFirestore.instance.collection('event').doc(docID)
      // .set({'likedUsersMap': userNumber}, SetOptions(merge: true));
      .set({'likedUsersList': userCheck(usersList, userNumber)},
          SetOptions(merge: true));
}

userCheck(List usersList, String userNumber) {
  if (usersList.contains(userNumber)) {
    usersList.remove(userNumber);
  } else {
    usersList.add(userNumber);
  }
  return usersList;
}
