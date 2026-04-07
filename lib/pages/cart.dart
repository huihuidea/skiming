import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle, size: 60, color: Colors.red),
          SizedBox(height: 20),
          Text('Publish Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}