import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:vehiclemaintenance/ScreenUtils/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashscreen,
      routes: AppRoutes.appRoutes,
    );
  }
}
