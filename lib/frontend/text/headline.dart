import 'package:flutter/material.dart';

/// A custom widget for displaying headlines with customizable styling.
class Headline extends StatelessWidget {
  /// The text to be displayed in the headline.
  final String text;

  /// The style to be applied to the headline.
  final TextStyle? textStyle;

  /// The font size of the headline.
  final double? fontSize;

  /// The space between words in the headline.
  final double? wordSpacing;

  /// The space between characters in the headline.
  final double? letterSpacing;

  /// The color of the headline text.
  final Color? color;

  /// The background color of the headline.
  final Color? backgroundColor;

  /// The font weight of the headline text.
  final FontWeight? fontWeight;

  /// The font family of the headline text.
  final String? fontFamily;

  /// The background paint of the headline text.
  final Paint? background;

  /// The foreground paint of the headline text.
  final Paint? foreground;

  /// The decoration to be applied to the headline text.
  final TextDecoration? decoration;

  /// The list of shadows applied to the headline text.
  final List<Shadow>? shadows;

  /// The baseline alignment of the headline text.
  final TextBaseline? textBaseline;

  /// The font style of the headline text.
  final FontStyle? fontStyle;

  /// The overflow behavior for the headline text.
  final TextOverflow? overflow;

  /// The alignment of the headline text within its container.
  final TextAlign? textAlign;

  /// Constructs a [Headline] widget.
  ///
  /// The [text] parameter is required and represents the text to be displayed in the headline.
  /// The other parameters are optional and allow customization of the headline's appearance.
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
