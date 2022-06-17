import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:vehiclemaintenance/Maintenance/maintenance.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/addVehical/AddNewVehical.dart';
import 'package:vehiclemaintenance/globals.dart';
import 'package:vehiclemaintenance/resetpassword/resetpassword.dart';
import 'package:vehiclemaintenance/updatemeter/components/background.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _count = 0;
  final _CounterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextEditingController forgetemailController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
          child: Column(
        children: [
          SizedBox(
            height: ScreenUtils.screenheight(context) * 0.24,
          ),
          Text(
            'Meter Value',
            style: GoogleFonts.poiretOne(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtils.screenheight(context) * 0.045,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: ScreenUtils.screenheight(context) * 0.015),
          Text(
            "Enter your latest meter value ",
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
          Container(
            height: ScreenUtils.screenheight(context) * 0.06,
            width: ScreenUtils.screenwidth(context) * 0.58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: NumberInputPrefabbed.squaredButtons(
              // max: 100000,
              //onChanged: "",
              controller: _CounterController,
              incDecBgColor: Color.fromARGB(255, 255, 255, 255),
              buttonArrangement: ButtonArrangement.incRightDecLeft,
              incIcon: Icons.add,
              decIcon: Icons.remove,
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                    .collection("maintenance")
                    .get();
                for (int i = 0; i < querySnapshot.docs.length; i++) {
                  String a = querySnapshot.docs[i]["id"];
                  int kmprev = int.parse(querySnapshot.docs[i]["km"]);
                  int tolbykm_prev =
                      int.parse(querySnapshot.docs[i]["tolbykm"]);

                  int trip_val = int.parse(querySnapshot.docs[i]["trip"]);

                  // print(kmprev);
                  int contp = int.parse(_CounterController.text);
                  int kmf = kmprev + contp + _count;
                  int update_trip = 0;
                  update_trip++;
                  print("this is data base trip value");
                  print(trip_val);
                  int newtripvalue = trip_val + update_trip;
                  print(newtripvalue);
                  int update_tolbykm = tolbykm_prev + contp + _count;
                  print(a);
                  FirebaseFirestore.instance
                      .collection("maintenance")
                      .doc(a)
                      .update({
                    "km": kmf.toString(),
                    "trip": newtripvalue.toString(),
                    "tolbykm": update_tolbykm.toString(), //+ kmprev,
                  });
                }
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Color.fromRGBO(33, 40, 48, 1.0),
                        insetPadding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0)), //this right here
                        child: Container(
                          height: ScreenUtils.screenheight(context) * 0.27,
                          width: ScreenUtils.screenwidth(context) * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LargeText(
                                      text: 'Meter Value Updated',
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Divider(
                                  height: 2,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 0, top: 40),
                                  //width: ScreenUtils.screenwidth(context) * 0.7,
                                  child: SmallText(
                                    text: "Meter Value Updated Successfully !",
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40.0, right: 0, left: 0),
                                  child: Container(
                                    height: ScreenUtils.screenheight(context) *
                                        0.04,
                                    width:
                                        ScreenUtils.screenwidth(context) * 0.27,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Color(0xff4a4f60),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Ok',
                                      style: GoogleFonts.poiretOne(
                                        textStyle: TextStyle(
                                            color: AppColors.ktextColorWhite,
                                            fontSize: ScreenUtils.screenwidth(
                                                    context) *
                                                0.038,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  height: ScreenUtils.screenheight(context) * 0.05,
                  width: ScreenUtils.screenwidth(context) * 0.48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color(0xff4a4f60),
                  ),
                  child: Center(
                      child: Text(
                    'Update Meter Value',
                    style: GoogleFonts.poiretOne(
                      textStyle: TextStyle(
                          color: AppColors.ktextColorWhite,
                          fontSize: ScreenUtils.screenwidth(context) * 0.045,
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
