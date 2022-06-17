import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/newpassword/components/background.dart';
import 'package:vehiclemaintenance/updatemeter/updatemeter.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController newpasswordController = TextEditingController();
    TextEditingController confirmnewpasswordController =
        TextEditingController();
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
          child: Column(
        children: [
          SizedBox(
            height: ScreenUtils.screenheight(context) * 0.22,
          ),
          Text(
            'Create new password',
            style: GoogleFonts.poiretOne(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtils.screenheight(context) * 0.045,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: ScreenUtils.screenheight(context) * 0.015),
          Text(
            "Your new password must be different from \n your previous used password.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poiretOne(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtils.screenheight(context) * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: ScreenUtils.screenheight(context) * 0.035),
          Padding(
            padding: const EdgeInsets.only(right: 220.0, bottom: 5),
            child: Text(
              'Password',
              style: GoogleFonts.poiretOne(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtils.screenheight(context) * 0.028,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtils.screenheight(context) * 0.06,
            width: ScreenUtils.screenwidth(context) * 0.8,
            child: TextField(
              textAlign: TextAlign.start,
              controller: newpasswordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(6),
                fillColor: AppColors.ktextColorWhite,
              ),
            ),
          ),
          SizedBox(height: ScreenUtils.screenheight(context) * 0.01),
          Padding(
            padding: const EdgeInsets.only(right: 140.0, bottom: 5),
            child: Text(
              'Confirm Password',
              style: GoogleFonts.poiretOne(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtils.screenheight(context) * 0.028,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtils.screenheight(context) * 0.06,
            width: ScreenUtils.screenwidth(context) * 0.8,
            child: TextField(
              textAlign: TextAlign.start,
              controller: confirmnewpasswordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(6),
                fillColor: AppColors.ktextColorWhite,
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  height: ScreenUtils.screenheight(context) * 0.045,
                  width: ScreenUtils.screenwidth(context) * 0.39,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color(0xff4a4f60),
                  ),
                  child: Center(
                      child: Text(
                    ' Reset Password',
                    style: GoogleFonts.poiretOne(
                      textStyle: TextStyle(
                          color: AppColors.ktextColorWhite,
                          fontSize: ScreenUtils.screenwidth(context) * 0.05,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
