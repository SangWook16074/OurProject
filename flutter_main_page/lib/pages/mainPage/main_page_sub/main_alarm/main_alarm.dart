import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/main.dart';

class Alarm {
  String title;
  bool status;
  Alarm(this.title, this.status);
}

class MainPage3 extends StatefulWidget {
  const MainPage3({Key? key}) : super(key: key);

  @override
  State<MainPage3> createState() => _MainPage3State();
}

class _MainPage3State extends State<MainPage3> {
  void _updateStatus(String docId, bool status) {
    FirebaseFirestore.instance
        .collection(
            'UserInfo/${prefs.getString('userNumber').toString()}/alarmlog')
        .doc(docId)
        .update({"status": status});
  }

  void _createDeleteAlarm() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("알림 기록 전체 삭제"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [Text('알림 기록을 지우시겠습니까? 지워진 알림은 볼 수 없습니다.')],
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    prefs.setInt('index', 1);
                    final instance = FirebaseFirestore.instance;
                    final batch = instance.batch();
                    var collection = instance.collection(
                        'UserInfo/${prefs.getString('userNumber').toString()}/alarmlog');
                    var snapshots = await collection.get();
                    for (var doc in snapshots.docs) {
                      batch.delete(doc.reference);
                    }
                    await batch.commit();

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
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Icon(Icons.notification_add),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '알림',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      _createDeleteAlarm();
                    },
                    icon: Icon(Icons.clear_sharp)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(
                        'UserInfo/${prefs.getString('userNumber').toString()}/alarmlog')
                    .orderBy('index', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return _loading();
                  }
                  final documents = snapshot.data!.docs;
                  if (documents.isEmpty) {
                    return _buildNonEvent();
                  } else {
                    return Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: documents
                            .map((doc) => _buildItemWidget(doc))
                            .toList(),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final alarm = Alarm(
      doc['alarm'],
      doc['status'],
    );
    return GestureDetector(
      onTap: () {
        _updateStatus(doc.id, true);
      },
      child: Container(
        decoration: BoxDecoration(
          color: (doc['status'] ? Colors.white : Colors.yellow[100]),
        ),
        alignment: Alignment.centerLeft,
        height: 80,
        child: ListTile(
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          leading: Icon(
            Icons.alarm_on_rounded,
            color: Colors.blue,
          ),
          title: Text(
            alarm.title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNonEvent() {
    return Center(
      child: Container(
        height: 500,
        child: const Center(
          child: Text(
            '알람이 없습니다',
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _loading() {
    return Center(child: CircularProgressIndicator());
  }
}
