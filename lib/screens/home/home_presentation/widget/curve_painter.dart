import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;

    final path = Path();

    double width = size.width;
    double height = size.height;

    path.moveTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);

    path.cubicTo(
      width * 0.6,
      height * 0.95,
      width * 1.05,
      height * 0.5,
      width,
      0,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
