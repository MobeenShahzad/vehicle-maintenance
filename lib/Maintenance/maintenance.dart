import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/Maintenance/component/body.dart';

class Maintenance extends StatelessWidget {
  Maintenance({Key? key, this.vehicle}) : super(key: key);
  QueryDocumentSnapshot<Object?>? vehicle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(vehicle!),
    );
  }
}
