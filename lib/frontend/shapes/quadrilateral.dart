import 'package:flutter/material.dart';
import 'point.dart';
import 'two_d_shapes.dart';

class Quadrilateral extends TwoDShape {
  Point pointA = Point(x: 0, y: 0);
  Point pointB = Point(x: 0, y: 0);
  Point pointC = Point(x: 0, y: 0);
  Point pointD = Point(x: 0, y: 0);

  Quadrilateral({
    required double x1,
    required double y1,
    required double x2,
    required double y2,
    required double x3,
    required double y3,
    required double x4,
    required double y4,
    double newThickness = 5,
    Color newColor = Colors.black,
  }) {
    pointA = Point(x: x1, y: y1, thickness: thickness, color: newColor);
    pointB = Point(x: x2, y: y2, thickness: thickness, color: newColor);
    pointC = Point(x: x3, y: y3, thickness: thickness, color: newColor);
    pointD = Point(x: x4, y: y4, thickness: thickness, color: newColor);

    color = newColor;
    thickness = newThickness;
  }

  Quadrilateral.fromPoints(
      {required this.pointA,
      required this.pointB,
      required this.pointC,
      required this.pointD});

  List<Positioned> buildSquare() {
    List<Positioned> points = [];

    for (Point point1 in [pointA, pointD]) {
      for (Point point2 in [pointA, pointD]) {
        double x = point1.x;
        double y = point1.y;
        double x2 = point2.x;
        double y2 = point2.y;

        double dx = (x2 - x).abs();
        double dy = (y2 - y).abs();
        double sx = x < x2 ? 1 : -1;
        double sy = y < y2 ? 1 : -1;
        double err = dx - dy;
        while (true) {
          points.add(Positioned(
            left: x,
            top: y,
            child: Container(
              width: thickness,
              height: thickness,
              color: color,
            ),
          ));
          if (x == x2 && y == y2) break;
          double e2 = 2 * err;
          if (e2 > -dy) {
            err -= dy;
            x += sx;
          }
          if (e2 < dx) {
            err += dx;
            y += sy;
          }
        }
      }
    }

    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: buildSquare(), // dunno ob das funktioniert
    );
  }
}
