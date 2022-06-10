import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:vehiclemaintenance/Add_maintenance/AddNewMaintenace.dart';
import 'package:vehiclemaintenance/Edit_maintenance/EditMaintenance.dart';
import 'package:vehiclemaintenance/Maintenance/component/background.dart';
import 'package:vehiclemaintenance/Maintenance/maintenance.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/addVehical/AddNewVehical.dart';
import 'package:vehiclemaintenance/components/addVehiCard.dart';
import 'package:vehiclemaintenance/components/maintenence_item_text.dart';
import 'package:vehiclemaintenance/globals.dart';
import 'package:vehiclemaintenance/models/app_maintennace.dart';
import 'package:vehiclemaintenance/models/app_vehicle.dart';
import 'package:vehiclemaintenance/providers/vehicleprovider.dart';
import 'package:vehiclemaintenance/updatemeter/updatemeter.dart';
import 'package:vehiclemaintenance/globals.dart' as globals;

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
  bool swapbt = false;
  bool isObsecure = true;
  // @override
  // void initState() {
  //   Get.to(Maintenance());
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => Maintenance()));
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    maintenance_unique_id = widget.vehicle["maintenance_uniquie_id"];
    final firebaseAuth = FirebaseAuth.instance;
    final firebaseUser = firebaseAuth.currentUser;

    print(
        "this is passed id to maintennace main screen ${widget.vehicle["maintenance_uniquie_id"]}");
    //   TextEditingController emailController = TextEditingController();
    // TextEditingController passwordController = TextEditingController();
    print(maintenance_unique_id);

    final past = Column(children: [
      Text(
        'Past',
        style: GoogleFonts.poiretOne(
          textStyle: TextStyle(
              color: AppColors.ktextColorWhite,
              fontSize: ScreenUtils.screenwidth(context) * 0.06,
              fontWeight: FontWeight.bold),
        ),
      ),
    ]);

    // final upcoming = Column(children: [
    //   Text(
    //     'Upcoming',
    //     style: GoogleFonts.poiretOne(
    //       textStyle: TextStyle(
    //           color: AppColors.ktextColorWhite,
    //           fontSize: ScreenUtils.screenwidth(context) * 0.06,
    //           fontWeight: FontWeight.bold),
    //     ),
    //   ),
    // ]);

    setState(() {});

    var swapTile = swapbt
        ? Container(
            height: ScreenUtils.screenheight(context) * 0.6,
            width: ScreenUtils.screenwidth(context) * 0.9,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("maintenance")
                  .where("uid", isEqualTo: firebaseUser?.uid)
                  .where('maintenance_uniquie_id',
                      isEqualTo: maintenance_unique_id)
                  .where("status", isEqualTo: "complete")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot main_items = snapshot.data!.docs[index];
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: ScreenUtils.screenheight(context) * 0.1,
                            width: ScreenUtils.screenwidth(context) * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color.fromARGB(255, 33, 36, 48)
                                  .withOpacity(0.7),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 35.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Maintenace_Item_Text(
                                        text: "Title",
                                      ),
                                      Maintenace_Item_Text(
                                        text: "Part",
                                      ),
                                      Maintenace_Item_Text(
                                        text: "Remaining",
                                      ),
                                      Maintenace_Item_Text(
                                        text: "KM/Date",
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Container(
                                    height: ScreenUtils.screenheight(context) *
                                        0.095,
                                    width:
                                        ScreenUtils.screenwidth(context) * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Color.fromARGB(255, 50, 55, 72)
                                          .withOpacity(0.7),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Maintenace_Item_Text(
                                            text: main_items['miantenancetype'],
                                          ),
                                          Maintenace_Item_Text(
                                            text: "Oil Change",
                                          ),
                                          Maintenace_Item_Text(
                                            text:
                                                "Due in ${main_items['km']} KM",
                                          ),
                                          Maintenace_Item_Text(
                                            text: "2435.4",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 28),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.04,
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.27,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Color.fromARGB(255, 50, 55, 72)
                                              .withOpacity(0.7),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Maintenace_Item_Text(
                                                    text: "Interval",
                                                  ),
                                                  Maintenace_Item_Text(
                                                    text: "Trip Count",
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Maintenace_Item_Text(
                                                      text: "50 KM",
                                                    ),
                                                    Maintenace_Item_Text(
                                                      text: "20",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(1.0) +
                                                EdgeInsets.only(right: 1.0),
                                            child: Container(
                                                height:
                                                    ScreenUtils.screenheight(
                                                            context) *
                                                        0.030,
                                                width: ScreenUtils.screenwidth(
                                                        context) *
                                                    0.067,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    // border: Border.all(
                                                    //   color: AppColors.kgreyLightColor,
                                                    // )
                                                    color: Color(0xff464b5f)
                                                    // AppColors.kgreyLightColor,
                                                    ),
                                                child: Center(
                                                  child: ImageIcon(
                                                    AssetImage(
                                                        "assets/done.png"),
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    size: ScreenUtils
                                                            .screenheight(
                                                                context) *
                                                        0.025,
                                                  ),
                                                )),
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                      1.0) +
                                                  EdgeInsets.only(right: 1.0),
                                              child: Container(
                                                  height:
                                                      ScreenUtils.screenheight(
                                                              context) *
                                                          0.030,
                                                  width:
                                                      ScreenUtils.screenwidth(
                                                              context) *
                                                          0.067,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      // border: Border.all(
                                                      //   color: AppColors.kgreyLightColor,
                                                      // )
                                                      color: Color(0xff464b5f)
                                                      // AppColors.kgreyLightColor,
                                                      ),
                                                  child: Center(
                                                    child: ImageIcon(
                                                      AssetImage(
                                                          "assets/delete.png"),
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      size: ScreenUtils
                                                              .screenheight(
                                                                  context) *
                                                          0.025,
                                                    ),
                                                  )),
                                            ),
                                            onTap: () async {
//                             await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
//                                      await myTransaction.delete(snapshot.data.documents[maintenance].reference);
// });                                 FirebaseFirestore.instance.collection("featured")

                                              // print(widget.index);
                                              // String ind = widget.index.toString();
                                              // //print("hello world ");
                                              // print(ind);

                                              // String id = FirebaseFirestore.instance
                                              //     .collection("maintenance")
                                              //     .doc(ind)
                                              //     .id;
                                              //retrieve one document and save it to userDetails

                                              // FirebaseFirestore.instance
                                              //     .collection("maintenance")
                                              //     .doc(widget.maintenance.id)
                                              //     .delete();
                                              // globals.set = true;
                                              // print(set);
                                              // Get.to(Maintenance());
                                              // Navigator.push(
                                              //         context,
                                              //         MaterialPageRoute(
                                              //             builder: (context) => Maintenance()))
                                              //     .then((value) => setState(() {}));

                                              // var doc_ref = await FirebaseFirestore.instance
                                              //     .collection("maintenance")
                                              //     .get();
                                              // doc_ref.docs.forEach((result) {
                                              //   print(result.toString());
                                              // });
                                              FirebaseFirestore.instance
                                                  .collection("maintenance")
                                                  .doc(main_items['id'])
                                                  .delete();
                                              // print("ididdididi");
                                              // //    print(id);
                                              // FirebaseFirestore.instance
                                              //     .collection("maintenance")
                                              //     .doc()
                                              //     .delete();
                                            },
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                      1.0) +
                                                  EdgeInsets.only(right: 1.0),
                                              child: Container(
                                                  height:
                                                      ScreenUtils.screenheight(
                                                              context) *
                                                          0.030,
                                                  width:
                                                      ScreenUtils.screenwidth(
                                                              context) *
                                                          0.067,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      // border: Border.all(
                                                      //   color: AppColors.kgreyLightColor,
                                                      // )
                                                      color: Color(0xff464b5f)
                                                      // AppColors.kgreyLightColor,
                                                      ),
                                                  child: Center(
                                                    child: ImageIcon(
                                                      AssetImage(
                                                          "assets/edit.png"),
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      size: ScreenUtils
                                                              .screenheight(
                                                                  context) *
                                                          0.025,
                                                    ),
                                                  )),
                                            ),
                                            onTap: () {
                                              //todo
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditMaintenance(
                                                      maintenance: main_items,
                                                    ),
                                                  ));
                                              // FirebaseFirestore.instance
                                              //     .collection("maintenance")
                                              //     .doc(widget.maintenance.id)
                                              //     .update({
                                              //   "km": "000",
                                              // });

                                              // QuerySnapshot querySnapshot =
                                              //     await FirebaseFirestore.instance
                                              //         .collection("maintenance")
                                              //         .get();
                                              // for (int i = 0;
                                              //     i < querySnapshot.docs.length;
                                              //     i++) {
                                              //   String a = querySnapshot.docs[i]["id"];

                                              //   print(a);
                                              //   FirebaseFirestore.instance
                                              //       .collection("maintenance")
                                              //       .doc(a)
                                              //       .update({
                                              //     "km": "11111111",
                                              //   });
                                              // }
                                            },
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                      1.0) +
                                                  EdgeInsets.only(right: 1.0),
                                              child: Container(
                                                  height:
                                                      ScreenUtils.screenheight(
                                                              context) *
                                                          0.030,
                                                  width:
                                                      ScreenUtils.screenwidth(
                                                              context) *
                                                          0.067,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      // border: Border.all(
                                                      //   color: AppColors.kgreyLightColor,
                                                      // )
                                                      color: Color(0xff464b5f)
                                                      // AppColors.kgreyLightColor,
                                                      ),
                                                  child: Center(
                                                    child: ImageIcon(
                                                      AssetImage(
                                                          "assets/view-filled.png"),
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      size: ScreenUtils
                                                              .screenheight(
                                                                  context) *
                                                          0.025,
                                                    ),
                                                  )),
                                            ),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      backgroundColor:
                                                          Color.fromRGBO(
                                                              33, 40, 48, 1.0),
                                                      insetPadding:
                                                          EdgeInsets.all(15),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20.0)), //this right here
                                                      child: Container(
                                                        height: ScreenUtils
                                                                .screenheight(
                                                                    context) *
                                                            0.37,
                                                        child: Stack(children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 180,
                                                                    top: 20,
                                                                    right: 10),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        106,
                                                                        107,
                                                                        109),
                                                              ),
                                                              height: ScreenUtils
                                                                      .screenheight(
                                                                          context) *
                                                                  0.16,
                                                              width: ScreenUtils
                                                                      .screenwidth(
                                                                          context) *
                                                                  0.6,
                                                              child: SmallText(
                                                                  text: ""),
                                                            ),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Padding(
                                                              //   padding: EdgeInsets.only(left: 40, top: 10),
                                                              //   child: Container(
                                                              //       color: Color(0xff383d4d),
                                                              //       height: 150,
                                                              //       width: 300,
                                                              //       child: Image.file(
                                                              //         file!,
                                                              //         fit: BoxFit.cover,
                                                              //       )

                                                              //       // Image.file(
                                                              //       // File( file != null ? FileImage(file!) : null.toString()),

                                                              //       //Image(image: file != null ? FileImage(file!) : null)
                                                              //       //file != null ? FileImage(file!) : null
                                                              //       ),
                                                              // ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            25,
                                                                        top:
                                                                            25),
                                                                    width: 200,
                                                                    child: SmallText(
                                                                        text:
                                                                            'Maintenance Type'),
                                                                  ),
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              20),
                                                                      width:
                                                                          100,
                                                                      child: SmallText(
                                                                          text:
                                                                              main_items['miantenancetype'])),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            25,
                                                                        top:
                                                                            10),
                                                                    width: 200,
                                                                    child: SmallText(
                                                                        text:
                                                                            'Maintenance Date'),
                                                                  ),
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          100,
                                                                      child: SmallText(
                                                                          text:
                                                                              main_items['maintenacedate'])),
                                                                ],
                                                              ),

                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              25,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          200,
                                                                      child: SmallText(
                                                                          text:
                                                                              'Tolerence by Days')),
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          100,
                                                                      child: SmallText(
                                                                          text:
                                                                              main_items['tolbyday'])),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              25,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          200,
                                                                      child: SmallText(
                                                                          text:
                                                                              'Serial Number (SN#)')),
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          100,
                                                                      child: SmallText(
                                                                          text:
                                                                              main_items['serialnumber'])),
                                                                ],
                                                              ),

                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              25,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          200,
                                                                      child: SmallText(
                                                                          text:
                                                                              'KM when maintenance due')),
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          100,
                                                                      child: SmallText(
                                                                          text:
                                                                              main_items['km'])),
                                                                ],
                                                              ),
                                                              Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              25,
                                                                          top:
                                                                              10),
                                                                  width: 200,
                                                                  child: SmallText(
                                                                      text:
                                                                          'Description')),
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            25,
                                                                        top: 10,
                                                                        right:
                                                                            10),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0),
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            106,
                                                                            107,
                                                                            109),
                                                                      ),
                                                                      height: ScreenUtils.screenheight(
                                                                              context) *
                                                                          0.12,
                                                                      width: ScreenUtils.screenwidth(
                                                                              context) *
                                                                          0.6,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: SmallText(
                                                                            text:
                                                                                main_items['desc']),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              15.0,
                                                                          right:
                                                                              0,
                                                                          left:
                                                                              0),
                                                                      child:
                                                                          Container(
                                                                        height: ScreenUtils.screenheight(context) *
                                                                            0.04,
                                                                        width: ScreenUtils.screenwidth(context) *
                                                                            0.2,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15.0),
                                                                          color:
                                                                              Color(0xff4a4f60),
                                                                        ),
                                                                        child: Center(
                                                                            child: Text(
                                                                          'Cancel',
                                                                          style:
                                                                              GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                                color: AppColors.ktextColorWhite,
                                                                                fontSize: ScreenUtils.screenwidth(context) * 0.038,
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
                                                        ]),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    //}
                    );
              },
            ),
          )
        : Container(
            height: ScreenUtils.screenheight(context) * 0.6,
            width: ScreenUtils.screenwidth(context) * 0.9,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("maintenance")
                  .where("uid", isEqualTo: firebaseUser?.uid)
                  .where('maintenance_uniquie_id',
                      isEqualTo: maintenance_unique_id)
                  .where("status", isEqualTo: "incomplete")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot main_items = snapshot.data!.docs[index];
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: ScreenUtils.screenheight(context) * 0.1,
                            width: ScreenUtils.screenwidth(context) * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color.fromARGB(255, 33, 36, 48)
                                  .withOpacity(0.7),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 35.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Maintenace_Item_Text(
                                        text: "Title",
                                      ),
                                      Maintenace_Item_Text(
                                        text: "Part",
                                      ),
                                      Maintenace_Item_Text(
                                        text: "Remaining",
                                      ),
                                      Maintenace_Item_Text(
                                        text: "KM/Date",
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Container(
                                    height: ScreenUtils.screenheight(context) *
                                        0.095,
                                    width:
                                        ScreenUtils.screenwidth(context) * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Color.fromARGB(255, 50, 55, 72)
                                          .withOpacity(0.7),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Maintenace_Item_Text(
                                            text: main_items['miantenancetype'],
                                          ),
                                          Maintenace_Item_Text(
                                            text: "Oil Change",
                                          ),
                                          Maintenace_Item_Text(
                                            text:
                                                "Due in ${main_items['km']} KM",
                                          ),
                                          Maintenace_Item_Text(
                                            text: "2435.4",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 28),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            ScreenUtils.screenheight(context) *
                                                0.04,
                                        width:
                                            ScreenUtils.screenwidth(context) *
                                                0.27,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Color.fromARGB(255, 50, 55, 72)
                                              .withOpacity(0.7),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Maintenace_Item_Text(
                                                    text: "Interval",
                                                  ),
                                                  Maintenace_Item_Text(
                                                    text: "Trip Count",
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Maintenace_Item_Text(
                                                      text: "50 KM",
                                                    ),
                                                    Maintenace_Item_Text(
                                                      text: "20",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              FirebaseFirestore.instance
                                                  .collection("maintenance")
                                                  .doc(main_items['id'])
                                                  .update({
                                                "status": "complete",
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                      1.0) +
                                                  EdgeInsets.only(right: 1.0),
                                              child: Container(
                                                  height:
                                                      ScreenUtils.screenheight(
                                                              context) *
                                                          0.030,
                                                  width:
                                                      ScreenUtils.screenwidth(
                                                              context) *
                                                          0.067,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      // border: Border.all(
                                                      //   color: AppColors.kgreyLightColor,
                                                      // )
                                                      color: Color(0xff464b5f)
                                                      // AppColors.kgreyLightColor,
                                                      ),
                                                  child: Center(
                                                    child: ImageIcon(
                                                      AssetImage(
                                                          "assets/done.png"),
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      size: ScreenUtils
                                                              .screenheight(
                                                                  context) *
                                                          0.025,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                      1.0) +
                                                  EdgeInsets.only(right: 1.0),
                                              child: Container(
                                                  height:
                                                      ScreenUtils.screenheight(
                                                              context) *
                                                          0.030,
                                                  width:
                                                      ScreenUtils.screenwidth(
                                                              context) *
                                                          0.067,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      // border: Border.all(
                                                      //   color: AppColors.kgreyLightColor,
                                                      // )
                                                      color: Color(0xff464b5f)
                                                      // AppColors.kgreyLightColor,
                                                      ),
                                                  child: Center(
                                                    child: ImageIcon(
                                                      AssetImage(
                                                          "assets/delete.png"),
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      size: ScreenUtils
                                                              .screenheight(
                                                                  context) *
                                                          0.025,
                                                    ),
                                                  )),
                                            ),
                                            onTap: () async {
//                             await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
//                                      await myTransaction.delete(snapshot.data.documents[maintenance].reference);
// });                                 FirebaseFirestore.instance.collection("featured")

                                              // print(widget.index);
                                              // String ind = widget.index.toString();
                                              // //print("hello world ");
                                              // print(ind);

                                              // String id = FirebaseFirestore.instance
                                              //     .collection("maintenance")
                                              //     .doc(ind)
                                              //     .id;
                                              //retrieve one document and save it to userDetails

                                              // FirebaseFirestore.instance
                                              //     .collection("maintenance")
                                              //     .doc(widget.maintenance.id)
                                              //     .delete();
                                              // globals.set = true;
                                              // print(set);
                                              // Get.to(Maintenance());
                                              // Navigator.push(
                                              //         context,
                                              //         MaterialPageRoute(
                                              //             builder: (context) => Maintenance()))
                                              //     .then((value) => setState(() {}));

                                              // var doc_ref = await FirebaseFirestore.instance
                                              //     .collection("maintenance")
                                              //     .get();
                                              // doc_ref.docs.forEach((result) {
                                              //   print(result.toString());
                                              // });
                                              FirebaseFirestore.instance
                                                  .collection("maintenance")
                                                  .doc(main_items['id'])
                                                  .delete();
                                              // print("ididdididi");
                                              // //    print(id);
                                              // FirebaseFirestore.instance
                                              //     .collection("maintenance")
                                              //     .doc()
                                              //     .delete();
                                            },
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                      1.0) +
                                                  EdgeInsets.only(right: 1.0),
                                              child: Container(
                                                  height:
                                                      ScreenUtils.screenheight(
                                                              context) *
                                                          0.030,
                                                  width:
                                                      ScreenUtils.screenwidth(
                                                              context) *
                                                          0.067,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      // border: Border.all(
                                                      //   color: AppColors.kgreyLightColor,
                                                      // )
                                                      color: Color(0xff464b5f)
                                                      // AppColors.kgreyLightColor,
                                                      ),
                                                  child: Center(
                                                    child: ImageIcon(
                                                      AssetImage(
                                                          "assets/edit.png"),
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      size: ScreenUtils
                                                              .screenheight(
                                                                  context) *
                                                          0.025,
                                                    ),
                                                  )),
                                            ),
                                            onTap: () {
                                              //todo
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditMaintenance(
                                                      maintenance: main_items,
                                                    ),
                                                  ));
                                              // FirebaseFirestore.instance
                                              //     .collection("maintenance")
                                              //     .doc(widget.maintenance.id)
                                              //     .update({
                                              //   "km": "000",
                                              // });

                                              // QuerySnapshot querySnapshot =
                                              //     await FirebaseFirestore.instance
                                              //         .collection("maintenance")
                                              //         .get();
                                              // for (int i = 0;
                                              //     i < querySnapshot.docs.length;
                                              //     i++) {
                                              //   String a = querySnapshot.docs[i]["id"];

                                              //   print(a);
                                              //   FirebaseFirestore.instance
                                              //       .collection("maintenance")
                                              //       .doc(a)
                                              //       .update({
                                              //     "km": "11111111",
                                              //   });
                                              // }
                                            },
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                      1.0) +
                                                  EdgeInsets.only(right: 1.0),
                                              child: Container(
                                                  height:
                                                      ScreenUtils.screenheight(
                                                              context) *
                                                          0.030,
                                                  width:
                                                      ScreenUtils.screenwidth(
                                                              context) *
                                                          0.067,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      // border: Border.all(
                                                      //   color: AppColors.kgreyLightColor,
                                                      // )
                                                      color: Color(0xff464b5f)
                                                      // AppColors.kgreyLightColor,
                                                      ),
                                                  child: Center(
                                                    child: ImageIcon(
                                                      AssetImage(
                                                          "assets/view-filled.png"),
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      size: ScreenUtils
                                                              .screenheight(
                                                                  context) *
                                                          0.025,
                                                    ),
                                                  )),
                                            ),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      backgroundColor:
                                                          Color.fromRGBO(
                                                              33, 40, 48, 1.0),
                                                      insetPadding:
                                                          EdgeInsets.all(15),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20.0)), //this right here
                                                      child: Container(
                                                        height: ScreenUtils
                                                                .screenheight(
                                                                    context) *
                                                            0.37,
                                                        child: Stack(children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 180,
                                                                    top: 20,
                                                                    right: 10),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        106,
                                                                        107,
                                                                        109),
                                                              ),
                                                              height: ScreenUtils
                                                                      .screenheight(
                                                                          context) *
                                                                  0.16,
                                                              width: ScreenUtils
                                                                      .screenwidth(
                                                                          context) *
                                                                  0.6,
                                                              child: SmallText(
                                                                  text: ""),
                                                            ),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Padding(
                                                              //   padding: EdgeInsets.only(left: 40, top: 10),
                                                              //   child: Container(
                                                              //       color: Color(0xff383d4d),
                                                              //       height: 150,
                                                              //       width: 300,
                                                              //       child: Image.file(
                                                              //         file!,
                                                              //         fit: BoxFit.cover,
                                                              //       )

                                                              //       // Image.file(
                                                              //       // File( file != null ? FileImage(file!) : null.toString()),

                                                              //       //Image(image: file != null ? FileImage(file!) : null)
                                                              //       //file != null ? FileImage(file!) : null
                                                              //       ),
                                                              // ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            25,
                                                                        top:
                                                                            25),
                                                                    width: 200,
                                                                    child: SmallText(
                                                                        text:
                                                                            'Maintenance Type'),
                                                                  ),
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              20),
                                                                      width:
                                                                          100,
                                                                      child: SmallText(
                                                                          text:
                                                                              main_items['miantenancetype'])),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            25,
                                                                        top:
                                                                            10),
                                                                    width: 200,
                                                                    child: SmallText(
                                                                        text:
                                                                            'Maintenance Date'),
                                                                  ),
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          100,
                                                                      child: SmallText(
                                                                          text:
                                                                              main_items['maintenacedate'])),
                                                                ],
                                                              ),

                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              25,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          200,
                                                                      child: SmallText(
                                                                          text:
                                                                              'Tolerence by Days')),
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          100,
                                                                      child: SmallText(
                                                                          text:
                                                                              main_items['tolbyday'])),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              25,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          200,
                                                                      child: SmallText(
                                                                          text:
                                                                              'Serial Number (SN#)')),
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          100,
                                                                      child: SmallText(
                                                                          text:
                                                                              main_items['serialnumber'])),
                                                                ],
                                                              ),

                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              25,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          200,
                                                                      child: SmallText(
                                                                          text:
                                                                              'KM when maintenance due')),
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              10),
                                                                      width:
                                                                          100,
                                                                      child: SmallText(
                                                                          text:
                                                                              main_items['km'])),
                                                                ],
                                                              ),
                                                              Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              25,
                                                                          top:
                                                                              10),
                                                                  width: 200,
                                                                  child: SmallText(
                                                                      text:
                                                                          'Description')),
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            25,
                                                                        top: 10,
                                                                        right:
                                                                            10),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0),
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            106,
                                                                            107,
                                                                            109),
                                                                      ),
                                                                      height: ScreenUtils.screenheight(
                                                                              context) *
                                                                          0.12,
                                                                      width: ScreenUtils.screenwidth(
                                                                              context) *
                                                                          0.6,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: SmallText(
                                                                            text:
                                                                                main_items['desc']),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              15.0,
                                                                          right:
                                                                              0,
                                                                          left:
                                                                              0),
                                                                      child:
                                                                          Container(
                                                                        height: ScreenUtils.screenheight(context) *
                                                                            0.04,
                                                                        width: ScreenUtils.screenwidth(context) *
                                                                            0.2,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15.0),
                                                                          color:
                                                                              Color(0xff4a4f60),
                                                                        ),
                                                                        child: Center(
                                                                            child: Text(
                                                                          'Cancel',
                                                                          style:
                                                                              GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                                color: AppColors.ktextColorWhite,
                                                                                fontSize: ScreenUtils.screenwidth(context) * 0.038,
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
                                                        ]),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    //}
                    );
              },
            ),
          );

    // getproductdata();

    return SingleChildScrollView(
      child: Background(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: ScreenUtils.screenheight(context) * 0.1,
          ),
          Container(
            height: ScreenUtils.screenheight(context) * 0.18,
            width: ScreenUtils.screenwidth(context) * 0.93,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Color(0xff454c60).withOpacity(0.7),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Maintenance',
                  style: GoogleFonts.poiretOne(
                    textStyle: TextStyle(
                        color: AppColors.ktextColorWhite,
                        fontSize: ScreenUtils.screenwidth(context) * 0.09,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: ScreenUtils.screenheight(context) * 0.023,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Past',
                      style: GoogleFonts.poiretOne(
                        textStyle: TextStyle(
                            color: AppColors.ktextColorWhite,
                            fontSize: ScreenUtils.screenwidth(context) * 0.03,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtils.screenwidth(context) * 0.05,
                    ),
                    ToggleSwitch(
                      changeOnTap: true,
                      minWidth: 32.0,
                      minHeight: 34.0,
                      cornerRadius: 100.0,
                      fontSize: ScreenUtils.screenheight(context) * 0.01800,
                      activeBorders: [
                        Border.all(color: Color(0xffffffff), width: 2.5),
                        Border.all(
                          color: Color(0xffffffff),
                          width: 2.5,
                        ),
                      ],
                      activeBgColor: [Color.fromARGB(255, 38, 42, 55)],
                      activeFgColor: Color.fromARGB(255, 23, 22, 22),
                      inactiveBgColor: Color(0xffffffff),
                      inactiveFgColor: Color(0xffffffff),
                      initialLabelIndex: swapbt ? 0 : 1,
                      labels: ['', ''],
                      radiusStyle: true,
                      onToggle: (index) {
                        print('switched to: $index');
                        print('switched to: $swapbt');
                        setState(() {
                          swapbt = !swapbt;
                        });
                      },
                    ),
                    SizedBox(
                      width: ScreenUtils.screenwidth(context) * 0.05,
                    ),
                    Text(
                      'Upcoming',
                      style: GoogleFonts.poiretOne(
                        textStyle: TextStyle(
                            color: AppColors.ktextColorWhite,
                            fontSize: ScreenUtils.screenwidth(context) * 0.03,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtils.screenheight(context) * 0.015,
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtils.screenheight(context) * 0.019,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddNewMaintenace(vehicle: widget.vehicle),
                        ));
                  },
                  child: Container(
                    height: ScreenUtils.screenheight(context) * 0.044,
                    width: ScreenUtils.screenwidth(context) * 0.26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xff2f3449),
                    ),
                    child: Center(
                        child: Text(
                      'Add Maintenance',
                      style: GoogleFonts.poiretOne(
                        textStyle: TextStyle(
                            color: AppColors.ktextColorWhite,
                            fontSize: ScreenUtils.screenwidth(context) * 0.027,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtils.screenwidth(context) * 0.03,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UpdateMeter(),
                        ));
                  },
                  child: Container(
                    height: ScreenUtils.screenheight(context) * 0.044,
                    width: ScreenUtils.screenwidth(context) * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xff4a4f60),
                    ),
                    child: Center(
                        child: Text(
                      'Add Meter Value',
                      style: GoogleFonts.poiretOne(
                        textStyle: TextStyle(
                            color: AppColors.ktextColorWhite,
                            fontSize: ScreenUtils.screenwidth(context) * 0.036,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtils.screenheight(context) * 0.019,
          ),
          Container(
            height: ScreenUtils.screenheight(context) * 0.62,
            width: ScreenUtils.screenwidth(context) * 0.93,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Color(0xff454c60).withOpacity(0.7),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtils.screenheight(context) * 0.01,
                ),
                swapTile,
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class maintenance_tile extends StatefulWidget {
  maintenance_tile({
    Key? key,
    required this.maintenance,
  }) : super(key: key);
  final MaintenanceModel maintenance;

  @override
  State<maintenance_tile> createState() => _maintenance_tileState();
}

class _maintenance_tileState extends State<maintenance_tile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: ScreenUtils.screenheight(context) * 0.1,
          width: ScreenUtils.screenwidth(context) * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Color.fromARGB(255, 33, 36, 48).withOpacity(0.7),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Maintenace_Item_Text(
                      text: "Title",
                    ),
                    Maintenace_Item_Text(
                      text: "Part",
                    ),
                    Maintenace_Item_Text(
                      text: "Remaining",
                    ),
                    Maintenace_Item_Text(
                      text: "KM/Date",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Container(
                  height: ScreenUtils.screenheight(context) * 0.095,
                  width: ScreenUtils.screenwidth(context) * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color.fromARGB(255, 50, 55, 72).withOpacity(0.7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Maintenace_Item_Text(
                          text: widget.maintenance.miantenancetype,
                        ),
                        Maintenace_Item_Text(
                          text: "Oil Change",
                        ),
                        Maintenace_Item_Text(
                          text: "Due in ${widget.maintenance.km} KM",
                        ),
                        Maintenace_Item_Text(
                          text: "2435.4",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: ScreenUtils.screenheight(context) * 0.04,
                      width: ScreenUtils.screenwidth(context) * 0.27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color.fromARGB(255, 50, 55, 72).withOpacity(0.7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Maintenace_Item_Text(
                                  text: "Interval",
                                ),
                                Maintenace_Item_Text(
                                  text: "Trip Count",
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Maintenace_Item_Text(
                                    text: "50 KM",
                                  ),
                                  Maintenace_Item_Text(
                                    text: "20",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0) +
                              EdgeInsets.only(right: 1.0),
                          child: Container(
                              height: ScreenUtils.screenheight(context) * 0.030,
                              width: ScreenUtils.screenwidth(context) * 0.067,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  // border: Border.all(
                                  //   color: AppColors.kgreyLightColor,
                                  // )
                                  color: Color(0xff464b5f)
                                  // AppColors.kgreyLightColor,
                                  ),
                              child: Center(
                                child: ImageIcon(
                                  AssetImage("assets/done.png"),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size:
                                      ScreenUtils.screenheight(context) * 0.025,
                                ),
                              )),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0) +
                                EdgeInsets.only(right: 1.0),
                            child: Container(
                                height:
                                    ScreenUtils.screenheight(context) * 0.030,
                                width: ScreenUtils.screenwidth(context) * 0.067,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    // border: Border.all(
                                    //   color: AppColors.kgreyLightColor,
                                    // )
                                    color: Color(0xff464b5f)
                                    // AppColors.kgreyLightColor,
                                    ),
                                child: Center(
                                  child: ImageIcon(
                                    AssetImage("assets/delete.png"),
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    size: ScreenUtils.screenheight(context) *
                                        0.025,
                                  ),
                                )),
                          ),
                          onTap: () async {
//                             await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
//                                      await myTransaction.delete(snapshot.data.documents[maintenance].reference);
// });                                 FirebaseFirestore.instance.collection("featured")

                            // print(widget.index);
                            // String ind = widget.index.toString();
                            // //print("hello world ");
                            // print(ind);

                            // String id = FirebaseFirestore.instance
                            //     .collection("maintenance")
                            //     .doc(ind)
                            //     .id;
                            //retrieve one document and save it to userDetails

                            FirebaseFirestore.instance
                                .collection("maintenance")
                                .doc(widget.maintenance.id)
                                .delete();
                            globals.set = true;
                            print(set);
                            // Get.to(Maintenance());
                            // Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => Maintenance()))
                            //     .then((value) => setState(() {}));

                            // var doc_ref = await FirebaseFirestore.instance
                            //     .collection("maintenance")
                            //     .get();
                            // doc_ref.docs.forEach((result) {
                            //   print(result.toString());
                            // });

                            print("ididdididi");
                            //    print(id);
                            // FirebaseFirestore.instance
                            //     .collection("maintenance")
                            //     .doc()
                            //     .delete();
                          },
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0) +
                                EdgeInsets.only(right: 1.0),
                            child: Container(
                                height:
                                    ScreenUtils.screenheight(context) * 0.030,
                                width: ScreenUtils.screenwidth(context) * 0.067,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    // border: Border.all(
                                    //   color: AppColors.kgreyLightColor,
                                    // )
                                    color: Color(0xff464b5f)
                                    // AppColors.kgreyLightColor,
                                    ),
                                child: Center(
                                  child: ImageIcon(
                                    AssetImage("assets/edit.png"),
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    size: ScreenUtils.screenheight(context) *
                                        0.025,
                                  ),
                                )),
                          ),
                          onTap: () {
                            //todo
                            //      Navigator.push(
                            // context,
                            // MaterialPageRoute(
                            //   builder: (context) =>
                            //       EditMaintenance(maintenance: ),
                            // ));
                            // FirebaseFirestore.instance
                            //     .collection("maintenance")
                            //     .doc(widget.maintenance.id)
                            //     .update({
                            //   "km": "000",
                            // });

                            // QuerySnapshot querySnapshot =
                            //     await FirebaseFirestore.instance
                            //         .collection("maintenance")
                            //         .get();
                            // for (int i = 0;
                            //     i < querySnapshot.docs.length;
                            //     i++) {
                            //   String a = querySnapshot.docs[i]["id"];

                            //   print(a);
                            //   FirebaseFirestore.instance
                            //       .collection("maintenance")
                            //       .doc(a)
                            //       .update({
                            //     "km": "11111111",
                            //   });
                            // }
                          },
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0) +
                                EdgeInsets.only(right: 1.0),
                            child: Container(
                                height:
                                    ScreenUtils.screenheight(context) * 0.030,
                                width: ScreenUtils.screenwidth(context) * 0.067,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    // border: Border.all(
                                    //   color: AppColors.kgreyLightColor,
                                    // )
                                    color: Color(0xff464b5f)
                                    // AppColors.kgreyLightColor,
                                    ),
                                child: Center(
                                  child: ImageIcon(
                                    AssetImage("assets/view-filled.png"),
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    size: ScreenUtils.screenheight(context) *
                                        0.025,
                                  ),
                                )),
                          ),
                          onTap: () {
                            _showDialog(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
              height: ScreenUtils.screenheight(context) * 0.37,
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(left: 180, top: 20, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color.fromARGB(255, 106, 107, 109),
                    ),
                    height: ScreenUtils.screenheight(context) * 0.16,
                    width: ScreenUtils.screenwidth(context) * 0.6,
                    child: SmallText(text: ""),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.only(left: 40, top: 10),
                    //   child: Container(
                    //       color: Color(0xff383d4d),
                    //       height: 150,
                    //       width: 300,
                    //       child: Image.file(
                    //         file!,
                    //         fit: BoxFit.cover,
                    //       )

                    //       // Image.file(
                    //       // File( file != null ? FileImage(file!) : null.toString()),

                    //       //Image(image: file != null ? FileImage(file!) : null)
                    //       //file != null ? FileImage(file!) : null
                    //       ),
                    // ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 25, top: 25),
                          width: 200,
                          child: SmallText(text: 'Maintenance Type'),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 0, top: 20),
                            width: 100,
                            child: SmallText(
                                text: widget.maintenance.miantenancetype)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 25, top: 10),
                          width: 200,
                          child: SmallText(text: 'Maintenance Date'),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 0, top: 10),
                            width: 100,
                            child: SmallText(
                                text: widget.maintenance.maintenacedate)),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 25, top: 10),
                            width: 200,
                            child: SmallText(text: 'Tolerence by Days')),
                        Container(
                            padding: EdgeInsets.only(left: 0, top: 10),
                            width: 100,
                            child:
                                SmallText(text: widget.maintenance.tolbyday)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 25, top: 10),
                            width: 200,
                            child: SmallText(text: 'Serial Number (SN#)')),
                        Container(
                            padding: EdgeInsets.only(left: 0, top: 10),
                            width: 100,
                            child: SmallText(
                                text: widget.maintenance.serialnumber)),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 25, top: 10),
                            width: 200,
                            child: SmallText(text: 'KM when maintenance due')),
                        Container(
                            padding: EdgeInsets.only(left: 0, top: 10),
                            width: 100,
                            child: SmallText(text: widget.maintenance.km)),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 25, top: 10),
                        width: 200,
                        child: SmallText(text: 'Description')),
                    Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 25, top: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color.fromARGB(255, 106, 107, 109),
                            ),
                            height: ScreenUtils.screenheight(context) * 0.12,
                            width: ScreenUtils.screenwidth(context) * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SmallText(text: widget.maintenance.desc),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, right: 0, left: 0),
                            child: Container(
                              height: ScreenUtils.screenheight(context) * 0.04,
                              width: ScreenUtils.screenwidth(context) * 0.2,
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
                                      fontSize:
                                          ScreenUtils.screenwidth(context) *
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
              ]),
            ),
          );
        });
  }
}

class maintenance_icons_widgets extends StatefulWidget {
  final String imageurl;
  const maintenance_icons_widgets({
    Key? key,
    required this.imageurl,
  }) : super(key: key);

  @override
  State<maintenance_icons_widgets> createState() =>
      _maintenance_icons_widgetsState();
}

class _maintenance_icons_widgetsState extends State<maintenance_icons_widgets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0) + EdgeInsets.only(right: 1.0),
      child: Container(
          height: ScreenUtils.screenheight(context) * 0.030,
          width: ScreenUtils.screenwidth(context) * 0.067,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              // border: Border.all(
              //   color: AppColors.kgreyLightColor,
              // )
              color: Color(0xff464b5f)
              // AppColors.kgreyLightColor,
              ),
          child: Center(
            child: ImageIcon(
              AssetImage(widget.imageurl),
              color: Color.fromARGB(255, 122, 196, 218),
              size: ScreenUtils.screenheight(context) * 0.025,
            ),
          )),
    );
  }
}

// checking this function
class getproductdata extends StatefulWidget {
  const getproductdata({
    Key? key,
  }) : super(key: key);

  @override
  State<getproductdata> createState() => _getproductdataState();
}

class _getproductdataState extends State<getproductdata> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MaintenanceModel>>(
        future:
            Provider.of<HomeNotifier>(context, listen: false).getMaintenance(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(child: Text('No internet connection'));

              break;
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final data = snapshot.data!;
                final product = data.toList();
                if (data.isEmpty) {
                  return const Center(
                    child: Text("Data not found "),
                  );
                }
                return Consumer(builder: (context, provider, _) {
                  return ProductBuilder(item: data);
                });
              }
          }

          return SizedBox();
        });
  }
}

class ProductBuilder extends StatefulWidget {
  ProductBuilder({required this.item, Key? key}) : super(key: key);
  List<MaintenanceModel> item;
  @override
  State<ProductBuilder> createState() => _ProductBuilderState();
}

class _ProductBuilderState extends State<ProductBuilder> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final maintenance = widget.item[index];
          print("");

          return maintenance_tile(
            maintenance: maintenance,
          );
          // AddVehiCard(vehicle: vehicle);
        },
        itemCount: widget.item.length,
      ),
    );
  }
}
