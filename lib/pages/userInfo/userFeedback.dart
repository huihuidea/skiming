import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class UserFeedback extends StatefulWidget {
  const UserFeedback({super.key});

  @override
  State<UserFeedback> createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed back"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: .infinity,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    spreadRadius: 2
                  )
                ]
              ),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Please your feedback",
                  border: .none
                ),
              ),
            ),
            SizedBox(height: 40,),
            SizedBox(
              width: .infinity,
              height: 44,
              child: ElevatedButton(onPressed: (){
                Fluttertoast.showToast(
                  msg: "Your feedback submitted",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,   // 必加
                  textColor: Colors.white,
                  fontSize: 16.0,
                );

              }, child: Text("Submit")),
            )
          ],
        ),
      ),
    );
  }
}
