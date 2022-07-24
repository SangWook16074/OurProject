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
        body: Column(
          children: [
            _buildSearch(),
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
                    builder: (context) => ComViewPage(
                        title, content, '익명', time, id, widget.userNumber)));
          },
          title: Text(
            "[익명] $title",
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "익명",
            style: const TextStyle(fontSize: 10),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(countLike.toString()),
              IconButton(
                  icon: Icon(
                    Icons.favorite,
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

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
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
      ),
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
