
class UserInfoModel {
  String username;
  String gender;
  String avatar;
  Vip vip;
  String address;
  String email;
  DateTime createdAt;

  UserInfoModel({
    required this.username,
    required this.gender,
    required this.avatar,
    required this.vip,
    required this.address,
    required this.email,
    required this.createdAt,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    final vipJson = json["vip"];
    final createdAtValue = json["createdAt"];

    return UserInfoModel(
      username: json["username"]?.toString() ?? "",
      gender: json["gender"]?.toString() ?? "",
      avatar: json["avatar"]?.toString() ?? "",
      vip: vipJson is Map
          ? Vip.fromJson(Map<String, dynamic>.from(vipJson))
          : Vip.empty(),
      address: json["address"]?.toString() ?? "",
      email: json["email"]?.toString() ?? "",
      createdAt: createdAtValue is DateTime
          ? createdAtValue
          : DateTime.tryParse(createdAtValue?.toString() ?? "") ??
              DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "gender": gender,
    "avatar": avatar,
    "vip": vip.toJson(),
    "address": address,
    "email": email,
    "createdAt": createdAt.toIso8601String(),
  };
}

class Vip {
  int level;
  bool isActive;
  dynamic expireAt;

  Vip({
    required this.level,
    required this.isActive,
    required this.expireAt,
  });

  factory Vip.fromJson(Map<String, dynamic> json) => Vip(
    level: json["level"] is int
        ? json["level"] as int
        : int.tryParse(json["level"]?.toString() ?? "") ?? 0,
    isActive: json["isActive"] == true,
    expireAt: json["expireAt"],
  );

  factory Vip.empty() => Vip(level: 0, isActive: false, expireAt: null);

  Map<String, dynamic> toJson() => {
    "level": level,
    "isActive": isActive,
    "expireAt": expireAt,
  };
}
