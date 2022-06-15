import 'package:cloud_firestore/cloud_firestore.dart';

class MaintenanceModel {
  MaintenanceModel({
    required this.miantenancetype,
    required this.km,
    required this.maintenacedate,
    required this.serialnumber,
    required this.tolbyday,
    required this.tolbykm,
    required this.desc,
    required this.maintenance_uniquie_id,
    required this.uid,
    required this.id,
    required this.status,
    required this.trip,
  });
  String id;
  String miantenancetype;
  String km;
  String maintenacedate;
  String serialnumber;
  String tolbyday;
  String tolbykm;
  String desc;
  String uid;
  String maintenance_uniquie_id;
  String status;
  String trip;

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) =>
      MaintenanceModel(
          miantenancetype: json["miantenancetype"],
          km: json["km"],
          maintenacedate: json["maintenacedate"],
          serialnumber: json["serialnumber"],
          tolbyday: json["tolbyday"],
          tolbykm: json["tolbykm"],
          desc: json["desc"],
          maintenance_uniquie_id: json["maintenance_uniquie_id"],
          uid: json["uid"],
          id: json["id"],
          status: json["status"],
          trip: json["trip"]);

  Map<String, dynamic> toJson() => {
        "miantenancetype": miantenancetype,
        "km": km,
        "maintenacedate": maintenacedate,
        "serialnumber": serialnumber,
        "tolbyday": tolbyday,
        "tolbykm": tolbykm,
        "desc": desc,
        "maintenance_uniquie_id": maintenance_uniquie_id,
        "uid": uid,
        "id": id,
        "status": status,
        "trip": trip
      };
}
