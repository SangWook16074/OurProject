import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DeletePhotoPage extends StatefulWidget {
  const DeletePhotoPage({Key? key}) : super(key: key);

  @override
  State<DeletePhotoPage> createState() => _DeletePhotoPageState();
}

class _DeletePhotoPageState extends State<DeletePhotoPage> {
  void _deleteItemDialog(DocumentSnapshot doc) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [Text('정말로 삭제하시겠습니까?')],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _deleteItem(doc);
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

  void _deleteItem(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('eventImage').doc(doc.id).delete();
    FirebaseStorage.instance.ref('/files').child(doc['title']).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "DELETE PHOTO",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
      ),
      body: _buildItemPhoto(),
    );
  }

  Widget _buildItemPhoto() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('eventImage').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;

          return ListView(
            shrinkWrap: true,
            children: documents.map((doc) => _buildItem(doc)).toList(),
          );
        });
  }

  Widget _buildItem(DocumentSnapshot doc) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                doc['url'],
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _deleteItemDialog(doc);
              },
              child: Text("위 사진 삭제하기")),
        ],
      ),
    );
  }
}
