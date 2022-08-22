import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/View_pages/com_view.dart';
import 'package:flutter_main_page/pages/WritePages/com_write_com.dart';
import '../../custom_page_route.dart';
import 'com_search.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.edit),
          label: Text("글쓰기"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (contexst) {
              return WriteComPage(userNumber: widget.userNumber);
            }));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CustomPageRightRoute(
                          child: SearchPage(
                        topic: 'com',
                      )));
                },
                icon: Icon(Icons.search))
          ],
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
                          if (data['url'] == "") {
                            return _buildItemWidget(
                              id,
                              data['title'],
                              data['content'],
                              data['author'],
                              data['time'],
                              data['countLike'],
                              data['likedUsersList'],
                            );
                          } else {
                            return _buildItemImageWidget(
                                id,
                                data['title'],
                                data['content'],
                                data['author'],
                                data['time'],
                                data['countLike'],
                                data['likedUsersList'],
                                data['url']);
                          }
                        }

                        return Container();
                      });
            }),
      ),
    );
  }

  Widget _buildItemImageWidget(
      String id,
      String title,
      String content,
      String author,
      String time,
      int countLike,
      List likedUsersList,
      String? url) {
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
                        url: url!,
                        user: widget.userNumber,
                        countLike: countLike,
                        likedUsersList: likedUsersList)));
          },
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "익명 | $time",
                style: const TextStyle(fontSize: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.thumb_up, size: 15, color: Colors.purple),
                  Text('  $countLike')
                ],
              )
            ],
          ),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: 70,
                        child: CachedNetworkImage(
                          imageUrl: url!,
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) => Container(
                            color: Colors.black,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ))),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }

  Widget _buildItemWidget(
    String id,
    String title,
    String content,
    String author,
    String time,
    int countLike,
    List likedUsersList,
  ) {
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
                        user: widget.userNumber,
                        countLike: countLike,
                        likedUsersList: likedUsersList)));
          },
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "익명 | $time",
                style: const TextStyle(fontSize: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.thumb_up, size: 15, color: Colors.purple),
                  Text('  $countLike')
                ],
              )
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
