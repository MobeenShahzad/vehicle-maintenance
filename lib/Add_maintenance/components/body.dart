import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vehiclemaintenance/Add_maintenance/components/background.dart';
import 'package:vehiclemaintenance/Maintenance/maintenance.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/addVehical/AddNewVehical.dart';
import 'package:vehiclemaintenance/components/add_maintenance_card_item.dart';
import 'package:vehiclemaintenance/models/app_vehicle.dart';
import 'package:vehiclemaintenance/providers/auth_provider.dart';
import 'package:vehiclemaintenance/providers/vehicleprovider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:vehiclemaintenance/reminder.dart';
import 'package:scheduled_timer/scheduled_timer.dart';

class Body extends StatefulWidget {
  QueryDocumentSnapshot<Object?> vehicle;
  Body(
    this.vehicle, {
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  String radioButtonItem = 'ONE';
  int id = 1;
  //bool _value = false;

  final NotificationService _notificationService = NotificationService();
  DateTime selectedDate = DateTime.now();
  DateTime fullDate = DateTime.now();
  String endday = "";
  String startday = "";
  String newTime = "";

  bool checkBoxBooleanValueVariable = false;
  var dropdownselectedMaintenance;

  final _KmController = TextEditingController();
  final _SerialNumberController = TextEditingController();
  final _TolbydayController = TextEditingController();
  final _DescController = TextEditingController();
  final _TolerenceByKilometer = TextEditingController();

  final List<String> items = [
    'Brake Oil',
    'Gear Oil',
    'Radiator Water',
    'Battery Checking',
    'Ev Checking',
    'Engine Tuning',
    'Air Filter Maintenance',
    'Ac Filter Maintenance',
    'Tire Air Pressure',
    'Washer Fluid',
    'Water Level',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    print(
        "this is passed id miantenance form ${widget.vehicle["maintenance_uniquie_id"]}");
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Background(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.only(top: 250.0),
              child: Center(
                child: Text(
                  'Add Maintenance',
                  style: GoogleFonts.poiretOne(
                    textStyle: TextStyle(
                        color: Color(0xffc8c9cd),
                        fontSize: ScreenUtils.screenheight(context) * 0.038,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Maintenance Type",
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Text(
                            'Categories',
                            style: GoogleFonts.poiretOne(
                              textStyle: TextStyle(
                                  color: Color(0xffc8c9cd),
                                  fontSize:
                                      ScreenUtils.screenheight(context) * 0.016,
                                  fontWeight: FontWeight.w700),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.poiretOne(
                                    textStyle: TextStyle(
                                        color: Color(0xffc8c9cd),
                                        fontSize:
                                            ScreenUtils.screenheight(context) *
                                                0.016,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: dropdownselectedMaintenance,
                      onChanged: (value) {
                        setState(() {
                          dropdownselectedMaintenance = value as String;
                        });
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color.fromARGB(255, 198, 198, 198),
                        size: 25.0,
                      ),
                      iconOnClick: const Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.grey,
                      buttonHeight: 30,
                      buttonWidth: ScreenUtils.screenwidth(context) * 0.4,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: const Color(0xff393d4d),
                      ),
                      buttonElevation: 2,
                      itemHeight: 15,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight:
                          ScreenUtils.screenheight(context) * 0.2,
                      dropdownWidth: ScreenUtils.screenwidth(context) * 0.4,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xff393d4d),
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(0, 0),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "KM When Maintenance Due",
                                style: GoogleFonts.poiretOne(
                                  textStyle: TextStyle(
                                      color: Color(0xffc8c9cd),
                                      fontSize:
                                          ScreenUtils.screenheight(context) *
                                              0.016,
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
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize:
                                        ScreenUtils.screenheight(context) *
                                            0.017,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                                controller: _KmController,
                                maxLength: 6,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Empty field";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    errorStyle: GoogleFonts.poiretOne(
                                      color: Color.fromARGB(255, 253, 4, 4),
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          ScreenUtils.screenheight(context) *
                                              0.014,
                                    ),
                                    contentPadding:
                                        EdgeInsets.only(bottom: 5.0),
                                    border: InputBorder.none,
                                    //  hintText: "VehicleNumber",
                                    hintStyle: GoogleFonts.poiretOne(
                                      color: Color.fromARGB(255, 174, 169, 169),
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          ScreenUtils.screenheight(context) *
                                              0.015,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Maintenace Date",
                            style: GoogleFonts.poiretOne(
                              textStyle: TextStyle(
                                  color: Color(0xffc8c9cd),
                                  fontSize:
                                      ScreenUtils.screenheight(context) * 0.016,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        GestureDetector(
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
                              height: ScreenUtils.screenheight(context) * 0.037,
                              child: Center(
                                child: Text(
                                  newTime,
                                  style: GoogleFonts.poiretOne(
                                    textStyle: TextStyle(
                                        color: Color(0xffc8c9cd),
                                        fontSize:
                                            ScreenUtils.screenheight(context) *
                                                0.016,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              //  pickDateRange(context);
                              _selectDate(context);
                            }),
                      ],
                    ),
                  ],
                ),
                // Positioned(
                //   top: 0,
                //   bottom: 40,
                //   // right: 10,
                //   left: 8,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       // Padding(
                //       //   padding: const EdgeInsets.only(left: 25.0),
                //       //   child: Container(
                //       //     height: 4,
                //       //     width: 4,
                //       //     margin: EdgeInsets.only(right: 8.5),
                //       //     child: Radio(
                //       //       value: 1,
                //       //       groupValue: id,
                //       //       onChanged: (val) {
                //       //         setState(() {
                //       //           radioButtonItem = 'ONE';
                //       //           id = 1;
                //       //         });
                //       //       },
                //       //     ),
                //       //   ),
                //       // ),
                //       // Text(
                //       //   "KM When Maintenance Due",
                //       //   style: GoogleFonts.poiretOne(
                //       //     textStyle: TextStyle(
                //       //         color: Color(0xffc8c9cd),
                //       //         fontSize:
                //       //             ScreenUtils.screenheight(context) * 0.016,
                //       //         fontWeight: FontWeight.w700),
                //       //   ),
                //       // ),
                //       // Padding(
                //       //   padding: const EdgeInsets.only(left: 22.0),
                //       //   child: Container(
                //       //     height: 4,
                //       //     width: 4,
                //       //     margin: EdgeInsets.only(right: 8.5),
                //       //     child: Radio(
                //       //       value: 2,
                //       //       groupValue: id,
                //       //       onChanged: (val) {
                //       //         setState(() {
                //       //           radioButtonItem = 'TWO';
                //       //           id = 2;
                //       //         });
                //       //       },
                //       //     ),
                //       //   ),
                //       // ),
                //       // Text(
                //       //   "Maintenace Date",
                //       //   style: GoogleFonts.poiretOne(
                //       //     textStyle: TextStyle(
                //       //         color: Color(0xffc8c9cd),
                //       //         fontSize:
                //       //             ScreenUtils.screenheight(context) * 0.016,
                //       //         fontWeight: FontWeight.w700),
                //       //   ),
                //       // ),
                //     ],
                //   ),
                //  ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Serial Number (SN#)",
                          style: GoogleFonts.poiretOne(
                            textStyle: TextStyle(
                                color: Color(0xffc8c9cd),
                                fontSize:
                                    ScreenUtils.screenheight(context) * 0.016,
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
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.screenheight(context) * 0.017,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          keyboardType: TextInputType.text,
                          controller: _SerialNumberController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Empty field";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 5.0),
                              border: InputBorder.none,
                              //   hintText: "Serial Number",
                              hintStyle: GoogleFonts.poiretOne(
                                color: Color.fromARGB(255, 174, 169, 169),
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    ScreenUtils.screenheight(context) * 0.012,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // AddMaintenanceCardItem(
                  //   title: "Tolerence by KM",
                  //   onChanged: (value) {
                  //     print(value);
                  //   },
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Tolerence By Days",
                          style: GoogleFonts.poiretOne(
                            textStyle: TextStyle(
                                color: Color(0xffc8c9cd),
                                fontSize:
                                    ScreenUtils.screenheight(context) * 0.016,
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
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.screenheight(context) * 0.017,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                          controller: _TolbydayController,
                          maxLength: 3,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Empty field";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 5.0),
                              border: InputBorder.none,
                              //  hintText: "1-30",
                              hintStyle: GoogleFonts.poiretOne(
                                color: Color.fromARGB(255, 174, 169, 169),
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    ScreenUtils.screenheight(context) * 0.015,
                              )),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Tolerence By Km",
                          style: GoogleFonts.poiretOne(
                            textStyle: TextStyle(
                                color: Color(0xffc8c9cd),
                                fontSize:
                                    ScreenUtils.screenheight(context) * 0.016,
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
                        child: TextFormField(
                          style: TextStyle(
                              fontSize:
                                  ScreenUtils.screenheight(context) * 0.017,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                          controller: _TolerenceByKilometer,
                          maxLength: 6,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Empty field";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 5.0),
                              border: InputBorder.none,
                              //  hintText: "1-30",
                              hintStyle: GoogleFonts.poiretOne(
                                color: Color.fromARGB(255, 174, 169, 169),
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    ScreenUtils.screenheight(context) * 0.015,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 280.0, bottom: 5),
              child: Text(
                "Description",
                style: GoogleFonts.poiretOne(
                  textStyle: TextStyle(
                      color: Color(0xffc8c9cd),
                      fontSize: ScreenUtils.screenheight(context) * 0.016,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              //   margin: const EdgeInsets.all(5.0),
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
              width: ScreenUtils.screenwidth(context) * 0.87,
              height: ScreenUtils.screenheight(context) * 0.12,

              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextFormField(
                  style: TextStyle(
                      fontSize: ScreenUtils.screenheight(context) * 0.017,
                      color: Color.fromARGB(255, 253, 253, 253)),
                  textAlign: TextAlign.start,
                  controller: _DescController,
                  maxLength: 300,
                  maxLines: null,
                  minLines: 1,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Empty field";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 13.0),
                      border: InputBorder.none,
                      // hintText: "",
                      hintStyle: GoogleFonts.poiretOne(
                        color: Color.fromARGB(255, 174, 169, 169),
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtils.screenheight(context) * 0.012,
                      )),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 20.0),
            //   child: Radio(
            //     value: 1,
            //     groupValue: id,
            //     onChanged: (val) {
            //       setState(() {
            //         //  radioButtonItem = 'ONE';
            //         id = 1;
            //         value:
            //         1;
            //       });
            //     },
            //   ),
            // ),

            // Center(
            //     child: InkWell(
            //   onTap: () {
            //     setState(() {
            //       _value = !_value;
            //     });
            //   },
            //   child: Container(
            //     height: ScreenUtils.screenheight(context) * 0.04,
            //     width: ScreenUtils.screenwidth(context) * 0.04,
            //     decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: Color.fromARGB(255, 240, 238, 238)),
            //     child: Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: _value
            //           ? Icon(
            //               Icons.circle,
            //               size: 10.0,
            //               color: Color.fromARGB(255, 91, 125, 197),
            //             )
            //           : Icon(
            //               Icons.check_box_outline_blank,
            //               size: 10.0,
            //               color: Color.fromARGB(255, 11, 11, 12),
            //             ),
            //     ),
            //   ),
            // )),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Container(
            //       child: Padding(
            //         padding: const EdgeInsets.only(left: 13.0),
            //         child: Checkbox(
            //           checkColor: Color.fromARGB(255, 255, 255, 255),

            //           activeColor: Color.fromARGB(255, 65, 89, 186),
            //           shape: const CircleBorder(), // Rounded Checkbox
            //           value: checkBoxBooleanValueVariable,
            //           onChanged: (inputValue) {
            //             setState(() {
            //               checkBoxBooleanValueVariable = inputValue!;
            //             });
            //           },
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(right: 0.0),
            //       child: Container(
            //         margin: const EdgeInsets.only(right: 20),
            //         child: Text(
            //           "Recurring Maintenance ",
            //           style: GoogleFonts.poiretOne(
            //             textStyle: TextStyle(
            //                 color: Color(0xffc8c9cd),
            //                 fontSize: ScreenUtils.screenheight(context) * 0.016,
            //                 fontWeight: FontWeight.w700),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     AddMaintenanceCardItem(
            //       title: "Days",
            //       onChanged: (value) {
            //         print(value);
            //       },
            //     ),
            //     AddMaintenanceCardItem(
            //       title: "KM",
            //       onChanged: (value) {
            //         print(value);
            //       },
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0) + EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // SaveData();
                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(SnackBar(
                        //   content: Text("File Save"),
                        // ));

                        _showDialog(context);
                      }

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const Maintenance(),
                      //  ));
                    },
                    child: Container(
                      height: ScreenUtils.screenheight(context) * 0.04,
                      width: ScreenUtils.screenwidth(context) * 0.27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xff4a4f60),
                      ),
                      child: Center(
                          child: Text(
                        'Register',
                        style: GoogleFonts.poiretOne(
                          textStyle: TextStyle(
                              color: AppColors.ktextColorWhite,
                              fontSize:
                                  ScreenUtils.screenwidth(context) * 0.038,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                    ),
                  ),
                  // SizedBox(
                  //   width: ScreenUtils.screenwidth(context) * 0.03,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => const Maintenance(),
                  //         ));
                  //   },
                  //   child: Container(
                  //     height: ScreenUtils.screenheight(context) * 0.04,
                  //     width: ScreenUtils.screenwidth(context) * 0.27,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5.0),
                  //       color: Color(0xff4a4f60),
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //       'Cancel',
                  //       style: GoogleFonts.poiretOne(
                  //         textStyle: TextStyle(
                  //             color: AppColors.ktextColorWhite,
                  //             fontSize:
                  //                 ScreenUtils.screenwidth(context) * 0.038,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     )),
                  //   ),
                  // ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    DateTime a;
    //int a = 5;
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: selectedDate,
        lastDate: DateTime(2100));
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );
      if (time != null) {
        setState(() {
          fullDate = DateTimeField.combine(date, time);
          startday = date.toString();
          newTime = date.day.toString() +
              "/" +
              date.month.toString() +
              "/" +
              date.year.toString();
        });

        //schedule a notification
        //     await _notificationService.scheduleNotifications(
        // id: widget.id,
        // title: widget.title,
        // body: widget.content,
        // time: fullDate);
        //           switch (dropdownselectedMaintenance) {
        //   case 'Brake Oil':
        //     // do something
        //     break;
        //      case 'Gear Oil':
        //     // do something
        //     break;
        //      case 'Radiator Water':
        //     // do something
        //     break;

        // }
      }
      return DateTimeField.combine(date, time);
    } else {
      return selectedDate;
      print(selectedDate);
    }
  }

  // DateTime? dateRange;
  // //  DateTime dateRange;
  // DateTime? dateRange2;
  // // DateTime dateRange2;
  // String getFrom() {
  //   if (dateRange == null) {
  //     return 'Start';
  //   } else {
  //     return DateFormat('yyyy-MM-dd').format(dateRange!);
  //   }
  // }

  // Future pickDateRange(BuildContext context) async {
  //   final initialDate = DateTime.now();
  //   final newDate = await showDatePicker(
  //     context: context,
  //     initialDate: initialDate,
  //     firstDate: DateTime(DateTime.now().year - 5),
  //     lastDate: DateTime(DateTime.now().year + 5),
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: ColorScheme.light(
  //             primary: Color(0xff4a4f60), // header background color
  //             onPrimary:
  //                 Color.fromARGB(255, 181, 171, 171), // header text color
  //             onSurface: Colors.black, // body text color
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               primary: Color(0xff4a4f60), // button text color
  //             ),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //   if (newDate == null) return;
  //   setState(() {
  //     dateRange = newDate;
  //     print("$newDate");
  //   });
  // }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Color.fromRGBO(33, 40, 48, 1.0),
            insetPadding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: ScreenUtils.screenheight(context) * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LargeText(
                          text: 'Add Maintenance',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Divider(
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 40, top: 10),
                        width: 200,
                        child: SmallText(text: 'KM when maintenance due'),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          width: 100,
                          child: SmallText(text: _KmController.text)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 200,
                          child: SmallText(text: 'Serial Number (SN#)')),
                      Container(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          width: 100,
                          child: SmallText(text: _SerialNumberController.text)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 200,
                          child: SmallText(text: 'Maintenance Type*')),
                      Container(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          width: 100,
                          child: SmallText(
                              text: dropdownselectedMaintenance.toString())),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 200,
                          child: SmallText(text: 'Tolerance by Days')),
                      Container(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          width: 100,
                          child: SmallText(text: _TolbydayController.text)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 200,
                          child: SmallText(text: 'Tolerence by Km')),
                      Container(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          width: 120,
                          child: SmallText(text: _TolerenceByKilometer.text)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 200,
                          child: SmallText(text: 'Maintenance Date')),
                      Container(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          width: 120,
                          child: SmallText(text: newTime)),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 40, top: 30),
                      child: SmallText(text: "Description")),
                  Padding(
                    padding: EdgeInsets.only(left: 40, top: 10),
                    child: Container(
                      color: Color.fromRGBO(50, 61, 77, 1),
                      height: ScreenUtils.screenheight(context) * 0.2,
                      width: ScreenUtils.screenwidth(context) * 0.7,
                      child: SmallText(text: _DescController.text),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            //  SaveData();
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content: Text("File Save"),
                            // ));

                            //   _showDialog(context);
                          }
                          // await _notificationService.scheduleNotifications(
                          //   id: 1,
                          //   title: "Maintenance",
                          //   body: "It's time to maintenance 1",
                          //   time: fullDate,
                          // );

                          // await _notificationService.scheduleNotifications(
                          //   id: 1,
                          //   title: "Maintenance",
                          //   body: "It's time to maintenance 1",
                          //   time: fullDate,
                          // );

                          print(dropdownselectedMaintenance);
                          switch (dropdownselectedMaintenance) {
                            case 'Brake Oil':
                              fullDate.add(Duration(
                                days: 14,
                              ));
                              await _notificationService.scheduleNotifications(
                                id: 1,
                                title: "Brake Oil Maintenance",
                                body: "It's time to Check Brake Oil",
                                time: fullDate,
                              );
                              await _notificationService.scheduleNotifications(
                                id: 2,
                                title: "Brake Oil Maintenance",
                                body: "It's time to Check Brake Oil",
                                time: fullDate.add(
                                  Duration(
                                    days: fullDate.day +
                                        int.parse(_TolbydayController.text),
                                  ),
                                ),
                              );
                              // do something
                              break;

                            case 'Gear Oil':
                              fullDate.add(Duration(
                                days: 15,
                              ));
                              await _notificationService.scheduleNotifications(
                                id: 1,
                                title: "Gear Oil Maintenance",
                                body: "It's time to Check Gear Oil",
                                time: fullDate,
                              );
                              await _notificationService.scheduleNotifications(
                                id: 2,
                                title: "Gear Oil Maintenance",
                                body: "It's time to Check Gear Oil",
                                time: fullDate.add(
                                  Duration(
                                    days: fullDate.day +
                                        int.parse(_TolbydayController.text),
                                  ),
                                ),
                              );
                              // do something

                              break;
                            case 'Radiator Water':
                              fullDate.add(Duration(
                                days: 2,
                              ));
                              await _notificationService.scheduleNotifications(
                                id: 1,
                                title: "Radiator Water Maintenance",
                                body: "It's time to Check Radiator Water",
                                time: fullDate,
                              );
                              await _notificationService.scheduleNotifications(
                                id: 2,
                                title: "Radiator Water Maintenance",
                                body: "It's time to Check Radiator Water",
                                time: fullDate.add(
                                  Duration(
                                    days: fullDate.day +
                                        int.parse(_TolbydayController.text),
                                  ),
                                ),
                              );
                              // do something
                              break;

                            case 'Battery Checking':
                              await _notificationService.weeklyNotifications(
                                id: 1,
                                title: "Water Level Maintenance",
                                body: "It's time to check water level",
                                time: fullDate,
                              );
                              print("reminder 1");

                              await _notificationService.scheduleNotifications(
                                id: 2,
                                title: "Water Level Maintenance",
                                body: "It's time to check water level",
                                time: fullDate.day +
                                    int.parse(_TolbydayController.text),
                              );
                              // fullDate.add(Duration(
                              //   days: 7,
                              // ));
                              // await _notificationService.scheduleNotifications(
                              //   id: 1,
                              //   title: "Battery Maintenance ",
                              //   body: "It's time to Check Battery",
                              //   time: fullDate,
                              // );
                              // await _notificationService.scheduleNotifications(
                              //   id: 2,
                              //   title: "Battery Maintenance ",
                              //   body: "It's time to Check Battery",
                              //   time: fullDate.add(
                              //     Duration(
                              //       days: fullDate.day +
                              //           int.parse(_TolbydayController.text),
                              //     ),
                              //   ),
                              // );
                              // do something
                              break;

                            case 'Ev Checking':
                              fullDate.add(Duration(
                                days: 30,
                              ));
                              await _notificationService.scheduleNotifications(
                                id: 1,
                                title: "Ev Maintenance",
                                body: "It's time to Check EV",
                                time: fullDate,
                              );
                              await _notificationService.scheduleNotifications(
                                id: 2,
                                title: "Ev Maintenance",
                                body: "It's time to Check EV",
                                time: fullDate.add(
                                  Duration(
                                    days: fullDate.day +
                                        int.parse(_TolbydayController.text),
                                  ),
                                ),
                              );
                              // do something
                              break;

                            case 'Engine Tuning':
                              fullDate.add(Duration(
                                days: 30,
                              ));
                              await _notificationService.scheduleNotifications(
                                id: 1,
                                title: "Engine Tunning Maintenance",
                                body: "It's time to tune your Engine",
                                time: fullDate,
                              );
                              await _notificationService.scheduleNotifications(
                                id: 2,
                                title: "Engine Tunning Maintenance",
                                body: "It's time to tune your Engine",
                                time: fullDate.add(
                                  Duration(
                                    days: fullDate.day +
                                        int.parse(_TolbydayController.text),
                                  ),
                                ),
                              );
                              // do something
                              break;

                            case 'Air Filter Maintenance':
                              fullDate.add(Duration(
                                days: 30,
                              ));
                              await _notificationService.scheduleNotifications(
                                id: 1,
                                title: "Air Filter Maintenance",
                                body: "It's time to Change Air Filter",
                                time: fullDate,
                              );
                              await _notificationService.scheduleNotifications(
                                id: 2,
                                title: "Air Filter Maintenance",
                                body: "It's time to Change Air Filter",
                                time: fullDate.add(
                                  Duration(
                                    days: fullDate.day +
                                        int.parse(_TolbydayController.text),
                                  ),
                                ),
                              );
                              // do something
                              break;
                            case 'Ac Filter Maintenance':
                              fullDate.add(Duration(
                                days: 90,
                              ));
                              await _notificationService.scheduleNotifications(
                                id: 1,
                                title: "Ac Filter Maintenance",
                                body: "It's time to Chnage AC Filter",
                                time: fullDate,
                              );
                              await _notificationService.scheduleNotifications(
                                id: 2,
                                title: "Ac Filter Maintenance",
                                body: "It's time to Chnage AC Filter",
                                time: fullDate.add(
                                  Duration(
                                    days: fullDate.day +
                                        int.parse(_TolbydayController.text),
                                  ),
                                ),
                              );
                              // do something
                              break;

                            case 'Tire Air Pressure':
                              fullDate.add(Duration(
                                days: 7,
                              ));
                              await _notificationService.scheduleNotifications(
                                id: 1,
                                title: "Tire Air Pressure Maintenance",
                                body: "It's time to check Tire Air Pressure",
                                time: fullDate,
                              );
                              await _notificationService.scheduleNotifications(
                                  id: 2,
                                  title: "Tire Air Pressure Maintenance",
                                  body: "It's time to check Tire Air Pressure",
                                  time: fullDate.add(Duration(
                                    days: fullDate.day +
                                        int.parse(_TolbydayController.text),
                                  )));

                              // do something
                              break;

                            case 'Washer Fluid':
                              fullDate.add(Duration(
                                days: 15,
                              ));
                              await _notificationService.scheduleNotifications(
                                id: 1,
                                title: "Washer Fluid Maintenance",
                                body: "It's time to Check Washer Fluid",
                                time: fullDate,
                              );
                              await _notificationService.scheduleNotifications(
                                  id: 2,
                                  title: "Washer Fluid Maintenance",
                                  body: "It's time to Check Washer Fluid",
                                  time: fullDate.add(Duration(
                                    days: fullDate.day +
                                        int.parse(_TolbydayController.text),
                                  )));
                              // do something
                              break;
                            case 'Water Level':
                              print(dropdownselectedMaintenance);
                              // fullDate.add(Duration(
                              //   days: 2,
                              // ));
                              await _notificationService.dailyNotifications(
                                id: 1,
                                title: "Water Level Maintenance",
                                body: "It's time to check water level",
                                time: fullDate,
                              );
                              print("reminder 1");

                              await _notificationService.scheduleNotifications(
                                id: 2,
                                title: "Water Level Maintenance",
                                body: "It's time to check water level",
                                time: fullDate.day +
                                    int.parse(_TolbydayController.text),
                              );

                              // do something else
                              // Timer.periodic(
                              //   Duration(seconds: 1),
                              //   await _notificationService.dailyNotifications(
                              //     id: Random(),
                              //     title: "Water Level Maintenance",
                              //     body: "It's time to check water level",
                              //     time: fullDate,
                              //   ),
                              // );

                              //

                              // Timer timer = Timer.periodic(
                              //     Duration(seconds: 1),
                              //     (time) async => await _notificationService
                              //         .dailyNotifications(
                              //             id: 2,
                              //             title: "Water Level Maintenance",
                              //             body:
                              //                 "It's time to check water level",
                              //             time: fullDate
                              //             //  fullDate.add(
                              //             //   Duration(
                              //             //     days: fullDate.day +
                              //             //         int.parse(_TolbydayController.text),
                              //             //   ),
                              //             // ),
                              //             ));

                              // await _notificationService.dailyNotifications(
                              //     id: 2,
                              //     title: "Water Level Maintenance",
                              //     body: "It's time to check water level",
                              //     time: fullDate
                              //     //  fullDate.add(
                              //     //   Duration(
                              //     //     days: fullDate.day +
                              //     //         int.parse(_TolbydayController.text),
                              //     //   ),
                              //     // ),
                              //     );
                              // print("reminder 2");

                              // _notification2() {
                              //   return FutureBuilder(
                              //     future: LongTimeNoNotification.findBy(
                              //         'notification_2'),
                              //     builder: (context,
                              //         AsyncSnapshot<LongTimeNoNotification?>
                              //             snapshot) {
                              //       if (snapshot.data == null ||
                              //           snapshot.data!.shouldNotify()) {
                              //         return Card(
                              //           child: ListTile(
                              //             title: const Text('Notification2'),
                              //             subtitle: const Text(
                              //                 'Display again in 7 days.'),
                              //             trailing: IconButton(
                              //               icon: const Icon(Icons.clear),
                              //               onPressed: () {
                              //                 setState(() {
                              //                   LongTimeNoNotification
                              //                       .setDuration(
                              //                           id: 'notification_2',
                              //                           duration:
                              //                               const Duration(
                              //                                   seconds: 10));
                              //                 });
                              //               },
                              //             ),
                              //           ),
                              //         );
                              //       } else {
                              //         return Container();
                              //       }
                              //     },
                              //   );
                              // }

                              break;
                          }
                          print(_TolbydayController);

                          // if (dropdownselectedMaintenance == 'Water Level') {
                          //   await _notificationService.scheduleNotifications(
                          //       id: 1,
                          //       title: "Water Level Maintenance",
                          //       body: "It's time to check water level",
                          //       time: fullDate.add(Duration(
                          //         days: fullDate.day +
                          //             int.parse(_TolbydayController.text),
                          //       )));
                          // } else {}

                          //TODO

                          _showDialogmini(context);
                          Provider.of<HomeNotifier>(context, listen: false)
                              .uploadMaintenance(
                            context,
                            miantenancetype:
                                dropdownselectedMaintenance.toString(),
                            km: _KmController.text,
                            maintenacedate: newTime,
                            serialnumber: _SerialNumberController.text,
                            tolbyday: _TolbydayController.text,
                            tolbykm: _TolerenceByKilometer.text,
                            desc: _DescController.text,

                            maintenance_uniquie_id:
                                widget.vehicle["maintenance_uniquie_id"],
                            // FirebaseFirestore.instance
                            //     .collection("vehicles")
                            //     .toString(),
                            uid: Provider.of<AuthProvider>(context,
                                    listen: false)
                                .currentUser
                                .uid,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, right: 0, left: 60),
                          child: Container(
                            height: ScreenUtils.screenheight(context) * 0.04,
                            width: ScreenUtils.screenwidth(context) * 0.27,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xff4a4f60),
                            ),
                            child: Center(
                                child: Text(
                              'Save',
                              style: GoogleFonts.poiretOne(
                                textStyle: TextStyle(
                                    color: AppColors.ktextColorWhite,
                                    fontSize: ScreenUtils.screenwidth(context) *
                                        0.038,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, right: 60, left: 0),
                          child: Container(
                            height: ScreenUtils.screenheight(context) * 0.04,
                            width: ScreenUtils.screenwidth(context) * 0.27,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xff4a4f60),
                            ),
                            child: Center(
                                child: Text(
                              'Cancel',
                              style: GoogleFonts.poiretOne(
                                textStyle: TextStyle(
                                    color: AppColors.ktextColorWhite,
                                    fontSize: ScreenUtils.screenwidth(context) *
                                        0.038,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             if (file != null) {
              //               if (_formKey.currentState!.validate()) {
              //                 //  SaveData();
              //                 // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //                 //   content: Text("File Save"),
              //                 // ));

              //                 //   _showDialog(context);
              //               }
              //               _showDialogmini(context);
              //               Provider.of<HomeNotifier>(context, listen: false)
              //                   .uploadVehicle(
              //                 context,
              //                 vehiclenumber: _VehicleNumberController.text,
              //                 maker: _MakerController.text,
              //                 manufactureyear:
              //                     int.parse(_ManufactureYearController.text),
              //                 model: int.parse(_ModelController.text),
              //                 enginenumber: _EngineController.text,
              //                 metervalue: int.parse(_MeterValueController.text),
              //                 image: file!,
              //                 loginuser: Provider.of<AuthProvider>(context,
              //                         listen: false)
              //                     .currentUser
              //                     .uid,
              //               );
              //             } else {
              //               ScaffoldMessenger.of(context).showSnackBar(
              //                   SnackBar(content: Text("please pick image")));
              //             }
              //           },
              //           child: Padding(
              //             padding: const EdgeInsets.only(
              //                 top: 15.0, right: 0, left: 60),
              //             child: Container(
              //               height: ScreenUtils.screenheight(context) * 0.04,
              //               width: ScreenUtils.screenwidth(context) * 0.27,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(15.0),
              //                 color: Color(0xff4a4f60),
              //               ),
              //               child: Center(
              //                   child: Text(
              //                 'Save',
              //                 style: GoogleFonts.poiretOne(
              //                   textStyle: TextStyle(
              //                       color: AppColors.ktextColorWhite,
              //                       fontSize: ScreenUtils.screenwidth(context) *
              //                           0.038,
              //                       fontWeight: FontWeight.bold),
              //                 ),
              //               )),
              //             ),
              //           ),
              //         ),
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.of(context).pop();
              //           },
              //           child: Padding(
              //             padding: const EdgeInsets.only(
              //                 top: 15.0, right: 60, left: 0),
              //             child: Container(
              //               height: ScreenUtils.screenheight(context) * 0.04,
              //               width: ScreenUtils.screenwidth(context) * 0.27,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(15.0),
              //                 color: Color(0xff4a4f60),
              //               ),
              //               child: Center(
              //                   child: Text(
              //                 'Cancel',
              //                 style: GoogleFonts.poiretOne(
              //                   textStyle: TextStyle(
              //                       color: AppColors.ktextColorWhite,
              //                       fontSize: ScreenUtils.screenwidth(context) *
              //                           0.038,
              //                       fontWeight: FontWeight.bold),
              //                 ),
              //               )),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
            ),
          );
        });
  }

  void _showDialogmini(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Color.fromRGBO(33, 40, 48, 1.0),
            insetPadding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: ScreenUtils.screenheight(context) * 0.27,
              width: ScreenUtils.screenwidth(context) * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LargeText(
                          text: 'Maintenance Registered',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Divider(
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 0, top: 40),
                      //width: ScreenUtils.screenwidth(context) * 0.7,
                      child: SmallText(
                        text: "Maintenance Added Successfully !",
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 40.0, right: 0, left: 0),
                      child: Container(
                        height: ScreenUtils.screenheight(context) * 0.04,
                        width: ScreenUtils.screenwidth(context) * 0.27,
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
                                fontSize:
                                    ScreenUtils.screenwidth(context) * 0.038,
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
  }
}
