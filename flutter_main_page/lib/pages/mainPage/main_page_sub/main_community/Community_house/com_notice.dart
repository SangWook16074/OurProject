// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/View_pages/notice_view.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/Community_house/com_noticeWrite.dart';

class NoticePage extends StatefulWidget {
  final String user;
  final bool? isAdmin;
  const NoticePage(this.user, this.isAdmin, {Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  var _search = TextEditingController();
  String _searchContent = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAdmin == true) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              "NOTICE",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildSearch(),
                _buildItem(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                //글쓰기 페이지 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WriteNotice(widget.user, widget.isAdmin)),
                );
              },
              child: const Icon(Icons.border_color)),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              "NOTICE",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
            centerTitle: true,
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildSearch(),
                _buildItem(),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildItem() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notice')
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

                        if (_searchContent.isEmpty) {
                          return _buildItemWidget(data['title'],
                              data['content'], data['author'], data['time']);
                        }
                        if (data['title'].toString().contains(_searchContent)) {
                          return _buildItemWidget(data['title'],
                              data['content'], data['author'], data['time']);
                        }
                        return Container();
                      });
            }),
      ),
    );
  }

  Widget _buildItemWidget(
      String title, String content, String author, String time) {
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
          leading: const Icon(
            Icons.notifications,
            color: Colors.deepPurple,
          ),
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "작성자 : $author",
            style: const TextStyle(fontSize: 10),
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
}
