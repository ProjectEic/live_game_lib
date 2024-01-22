import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final double? fontSize;
  final double? wordSpacing;
  final double? letterSpacing;
  final Color? color;
  final String? fontFamily;
  final Paint? background;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final Paint? foreground;
  final TextDecoration? decoration;
  final List<Shadow>? shadows;
  final TextBaseline? textBaseline;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const Headline({
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
            fontSize: fontSize ?? 24.0,
            fontWeight: fontWeight ?? FontWeight.bold,
            color: color ?? Colors.black,
            fontFamily: fontFamily,
            background: background,
            decoration: decoration,
            foreground: foreground,
            wordSpacing: wordSpacing ?? 2.0,
            letterSpacing: letterSpacing ?? 1.0,
            shadows: shadows,
            backgroundColor: backgroundColor,
            textBaseline: textBaseline,
            fontStyle: fontStyle,
            overflow: overflow,
          ),
      textAlign: textAlign,
    );
  }
}
