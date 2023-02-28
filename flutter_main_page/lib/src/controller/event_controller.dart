import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_main_page/src/constants/firebase_constants.dart';
import 'package:flutter_main_page/src/data/model/event_model.dart';
import 'package:flutter_main_page/src/data/repository/event_repository.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  Rx<List<EventModel>> eventList = Rx<List<EventModel>>([]);
  List<EventModel> get events => eventList.value;

  @override
  void onReady() {
    eventList.bindStream(EventRepository.eventStream());
    super.onReady();
  }

  void updatecountLike(String docID, List likedUsersList) {
    firebaseFirestore
        .collection('event')
        .doc(docID)
        .set({'countLike': likedUsersList.length}, SetOptions(merge: true));
  }

  void updatelikedUsersList(String docID, String userNumber, List usersList) {
    firebaseFirestore.collection('event').doc(docID)
        // .set({'likedUsersMap': userNumber}, SetOptions(merge: true));
        .set({'likedUsersList': userCheck(usersList, userNumber)},
            SetOptions(merge: true));
  }

  userCheck(List usersList, String userNumber) {
    if (usersList.contains(userNumber)) {
      usersList.remove(userNumber);
    } else {
      usersList.add(userNumber);
    }
    return usersList;
  }
}
