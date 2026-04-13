// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';
import './userInfo_model.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String token;
  UserInfoModel userInfo;

  LoginModel({
    required this.token,
    required this.userInfo,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    token: json["token"],
    userInfo: UserInfoModel.fromJson(json["userInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "userInfo": userInfo.toJson(),
  };
}
