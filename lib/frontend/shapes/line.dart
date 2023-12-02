import 'package:flutter/material.dart';
import 'point.dart';
import 'two_d_shapes.dart';

class Line extends TwoDShape {
  Point pointStart = Point(x: 0, y: 0);
  Point pointEnd = Point(x: 0, y: 0);

  Line(
      {required double x,
      required double y,
      required double x2,
      required double y2,
      double? thickness,
      Color? color}) {
    pointStart = Point(x: x, y: y, thickness: thickness, color: color);
    pointEnd = Point(x: x2, y: y2, thickness: thickness, color: color);
  }

  Line.fromPoints(this.pointStart, this.pointEnd);

  List<Positioned> buildLine() {
    List<Positioned> points = [];

    double x = pointStart.x;
    double y = pointStart.y;
    double x2 = pointEnd.x;
    double y2 = pointEnd.y;
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
          width: pointStart.thickness ?? 5,
          height: pointStart.thickness ?? 5,
          color: pointStart.color,
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
    return points;
  }

  void setColor(Color color) {
    pointStart.setColor(color);
    pointEnd.setColor(color);
  }

  void setthickness(double thickness) {
    pointStart.setthickness(thickness);
    pointEnd.setthickness(thickness);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: buildLine(),
    );
  }
}
