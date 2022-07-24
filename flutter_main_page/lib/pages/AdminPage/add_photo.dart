import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
    Fluttertoast.showToast(
        msg: "완료 !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "ADD PHOTO",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pacifico',
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
