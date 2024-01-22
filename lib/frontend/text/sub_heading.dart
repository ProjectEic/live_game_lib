import 'package:flutter/material.dart';

class SubHeading extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextOverflow? overflow;
  final TextStyle? textStyle;
  final Color? color;
  final String? fontFamily;
  final Paint? background;
  final Color? backgroundColor;
  final Paint? foreground;
  final TextDecoration? decoration;
  final List<Shadow>? shadows;
  final TextBaseline? textBaseline;

  const SubHeading({
    Key? key,
    this.textStyle,
    this.fontSize,
    this.wordSpacing,
    this.letterSpacing,
    this.color,
    this.backgroundColor,
    this.fontWeight,
    this.fontFamily,
    this.background,
    this.foreground,
    this.decoration,
    this.shadows,
    this.textBaseline,
    this.fontStyle,
    this.overflow,
    this.textAlign,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ??
          TextStyle(
            fontSize: fontSize ?? 18.0,
            fontWeight: fontWeight ?? FontWeight.bold,
            color: color ?? Colors.black,
            fontFamily: fontFamily,
            background: background,
            decoration: decoration,
            foreground: foreground,
            wordSpacing: wordSpacing,
            letterSpacing: letterSpacing,
            shadows: shadows,
            backgroundColor: backgroundColor,
            textBaseline: textBaseline,
            fontStyle: fontStyle,
            overflow: overflow,
          ),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
