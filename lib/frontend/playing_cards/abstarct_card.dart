import 'package:flutter/material.dart';

import '../shapes/rectangle.dart';

abstract class AbstractCard {
  String value;
  String icon;
  String text;
  double x;
  double y;
  double? width;
  double? height;

  AbstractCard({
    required this.value,
    required this.icon,
    required this.text,
    required this.x,
    required this.y,
    this.width,
    this.height,
  });

  Widget buildCard(BuildContext context) {
    Rectangle rectangle = Rectangle(
      x: x,
      y: y,
      width: width ?? 100,
      height: height ?? 100,
    );

    rectangle.fill(Colors.white);
    rectangle.stroke(Colors.black, 1);
    rectangle.borderRadius(10.0);

    return Column(
      children: [
        rectangle.build(context),
        Positioned(
          left: x + width! / 8,
          top: y + width! / 8,
          child: Text(
            value,
            style: TextStyle(
              fontSize: width! / 6,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          left: x + width! / 8,
          top: y + width! / 8 + width! / 6 + 5,
          child: Text(
            icon,
            style: TextStyle(
              fontSize: width! / 6,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          right: x + width! / 8,
          bottom: y + width! / 8,
          child: Text(
            value,
            style: TextStyle(
              fontSize: width! / 6,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          right: x + width! / 8,
          bottom: y + width! / 8 + width! / 6 + 5,
          child: Text(
            icon,
            style: TextStyle(
              fontSize: width! / 6,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          left: x + width! / 2,
          top: y + width! / 2,
          child: Text(
            icon,
            style: TextStyle(
              fontSize: width! / 4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          left: x + width! / 2,
          top: y + width! / 2 + width! / 4 + 5,
          child: Text(
            icon,
            style: TextStyle(
              fontSize: width! / 4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
