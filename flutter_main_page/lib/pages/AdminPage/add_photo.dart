import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_main_page/pages/loginPage/login_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';


class AddPhoto extends StatefulWidget {
  const AddPhoto({Key? key}) : super(key: key);

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();

  var tab = 0;
  var data = [];
  var userImage;
  var userContent;

  _addMyData() {
    var myData = {
      'id': data.length,
      'image': userImage,
      'userName': '관리자',
      'content': userContent,
    };
    setState(() {
      data.insert(0, myData);
    });
  }

  _setUserContent(a) {
    userContent = a;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              "Event Photo",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
            actions: [
          IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () async {
                var picker = ImagePicker();
                var image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    userImage = File(image.path);
                  });
                }
                // 파일경로로 이미지 띄우는 법
                // Image.file(userImage);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Upload(
                            userImage: userImage,
                            setUserContent: _setUserContent,
                            addMyData: _addMyData)));
              })
        ]));
  }
}

class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage, this.setUserContent, this.addMyData})
      : super(key: key);
  final userImage;
  final setUserContent;
  final addMyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
              IconButton(
                onPressed: () {
                Navigator.pop(context);},
                icon: Icon(Icons.close)),    
              IconButton(
                  onPressed: () {
                    addMyData();
                  },
                  icon: Icon(Icons.send)),

        ],
      ),
      body: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(userImage),
          Text('이미지 업로드 화면'),
          // TextField(
            // onChanged: (text) {
              // setUserContent(text);
            // },
        ],


      ),
        
    );

  }
  
}
