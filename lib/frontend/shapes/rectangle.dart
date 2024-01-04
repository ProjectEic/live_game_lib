import 'package:flutter/material.dart';

import 'two_d_shapes.dart';

class Rectangle extends TwoDShape {
  double x;
  double y;
  double width;
  double height;

  Rectangle(
      {required this.x,
      required this.y,
      required this.width,
      required this.height}) {
    stroke(Colors.black, 1);
    fill(Colors.transparent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration,
    );
  }
}
