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
            top: 0,
            child: Image.asset(
              'assets/login_header.png',
              width: size.width,
            ),
          ),
          Positioned(
            bottom: -20,
            child: Image.asset(
              'assets/login_footer.png',
              width: size.width,
            ),
          ),
          Positioned(
            top: ScreenUtils.screenheight(context) * 0.79,
            child: Image.asset('assets/car.png',
                width: ScreenUtils.screenwidth(context) * 0.6),
          ),
          child,
        ],
      ),
    );
  }
}
