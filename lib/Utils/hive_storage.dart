import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  static late Box _box;

  static Future init() async {
    await Hive.initFlutter();
  }

  static Future openHive() async {
    _box = await Hive.openBox("USERINFO");
  }

  static Future setHive(String key, dynamic value) async {
    await _box.put(key, value);
  }

  static Future<dynamic> getHive(String key) async {
    return _box.get(key);
  }
}
