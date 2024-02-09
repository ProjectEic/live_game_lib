// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget representing an input field with a submit button.
class TextFieldWithSubmit extends StatelessWidget {
  /// The hint text for the input field.
  final String hintText;

  /// The text displayed on the submit button.
  final String buttonText;

  /// The color of the submit button.
  final Color buttonColor;

  /// The elevation of the submit button.
  final double buttonElevation;

  /// The padding between the submit button and the input field.
  final EdgeInsets paddingBetweenButtonAndTextField;

  /// The overall padding around the entire widget.
  final EdgeInsets padding;

  /// The distance between the input field and the submit button.
  final double distanceBetweenInputAndButton;

  /// The border radius of the input field and the submit button.
  final double borderRadius;

  /// The text style of the submit button.
  final TextStyle buttonTextStyle;

  /// The input decoration for the input field.
  final InputDecoration? inputDecoration;

  /// The main axis alignment of the widget.
  final MainAxisAlignment? mainAxisAlignment;
  TextEditingController controller = TextEditingController();
  final TextInputType? keyboardType;

  /// The input formatters for the input field.
  final List<TextInputFormatter>? inputFormatter;
  final Function(String b) onPressed;

  TextFieldWithSubmit({
    Key? key,
    this.hintText = 'Enter text',
    this.buttonText = 'Submit',
    this.buttonColor = Colors.black,
    this.buttonElevation = 4.0,
    this.inputDecoration,
    this.distanceBetweenInputAndButton = 20.0,
    this.paddingBetweenButtonAndTextField =
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    this.borderRadius = 8.0,
    this.buttonTextStyle = const TextStyle(fontSize: 16.0, color: Colors.white),
    this.mainAxisAlignment,
    this.keyboardType,
    this.inputFormatter,
    controller ,
    required this.onPressed, required this.padding,
  }) : super(key: key) {
    this.controller = controller ?? this.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: controller,
            decoration: inputDecoration ?? InputDecoration(hintText: hintText),
            keyboardType: keyboardType,
            inputFormatters: inputFormatter,
          ),
          SizedBox(height: distanceBetweenInputAndButton),
          ElevatedButton(
            child: Text(hintText, style: buttonTextStyle),
            onPressed: () => onPressed(controller.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              padding: paddingBetweenButtonAndTextField,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
