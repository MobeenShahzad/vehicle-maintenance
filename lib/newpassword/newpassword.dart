import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/newpassword/components/body.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
