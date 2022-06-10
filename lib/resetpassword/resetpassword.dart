import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/resetpassword/components/body.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
