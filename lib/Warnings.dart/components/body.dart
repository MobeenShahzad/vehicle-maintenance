import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/Warnings.dart/components/background.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 250),
              child: Image.asset(
                'assets/warnings.png',
                width: ScreenUtils.screenheight(context) * 0.50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
