// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vehiclemaintenance/addVehical/components/vehicleformpreviewdata.dart';
// import 'package:vehiclemaintenance/models/app_products.dart';

// class PreferencesService extends ChangeNotifier {
//   Future saveSettings(Settings vehicle) async {
//     final preferences = await SharedPreferences.getInstance();
//     //TextField Save
//     await preferences.setString('vehiclenumber', vehicle.vehiclenumber);
//     await preferences.setString('maker', vehicle.maker);
//     await preferences.setString('manufactureyear', vehicle.manufactureyear);
//     await preferences.setInt('model', vehicle.model);
//     await preferences.setString('enginenumber', vehicle.enginenumber);
//     await preferences.setInt('metervalue', vehicle.metervalue);
//     //  await preferences.setString('image', vehicle.image);

//     //print('Saved settings');
//   }

//   Future<Settings> getSettings() async {
//     final preferences = await SharedPreferences.getInstance();
//     final vehiclenumber = preferences.getString('vehiclenumber') ?? "";
//     final maker = preferences.getString('maker') ?? '';
//     final manufactureyear = preferences.getString('manufactureyear') ?? "";
//     final model = preferences.getInt('model') ?? 0;
//     final enginenumber = preferences.getString('enginenumber') ?? "";
//     final metervalue = preferences.getInt('metervalue') ?? 0;
//     // final image = preferences.getString('image') ?? "";
//     // final id = "";
//     //final loginuser = "";
//     return Settings(
//       vehiclenumber: vehiclenumber,
//       maker: maker,
//       manufactureyear: manufactureyear,
//       model: model,
//       enginenumber: enginenumber,
//       metervalue: metervalue,
//       // image: image,
//       // id: id,
//       //  loginuser: loginuser
//     );
//   }
// }
