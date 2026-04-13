import 'dart:io';

import 'package:babay_pro/api/HttpService.dart';
import 'package:babay_pro/api/user_api.dart';
import 'package:babay_pro/models/ApiResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:babay_pro/models/register.dart' as RegosterModel;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  //commit
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      Map<String, String> params = {
        'username': _controller1.text,
        'password': _controller2.text,
      };
      EasyLoading.show();
      try {
        final resReqModel = await UserApi.register(params);
        EasyLoading.dismiss();
        if (resReqModel.code == 0) {
          Fluttertoast.showToast(msg: "register success");
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: resReqModel.message);
        }
      } catch (e) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: "Throw a error: $e");
        print(e);
      }
    } else {
      Fluttertoast.showToast(msg: "Please you check");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _controller1,
                decoration: InputDecoration(
                  hintText: "userName",
                  labelText: "UserName",
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  return v?.isEmpty == true ? "should not be null" : null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _controller2,
                validator: (v) {
                  return v?.isEmpty == true ? "should not be null" : null;
                },
                decoration: InputDecoration(
                  hintText: "password",
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              //Space
              Spacer(),
              //RegiserBUtton
              SizedBox(
                width: .infinity,
                height: 44,
                child: ElevatedButton(onPressed: () {
                  _submit();
                }, child: Text("Sign in")),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // Form
}
