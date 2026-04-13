import 'dart:io' show Platform;
import 'package:babay_pro/models/ApiResponse.dart';
import 'package:babay_pro/models/loginModel.dart';
import 'package:babay_pro/pages/register.dart';
import 'package:babay_pro/store/providers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:babay_pro/api/HttpService.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  var _isSee = false;

  @override
  Widget build(BuildContext context) {
    final futureProvier = ref.watch(userProileProvider);

    //login submit
    void _submit() async {
      if (_key.currentState!.validate()) {
        final pamrams = {
          "username": _controller1.text,
          "password": _controller2.text,
        };
        print("Button pressed $pamrams");
        EasyLoading.show();
        try {
          final res = await HttpService().post(
            '/login',
            pamrams,
          );
          final model = ApiResponse<LoginModel>.fromJson(
            res.data,
                (data) => LoginModel.fromJson(
              data as Map<String, dynamic>,
            ),
          );
          print("userInfo ${model.data?.userInfo.createdAt}");
          EasyLoading.dismiss();
          if (model.code == 0) {
            Fluttertoast.showToast(
              msg:
              "${model.message} vip:${model.data?.userInfo.vip.level}",
              gravity: .CENTER
            );
          } else {
            Fluttertoast.showToast(
              msg: "Login error ${model.message}",
            );
          }
        } catch (e) {
          EasyLoading.dismiss();
          print("error===$e");
          // 登录失败
          String errorMessage =
              "Login failed. Please try again.";

          showDialog(
            context: context,
            builder: (cxt) {
              return AlertDialog(
                title: Text("Login Error"),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(cxt);
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (cxt) {
            return AlertDialog(
              title: Text("Warning"),
              content: Text(
                "Please fill in all required fields",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(cxt);
                  },
                  child: Text("I know"),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: futureProvier.when(
          data: (v) => Text("$v"),
          error: (r, _) => Text("err"),
          loading: () => CircularProgressIndicator(),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                //account
                TextFormField(
                  controller: _controller1,
                  validator: (v) {
                    if (v?.isEmpty == true) {
                      return "account should not be null";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "please input accout",
                    border: OutlineInputBorder(),
                    labelText: "accout",
                  ),
                ),
                SizedBox(height: 16),
                //passwordbor
                TextFormField(
                  controller: _controller2,
                  validator: (v) {
                    if (v?.isEmpty == true) {
                      print("password---null");
                      return "password should not null";
                    }
                    print("password---$v");
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "please Input password",
                    labelText: "password",
                    border: OutlineInputBorder(),
                    suffixIcon: InkWell(
                      child: Icon(
                        _isSee ? Icons.remove_red_eye : Icons.panorama_fish_eye,
                      ),
                      onTap: () {
                        setState(() {
                          _isSee = !_isSee;
                        });
                      },
                    ),
                  ),
                  obscureText: _isSee,
                ),
                //user agreement
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: .start,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Checkbox(value: true, onChanged: (v) {}),
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "You must know",
                          children: [
                            TextSpan(
                              text: " User agreent",
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: .underline,
                              ),
                            ),
                            TextSpan(text: " And "),
                            TextSpan(
                              text: "User Ploicy ",
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: .underline,
                              ),
                            ),
                            TextSpan(
                              text: "if you have not accout ,please to ",
                              children: [
                                TextSpan(
                                  text: "register",
                                  style: TextStyle(
                                    decoration: .underline,
                                    color: Colors.red,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (cxt) {
                                            return Register();
                                          },
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Spacer(),
                //
                SizedBox(
                  width: .infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: ()  {
                      _submit();
                    },
                    child: Text("Login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
