import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/updatemeter/components/body.dart';

class UpdateMeter extends StatefulWidget {
  const UpdateMeter({Key? key}) : super(key: key);

  @override
  State<UpdateMeter> createState() => _UpdateMeterState();
}

class _UpdateMeterState extends State<UpdateMeter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
