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
    apiKey: 'AIzaSyA-fKFrOjTpTgI1IJvIq5OW9HzrggtdZXo',
    appId: '1:647782774462:web:888969d591c64d62e890ef',
    messagingSenderId: '647782774462',
    projectId: 'emodsujin',
    authDomain: 'emodsujin.firebaseapp.com',
    storageBucket: 'emodsujin.appspot.com',
    measurementId: 'G-L1CHE4JY02',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjs9r3fWhfSYN_UpIzrwEkHovIPFWHxig',
    appId: '1:647782774462:android:554e2dd36cde84f6e890ef',
    messagingSenderId: '647782774462',
    projectId: 'emodsujin',
    storageBucket: 'emodsujin.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDunDNj2vM8KV-w2wHiWBduDhIqeumFsmQ',
    appId: '1:647782774462:ios:0a70e30eb37d2ebbe890ef',
    messagingSenderId: '647782774462',
    projectId: 'emodsujin',
    storageBucket: 'emodsujin.appspot.com',
    iosBundleId: 'Y',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDunDNj2vM8KV-w2wHiWBduDhIqeumFsmQ',
    appId: '1:647782774462:ios:c3afb33afb33dd1ae890ef',
    messagingSenderId: '647782774462',
    projectId: 'emodsujin',
    storageBucket: 'emodsujin.appspot.com',
    iosBundleId: 'com.example.capston1.RunnerTests',
  );
}
