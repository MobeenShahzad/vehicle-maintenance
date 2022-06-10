import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

class NotificationService {
  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> init() async {
    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //Initialization Settings for iOS
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    //Initializing settings for both platforms (Android & iOS)
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  onSelectNotification(String? payload) async {
    //Navigate to wherever you want
  }
  requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotifications({id, title, body, payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<void> scheduleNotifications({id, title, body, time, token}) async {
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(time, tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'your channel id', 'your channel name',
          channelDescription: 'your channel description',
          // sound:
        )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      sendNotification(id, title, body, time, token);
    } catch (e) {
      print(e);
    }
  }

  sendNotification(id, title, body, token, time) async {
    print(token);
    final data = {
      'click_action': "FLUTTER_NOTIFICATION_CLICK",
      'id': id,
      'status': 'done',
      'title': title,
      "body": body,
      'time': time,
    };
    try {
      http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAAP0H1z38:APA91bGyhWVoOZ9WtBtYv2YLiwxmdyp5HmzhMxpARstwlYUYwDCbUtNz48sdeDJptTO_pSuaOSpEPIX_hSebRtii18ovOsH_VGYJHGIhVQw0sI-CGdFMl0O3iDfhIZVDLetdLWeXIeFf',
              },
              body: jsonEncode(<String, dynamic>{
                'notification': <String, dynamic>{'title': title, 'body': body},
                'priority': 'high',
                'time': tz.TZDateTime.from(time, tz.local),
                'data': data,
                'to': '$token',
              }));
      if (response.statusCode == 200) {
        print("success");
        print(response.body);
      } else {
        print("error");
      }
    } catch (e) {}
  }
}
