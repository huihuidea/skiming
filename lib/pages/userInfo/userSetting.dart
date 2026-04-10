import 'package:flutter/material.dart';

class Usersetting extends StatefulWidget {
  const Usersetting({super.key});

  @override
  State<Usersetting> createState() => _UsersettingState();
}

class _UsersettingState extends State<Usersetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text("Setting user"),
        centerTitle: false,
        actions: [],
      ),
      body: Center(
        child: Text("user"),
      ),
    );
  }
}
