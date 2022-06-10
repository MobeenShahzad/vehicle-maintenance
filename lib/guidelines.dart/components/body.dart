import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehiclemaintenance/Home/home.dart';
import 'package:vehiclemaintenance/Meter_Guidelines.dart/MeterGuidelines.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/Warnings.dart/Warnings.dart';
import 'package:vehiclemaintenance/guidelines.dart/components/background.dart';

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
            GestureDetector(
                child: guideline_items(text: "Warnings"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Warnings(),
                      ));
                }),
            GestureDetector(
                child: guideline_items(text: "Meter Guidelines"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MeterGuidelines(),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}

class guideline_items extends StatelessWidget {
  guideline_items({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: const Color(0xff393d4d),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                spreadRadius: 0,
                blurRadius: 6,
                offset: Offset(0, 4),
                color: Color.fromARGB(255, 41, 159, 169),
              )
            ]),
        width: ScreenUtils.screenwidth(context) * 0.8,
        height: ScreenUtils.screenheight(context) * 0.05,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poiretOne(
              textStyle: TextStyle(
                  color: AppColors.ktextColorWhite,
                  fontSize: ScreenUtils.screenwidth(context) * 0.053,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
