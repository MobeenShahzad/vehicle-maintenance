import 'package:vehiclemaintenance/Add_maintenance/AddNewMaintenace.dart';
import 'package:vehiclemaintenance/Edit_maintenance/EditMaintenance.dart';
import 'package:vehiclemaintenance/Home/home.dart';
import 'package:vehiclemaintenance/Maintenance/maintenance.dart';
import 'package:vehiclemaintenance/Meter_Guidelines.dart/MeterGuidelines.dart';
import 'package:vehiclemaintenance/Register/register_screen.dart';
import 'package:vehiclemaintenance/SplashScreen/SplashScreen.dart';
import 'package:vehiclemaintenance/Warnings.dart/Warnings.dart';
import 'package:vehiclemaintenance/addVehical/AddNewVehical.dart';
import 'package:vehiclemaintenance/forgetpassword/forgotPassword.dart';
import 'package:vehiclemaintenance/guidelines.dart/guidelines.dart';
import 'package:vehiclemaintenance/login/login_screen.dart';
import 'package:vehiclemaintenance/models/app_vehicle.dart';
import 'package:vehiclemaintenance/newpassword/newpassword.dart';
import 'package:vehiclemaintenance/resetpassword/resetpassword.dart';
import 'package:vehiclemaintenance/updatemeter/updatemeter.dart';

class AppRoutes {
  static const splashscreen = "/splashscreen";
  static const register = "/register";
  static const loginscreen = "/loginscreen";
  static const forgetpassword = "/forgetpassword";
  static const resetpassword = "/resetpassword";
  static const newpassword = "/newpassword";
  static const updatemeter = "/updatemeter";
  static const addnewvehicle = "/addnewvehicle";
  static const maintenance = "/maintenance";
  static const addnewmaintenance = "/addnewmaintenace";
  static const home = "/home";
  static const guidelines = "/guideline";
  static const warnings = "/warnings";
  static const meterguidelines = "/meterguidelines";
  static const editmaintenance = "/editmaintenance";

  static final appRoutes = {
    splashscreen: (context) => SplashScreen(),
    register: (context) => const Register(),
    loginscreen: (context) => LoginScreen(),
    forgetpassword: (context) => ForgetPassword(),
    resetpassword: (context) => ResetPassword(),
    newpassword: (context) => const NewPassword(),
    updatemeter: (context) => const UpdateMeter(),
    addnewvehicle: (context) => AddNewVehical(),
    maintenance: (context) => Maintenance(),
    addnewmaintenance: (context) => AddNewMaintenace(),
    home: (context) => Home(),
    guidelines: (context) => const Guidelines(),
    warnings: (context) => Warnings(),
    meterguidelines: (context) => const MeterGuidelines(),
    editmaintenance: (context) => EditMaintenance()
  };
}
