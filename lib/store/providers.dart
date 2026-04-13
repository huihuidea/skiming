import 'package:babay_pro/Utils/Storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
//1 普通的只能读取值
final appNameProvider = Provider((ref){
  return 'Ski Tracer';
});

//2 有状态的
final userNameProvider = StateProvider((ref){
  return "zhangsan";
});

final isLoginProvider = StateProvider<bool>((ref) {
  return Storage.isLogin();
});

//3.异步
final userProileProvider = FutureProvider((ref) async{
  await Future.delayed(Duration(seconds: 2));
  return "Login";
});

final loginProvider = FutureProvider.family<String,Map<String ,String>>((ref,params) async {
  print("debug ---");

  await Future.delayed(Duration(seconds: 2));
  final userName = params["account"]!;
  print("debug $userName");
  return userName;
});