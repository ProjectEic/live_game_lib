import 'package:flutter/material.dart';

abstract class TwoDShape {
  BoxDecoration? decoration;
  Color color = Colors.black;
  double thickness = 5;

  Widget build(BuildContext context);

  void stroke(Color? strokeColor, double? strokeWeight) {
    decoration =
        boxDecotration(strokeColor ?? color, strokeWeight ?? thickness);
  }

  void noStroke() {
    decoration = null;
  }

  void strokeWeight(double thickness) {
    this.thickness = thickness;
  }

  void fill(Color color) {
    this.color = color;
  }

  void borderRadius(double radius) {
    decoration = decoration!.copyWith(
      borderRadius: BorderRadius.circular(radius),
    );
  }

  BoxDecoration boxDecotration(Color color, double thickness) {
    return BoxDecoration(
      color: color,
      border: Border.all(
        color: color,
        width: thickness,
      ),
    );
  }
}
