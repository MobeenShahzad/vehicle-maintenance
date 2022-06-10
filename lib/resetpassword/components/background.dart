import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background.png'), fit: BoxFit.cover),
      ),
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: ScreenUtils.screenheight(context) * 0.80,
            child: Image.asset('assets/login_header.png',
                width: ScreenUtils.screenwidth(context) * 1),
          ),
          Positioned(
            top: ScreenUtils.screenheight(context) * 0.64,
            child: Image.asset(
              'assets/splashpath.png',
              width: size.width,
            ),
          ),
          Positioned(
            bottom: 25,
            child: Image.asset('assets/car.png',
                width: ScreenUtils.screenheight(context) * 0.42),
          ),
          child,
        ],
      ),
    );
  }
}
