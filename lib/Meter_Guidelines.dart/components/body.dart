import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/Meter_Guidelines.dart/components/background.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';

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
              padding: const EdgeInsets.only(left: 40.0, top: 260),
              child: Image.asset(
                'assets/blackmeter.jpg',
                width: ScreenUtils.screenheight(context) * 0.42,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
