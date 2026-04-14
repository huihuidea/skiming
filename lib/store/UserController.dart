import 'package:babay_pro/models/userInfo_model.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../Utils/hive_storage.dart';

class UserController extends StateNotifier<UserInfoModel?> {
  UserController(): super(null) {
    loadFormHive();
  }

 Future<void> loadFormHive()  async{
    final user = await HiveStorage.getHive("USERINFO");
    print("loadFormHive---${user}");
    if (user != null) {
     final model = UserInfoModel.fromJson(
       Map<String, dynamic>.from(user as Map),
     );
     state = model;
     print("loadFormHive Model---${model.username}");
    }
  }

  Future saveHive(UserInfoModel? model) async {
    state = model;
    await HiveStorage.setHive("USERINFO", model?.toJson());
    print("SaveHive Model---${model?.toJson()}");
  }
}
