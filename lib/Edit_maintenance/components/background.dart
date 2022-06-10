import 'package:flutter/material.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';

class Background extends StatelessWidget {
  final Widget child;

  Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background.png'), fit: BoxFit.cover),
      ),
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 40,
            child: Container(
              width: ScreenUtils.screenwidth(context) * 1,
              height: ScreenUtils.screenheight(context) * 0.3,
              //  color: Colors.blue,
              child: Stack(
                alignment: Alignment.topCenter,
                fit: StackFit.loose,
                //   overflow: Overflow.visible,
                children: [
                  Positioned(
                    right: 0,
                    top: 40,
                    child: SizedBox(
                      width: ScreenUtils.screenwidth(context) * 0.87,
                      height: ScreenUtils.screenheight(context) * 0.22,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                bottomLeft: Radius.circular(100)),
                            color: AppColors.kgreyDark,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  spreadRadius: 0,
                                  color: Color.fromARGB(255, 41, 159, 169),
                                  blurRadius: 5,
                                  offset: const Offset(2, 4))
                            ]),
                      ),
                    ),
                  ),
                  Positioned(
                    top: ScreenUtils.screenheight(context) * 0.00,
                    left: ScreenUtils.screenheight(context) * 0.145,
                    child: Image.asset(
                      'assets/car.png',
                      width: ScreenUtils.screenheight(context) * 0.40,
                    ),
                  ),
                ],
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
