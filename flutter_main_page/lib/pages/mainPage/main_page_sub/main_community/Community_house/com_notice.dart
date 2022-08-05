// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/View_pages/notice_view.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/Community_house/com_noticeWrite.dart';

class NoticePage extends StatefulWidget {
  final String user;

  const NoticePage(this.user, {Key? key}) : super(key: key);

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '공지사항',
            style: TextStyle(
                fontFamily: 'hoon', color: Colors.black, fontSize: 25),
          ),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          iconTheme: IconThemeData.fallback(),
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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

                      if (snapshot.hasData) {
                        return _buildItemWidget(context, data['title'],
                            data['content'], data['author'], data['time']);
                      }

                      return Container();
                    });
          }),
    ),
  );
}

Widget _buildItemWidget(BuildContext context, String title, String content,
    String author, String time) {
  return Column(
    children: [
      ListTile(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NoticeViewPage(title, content, author, time)));
        },
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "작성자 : $author | $time",
          style: const TextStyle(fontSize: 10),
        ),
      ),
      Divider(
        color: Colors.grey,
      )
    ],
  );
}

// Widget _buildSearch() {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: TextField(
//       controller: _search,
//       onChanged: (text) {
//         setState(() {
//           _searchContent = text;
//         });
//       },
//       decoration: InputDecoration(
//         hintText: "제목을 입력하세요.",
//         prefixIcon: Icon(Icons.search),
//       ),
//     ),
//   );
// }



