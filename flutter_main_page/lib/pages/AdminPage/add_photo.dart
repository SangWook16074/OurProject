import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

const Duration _duration = Duration(milliseconds: 300);

class AddPhotoPage extends StatefulWidget {
  const AddPhotoPage({Key? key}) : super(key: key);

  @override
  State<AddPhotoPage> createState() => _AddPhotoPageState();
}

class _AddPhotoPageState extends State<AddPhotoPage> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  var _picked = false;
  var _check = false;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
      _picked = true;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
      _check = true;
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final title = pickedFile!.name;
    final urlDonwload = await snapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection('eventImage').doc().set({
      'url': urlDonwload,
      'title': title,
    });

    setState(() {
      uploadTask = null;
    });

    Navigator.of(context).pop();
    toastMessage('업로드 완료!');
  }

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
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.white,
        title: const Text(
          "배너 사진 관리",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontFamily: 'hoon',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: selectFile,
            icon: Icon(Icons.add_a_photo),
          ),
          IconButton(onPressed: uploadFile, icon: Icon(Icons.check))
        ],
      ),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          if (pickedFile != null)
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Container(
                    child: Image.file(
                      File(pickedFile!.path!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  AnimatedOpacity(
                      duration: _duration,
                      opacity: _check ? 0.0 : 1.0,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              pickedFile = null;
                            });
                          },
                          child: Text("취소"))),
                ],
              ),
            ),
          _buildProgress(),
          _buildItemPhoto(),
        ],
      ),
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
    return Container(
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

  Widget _buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;

          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 50,
          );
        }
      });
}
