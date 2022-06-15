import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/login/component/body.dart';
import 'package:vehiclemaintenance/login/login_screen.dart';
import 'package:vehiclemaintenance/providers/auth_provider.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return Background(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, left: 50, right: 0, bottom: 0),
                  child: Text(
                    'Create New account',
                    style: GoogleFonts.poiretOne(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtils.screenheight(context) * 0.07,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtils.screenheight(context) * 0.07),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40.0, top: 6, bottom: 8, right: 38),
                    child: Text(
                      'Name',
                      style: GoogleFonts.poiretOne(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtils.screenheight(context) * 0.024,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtils.screenheight(context) * 0.070,
                    width: ScreenUtils.screenwidth(context) * 0.6,
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Name";
                        }
                        return null;
                      },

                      // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(6),
                        fillColor: AppColors.ktextColorWhite,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 10, left: 0, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0, top: 6, bottom: 8, right: 45),
                      child: Text(
                        'Email',
                        style: GoogleFonts.poiretOne(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  ScreenUtils.screenheight(context) * 0.024,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtils.screenheight(context) * 0.070,
                      width: ScreenUtils.screenwidth(context) * 0.6,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        maxLength: 40,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        controller: email,
                        validator: (value) => validateEmail(value),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(6),
                          fillColor: AppColors.ktextColorWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 0, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0, top: 6, bottom: 8, right: 40),
                      child: Text(
                        'Phone',
                        style: GoogleFonts.poiretOne(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  ScreenUtils.screenheight(context) * 0.024,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtils.screenheight(context) * 0.07,
                      width: ScreenUtils.screenwidth(context) * 0.6,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: phone,
                        maxLength: 13,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter Phone Number";
                          }
                          return null;
                        },
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(6),
                          fillColor: AppColors.ktextColorWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 0, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0, top: 6, bottom: 8, right: 10),
                      child: Text(
                        'Username',
                        style: GoogleFonts.poiretOne(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  ScreenUtils.screenheight(context) * 0.024,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtils.screenheight(context) * 0.07,
                      width: ScreenUtils.screenwidth(context) * 0.6,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: username,
                        keyboardType: TextInputType.text,
                        maxLength: 20,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter UserName";
                          }
                          return null;
                        },
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(6),
                          fillColor: AppColors.ktextColorWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 0, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0, top: 6, bottom: 8, right: 17),
                      child: Text(
                        'Password',
                        style: GoogleFonts.poiretOne(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  ScreenUtils.screenheight(context) * 0.024,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtils.screenheight(context) * 0.045,
                      width: ScreenUtils.screenwidth(context) * 0.6,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: password,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter Password";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(6),
                          fillColor: AppColors.ktextColorWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0, bottom: 0),
                child: Center(
                  child: FlutterPwValidator(
                    controller: password,
                    minLength: 8,
                    uppercaseCharCount: 1,
                    numericCharCount: 1,
                    specialCharCount: 1,
                    width: ScreenUtils.screenwidth(context) * 0.55,
                    height: ScreenUtils.screenheight(context) * 0.08,
                    onSuccess: () {
                      print("MATCHED");
                      // ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                      //     content: new Text("Password is matched"))

                      //  );
                    },
                    // onFail: () {
                    //   print("NOT MATCHED");
                    //   ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                    //       content: new Text("Password is Incorrect")));
                    // }
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .RegisterUser(
                      context,
                      name: nameController.text,
                      email: email.text,
                      password: password.text,
                      username: username.text,
                      phone: phone.text,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 100),
                    child: Container(
                      height: ScreenUtils.screenheight(context) * 0.04,
                      width: ScreenUtils.screenwidth(context) * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xff4a4f60),
                      ),
                      child: Center(
                          child: Text(
                        'Sign Up',
                        style: GoogleFonts.poiretOne(
                          textStyle: TextStyle(
                              color: AppColors.ktextColorWhite,
                              fontSize:
                                  ScreenUtils.screenwidth(context) * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account?",
                      style: GoogleFonts.poiretOne(
                        fontStyle: FontStyle.normal,
                        fontSize: ScreenUtils.screenheight(context) * 0.020,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 109, 112, 115),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.poiretOne(
                          fontStyle: FontStyle.normal,
                          fontSize: ScreenUtils.screenheight(context) * 0.020,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 109, 112, 115),
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
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background.png'), fit: BoxFit.cover),
      ),
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              'assets/login_header.png',
              width: size.width,
            ),
          ),
          Positioned(
            top: ScreenUtils.screenheight(context) * 0.85,
            child: Image.asset(
              'assets/login_footer.png',
              width: size.width,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
