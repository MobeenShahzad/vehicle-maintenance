class Vehicle {
  Vehicle({
    required this.image,
    required this.maker,
    required this.vehiclenumber,
    required this.manufactureyear,
    required this.model,
    required this.uid,
    required this.id,
    required this.enginenumber,
    required this.metervalue,
    required this.maintenance_uniquie_id,
  });

  String image;
  String maker;
  String vehiclenumber;
  int manufactureyear;
  int model;
  String enginenumber;
  int metervalue;
  String uid;
  String id;
  String maintenance_uniquie_id;
  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
      image: json["image"],
      maker: json["maker"],
      vehiclenumber: json["vehiclenumber"],
      manufactureyear: json["manufactureyear"],
      model: json["model"],
      enginenumber: json["enginenumber"],
      metervalue: json["metervalue"],
      uid: json["uid"],
      id: json["id"],
      maintenance_uniquie_id: json["maintenance_uniquie_id"]);

  Map<String, dynamic> toJson() => {
        "image": image,
        "maker": maker,
        "vehiclenumber": vehiclenumber,
        "manufactureyear": manufactureyear,
        "model": model,
        "enginenumber": enginenumber,
        "metervalue": metervalue,
        "uid": uid,
        "id": id,
        "maintenance_uniquie_id": maintenance_uniquie_id,
      };
}
