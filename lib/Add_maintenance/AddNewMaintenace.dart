import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/Add_maintenance/components/body.dart';

class AddNewMaintenace extends StatelessWidget {
  AddNewMaintenace({
    Key? key,
    this.vehicle,
  }) : super(key: key);
  QueryDocumentSnapshot<Object?>? vehicle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Body(vehicle!),
    );
  }
}
