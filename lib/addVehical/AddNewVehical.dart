import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/providers/auth_provider.dart';
import 'package:vehiclemaintenance/providers/vehicleprovider.dart';
import 'package:vehiclemaintenance/addVehical/components/background.dart';

class AddNewVehical extends StatefulWidget {
  const AddNewVehical({Key? key}) : super(key: key);

  @override
  State<AddNewVehical> createState() => _AddNewVehicalState();
}

class _AddNewVehicalState extends State<AddNewVehical> {
  final _formKey = GlobalKey<FormState>();

  File? file;
  // final _vehiprefdata = PreferencesService();

  final _MakerController = TextEditingController();
  final _VehicleNumberController = TextEditingController();
  final _ManufactureYearController = TextEditingController();
  final _ModelController = TextEditingController();
  final _EngineController = TextEditingController();
  final _MeterValueController = TextEditingController();
  var Imagetext = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Background(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 140),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40, left: 4),
                        width: ScreenUtils.screenwidth(context) * 0.9,
                        child: Text(
                          'Add Vehicle',
                          style: GoogleFonts.poiretOne(
                            textStyle: TextStyle(
                                color: Color(0xffc8c9cd),
                                fontSize:
                                    ScreenUtils.screenheight(context) * 0.045,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PhysicalModel(
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
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.35,
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.032,
                                        decoration: BoxDecoration(
                                          color: AppColors.kgreyLightColor,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        padding: EdgeInsets.only(bottom: 1.0),
                                        child: Center(
                                          child: Text(
                                            "VehicleNumber",
                                            style: GoogleFonts.poiretOne(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.017),
                                          ),
                                        )),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    child: ClipRRect(
                                      child: Container(
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.3,
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.03,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenUtils.screenheight(
                                                          context) *
                                                      0.017,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                          controller: _VehicleNumberController,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          maxLength: 10,
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Empty field";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              errorStyle: GoogleFonts.poiretOne(
                                                color: Color.fromARGB(
                                                    255, 253, 4, 4),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.013,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 0.0),
                                              border: InputBorder.none,
                                              hintText: "VehicleNumber",
                                              hintStyle: GoogleFonts.poiretOne(
                                                color: Color.fromARGB(
                                                    255, 174, 169, 169),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.015,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Positioned(child: Icon(icon)),
                                ],
                              ),
                            ),
                          ),
                          PhysicalModel(
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
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.35,
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.032,
                                        decoration: BoxDecoration(
                                          color: AppColors.kgreyLightColor,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        padding: EdgeInsets.only(bottom: 1.0),
                                        child: Center(
                                          child: Text(
                                            "Maker",
                                            style: GoogleFonts.poiretOne(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.017),
                                          ),
                                        )),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    child: ClipRRect(
                                      child: Container(
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.3,
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.03,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenUtils.screenheight(
                                                          context) *
                                                      0.017,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                          controller: _MakerController,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          maxLength: 10,
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Empty field";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              errorStyle: GoogleFonts.poiretOne(
                                                color: Color.fromARGB(
                                                    255, 253, 4, 4),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.013,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 0.0),
                                              border: InputBorder.none,
                                              hintText: "Maker",
                                              hintStyle: GoogleFonts.poiretOne(
                                                color: Color.fromARGB(
                                                    255, 174, 169, 169),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.015,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtils.screenheight(context) * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // AddVehicalCardItem(
                          //   title: "Manufacture Year",
                          //   onChanged: (value) {
                          //     print(value);
                          //   },
                          //   hintText: "Make year",
                          // ),

                          PhysicalModel(
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
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.35,
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.032,
                                        decoration: BoxDecoration(
                                          color: AppColors.kgreyLightColor,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        padding: EdgeInsets.only(bottom: 1.0),
                                        child: Center(
                                          child: Text(
                                            "Manufacture Year",
                                            style: GoogleFonts.poiretOne(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.017),
                                          ),
                                        )),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    child: ClipRRect(
                                      child: Container(
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.3,
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.03,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenUtils.screenheight(
                                                          context) *
                                                      0.017,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                          controller:
                                              _ManufactureYearController,
                                          keyboardType: TextInputType.number,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          maxLength: 4,
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Empty field";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              errorStyle: GoogleFonts.poiretOne(
                                                color: Color.fromARGB(
                                                    255, 253, 4, 4),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.013,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 0.0),
                                              border: InputBorder.none,
                                              hintText: "Manufacture Year",
                                              hintStyle: GoogleFonts.poiretOne(
                                                color: Color.fromARGB(
                                                    255, 174, 169, 169),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.015,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          PhysicalModel(
                            color: Colors.transparent,
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
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.35,
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.032,
                                        decoration: BoxDecoration(
                                          color: AppColors.kgreyLightColor,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        padding: EdgeInsets.only(bottom: 1.0),
                                        child: Center(
                                          child: Text(
                                            "Generation",
                                            style: GoogleFonts.poiretOne(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.017),
                                          ),
                                        )),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    child: ClipRRect(
                                      child: Container(
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.3,
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.03,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenUtils.screenheight(
                                                          context) *
                                                      0.017,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                          controller: _ModelController,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          maxLength: 2,
                                          keyboardType: TextInputType.number,
                                          // validator: (val) {
                                          //   if (val!.isEmpty) {
                                          //     return "Empty field";
                                          //   }
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                              errorStyle: GoogleFonts.poiretOne(
                                                color: Color.fromARGB(
                                                    255, 253, 4, 4),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.013,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 0.0),
                                              border: InputBorder.none,
                                              hintText: "Generation",
                                              hintStyle: GoogleFonts.poiretOne(
                                                color: Color.fromARGB(
                                                    255, 174, 169, 169),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.015,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtils.screenheight(context) * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PhysicalModel(
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
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.35,
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.032,
                                        decoration: BoxDecoration(
                                          color: AppColors.kgreyLightColor,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        padding: EdgeInsets.only(bottom: 1.0),
                                        child: Center(
                                          child: Text(
                                            "Engine Number",
                                            style: GoogleFonts.poiretOne(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.017),
                                          ),
                                        )),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    child: ClipRRect(
                                      child: Container(
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.3,
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.03,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenUtils.screenheight(
                                                          context) *
                                                      0.017,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                          controller: _EngineController,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          maxLength: 20,
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Empty field";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              errorStyle: GoogleFonts.poiretOne(
                                                color: Color.fromARGB(
                                                    255, 253, 4, 4),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.013,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 0.0),
                                              border: InputBorder.none,
                                              hintText: "Engine Number",
                                              hintStyle: GoogleFonts.poiretOne(
                                                color: Color.fromARGB(
                                                    255, 174, 169, 169),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.015,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          PhysicalModel(
                            color: Colors.transparent,
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
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.35,
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.032,
                                        decoration: BoxDecoration(
                                          color: AppColors.kgreyLightColor,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        padding: EdgeInsets.only(bottom: 1.0),
                                        child: Center(
                                          child: Text(
                                            "Meter Value",
                                            style: GoogleFonts.poiretOne(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.017),
                                          ),
                                        )),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    child: ClipRRect(
                                      child: Container(
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.3,
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.03,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenUtils.screenheight(
                                                          context) *
                                                      0.017,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                          controller: _MeterValueController,
                                          maxLength: 6,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          keyboardType: TextInputType.number,
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Meter Value";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              errorStyle: GoogleFonts.poiretOne(
                                                color: Color.fromARGB(
                                                    255, 253, 4, 4),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.013,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.only(bottom: .0),
                                              border: InputBorder.none,
                                              hintText: "Meter Value",
                                              hintStyle: GoogleFonts.poiretOne(
                                                color: Color.fromARGB(
                                                    255, 174, 169, 169),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.015,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtils.screenheight(context) * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 190.0),
                        child: PhysicalModel(
                          color: Colors.transparent,
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
                              children: [
                                Positioned(
                                  bottom: 34,
                                  child: Container(
                                      width: ScreenUtils.screenwidth(context) *
                                          0.35,
                                      height:
                                          ScreenUtils.screenheight(context) *
                                              0.032,
                                      decoration: BoxDecoration(
                                        color: AppColors.kgreyLightColor,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      padding: EdgeInsets.only(bottom: 1.0),
                                      child: Center(
                                        child: Text(
                                          "Upload Vehicle Picture",
                                          style: GoogleFonts.poiretOne(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  ScreenUtils.screenheight(
                                                          context) *
                                                      0.017),
                                        ),
                                      )),
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: 22,
                                  child: Container(
                                    width:
                                        ScreenUtils.screenwidth(context) * 0.22,
                                    height: ScreenUtils.screenheight(context) *
                                        0.03,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        Imagetext.length > 10
                                            ? Imagetext.substring(0, 10) + '...'
                                            : Imagetext,
                                        style: GoogleFonts.poiretOne(
                                          color: Color.fromARGB(
                                              255, 174, 169, 169),
                                          fontWeight: FontWeight.w700,
                                          fontSize: ScreenUtils.screenheight(
                                                  context) *
                                              0.017,
                                        ),
                                        //onChanged: widget.onChanged,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: 120,
                                  child: InkWell(
                                    onTap: () async {
                                      final ImageSource? source =
                                          await ScreenUtils.imagePickOptions(
                                              context);
                                      if (source != null) {
                                        final rawFile = await ImagePicker()
                                            .pickImage(source: source);
                                        if (rawFile != null) {
                                          setState(() {
                                            file = File(rawFile.path);
                                            Imagetext =
                                                File(rawFile.name).toString();
                                          });
                                        }
                                        // final file = File();
                                      }
                                    },
                                    child: ImageIcon(
                                      AssetImage("assets/upload-3.png"),
                                      color: Color.fromARGB(255, 122, 196, 218),
                                      size: ScreenUtils.screenheight(context) *
                                          0.025,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            if (file != null) {
                              if (_formKey.currentState!.validate()) {
                                _showDialog(context);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("please pick image")));
                            }
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, right: 190),
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
                                          ScreenUtils.screenwidth(context) *
                                              0.038,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
              height: ScreenUtils.screenheight(context) * 0.57,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LargeText(
                          text: 'Add Vehicle',
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
                  Container(
                      padding: EdgeInsets.only(left: 40, top: 10),
                      child: SmallText(text: 'Picture')),
                  Padding(
                    padding: EdgeInsets.only(left: 40, top: 10),
                    child: Container(
                        color: Color(0xff383d4d),
                        height: 150,
                        width: 300,
                        child: Image.file(
                          file!,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 40, top: 10),
                        width: 200,
                        child: SmallText(text: 'Vehicle Number'),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 100,
                          child:
                              SmallText(text: _VehicleNumberController.text)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 200,
                          child: SmallText(text: 'Maker')),
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 100,
                          child: SmallText(text: _MakerController.text)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 200,
                          child: SmallText(text: 'Manufacture Year')),
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 100,
                          child:
                              SmallText(text: _ManufactureYearController.text)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 200,
                          child: SmallText(text: 'Generation')),
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 100,
                          child: SmallText(text: _ModelController.text)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 200,
                          child: SmallText(text: 'Engine Number')),
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 100,
                          child: SmallText(text: _EngineController.text)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 200,
                          child: SmallText(text: 'Meter Value')),
                      Container(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          width: 100,
                          child: SmallText(text: _MeterValueController.text)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (file != null) {
                            if (_formKey.currentState!.validate()) {}
                            _showDialogmini(context);
                            Provider.of<HomeNotifier>(context, listen: false)
                                .uploadVehicle(
                              context,
                              vehiclenumber: _VehicleNumberController.text,
                              maker: _MakerController.text,
                              manufactureyear:
                                  int.parse(_ManufactureYearController.text),
                              model: int.parse(_ModelController.text),
                              enginenumber: _EngineController.text,
                              metervalue: int.parse(_MeterValueController.text),
                              image: file!,
                              uid: Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .currentUser
                                  .uid,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("please pick image")));
                          }
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
                          text: 'Vehicle Registered',
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
                        text: "Vehicle Registered Successfully !",
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

class LargeText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  LargeText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: GoogleFonts.poiretOne(
        textStyle: TextStyle(
            color: AppColors.ktextColorWhite,
            fontSize: ScreenUtils.screenwidth(context) * 0.058,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;

  SmallText({
    Key? key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 12,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poiretOne(
        textStyle: TextStyle(
            color: AppColors.ktextColorWhite,
            fontSize: ScreenUtils.screenwidth(context) * 0.032,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
