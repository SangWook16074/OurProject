import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  void _showToast(String content) {
    Fluttertoast.showToast(
      msg: content,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
    );
  }

  void _addAdmin(String name, String number) {
    FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(number)
        .update({'isAdmin': true});
    _showToast('새로운 관리자가 등록되었습니다');
  }

  void _addAdminDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("관리자 추가"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "이름"),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                TextField(
                  controller: _numberController,
                  decoration: InputDecoration(hintText: "학번"),
                  onChanged: (value) {
                    setState(() {});
                  },
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty) {
                      return _showToast('이름을 입력하세요');
                    }

                    if (_numberController.text.isEmpty) {
                      return _showToast('학번을 입력하세요');
                    }
                    _addAdmin(_nameController.text, _numberController.text);

                    Navigator.of(context).pop();
                  },
                  child: const Text("확인")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("취소")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                _addAdminDialog();
              },
              icon: Icon(Icons.person_add_alt))
        ],
        backgroundColor: Colors.blue,
        title: const Text(
          "Admin List",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('UserInfo')
              .where('isAdmin', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Container(child: const CircularProgressIndicator()));
            }
            final documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return _buildNonAdmin();
            } else {
              return Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: myColor, width: 3)),
                child: ListView(
                  shrinkWrap: true,
                  children:
                      documents.map((doc) => _buildEventWidget(doc)).toList(),
                ),
              );
            }
          }),
    );
  }

  Widget _buildEventWidget(DocumentSnapshot doc) {
    final user = doc['userName'];
    final userNumber = doc['userNumber'];
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            userNumber,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 100,
          ),
          Text(
            user,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildNonAdmin() {
    return Center(
      child: Container(
        child: const Center(
          child: Text(
            '등록된 관리자가 없습니다.',
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
