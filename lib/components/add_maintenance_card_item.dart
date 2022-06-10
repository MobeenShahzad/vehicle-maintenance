import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';

class AddMaintenanceCardItem extends StatelessWidget {
  final String title;

  final ValueChanged<String> onChanged;
  // IconData? icon;
  AddMaintenanceCardItem({
    Key? key,
    required this.title,
    required this.onChanged,

    //  this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              title,
              style: GoogleFonts.poiretOne(
                textStyle: TextStyle(
                    color: Color(0xffc8c9cd),
                    fontSize: ScreenUtils.screenheight(context) * 0.016,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
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
            height: ScreenUtils.screenheight(context) * 0.037,
            child: Container(
              width: ScreenUtils.screenwidth(context) * 0.3,
              height: ScreenUtils.screenheight(context) * 0.03,
              child: TextFormField(
                style: TextStyle(
                    fontSize: ScreenUtils.screenheight(context) * 0.017,
                    color: Colors.white),
                onChanged: onChanged,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 13.0),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
