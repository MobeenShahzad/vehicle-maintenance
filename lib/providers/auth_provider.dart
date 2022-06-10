import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehiclemaintenance/ScreenUtils/routes.dart';
import 'package:vehiclemaintenance/models/app_user.dart';
import 'package:vehiclemaintenance/repo/network.dart';

class AuthProvider with ChangeNotifier {
  final network = Network();
  final firebaseAuth = FirebaseAuth.instance;
  late AppUser currentUser;

  void checkCurrentUser(BuildContext context) async =>
      Future.delayed(const Duration(seconds: 2), () async {
        try {
          currentUser = await network.checkCurrentUser();
          // if (currentUser.type == UserType.seller) {
          //  Navigator.of(context).pushReplacementNamed(AppRoutes.addnewvehicle);
          //  print(currentUser.type);
          //  } else if (currentUser.type == UserType.buyer) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
          //   }
        } on FirebaseException catch (error, stk) {
          log("Error code: ${error.code}, Message: ${error.message}");
          Navigator.of(context).pushReplacementNamed(AppRoutes.loginscreen);
        }
      });

  void RegisterUser(
    BuildContext context, {
    required String name,
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    final AppUser user = AppUser(
      uid: "", name: name, email: email, username: username, phone: phone,
      //type: UserType.buyer
    );
    try {
      final currentUser = await network.register(
        user: user,
        password: password,
        username: username,
        phone: phone,
      );

      Navigator.pushReplacementNamed(context, AppRoutes.loginscreen);
    } on FirebaseException catch (error, stk) {
      //TODO: Handle Exception
    }
    //          try {
    //             final user =
    // await network.register(name: name, email: email, password: password, type:UserType.buyer, uid : "");
    // appUser = user;
    // Navigator.pushNamed(
    //     context, AppRoutes.homeScreen, );
    //           }  on FirebaseException {

    //   //TODO: Handle Exception
    //   showAlertDialog;
    // }
  }

  void login(BuildContext context,
      {required String email, required String password}) async {
    try {
      print("auth provider login");
      currentUser = await network.login(email: email, password: password);
      // if (currentUser.type == UserType.seller) {
      //   Navigator.of(context).pushReplacementNamed(AppRoutes.addnewvehicle);
      //  } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      // }
    } on FirebaseAuthException catch (error, stk) {
      print("ERROR OCCURED IN NETWORK FUNCTION: DISPLAYING IN PROVIDER");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Invalid Email or Password"),
              content: Text("Enter a Correct Email or Password"),
              actions: [
                FlatButton(
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

  void signOut(BuildContext context) {
    firebaseAuth.signOut();
    Navigator.pushNamed(context, AppRoutes.loginscreen);
  }
}
