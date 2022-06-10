import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/Maintenance/component/body.dart';
import 'package:vehiclemaintenance/models/app_vehicle.dart';

// class Maintenance extends StatefulWidget {
//   QueryDocumentSnapshot<Object?>? vehicle;
//   Maintenance({Key? key, this.vehicle}) : super(key: key);

//   @override
//   State<Maintenance> createState() => _MaintenanceState();
// }

// class _MaintenanceState extends State<Maintenance> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Body(widget.vehicle),
//     );
//   }
// }
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
