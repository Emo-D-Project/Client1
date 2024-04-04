import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



Future<void> handleBackgroundMessage(RemoteMessage message) async {

  print('TITLE: ${message.notification?.title}');
  print('BODY: ${message.notification?.body}');
  print('PAYLOAD: ${message.data}');

}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;


  Future<void> initNotifications() async {
    print('bbbbbbbbbbbbbbbbbbbbbbbbbb');
    await _firebaseMessaging.requestPermission();
    final fcmTocken = await _firebaseMessaging.getToken();
    print ('Tocken임 : $fcmTocken\n');
    print('aaaaaaaaaaaaaaaaaaaaaaaaaa');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }


}