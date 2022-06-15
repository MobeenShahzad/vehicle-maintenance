import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/addVehical/AddNewVehical.dart';
import 'package:vehiclemaintenance/globals.dart';
import 'package:vehiclemaintenance/models/app_maintennace.dart';
import 'package:vehiclemaintenance/models/app_user.dart';
import 'package:vehiclemaintenance/models/app_vehicle.dart';
import 'dart:math';

class Network {
  final firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  var maintenanceid;

  // get maintenance_unique_id => null;

  Future<AppUser> checkCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;

    try {
      if (firebaseUser != null) {
        print(firebaseUser.uid);
        final documentSnapshot =
            await firestore.collection("users").doc(firebaseUser.uid).get();

        if (documentSnapshot.exists) {
          final data = documentSnapshot.data();
          print("USER DATA FROM FIRESTORE ${data}");
          final vehiUser = AppUser.fromJson(data!, uid: firebaseUser.uid);
          return vehiUser;
        }
        throw FirebaseException(
            plugin: "Firestore",
            code: "no-data-found",
            message: "No data was found in database");
      }
      throw FirebaseException(
          plugin: "FirebaseAuth",
          code: 'no-user-logged',
          message: "No user was logged in.");
    } on FirebaseException catch (error, stk) {
      throw error;
    }
  }

  Future<AppUser> login(
      {required String email, required String password}) async {
    try {
      final UserCredential userCreds = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final userSnapshot =
          await firestore.collection("users").doc(userCreds.user!.uid).get();

      final data = userSnapshot.data()!;

      return AppUser.fromJson(data, uid: userCreds.user!.uid);
    } on FirebaseAuthException catch (error, stk) {
      print('An error occured during sign in: $error \n Stacktrace: $stk');
      throw FirebaseAuthException(code: error.code, message: error.message);
    }
  }

  Future<AppUser> register(
      {required AppUser user,
      required String password,
      required String username,
      required String phone}) async {
    try {
      final UserCredential creds =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: user.email, password: password);
      user.uid = creds.user!.uid;
      await firestore
          .collection("users")
          .doc(creds.user!.uid)
          .set(user.toJson());
      return user;
    } catch (error, stk) {
      throw FirebaseException(plugin: "Firebase", message: "Error: $error");
    }
  }

  // Future<void> uploadProduct(Product product, File productImage) async {
  //   final id = DateTime.now().millisecondsSinceEpoch.toString();
  //   product.id = id;
  //   final productImageUrl = await uploadImage(
  //       image: productImage,
  //       reference: "products/${product.sellerId}/${product.id}");
  //   product.image = productImageUrl;
  //   await firestore.collection("products").doc(id).set(product.toJson());
  // }

  // Future<String> uploadImage(
  //     {required File image, required String reference}) async {
  //   final storageReference = storage.ref(reference);

  //   TaskSnapshot uploadTask = await storageReference.putFile(image);
  //   final String url = await uploadTask.ref.getDownloadURL();

  //   print(url);

  //   return url;
  // }

  Future<void> uploadVehicle(
      BuildContext context, Vehicle vehicle, File productImage) async {
    final firebaseUser = firebaseAuth.currentUser;
    final QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('vehicles')
        .where("uid", isEqualTo: firebaseUser?.uid)
        .get();
    final int documents = qSnap.docs.length;

    print(documents);
    if (documents <= 4) {
      final productImageUrl =
          await uploadProductImage(image: productImage, vehicle: vehicle);
      vehicle.image = productImageUrl;

      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final maintenance_uniquie_id =
          DateTime.now().millisecondsSinceEpoch.toString();
      vehicle.maintenance_uniquie_id = maintenance_uniquie_id;
      vehicle.id = id;

      await firestore.collection("vehicles").doc().set(vehicle.toJson());

      void _showDialogmini(BuildContext context) {
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
                          padding: const EdgeInsets.only(
                              top: 40.0, right: 0, left: 0),
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
                ),
              );
            });
      }
    } else {
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
                            text: 'Limit Full',
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
                          text: "NO MORE CARS CAN BE ADDED !",
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

  Future<void> uploadMaintenance(
    BuildContext context,
    MaintenanceModel maintenance,
  ) async {
    final firebaseUser = firebaseAuth.currentUser;
    final QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('maintenance')
        .where("uid", isEqualTo: firebaseUser?.uid)
        .get();
    final int documents = qSnap.docs.length;

    // final int documents = await FirebaseFirestore.instance
    //     .collection('vehicles')
    //     .where("loginuser", isEqualTo: firebaseUser?.uid)
    //     .snapshots()
    //     .length;

    // print(documents);

    print(documents);
    if (documents <= 50) {
      //  final id = DateTime.now().millisecondsSinceEpoch.toString();
      //  maintenance.usid = id;
      // read

      // var qid;
      // qid = maintenanceid;

      // final prefs = await SharedPreferences.getInstance();
      // read
      // final myfid = prefs.getString('qid_key') ?? "";
      // write
      //prefs.setString('qid_key', myfid);

      //print(myfid.toString());

      // qid = myfid;
      //  print(myfid.toString());
      const _chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random _rnd = Random();

      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
      var randomString = getRandomString(20); // 5GKjb
      maintenance.id = randomString;
      maintenance.status = "incomplete";
      maintenance.trip = "0";
      statusq = maintenance.status;
      await firestore
          .collection("maintenance")
          .doc(randomString)
          .set(maintenance.toJson());
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Limit Full"),
              content: Text("No More Maintenace can be added"),
              actions: [
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  Future<String> uploadProductImage(
      {required File image, required vehicle}) async {
    final storageReference =
        storage.ref("products/${vehicle.uid}/${vehicle.id}");

    TaskSnapshot uploadTask = await storageReference.putFile(image);
    final String url = await uploadTask.ref.getDownloadURL();

    print(url);

    return url;
  }

//   Future<List<Vehicle>> getProducts() async {
//     try {
//       final querySnapshot = await firestore.collection("vehicles").get();
//       print(querySnapshot.size);
//       List<Vehicle> vehicles = List.empty(growable: true);

//       querySnapshot.docs.forEach((doc) {
//         final data = doc.data();

//         final product = Vehicle.fromJson(data);
//         vehicles.add(product);
//       });
//       return vehicles;
//     } on FirebaseException catch (error, stk) {
//       throw error;
//     }
//   }
// }

  Future<List<Vehicle>> getVehicles() async {
    try {
      final firebaseUser = firebaseAuth.currentUser;
      final querySnapshot = await firestore
          .collection("vehicles")
          //  .where("loginuser", isEqualTo: firebaseAuth.currentUser)
          //   .where("loginuser", isEqualTo: firebaseUser?.uid)
          //.orderBy("id")

          .where("loginuser", isEqualTo: firebaseUser?.uid)
          .orderBy('id', descending: true)
          .get();

      // where("population", ">", 100000), orderBy("population"), limit(2)
      List<Vehicle> vehicles = List.empty(growable: true);

      querySnapshot.docs.forEach((doc) {
        final data = doc.data();

        final vehicle = Vehicle.fromJson(data);
        vehicles.add(vehicle);
      });
      return vehicles;
    } on FirebaseException catch (error, stk) {
      //
      throw error;
    }
  }

  Future<List<MaintenanceModel>> getMaintenance() async {
    try {
      print(
          " And this is  maintenance uniquie id from vehicle ${maintenance_unique_id}");
      String a = maintenance_unique_id;
      final firebaseUser = firebaseAuth.currentUser;
      final querySnapshot = await firestore
          .collection("maintenance")
          //  .where("loginuser", isEqualTo: firebaseAuth.currentUser)
          //   .where("loginuser", isEqualTo: firebaseUser?.uid)

          .where("uid", isEqualTo: firebaseUser?.uid)
          .where('maintenance_uniquie_id', isEqualTo: a)
          // /   .orderBy('maintenance_uniquie_id', descending: true)
          .get();

      //   String a = "maintenance_uniquie_id";
      // print("this is  maintennace uniquie id ${a}");

      // where("population", ">", 100000), orderBy("population"), limit(2)
      List<MaintenanceModel> maintenances = List.empty(growable: true);

      querySnapshot.docs.forEach((doc) {
        final data = doc.data();

        final maintenance = MaintenanceModel.fromJson(data);
        maintenances.add(maintenance);
      });
      return maintenances;
    } on FirebaseException catch (error, stk) {
      //
      throw error;
    }
  }

  // Stream<List<Vehicle>> getProductsstream() {
  //   try {
  //      final firebaseUser = firebaseAuth.currentUser;
  //     final querySnapshot =
  //         firestore.collection('vehicles')
  //         .where("loginuser", isEqualTo: firebaseUser?.uid)
  //      .orderBy('id', descending: true)
  //         .snapshots().listen((event) {
  //       for (var element in event.docChanges) {
  //         List<Vehicle> vehicles = List.empty(growable: true);
  //         querySnapshot.docs.forEach((doc) {
  //           final data = doc.data();
  //           final vehicle = Vehicle.fromJson(data);
  //           vehicles.add(vehicle);

  //           return vehicles;
  //         });
  //       }
  //     });
  //   } on FirebaseException catch (error, stk) {
  //     //
  //     throw error;
  //   }
  // }
  // final firebaseUser = firebaseAuth.currentUser;
  // final querySnapshot =firestore
  //     .collection("vehicles")
  //     .where("loginuser", isEqualTo: firebaseUser?.uid)
  //     .orderBy('id', descending: true)
  //     .get();

  //     List<Vehicle> vehicles = List.empty(growable: true);

  //     querySnapshot.docs.forEach((doc) {
  //       final data = doc.data();

  //       final vehicle = Vehicle.fromJson(data);
  //       vehicles.add(vehicle);
  //     });
  //     return vehicles;
  //   } on FirebaseException catch (error, stk) {
  //     //
  //     throw error;
  //   }
  // }
}
