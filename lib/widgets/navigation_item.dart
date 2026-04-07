import 'package:flutter/material.dart';
class MavigationItem extends StatelessWidget {
  final  String name;
  final IconData icon;
   const MavigationItem({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 60, color: Colors.blue),
            SizedBox(height: 20),
            Icon(icon),
            Text('${name}', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}