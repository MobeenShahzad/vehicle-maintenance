import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:vehiclemaintenance/Maintenance/maintenance.dart';
import 'package:vehiclemaintenance/models/app_maintennace.dart';
import 'package:vehiclemaintenance/models/app_vehicle.dart';
import 'package:vehiclemaintenance/repo/network.dart';

class HomeNotifier with ChangeNotifier {
  Network _network = Network();

  List<Vehicle> products = List.empty(growable: true);
  List<Maintenance> maintenance = List.empty(growable: true);

  Future<void> uploadVehicle(
    BuildContext context, {
    required File image,
    required String maker,
    required String vehiclenumber,
    required int manufactureyear,
    required int model,
    required String uid,
    required String enginenumber,
    required int metervalue,
  }) async {
    Vehicle vehicle = Vehicle(
        image: "",
        maker: maker,
        vehiclenumber: vehiclenumber,
        manufactureyear: manufactureyear,
        model: model,
        enginenumber: enginenumber,
        metervalue: metervalue,
        uid: uid,
        id: "",
        maintenance_uniquie_id: "");

    await _network.uploadVehicle(context, vehicle, image);
  }

  Future<void> uploadMaintenance(
    BuildContext context, {
    required String miantenancetype,
    required String km,
    required String maintenacedate,
    required String serialnumber,
    required String tolbyday,
    required String desc,
    required String maintenance_uniquie_id,
    required String uid,
    required String tolbykm,
  }) async {
    MaintenanceModel maintenance = MaintenanceModel(
        miantenancetype: miantenancetype,
        km: km,
        maintenacedate: maintenacedate,
        serialnumber: serialnumber,
        tolbyday: tolbyday,
        tolbykm: tolbykm,
        desc: desc,
        maintenance_uniquie_id: maintenance_uniquie_id,
        uid: uid,
        id: "",
        status: "",
        trip: "0");

    await _network.uploadMaintenance(context, maintenance);
  }

  Future<List<Vehicle>> getVehicles() async => await _network.getVehicles();
  Future<List<MaintenanceModel>> getMaintenance() async =>
      await _network.getMaintenance();

  //   Stream<List<Vehicle>> getProductsstream() {
  //   return  _network.getProductsstream();

  // }

}
