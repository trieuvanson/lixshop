import 'package:flutter/material.dart';

class DecoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(size.height * 0.6, size.height);
    path.lineTo(size.width, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.lineTo(size.height * 0.6, size.height);
    path.lineTo(size.height * 0.6, size.height * 0.6);
    path.close();
    // path.quadraticBezierTo(size.width * 0.2, size.height * 0.8,
    //     size.width * 0.5, size.height * 0.6);
    // path.quadraticBezierTo(size.width * 0.8, size.height * 0.4,
    //     size.width * 0.5, size.height * 0.6);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    Paint paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
