import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:vehiclemaintenance/Maintenance/maintenance.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/addVehical/AddNewVehical.dart';
import 'package:vehiclemaintenance/resetpassword/resetpassword.dart';
import 'package:vehiclemaintenance/updatemeter/components/background.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _count = 0;
  final _CounterController = TextEditingController();

  int length = 0;
  _onchange(value) {
    setState(() {
      length = value.length;
    });
    if (length == 6) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                new Text('Sorry, You have Reached the Maximum input limit...'),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

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
              max: 6,
              onChanged: _onchange,
              controller: _CounterController,
              incDecBgColor: Color.fromARGB(255, 255, 255, 255),
              buttonArrangement: ButtonArrangement.incRightDecLeft,
              incIcon: Icons.add,
              decIcon: Icons.remove,
            ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       GestureDetector(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Container(
            //               height: ScreenUtils.screenheight(context) * 0.025,
            //               width: ScreenUtils.screenwidth(context) * 0.05,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(5.0),
            //                   border: Border.all(
            //                     color: AppColors.kgreyLightColor,
            //                   )),
            //               child: Center(
            //                   child: Icon(
            //                 Icons.remove,
            //                 size: ScreenUtils.screenheight(context) * 0.02,
            //               ))),
            //         ),
            //         onTap: decrementcount,
            //       ),
            //       Text("$_count"),
            //       GestureDetector(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Container(
            //               height: ScreenUtils.screenheight(context) * 0.025,
            //               width: ScreenUtils.screenwidth(context) * 0.05,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(5.0),
            //                   border: Border.all(
            //                     color: AppColors.kgreyLightColor,
            //                   )),
            //               child: Center(
            //                   child: Icon(
            //                 Icons.add,
            //                 size: ScreenUtils.screenheight(context) * 0.02,
            //               ))),
            //         ),
            //         onTap: incrementcount,
            //       ),
            //     ],
            //   ),
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => Maintenance(),
                //     ));
                QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                    .collection("maintenance")
                    .get();
                for (int i = 0; i < querySnapshot.docs.length; i++) {
                  String a = querySnapshot.docs[i]["id"];
                  int kmprev = int.parse(querySnapshot.docs[i]["km"]);
                  // print(kmprev);
                  int contp = int.parse(_CounterController.text);
                  int kmf = kmprev + contp;
                  print(a);
                  FirebaseFirestore.instance
                      .collection("maintenance")
                      .doc(a)
                      .update({
                    "km": kmf.toString(), //+ kmprev,
                  });
                }
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

//   void incrementcount() {
//     setState(() {
//       _count++;
//     });
//   }

//   void decrementcount() {
//     setState(() {
//       _count--;
//     });
//   }
}
