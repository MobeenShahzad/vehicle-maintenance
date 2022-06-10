import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don't have an Account? " : "Already have an Account?",
          style: const TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
