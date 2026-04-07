import 'package:flutter/material.dart';

class HomeRecent extends StatelessWidget {
  const HomeRecent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 178,
      width: .infinity,
      decoration: BoxDecoration(
        color: Color(0xff0F172A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_on_rounded, color: Colors.white, size: 40),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "Aspen Snowmass",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Yesterday . 4h 200m",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 82,

            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withAlpha(100), width: 1),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  _item("Runs", "14"),
                  _line(),
                  _item("Avg Speed", "42 km/h"),
                  _line(),
                  _item("Caloires", "850"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // item
  Widget _item(String title, String val) {
    return Container(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Text("$title", style: TextStyle(color: Colors.grey, fontSize: 16)),
          SizedBox(height: 10),
          Text(
            "$val",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: .w500,
            ),
          ),
        ],
      ),
    );
  }

  //line
Widget _line() {
    return Container(
      height: 40,
      width: 1,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(60)
      ),
    );
}
}
