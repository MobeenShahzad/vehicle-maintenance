import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/Meter_Guidelines.dart/components/body.dart';

class MeterGuidelines extends StatelessWidget {
  const MeterGuidelines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: Body(),
    );
  }
}
