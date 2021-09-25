import 'package:face_detection_app/constants.dart';
import 'package:flutter/material.dart';

class FacePainter extends CustomPainter {
  FacePainter({required this.faces});

  final List<Rect> faces;

  @override
  void paint(Canvas canvas, Size size) {
    for (var face in faces) {
      final offsetA = Offset(face.topLeft.dx, face.topLeft.dy);
      final offsetB = Offset(face.bottomRight.dx, face.bottomRight.dy);

      final rectCoordinates = Rect.fromPoints(offsetA, offsetB);

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.yellow
        ..strokeWidth = 16.0;

      canvas.drawRRect(
          RRect.fromRectAndRadius(rectCoordinates, circularRadius), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
