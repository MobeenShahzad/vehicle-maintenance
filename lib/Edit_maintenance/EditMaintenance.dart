import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/Edit_maintenance/components/body.dart';

class EditMaintenance extends StatelessWidget {
  EditMaintenance({
    Key? key,
    this.maintenance,
  }) : super(key: key);
  DocumentSnapshot<Object?>? maintenance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Body(maintenance!),
    );
  }
}
