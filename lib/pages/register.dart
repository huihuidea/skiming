import 'dart:io';

import 'package:babay_pro/api/HttpService.dart';
import 'package:flutter/material.dart';
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
                decoration: InputDecoration(
                  hintText: "userName",
                  labelText: "UserName",
                  border: OutlineInputBorder()
                ),
                validator: (v){
                  return v?.isEmpty == true ? "should not be null" : null;
                },
              ),
              SizedBox(height: 16,),
              TextFormField(
                validator: (v){
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
                child: ElevatedButton(onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                      Map<String,String> params = {
                        'username' : 'ddd',
                        'password' : '123456'
                      };
                     try {
                       final res = await HttpService().post("/register", params);
                       final model = RegosterModel.Register.formJosn(res.data);
                       print("model ${model.message}");
                     } catch (e) {
                       Fluttertoast.showToast(msg: "error: $e");
                     }
                  } else {
                      Fluttertoast.showToast(msg: "Register error");
                  }
                }, child: Text("Sign in")),
              ),
              SizedBox(height: 32,)
            ],
          ),
        ),
      ),
    );
  }
  // Form
}
