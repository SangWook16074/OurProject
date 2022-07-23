import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/View_pages/notice_view.dart';

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
          "information of JOB",
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
      ),
    );
  }

  Widget _buildItem() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('job')
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
          title: Text(
            "[취업정보] $title",
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
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
