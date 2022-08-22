import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../View_pages/notice_view.dart';

class SearchPage extends StatefulWidget {
  final String topic;
  const SearchPage({Key? key, required this.topic}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchController = TextEditingController();
  String _search = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData.fallback(),
          title: TextField(
            textInputAction: TextInputAction.search,
            controller: _searchController,
            onChanged: (text) {
              setState(() {
                _search = text;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "글 제목",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: _buildItem(),
      ),
    );
  }

  Widget _buildItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(widget.topic)
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

                      if (_search.isEmpty) {
                        return Container();
                      }
                      if (data['title'].toString().contains(_search)) {
                        return _buildItemWidget(
                          id,
                          data['title'],
                          data['content'],
                          data['author'],
                          data['time'],
                        );
                      }
                      return Container();
                    });
          }),
    );
  }

  Widget _buildItemWidget(
      String id, String title, String content, String author, String time) {
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
            title,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "$author | $time",
            style: const TextStyle(fontSize: 10),
          ),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }

  Widget _buildNonItem() {
    return Container(
      height: 300,
      child: Center(
          child: Text(
        '검색결과가 없습니다.',
        style: TextStyle(
            color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
      )),
    );
  }
}
