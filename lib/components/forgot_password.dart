import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final press;
  const ForgotPassword({
    Key? key,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: GestureDetector(
        onTap: press,
        child: const Text(
          "Forgot Password? ",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
