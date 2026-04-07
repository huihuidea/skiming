import 'package:babay_pro/pages/setting.dart';
import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/box.dart';
import '../pages/cart.dart';
import '../pages/mine.dart';
import '../pages/login.dart';

class PageConfig {
  final Widget page;
  final String title;

  PageConfig({
    required this.page,
    required this.title,
  });
}

class AppPages {
  static final List<PageConfig> pageConfigs = [
    PageConfig(
      page: HomePage(),
      title: 'Home',
    ),
    PageConfig(
      page: BoxPage(),
      title: 'Search',
    ),
    PageConfig(
      page: CartPage(),
      title: 'Publish',
    ),
    PageConfig(
      page: MinePage(),
      title: 'Shop',
    ),
    PageConfig(
      page: Setting(),
      title: 'Settings',
    ),
  ];

  static List<Widget> get pages => pageConfigs.map((config) => config.page).toList();
  static List<String> get titles => pageConfigs.map((config) => config.title).toList();
  static int get pageCount => pageConfigs.length;
}