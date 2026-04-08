import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController(text: "zhangsan");
  final TextEditingController _controller2 = TextEditingController(text: "123456");
  var _isSee = false;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text("Login"),
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
                      child: Icon(_isSee ? Icons.remove_red_eye : Icons.panorama_fish_eye),
                      onTap: (){
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
                    Text.rich(
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
                            text: "User Ploicy",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: .underline,
                            ),
                          ),
                        ],
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
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (cxt) {
                            return AlertDialog(
                              title: Text("success"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(cxt);
                                  Navigator.pop(context);
                                }, child: Text("Good"))
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (cxt) {
                            return AlertDialog(
                              title: Text("warring"),
                              content: Text("Login has error"),
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
