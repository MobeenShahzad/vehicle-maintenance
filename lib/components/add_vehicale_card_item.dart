import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';

class AddVehicalCardItem extends StatelessWidget {
  final String title;
  final String hintText;
  final ValueChanged<String> onChanged;
  // IconData? icon;
  AddVehicalCardItem({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.hintText,
    //  this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PhysicalModel(
      color: Colors.transparent,
      //  shadowColor: Color.fromARGB(255, 73, 231, 246),
      // elevation: 2.5,

      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xff393d4d),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                spreadRadius: 0,
                blurRadius: 6,
                offset: Offset(0, 4),
                color: Color.fromARGB(255, 41, 159, 169),
              )
            ]),
        width: ScreenUtils.screenwidth(context) * 0.4,
        height: ScreenUtils.screenheight(context) * 0.06,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          //  fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 34,
              child: Container(
                  width: ScreenUtils.screenwidth(context) * 0.35,
                  height: ScreenUtils.screenheight(context) * 0.032,
                  decoration: BoxDecoration(
                    color: AppColors.kgreyLightColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: EdgeInsets.only(bottom: 1.0),
                  child: Center(
                    child: Text(
                      title,
                      style: GoogleFonts.poiretOne(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenUtils.screenheight(context) * 0.017),
                    ),
                  )),
            ),
            Positioned(
              bottom: 5,
              child: ClipRRect(
                child: Container(
                  width: ScreenUtils.screenwidth(context) * 0.3,
                  height: ScreenUtils.screenheight(context) * 0.03,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    style: TextStyle(
                        fontSize: ScreenUtils.screenheight(context) * 0.017,
                        color: Colors.white),
                    onChanged: onChanged,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 13.0),
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: GoogleFonts.poiretOne(
                          color: Color.fromARGB(255, 174, 169, 169),
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtils.screenheight(context) * 0.015,
                        )),
                  ),
                ),
              ),
            ),
            // Positioned(child: Icon(icon)),
          ],
        ),
      ),
    );
  }
}
