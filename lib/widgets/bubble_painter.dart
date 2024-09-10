import 'package:flutter/material.dart';

class BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.purpleAccent.shade700;
    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.1),
      size.width * 1.1,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
