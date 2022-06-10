import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/guidelines.dart/components/body.dart';

class Guidelines extends StatelessWidget {
  const Guidelines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: Body(),
    );
  }
}
