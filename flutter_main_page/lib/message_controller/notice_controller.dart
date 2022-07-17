import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  Future<void> onInit() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    print(settings.authorizationStatus);

    _getToken();

    _onMessage();
    super.onInit();
  }

  Future<void> _getToken() async {
    String? token = await messaging.getToken();

    try {
      FirebaseMessaging.instance.subscribeToTopic("connectTopic");
      print(token);
    } catch (e) {}
  }

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_imprtance_channel', "High Importance Notification",
      description: 'This channel is used for important notification.',
      importance: Importance.high);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _onMessage() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings('mipmap/ic_launcher'),
          iOS: IOSInitializationSettings()),
      onSelectNotification: (String? payload) async {},
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description),
          ),
        );
      }

      print('foreground 상황에서 메시지를 받았다.');

      print('Message Data : ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notofication : ${message.notification!.body}');
      }
    });
  }
}
