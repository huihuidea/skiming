import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 背景和波浪线
          // Container(
          //   height: 60,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     border: Border(top: BorderSide(color: Colors.grey[200]!, width: 1)),
          //   ),
          //   child: CustomPaint(
          //     size: Size(double.infinity, 60),
          //     painter: WavePainter(),
          //   ),
          // ),
          // 导航栏
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              onTap: onTap,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/tab2.png", width: 24, height: 24),
                  activeIcon: Image.asset("assets/images/tab1_s.png", width: 24, height: 24),
                  label: "home",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/tab3.png", width: 24, height: 24),
                  activeIcon: Image.asset("assets/images/tab3.png", width: 24, height: 24),
                  label: "Community",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withAlpha(77),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 30),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/tab4.png", width: 24, height: 24),
                  activeIcon: Image.asset("assets/images/tab4.png", width: 24, height: 24),
                  label: "Shop",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/tab5.png", width: 24, height: 24),
                  activeIcon: Image.asset("assets/images/tab5.png", width: 24, height: 24),
                  label: "Person",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}