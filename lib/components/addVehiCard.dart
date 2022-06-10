import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/models/app_vehicle.dart';

class AddVehiCard extends StatefulWidget {
  AddVehiCard({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  final Vehicle vehicle;
  @override
  State<AddVehiCard> createState() => _AddVehiCardState();
}

class _AddVehiCardState extends State<AddVehiCard> {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(5.0),
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
      width: size.width * 0.4,
      height: size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    "assets/car.png",
                    width: 130,
                  ),
                ),
                Text(
                  'Miant by Date:',
                  style: GoogleFonts.poiretOne(
                    textStyle: TextStyle(
                        color: AppColors.ktextColorWhite,
                        fontSize: ScreenUtils.screenwidth(context) * 0.023,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Miant by Km:',
                  style: GoogleFonts.poiretOne(
                    textStyle: TextStyle(
                        color: AppColors.ktextColorWhite,
                        fontSize: ScreenUtils.screenwidth(context) * 0.023,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => Home(),
                      //     ));
                    },
                    child: Container(
                      height: ScreenUtils.screenheight(context) * 0.024,
                      width: ScreenUtils.screenwidth(context) * 0.17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xff4a4f60),
                      ),
                      child: Center(
                          child: Text(
                        widget.vehicle.vehiclenumber,
                        style: GoogleFonts.poiretOne(
                          textStyle: TextStyle(
                              color: AppColors.ktextColorWhite,
                              fontSize: ScreenUtils.screenwidth(context) * 0.03,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
