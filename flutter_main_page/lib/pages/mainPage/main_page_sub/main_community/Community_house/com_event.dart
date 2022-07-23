import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/View_pages/notice_view.dart';

class Event {
  String id;
  String title;
  String content;
  String author;
  String time;
  int countLike;
  List likedUsersList;

  Event(this.id, this.title, this.content, this.author, this.time,
      this.countLike, this.likedUsersList);
}

class EventPage extends StatefulWidget {
  final String userNumber;
  EventPage(this.userNumber, {Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  var _search = TextEditingController();
  String _searchContent = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
        body: Column(
          children: [
            _buildSearch(),
            _buildItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildItem() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('event')
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        var id = snapshot.data!.docs[index].id;

                        if (_searchContent.isEmpty) {
                          return _buildItemWidget(
                              id,
                              data['title'],
                              data['content'],
                              data['author'],
                              data['time'],
                              data['countLike'],
                              data['likedUsersList']);
                        }
                        if (data['title'].toString().contains(_searchContent)) {
                          return _buildItemWidget(
                              id,
                              data['title'],
                              data['content'],
                              data['author'],
                              data['time'],
                              data['countLike'],
                              data['likedUsersList']);
                        }
                        return Container();
                      });
            }),
      ),
    );
  }

  Widget _buildItemWidget(String id, String title, String content,
      String author, String time, int countLike, List likedUsersList) {
    return Column(
      children: [
        ListTile(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NoticeViewPage(title, content, author, time)));
            },
            title: Text(
              "[이벤트] $title",
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "작성자 : $author",
              style: const TextStyle(fontSize: 10),
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(countLike.toString()),
              IconButton(
                  icon: Icon(Icons.favorite,
                      color: likedUsersList.contains(widget.userNumber)
                          ? Colors.red
                          : Colors.grey),
                  onPressed: () {
                    _updatelikedUsersList(
                        id, widget.userNumber, likedUsersList);
                    _updatecountLike(id, likedUsersList);
                  }),
            ])),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }

  Widget _buildSearch() {
    return TextField(
      controller: _search,
      onChanged: (text) {
        setState(() {
          _searchContent = text;
        });
      },
      decoration: InputDecoration(
        hintText: "제목을 입력하세요.",
        prefixIcon: Icon(Icons.search),
      ),
    );
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
