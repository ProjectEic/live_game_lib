import 'package:flutter/material.dart';

/// A custom widget for displaying subheadings with customizable styling.
class SubHeading extends StatelessWidget {
  /// The text to be displayed in the subheading.
  final String text;

  /// The style to be applied to the subheading.
  final TextStyle? textStyle;

  /// The font size of the subheading.
  final double? fontSize;

  /// The space between words in the subheading.
  final double? wordSpacing;

  /// The space between characters in the subheading.
  final double? letterSpacing;

  /// The color of the subheading text.
  final Color? color;

  /// The background color of the subheading.
  final Color? backgroundColor;

  /// The font weight of the subheading text.
  final FontWeight? fontWeight;

  /// The font family of the subheading text.
  final String? fontFamily;

  /// The background paint of the subheading text.
  final Paint? background;

  /// The foreground paint of the subheading text.
  final Paint? foreground;

  /// The decoration to be applied to the subheading text.
  final TextDecoration? decoration;

  /// The list of shadows applied to the subheading text.
  final List<Shadow>? shadows;

  /// The baseline alignment of the subheading text.
  final TextBaseline? textBaseline;

  /// The font style of the subheading text.
  final FontStyle? fontStyle;

  /// The overflow behavior for the subheading text.
  final TextOverflow? overflow;

  /// The alignment of the subheading text within its container.
  final TextAlign? textAlign;

  /// Constructs a [SubHeading] widget.
  ///
  /// The [text] parameter is required and represents the text to be displayed in the subheading.
  /// The other parameters are optional and allow customization of the subheading's appearance.
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
