import 'dart:convert';
import 'dart:io';

import 'package:babay_pro/api/HttpService.dart';
import 'package:babay_pro/models/ApiResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../models/ComunitySubmitModel.dart';

// 将 StatelessWidget 修改为 StatefulWidget
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // 1. 定义控制器来获取 TextField 中的内容
  final TextEditingController _captionController = TextEditingController();

  // 2. 预留图片选择器实例
  final ImagePicker _picker = ImagePicker();
  String _path = "";

  // 释放资源
  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  // 模拟发布逻辑
  void _handlePublish() {
    final text = _captionController.text;
    if (text.isNotEmpty) {
      print('发布内容: $text');
      // 这里可以添加上传逻辑
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Create Post'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: _handlePublish, // 绑定发布方法
            child: const Text('Publish'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // 建议添加滚动视图，防止键盘弹起时溢出
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 顶部卡片部分
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFEEF0),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Color(0xFFFF5A5F),
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Share a new moment',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Add photos, a location and a short caption for your ride.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // 文本输入框
                TextField(
                  controller: _captionController, // 绑定控制器
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write something...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // 操作按钮栏
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          // TODO: 调用 _picker.pickImage 选择图片后执行 setState
                          final imgage = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          print("image ${imgage?.path}");
                          final file = File(imgage!.path);
                          final bytes = await file.readAsBytes();
                          final base64 = base64Encode(bytes);
                          String base64Image =
                              "data:image/png;base64," + base64;

                          print(base64Image);

                          final params = {
                            "content": _captionController.text,
                            "images": [base64Image],
                          };
                          EasyLoading.show();
                          try {
                            final res = await HttpService().post(
                              "/posts",
                              params,
                            );
                            print("res===$res");
                            EasyLoading.dismiss();
                            final model = ApiResponse.fromJson(res.data, (data) => Comunitysubmitmodel())
;                            if (model.code == 0) {
                              print("success");
                              EasyLoading.showToast('success');
                              Navigator.pop(context);
                            }
                          }catch(e) {

                          }

                          setState(() {
                            _path = imgage!.path;
                          });
                        },
                        icon: const Icon(Icons.image_outlined),
                        label: const Text('Photo'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: 获取位置逻辑
                        },
                        icon: const Icon(Icons.place_outlined),
                        label: const Text('Location'),
                      ),
                    ),
                  ],
                ),
                Image.file(File("$_path")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
