import 'package:babay_pro/Utils/Storage.dart';
import 'package:babay_pro/pages/login.dart';
import 'package:babay_pro/pages/userInfo/userFeedback.dart';
import 'package:babay_pro/store/userInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../store/providers.dart';

class Setting extends ConsumerWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _appname = ref.watch(appNameProvider);
    final _userName = ref.watch(userNameProvider);
    return Scaffold(
      backgroundColor: Color(0xffF1F5F9),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _topView()),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: _userInfo(_userName,ref)),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: _items()),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: _achivement(ref)),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            _itemList(context, ref),
          ],
        ),
      ),
    );
  }

  // topview
  Widget _topView() {
    return Container(
      height: 160 + 112 / 2,
      child: Stack(
        children: [
          //background
          Container(
            width: .infinity,
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: .topLeft,
                end: .bottomRight,
                colors: [Color(0xff3B82F6), Color(0xff38BDF8)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(16),
          ),
          //avater
          Align(
            alignment: .bottomCenter,
            child: Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                shape: .circle,
                color: Colors.white,
                border: Border.all(width: 4, color: Colors.white),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: ClipOval(
                child: Image.network(
                  "https://picsum.photos/id/870/200/300?grayscale&blur=2",
                  fit: .cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //UserInfo
  Widget _userInfo(String name,WidgetRef ref) {
    final _isLogin = ref.watch(isLoginProvider);
    final _userInfo = ref.watch(userProvider);

    return Column(
      children: [
        Text("Hello , ${_isLogin ? _userInfo?.username ?? "Visitor" : "Visitor"} ", style: TextStyle(fontSize: 20, fontWeight: .bold)),
        Text('Email: ${_userInfo?.email.isNotEmpty == true ? _userInfo!.email : "未设置"}'),
      ],
    );
  }

  //items
  Widget _items() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),

        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          _itemCell("124", "Folloers".toUpperCase()),
          _itemCell("45", "Following".toUpperCase()),
          _itemCell("12", "Resorts".toUpperCase()),
        ],
      ),
    );
  }

  //
  Widget _itemCell(String val, String title) {
    return Column(
      children: [
        Text("$val", style: TextStyle(fontSize: 18, fontWeight: .w500)),
        SizedBox(height: 4),
        Text("$title", style: TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }

  //Achivements
  Widget _achivement(WidgetRef ref) {
    final _isLogin = ref.watch(isLoginProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(vertical: 16),
            child: Text("Achivements", style: TextStyle(fontSize: 14)),
          ),
          Row(
            mainAxisAlignment: .start,
            children: [
              _archivementItem(
                Icons.face,
                "speed pro",
                Color(0xffFEF3C7),
                Color(0xffFEF3C7),
              ),
              SizedBox(width: 16),
              _archivementItem(
                Icons.speed,
                "speed pro",
                Color(0xffEFF6FF),
                Color(0xffFEF3C7),
              ),
              SizedBox(width: 16),
              _archivementItem(
                Icons.alarm,
                "speed pro",
                Color(0xffECFDF5),
                Color(0xffFEF3C7),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _archivementItem(
    IconData icon,
    String title,
    Color bg,
    Color itemColor,
  ) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: bg.withAlpha(120),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [Icon(icon), SizedBox(height: 6), Text("$title")],
      ),
    );
  }

  //List
  Widget _itemList(BuildContext context, WidgetRef ref) {
    final _isLogin = ref.watch(isLoginProvider);
    return SliverPadding(
      padding: EdgeInsetsGeometry.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                  spreadRadius: 8,
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    "My Gear",
                    style: TextStyle(fontSize: 16, fontWeight: .w500),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Text(
                    "Track Histroy",
                    style: TextStyle(fontSize: 16, fontWeight: .w500),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Text(
                    "Save Tutorials",
                    style: TextStyle(fontSize: 16, fontWeight: .w500),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Text(
                    "Order History",
                    style: TextStyle(fontSize: 16, fontWeight: .w500),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Text(
                    "User settings",
                    style: TextStyle(fontSize: 16, fontWeight: .w500),
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    ref.read(userNameProvider.notifier).state = "lisi";
                  },
                ),
                ListTile(
                  leading: Text(
                    "User feedback",
                    style: TextStyle(fontSize: 16, fontWeight: .w500),
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) {
                          return _isLogin ? UserFeedback() : LoginPage();
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Text(
                    _isLogin ? "Logout" : "Login",
                    style: TextStyle(fontSize: 16, fontWeight: .w500),
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    if (_isLogin) {
                      showDialog(
                        context: context,
                        builder: (cxt) {
                          return AlertDialog(
                            title: Text("Tips"),
                            content: Text("are you sure to Logout"),
                            actions: [
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                              }, child: Text("No")),
                              TextButton(
                                onPressed: () {
                                  Storage.cleanToken();
                                  ref.read(isLoginProvider.notifier).state =
                                      false;
                                  Navigator.pop(context);
                                },
                                child: Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (cxt) => LoginPage()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
