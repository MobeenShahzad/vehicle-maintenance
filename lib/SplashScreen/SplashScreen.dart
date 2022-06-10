import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehiclemaintenance/login/login_screen.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //       Duration(seconds: 3),
  //       () => Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => LoginScreen())));
  // }
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).checkCurrentUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: Colors.white,
        body: Background(
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenUtils.screenheight(context) * 0.23,
              ),
              Container(
                height: ScreenUtils.screenheight(context) * 0.134,
                width: ScreenUtils.screenheight(context) * 0.134,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/wheels.png"),
                  ),
                ),
              ),
              Container(
                height: ScreenUtils.screenheight(context) * 0.23,
                width: ScreenUtils.screenwidth(context) * 0.7,
                //  color: Colors.amberAccent,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/VehiMan.png"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

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
            height: ScreenUtils.screenheight(context) * 0.6,
            width: ScreenUtils.screenwidth(context) * 1,
            top: ScreenUtils.screenheight(context) * 0.5,
            child: Image.asset('assets/splashpath.png'),
          ),
          Positioned(
            top: ScreenUtils.screenheight(context) * 0.44,
            child: Container(
              height: ScreenUtils.screenheight(context) * 0.47,
              width: ScreenUtils.screenheight(context) * 0.47,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/car.png"),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
