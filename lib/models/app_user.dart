class AppUser {
  String uid;
  String name;
  String email;
  String username;
  String phone;
  //UserType? type;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    // required this.type,
  });

  //: assert(type != null, "Type should never be Null");

  factory AppUser.fromJson(Map<String, dynamic> json, {required String uid}) =>
      AppUser(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        username: json['username'],
        phone: json['phone'],
        // type: json['type'] == "buyer"
        //     ? UserType.buyer
        //    : json['type'] == null
        //        ? null
        //        : UserType.seller
      );
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'username': username,
        'phone': phone,

        //  "type": type == UserType.buyer ? "buyer" : "seller"
      };
}
