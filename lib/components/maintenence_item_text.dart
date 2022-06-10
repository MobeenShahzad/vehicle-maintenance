import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';

class Maintenace_Item_Text extends StatelessWidget {
  final String text;
  const Maintenace_Item_Text({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.2),
      child: Text(
        text,
        style: GoogleFonts.poiretOne(
          textStyle: TextStyle(
              color: AppColors.ktextColorWhite,
              fontSize: ScreenUtils.screenwidth(context) * 0.026,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
