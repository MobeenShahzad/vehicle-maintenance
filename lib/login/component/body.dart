import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vehiclemaintenance/Register/register_screen.dart';
import 'package:vehiclemaintenance/ScreenUtils/app_colors.dart';
import 'package:vehiclemaintenance/ScreenUtils/screenutils.dart';
import 'package:vehiclemaintenance/forgetpassword/forgotPassword.dart';
import 'package:vehiclemaintenance/login/component/background.dart';
import 'package:vehiclemaintenance/providers/auth_provider.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenUtils.screenheight(context) * 0.27,
              ),
              Text(
                'Login',
                style: GoogleFonts.poiretOne(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtils.screenwidth(context) * 0.15,
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtils.screenheight(context) * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: ScreenUtils.screenheight(context) * 0.09,
                  width: ScreenUtils.screenwidth(context) * 0.8,
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) => validateEmail(value),
                    decoration: InputDecoration(
                      errorStyle: GoogleFonts.poiretOne(
                        color: Color.fromARGB(255, 253, 4, 4),
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtils.screenheight(context) * 0.017,
                      ),
                      fillColor: Color.fromARGB(255, 255, 253, 251),
                      filled: true,
                      border: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: Icon(Icons.mail_outline),
                      ),
                      hintText: 'Username@gmail.com',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 35),
                child: SizedBox(
                  height: ScreenUtils.screenheight(context) * 0.06,
                  width: ScreenUtils.screenwidth(context) * 0.8,
                  child: TextField(
                    controller: passwordController,
                    obscureText: isObsecure,
                    decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 255, 253, 251),
                        filled: true,
                        border: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Password",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                            top: 9,
                            bottom: 15,
                            right: 0,
                          ),
                          child: Icon(Icons.lock,
                              color: Color.fromARGB(255, 144, 146, 153)),
                        ),
                        labelStyle: const TextStyle(color: Color(0xFF424242)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObsecure = !isObsecure;
                              });
                            },
                            icon: Icon(
                              isObsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: isObsecure
                                  ? const Color(0xFF424242)
                                  : Color.fromARGB(255, 30, 29, 28),
                            ))),
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false).login(
                        context,
                        email: emailController.text,
                        password: passwordController.text);
                  },
                  child: Container(
                    height: ScreenUtils.screenheight(context) * 0.055,
                    width: ScreenUtils.screenwidth(context) * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xff4a4f60),
                    ),
                    child: Center(
                        child: Text(
                      'Log in',
                      style: GoogleFonts.poiretOne(
                        textStyle: TextStyle(
                            color: AppColors.ktextColorWhite,
                            fontSize: ScreenUtils.screenwidth(context) * 0.06,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPassword(),
                        ));
                  },
                  child: Text(
                    "Forget Password?",
                    style: GoogleFonts.raleway(
                      fontStyle: FontStyle.normal,
                      fontSize: ScreenUtils.screenheight(context) * 0.020,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 109, 112, 115),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
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
                              builder: (context) => const Register(),
                            ));
                      },
                      child: Text(
                        "Register",
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

String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value))
    return 'Enter a valid email address !';
  else
    return null;
}
