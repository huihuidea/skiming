import 'package:flutter/material.dart';
class HomeCard extends StatelessWidget {

  final String title;
  final IconData iconData;
  final String valStr;
  final String unitStr;

  const HomeCard({super.key ,required this.title, required this.iconData, required this.valStr, required this.unitStr});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 110,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
          boxShadow: [  // 多个阴影叠加
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.blue.withOpacity(0.05),
              blurRadius: 12,
            ),
          ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(iconData),
              SizedBox(width: 10,),
              Text(title,style: TextStyle(
                fontSize: 12
              ),)
            ],
          ),
          Spacer(),
          Row(children: [
            Text(valStr,style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: .w500
            )),
            SizedBox(width: 15),
            Text(unitStr)
          ],)
        ],
      ),
    );
  }
}
