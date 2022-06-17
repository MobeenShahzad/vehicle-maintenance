import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vehiclemaintenance/Home/component/background.dart';
import 'package:vehiclemaintenance/Maintenance/maintenance.dart';
import 'package:vehiclemaintenance/Meter_Guidelines.dart/MeterGuidelines.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/Warnings.dart/Warnings.dart';
import 'package:vehiclemaintenance/addVehical/AddNewVehical.dart';
import 'package:vehiclemaintenance/components/lastviewitem.dart';
import 'package:vehiclemaintenance/globals.dart';
import 'package:vehiclemaintenance/providers/auth_provider.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //late List<Vehicle> items;
  final firebaseAuth = FirebaseAuth.instance;
  //var Vehicleid;
  final List<String> items = [
    'Warnings',
    'Meter Guidlines',
    'Logout',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    bool checkBoxBooleanValueVariable = false;
    var dropdownselectedMaintenance;
    final firebaseUser = firebaseAuth.currentUser;

    String home_date = "";
    String home_km = "";

    return Background(
      child: Container(
        //  color: Colors.amber,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40.0, right: 70),
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
                      width: ScreenUtils.screenwidth(context) * 0.12,
                      height: ScreenUtils.screenheight(context) * 0.052,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: GoogleFonts.poiretOne(
                                        textStyle: TextStyle(
                                            color: Color(0xffc8c9cd),
                                            fontSize: ScreenUtils.screenheight(
                                                    context) *
                                                0.016,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: dropdownselectedMaintenance,
                          onChanged: (value) {
                            dropdownselectedMaintenance = value;
                            switch (value) {
                              case "Warnings":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Warnings()),
                                );
                                break;
                              case "Meter Guidlines":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MeterGuidelines()),
                                );
                                break;
                              case "Logout":
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .signOut(context);
                                break;
                            }
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
                          buttonPadding:
                              const EdgeInsets.only(left: 0, right: 10),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: const Color(0xff393d4d),
                          ),
                          buttonElevation: 2,
                          itemHeight: 15,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight:
                              ScreenUtils.screenheight(context) * 0.2,
                          dropdownWidth:
                              ScreenUtils.screenwidth(context) * 0.29,
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
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("vehicles")
                        .where("uid", isEqualTo: firebaseUser?.uid)
                        .orderBy('id', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text("No Data")
                            // CircularProgressIndicator(),
                            );
                      }

                      QueryDocumentSnapshot<Object?> vehicle =
                          snapshot.data!.docs[0];
                      vehicle['maintenance_uniquie_id'];

                      if (maintenance_unique_id ==
                          vehicle['maintenance_uniquie_id']) {
                        home_date = maintenance_date;
                        home_km = maintenance_km;
                      } else {}

                      return GestureDetector(
                          child: Center(
                            child: Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: LastViewVehiCard(
                                    vehicle: vehicle,
                                    home_date: home_date,
                                    home_km: home_km)),
                          ),
                          onTap: () {
                            // print(Vehicleid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Maintenance(
                                          vehicle: vehicle,
                                        )));
                            var newid = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            print("ffffff ${newid}");
                            var doc_id = vehicle.id;
                            print(doc_id);
                            var collection = FirebaseFirestore.instance
                                .collection('vehicles');
                            collection
                                .doc(doc_id.toString())
                                .update({
                                  'id': newid.toString()
                                }) // <-- Updated data
                                .then((_) => print('Success'))
                                .catchError((error) => print('Failed: $error'));
                          });
                    }),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("vehicles")
                        .where("uid", isEqualTo: firebaseUser?.uid)
                        .limit(5)
                        .orderBy('id', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: const Center(child: Text("")),
                          //CircularProgressIndicator(),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, bottom: 30, right: 40, left: 40),
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 15.0,
                            childAspectRatio: 0.7 / 0.7,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children:
                                List.generate(snapshot.data!.docs.length - 1,
                                    // (item) {

                                    (index) {
                              QueryDocumentSnapshot<Object?> vehicle =
                                  snapshot.data!.docs[index + 1];

                              if (vehicle['maintenance_uniquie_id'] ==
                                  maintenance_unique_id) {
                                home_date = maintenance_date;
                                home_km = maintenance_km;
                              } else {}

                              // if (index == 0) {
                              return GestureDetector(
                                  child: Container(
                                    margin: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: const Color(0xff393d4d),
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                            spreadRadius: 0,
                                            blurRadius: 6,
                                            offset: Offset(0, 4),
                                            color: Color.fromARGB(
                                                255, 41, 159, 169),
                                          )
                                        ]),
                                    width:
                                        ScreenUtils.screenwidth(context) * 0.4,
                                    height:
                                        ScreenUtils.screenheight(context) * 0.2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: ScreenUtils.screenwidth(
                                                        context) *
                                                    0.7,
                                                height:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.07,
                                                child: Image.network(
                                                  //  "assets/car.png",
                                                  vehicle["image"],

                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Text(
                                                'Maker :${vehicle["maker"]}',
                                                style: GoogleFonts.poiretOne(
                                                  textStyle: TextStyle(
                                                      color: AppColors
                                                          .ktextColorWhite,
                                                      fontSize: ScreenUtils
                                                              .screenwidth(
                                                                  context) *
                                                          0.023,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                'Generation: ${vehicle["model"]}',
                                                style: GoogleFonts.poiretOne(
                                                  textStyle: TextStyle(
                                                      color: AppColors
                                                          .ktextColorWhite,
                                                      fontSize: ScreenUtils
                                                              .screenwidth(
                                                                  context) *
                                                          0.023,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3.0),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: ScreenUtils
                                                            .screenheight(
                                                                context) *
                                                        0.024,
                                                    width:
                                                        ScreenUtils.screenwidth(
                                                                context) *
                                                            0.17,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: Color(0xff4a4f60),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      vehicle["vehiclenumber"],
                                                      style:
                                                          GoogleFonts.poiretOne(
                                                        textStyle: TextStyle(
                                                            color: AppColors
                                                                .ktextColorWhite,
                                                            fontSize: ScreenUtils
                                                                    .screenwidth(
                                                                        context) *
                                                                0.03,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Maintenance(
                                            vehicle: vehicle,
                                          ),
                                        ));
                                    var newid = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();
                                    print("Gride item id new id");
                                    print(newid);
                                    var doc_id = vehicle.id;
                                    print("Gride item id");
                                    print(doc_id);
                                    var collection = FirebaseFirestore.instance
                                        .collection('vehicles');
                                    collection
                                        .doc(doc_id.toString())
                                        .update({
                                          'id': newid.toString()
                                        }) // <-- Updated data
                                        .then((_) => print('Success'))
                                        .catchError(
                                            (error) => print('Failed: $error'));
                                  });
                              //gride
                              // }
                              // return SizedBox();
                            }),
                          ),
                        );
                      }
                    }),
              ],
            ),
            Positioned(
              bottom: ScreenUtils.screenwidth(context) * 0.28,
              right: ScreenUtils.screenwidth(context) * 0.33,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewVehical(),
                      ));
                },
                child: Container(
                  height: ScreenUtils.screenheight(context) * 0.055,
                  width: ScreenUtils.screenwidth(context) * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xff4a4f60),
                  ),
                  child: Center(
                      child: Text(
                    'Add Vehicle',
                    style: GoogleFonts.poiretOne(
                      textStyle: TextStyle(
                          color: AppColors.ktextColorWhite,
                          fontSize: ScreenUtils.screenwidth(context) * 0.045,
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
  }
}
