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
    apiKey: 'AIzaSyCNWkwuwiWbBLHXl1ut4ClKAs_4mY-Xqmc',
    appId: '1:1070355012345:web:1aa05c5fee3f9ccdfc6028',
    messagingSenderId: '1070355012345',
    projectId: 'emod-project',
    authDomain: 'emod-project.firebaseapp.com',
    storageBucket: 'emod-project.appspot.com',
    measurementId: 'G-VVHZYQ3BB0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjFpIMLU75oxiswfuH46D6oYeFNjLUajQ',
    appId: '1:1070355012345:android:9b28baf30c57c1e2fc6028',
    messagingSenderId: '1070355012345',
    projectId: 'emod-project',
    storageBucket: 'emod-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3XjRgICPfwG184YRcf_zO63hcQT5ERFw',
    appId: '1:1070355012345:ios:9fadd5005fa57243fc6028',
    messagingSenderId: '1070355012345',
    projectId: 'emod-project',
    storageBucket: 'emod-project.appspot.com',
    iosBundleId: 'com.emod.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3XjRgICPfwG184YRcf_zO63hcQT5ERFw',
    appId: '1:1070355012345:ios:ea23f581bb54eb04fc6028',
    messagingSenderId: '1070355012345',
    projectId: 'emod-project',
    storageBucket: 'emod-project.appspot.com',
    iosBundleId: 'com.example.capston1.RunnerTests',
  );
}
