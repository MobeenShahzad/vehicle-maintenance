import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehiclemaintenance/Edit_maintenance/components/background.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/addVehical/AddNewVehical.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:vehiclemaintenance/reminder.dart';

class Body extends StatefulWidget {
  DocumentSnapshot<Object?> maintenance;
  Body(
    this.maintenance, {
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
        "this is passed id miantenance form ${widget.maintenance["maintenance_uniquie_id"]}");
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
                  'Edit Maintenance',
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
            Padding(
              padding: const EdgeInsets.all(8.0) + EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _showDialog(context);
                      }
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
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
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
      }
      return DateTimeField.combine(date, time);
    } else {
      return selectedDate;
    }
  }

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
                          text: 'Edit Maintenance',
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
                          child: SmallText(text: 'Maintenance Date')),
                      Container(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          width: 100,
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
                          if (_formKey.currentState!.validate()) {}
                          await _notificationService.scheduleNotifications(
                            id: 1,
                            title: "Maintenance",
                            body: "It's time to maintenance",
                            time: fullDate,
                          );

                          _showDialogmini(context);

                          //TODO
                          print("id");
                          print(widget.maintenance['id']);
                          FirebaseFirestore.instance
                              .collection("maintenance")
                              .doc(widget.maintenance['id'])
                              .update({
                            "miantenancetype":
                                dropdownselectedMaintenance.toString(),
                            "km": _KmController.text,
                            "desc": _DescController.text,
                            "tolbyday": _TolbydayController.text,
                            "serialnumber": _SerialNumberController.text,
                            "maintenacedate": newTime,
                          });
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
