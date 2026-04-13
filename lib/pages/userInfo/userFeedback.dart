import 'package:babay_pro/api/HttpService.dart';
import 'package:babay_pro/models/ApiResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/FeedbackModel.dart';

class UserFeedback extends StatefulWidget {
  const UserFeedback({super.key});

  @override
  State<UserFeedback> createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {

  final TextEditingController _controller = TextEditingController();

  // 提交接口
  void _submitFeedback() async {
    if(_controller.text.isEmpty) {
      // Fluttertoast.showToast(msg: "Please Input content");
      EasyLoading.showToast("Please Input content");
      return;
    }
    EasyLoading.show(status: "loading");
    final params = {'content': _controller.text, 'userId': '69dc3d59e61b46abf7bd2c9a'};
    try {
      final res = await HttpService().post("/feedback", params);
      final model = ApiResponse<Feedbackmodel>.fromJson(
        res.data,
        (data) => Feedbackmodel.fromJson(data as Map<String, dynamic>),
      );
      EasyLoading.dismiss()
;      if (model.code == 0) {
        Fluttertoast.showToast(msg: "Sumit success ${model.data?.content}",gravity: .TOP);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Sumit error");
      }
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: "Sumit Throw a error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feed back")),
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
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Please your feedback",
                  border: .none,
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: .infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  _submitFeedback();
                },
                child: Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
