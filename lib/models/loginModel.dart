// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String token;
  UserInfo userInfo;

  LoginModel({
    required this.token,
    required this.userInfo,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    token: json["token"],
    userInfo: UserInfo.fromJson(json["userInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "userInfo": userInfo.toJson(),
  };
}

class UserInfo {
  String username;
  String gender;
  String avatar;
  Vip vip;
  String address;
  String email;
  DateTime createdAt;

  UserInfo({
    required this.username,
    required this.gender,
    required this.avatar,
    required this.vip,
    required this.address,
    required this.email,
    required this.createdAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    username: json["username"],
    gender: json["gender"],
    avatar: json["avatar"],
    vip: Vip.fromJson(json["vip"]),
    address: json["address"],
    email: json["email"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

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
    level: json["level"],
    isActive: json["isActive"],
    expireAt: json["expireAt"],
  );

  Map<String, dynamic> toJson() => {
    "level": level,
    "isActive": isActive,
    "expireAt": expireAt,
  };
}
