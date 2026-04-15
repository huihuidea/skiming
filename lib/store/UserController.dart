import 'package:babay_pro/models/userInfo_model.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../Utils/hive_storage.dart';

class UserController extends StateNotifier<UserInfoModel?> {
  UserController(): super(null) {
    loadFormHive();
  }

 Future<void> loadFormHive()  async{
    try {
      final user = await HiveStorage.getHive("USERINFO");
      print("loadFormHive---${user}");
      if (user == null) return;
      if (user is! Map) {
        await HiveStorage.removeHive("USERINFO");
        return;
      }

      final model = UserInfoModel.fromJson(
        Map<String, dynamic>.from(user),
      );
      state = model;
      print("loadFormHive Model---${model.username}");
    } catch (e) {
      print("loadFormHive error---$e");
      await HiveStorage.removeHive("USERINFO");
      state = null;
    }
  }

  Future saveHive(UserInfoModel? model) async {
    state = model;
    await HiveStorage.setHive("USERINFO", model?.toJson());
    print("SaveHive Model---${model?.toJson()}");
  }
}
