import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/login/component/body.dart';
import 'package:vehiclemaintenance/newpassword/newpassword.dart';
import 'package:vehiclemaintenance/resetpassword/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController resetcodeController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Background(
            child: Column(
          children: [
            SizedBox(
              height: ScreenUtils.screenheight(context) * 0.24,
            ),
            Text(
              'Forgot your Password',
              style: GoogleFonts.poiretOne(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtils.screenheight(context) * 0.045,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: ScreenUtils.screenheight(context) * 0.015),
            Text(
              "We have sent recovery code to your \n registered email.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poiretOne(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtils.screenheight(context) * 0.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: ScreenUtils.screenheight(context) * 0.05),
            Padding(
              padding: const EdgeInsets.only(right: 180.0, bottom: 10),
              child: Text(
                'Reset Code',
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
              child: TextFormField(
                textAlign: TextAlign.start,
                controller: resetcodeController,
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewPassword(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: ScreenUtils.screenheight(context) * 0.045,
                    width: ScreenUtils.screenwidth(context) * 0.24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xff4a4f60),
                    ),
                    child: Center(
                        child: Text(
                      ' Enter',
                      style: GoogleFonts.poiretOne(
                        textStyle: TextStyle(
                            color: AppColors.ktextColorWhite,
                            fontSize: ScreenUtils.screenwidth(context) * 0.055,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
