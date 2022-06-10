import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/Warnings.dart/components/body.dart';

class Warnings extends StatelessWidget {
  const Warnings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: Body(),
    );
  }
}
