import 'package:babay_pro/models/ApiResponse.dart';
import 'package:babay_pro/models/loginModel.dart';
import 'package:babay_pro/models/register.dart';
import 'package:hive/hive.dart';
import './HttpService.dart';
class UserApi {
  // 注册
  static Future<ApiResponse<Register>> register(Map<String, dynamic> params) async {
    final res = await HttpService().post("/register", params);
    final model =  ApiResponse<Register>.fromJson(res.data, (data) => Register.formJosn(data as  Map<String,dynamic>));
    return model;
  }

  //登陆
  static Future<ApiResponse<LoginModel>> login(Map<String,dynamic> params) async {
    final res = await HttpService().post("/login", params);
    final model = ApiResponse<LoginModel>.fromJson(res.data, (data) => LoginModel.fromJson(data as Map<String,dynamic> ));

    var box = Hive.box("USERINFO");
    await box.put("USERINFO", model.data?.userInfo.toJson());

    return model;
  }

  // 获取userInfoUSERINFO
  static Future<ApiResponse<LoginModel>> updateUsrInfo(Map<String,dynamic> params) async {
    final res = await HttpService().patch("/profile",params);
    final model = ApiResponse<LoginModel>.fromJson(res.data, (data) => LoginModel.fromJson(data as Map<String,dynamic> ));
    return model;
  }
}
