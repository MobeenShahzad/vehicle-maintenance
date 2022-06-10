import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehiclemaintenance/Home/home.dart';
import 'package:vehiclemaintenance/Maintenance/maintenance.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/addVehical/components/background.dart';
import 'package:vehiclemaintenance/components/add_vehicale_card_item.dart';
import 'package:vehiclemaintenance/components/add_vehicale_card_item_Image.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
        child: Container(
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
                        fontSize: ScreenUtils.screenheight(context) * 0.045,
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
                  AddVehicalCardItem(
                    title: "Vehicle Number",
                    onChanged: (vehinum) {
                      print(vehinum);
                    },
                    hintText: "Vehicle Number",
                  ),
                  AddVehicalCardItem(
                    title: "Maker",
                    onChanged: (value) {
                      print(value);
                    },
                    hintText: "Maker",
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtils.screenheight(context) * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AddVehicalCardItem(
                    title: "Manufacture Year",
                    onChanged: (value) {
                      print(value);
                    },
                    hintText: "Make year",
                  ),
                  AddVehicalCardItem(
                    title: "Model",
                    onChanged: (value) {
                      print(value);
                    },
                    hintText: "Model",
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtils.screenheight(context) * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AddVehicalCardItem(
                    title: "Eng Number",
                    onChanged: (value) {
                      print(value);
                    },
                    hintText: "Eng number",
                  ),
                  AddVehicalCardItem(
                    title: "Meter value",
                    onChanged: (value) {
                      print(value);
                    },
                    hintText: "Meter Value",
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtils.screenheight(context) * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 190.0),
                child: AddVehicalCardItemImage(
                  title: "Upload Vehicle Picture",
                  onChanged: (value) {
                    print(value);
                  },
                  hintText: "Image Name",
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => Home(),
                    //     ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, right: 190),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
