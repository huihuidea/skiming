import 'package:flutter/services.dart';

class Nativeapi {
  static const channel = MethodChannel("com.baby/native");

  static Future openStting() => channel.invokeMethod("openSetting");

  static Future openCamera() => channel.invokeMethod("opnCarama");
}
