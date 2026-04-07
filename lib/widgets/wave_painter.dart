import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[100]!
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.1);
    
    // 波浪线
    final waveHeight = size.height * 0.05;
    final waveWidth = size.width / 10;
    
    for (int i = 0; i < 10; i++) {
      final x = i * waveWidth;
      final y = i % 2 == 0 ? size.height * 0.1 - waveHeight : size.height * 0.1 + waveHeight;
      path.lineTo(x, y);
    }
    
    path.lineTo(size.width, size.height * 0.1);
    path.lineTo(size.width, 0);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}