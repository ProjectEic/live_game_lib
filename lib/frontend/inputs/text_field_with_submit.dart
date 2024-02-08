import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// An input field with a submit button
class TextFieldWithSubmit extends StatelessWidget {
  final String hintText;
  final String buttonText;
  final Color buttonColor;
  final EdgeInsets paddingBetweenButtonAndTextField;
  final EdgeInsets padding;
  final double distanceBetweenInputAndButton;
  final double borderRadius;
  final double buttonElevation;
  final TextStyle buttonTextStyle;
  final InputDecoration? inputDecoration;
  final MainAxisAlignment? mainAxisAlignment;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final Function onPressed;

  const TextFieldWithSubmit({
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
    this.padding =
        const EdgeInsets.all(16.0), // Padding around the entire widget
    required this.controller,
    required this.onPressed,
  }) : super(key: key);

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
            onPressed: () => onPressed(),
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              padding: paddingBetweenButtonAndTextField,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              elevation: buttonElevation,
            ),
            child: Text(
              buttonText,
              style: buttonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
