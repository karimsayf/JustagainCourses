import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> onBackgroundMessageHandler(RemoteMessage message) async {

}

initMessagingServices() async {
  try {
    await Firebase.initializeApp();
    late AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'AlNatour',
      'AlNatour Notifications',
      importance: Importance.max,
    );

    late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((event) {
      RemoteNotification? notification = event.notification;
      AndroidNotification? android = event.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                icon: 'noti_icon',
                playSound: true,
                enableLights: true,
                enableVibration: true,
                importance: Importance.max),
          ),
        );
      }
    }).onError((error) {
      if (kDebugMode) {
        print('Error');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
    }).onError((error) {
      if (kDebugMode) {
        print('Error');
      }
    });

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);
  } catch (e) {
    if (kDebugMode) {
      print('Error$e');
    }
  }

  /* await FirebaseMessaging.instance
      .subscribeToTopic('allUsers')
      .catchError((error) {
    if (kDebugMode) {
      print('Error While Subscribe to Topic$error');
    }
  });*/
}
