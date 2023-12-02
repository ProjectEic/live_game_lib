import 'package:flutter/material.dart';

class Point {
  double x;
  double y;

  double? thickness;
  Color? color = Colors.black;

  Point({required this.x, required this.y, this.thickness, this.color});

  Color setColor(Color color) {
    this.color = color;
    return color;
  }

  double setthickness(double thickness) {
    this.thickness = thickness;
    return thickness;
  }

  double moveX(double x) {
    this.x = x;
    return this.x;
  }

  double moveY(double y) {
    this.y = y;
    return this.y;
  }

  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: thickness ?? 5,
        height: thickness ?? 5,
        color: color,
      ),
    );
  }
}
