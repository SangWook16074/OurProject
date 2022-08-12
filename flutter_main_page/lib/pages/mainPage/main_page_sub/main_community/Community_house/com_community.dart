import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/View_pages/com_view.dart';

class Com {
  String title;
  String content;
  String author;
  String time;
  int countLike;
  List likedUsersList;

  Com(this.title, this.author, this.content, this.time, this.countLike,
      this.likedUsersList);
}

class ComPage extends StatefulWidget {
  final String userNumber;
  ComPage(this.userNumber, {Key? key}) : super(key: key);

  @override
  State<ComPage> createState() => _ComPageState();
}

class _ComPageState extends State<ComPage> {
  var _search = TextEditingController();
  String _searchContent = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.edit),
          label: Text("글쓰기"),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          iconTheme: IconThemeData.fallback(),
          backgroundColor: Colors.white,
          title: const Text(
            "커뮤니티",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'hoon',
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _buildItem(),
          ],
        ));
  }

  Widget _buildItem() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('com')
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

                        if (snapshot.hasData) {
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
                    builder: (context) => ComViewPage(
                        title: title,
                        content: content,
                        author: '익명',
                        time: time,
                        id: id,
                        user: widget.userNumber)));
          },
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "익명 | $time",
            style: const TextStyle(fontSize: 10),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(countLike.toString()),
              IconButton(
                  icon: Icon(
                    Icons.favorite,
                    size: 20,
                    color: likedUsersList.contains(widget.userNumber)
                        ? Colors.red
                        : Colors.grey,
                  ),
                  onPressed: () {
                    _updatelikedUsersList(
                        id, widget.userNumber, likedUsersList);
                    _updatecountLike(id, likedUsersList);
                  }),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }

  void _updatecountLike(String docID, List likedUsersList) {
    FirebaseFirestore.instance
        .collection('com')
        .doc(docID)
        .set({'countLike': likedUsersList.length}, SetOptions(merge: true));
  }

  _updatelikedUsersList(String docID, String userNumber, List usersList) {
    FirebaseFirestore.instance.collection('com').doc(docID)
        // .set({'likedUsersMap': userNumber}, SetOptions(merge: true));
        .set({'likedUsersList': userCheck(usersList, userNumber)},
            SetOptions(merge: true));
  }
}

userCheck(List usersList, String userNumber) {
  if (usersList.contains(userNumber)) {
    usersList.remove(userNumber);
  } else {
    usersList.add(userNumber);
  }
  return usersList;
}
