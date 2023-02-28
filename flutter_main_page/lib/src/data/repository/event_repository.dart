import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_main_page/src/constants/firebase_constants.dart';
import 'package:flutter_main_page/src/data/model/event_model.dart';

class EventRepository {
  static Stream<List<EventModel>> eventStream() {
    return firebaseFirestore
        .collection('event')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<EventModel> events = [];
      for (var event in snapshot.docs) {
        final eventModel = EventModel.fromDocumentSnapshot(event);
        events.add(eventModel);
      }
      return events;
    });
  }
}
