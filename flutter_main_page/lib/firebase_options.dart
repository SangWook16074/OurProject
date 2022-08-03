// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA4ZSp6zp-WgtuFOWSukiVpPvj6LZEa8T4',
    appId: '1:974035462798:web:ccee57e62f71930cf2f7df',
    messagingSenderId: '974035462798',
    projectId: 'ourproject-fa19a',
    authDomain: 'ourproject-fa19a.firebaseapp.com',
    storageBucket: 'ourproject-fa19a.appspot.com',
    measurementId: 'G-97R010FRNS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgIqR2wfXPtsVl90zblKh5sTsvrVbTV30',
    appId: '1:974035462798:android:66ea99405906c682f2f7df',
    messagingSenderId: '974035462798',
    projectId: 'ourproject-fa19a',
    storageBucket: 'ourproject-fa19a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkziF43aUdET1GaSAwr9kh5j3taGF93H0',
    appId: '1:974035462798:ios:3ee4cabf2e7802d7f2f7df',
    messagingSenderId: '974035462798',
    projectId: 'ourproject-fa19a',
    storageBucket: 'ourproject-fa19a.appspot.com',
    iosClientId: '974035462798-q2t8tomg73lnog186la5pgpc3kenv4h2.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterMainPage',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBkziF43aUdET1GaSAwr9kh5j3taGF93H0',
    appId: '1:974035462798:ios:3ee4cabf2e7802d7f2f7df',
    messagingSenderId: '974035462798',
    projectId: 'ourproject-fa19a',
    storageBucket: 'ourproject-fa19a.appspot.com',
    iosClientId: '974035462798-q2t8tomg73lnog186la5pgpc3kenv4h2.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterMainPage',
  );
}