import 'package:flutter/material.dart';

class RegistrationTextFieldContainer extends StatelessWidget {
  final Widget child;
  const RegistrationTextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: child,
    );
  }
}
