import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? documentId;
  late String title;
  late String content;
  late String author;
  late String time;
  late int countLike;
  late List likedUsersList;
  late String url;

  EventModel({
    required this.title,
    required this.content,
    required this.author,
    required this.time,
    required this.countLike,
    required this.likedUsersList,
    required this.url,
  });

  EventModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    documentId = documentSnapshot.id;
    title = documentSnapshot['title'];
    content = documentSnapshot['content'];
    author = documentSnapshot['author'];
    time = documentSnapshot['time'];
    countLike = documentSnapshot['countLike'];
    likedUsersList = documentSnapshot['likedUsersList'];
    url = (documentSnapshot['url'] == null) ? '' : documentSnapshot['url'];
  }
}
