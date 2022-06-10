import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehiclemaintenance/Home/component/body.dart';
import 'package:vehiclemaintenance/providers/vehicleprovider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
