import 'dart:math' as math;
import 'package:flutter/material.dart';

class FancyBackground extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const FancyBackground({Key? key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: BackgroundPainter(),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 104, 58, 183)
      ..style = PaintingStyle.fill;

    final random = math.Random();
    const circleCount = 2;
    const rectangleCount = 3;

    final shapes = <Rect>[];

    for (int i = 0; i < circleCount; i++) {
      final shapeSize = random.nextDouble() * 100 + 50;

      Rect shapeRect;
      bool intersects;

      do {
        intersects = false;

        final centerX =
            random.nextDouble() * (size.width - shapeSize * 2) + shapeSize;
        final centerY =
            random.nextDouble() * (size.height - shapeSize * 2) + shapeSize;

        shapeRect = Rect.fromCircle(
            center: Offset(centerX, centerY), radius: shapeSize);

        for (final existingRect in shapes) {
          if (shapeRect.overlaps(existingRect)) {
            intersects = true;
            break;
          }
        }
      } while (intersects);

      shapes.add(shapeRect);

      canvas.drawCircle(
        shapeRect.center,
        shapeSize,
        paint,
      );
    }

    for (int i = 0; i < rectangleCount; i++) {
      final shapeWidth = random.nextDouble() * 100 + 50;
      final shapeHeight = random.nextDouble() * 100 + 50;

      Rect shapeRect;
      bool intersects;

      do {
        intersects = false;

        final left = random.nextDouble() * (size.width - shapeWidth);
        final top = random.nextDouble() * (size.height - shapeHeight);

        shapeRect = Rect.fromLTWH(left, top, shapeWidth, shapeHeight);

        for (final existingRect in shapes) {
          if (shapeRect.overlaps(existingRect)) {
            intersects = true;
            break;
          }
        }
      } while (intersects);

      shapes.add(shapeRect);

      canvas.drawRect(shapeRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
