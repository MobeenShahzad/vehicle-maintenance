import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehiclemaintenance/VehicleMaintenance.dart';
import 'package:vehiclemaintenance/providers/auth_provider.dart';
import 'package:vehiclemaintenance/providers/vehicleprovider.dart';
import 'package:vehiclemaintenance/reminder.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  //notification initialization and requesting permission
  await NotificationService().init(); //
  await NotificationService().requestIOSPermissions();
  // LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage((_firebaseMessagingBackgroundHandler));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(
        create: ((context) => HomeNotifier()),
      )
    ],
    child: const MyApp(),
  ));
}
