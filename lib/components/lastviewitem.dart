import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/models/app_vehicle.dart';

class LastViewVehiCard extends StatelessWidget {
  LastViewVehiCard({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  QueryDocumentSnapshot<Object?> vehicle;
  @override
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
      width: size.width * 0.8,
      height: size.height * 0.17,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Miant by Date:    ',
                      style: GoogleFonts.poiretOne(
                        textStyle: TextStyle(
                            color: AppColors.ktextColorWhite,
                            fontSize: ScreenUtils.screenwidth(context) * 0.023,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'Miant by Km:   ${vehicle['metervalue']}',
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
                          width: ScreenUtils.screenwidth(context) * 0.20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color(0xff4a4f60),
                          ),
                          child: Center(
                              child: Text(
                            vehicle['vehiclenumber'],
                            style: GoogleFonts.poiretOne(
                              textStyle: TextStyle(
                                  color: AppColors.ktextColorWhite,
                                  fontSize:
                                      ScreenUtils.screenwidth(context) * 0.03,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: ScreenUtils.screenwidth(context) * 0.39,
                  height: ScreenUtils.screenheight(context) * 0.14,
                  color: Colors.transparent,
                  child: Image.network(
                    vehicle['image'],
                    fit: BoxFit.cover,
                  ),
                )

                // Container(
                //   child: Image.network(
                //     vehicle['vehiclenumber'],
                //     width: 0.1,
                //     height: 0.4,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
