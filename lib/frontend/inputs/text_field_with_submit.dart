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

  /// The controller for the input field.
  final TextEditingController controller;

  /// The keyboard type for the input field.
  final TextInputType? keyboardType;

  /// The input formatters for the input field.
  final List<TextInputFormatter>? inputFormatter;

  /// The function to be executed when the submit button is pressed.
  final Function onPressed;

  /// Constructs a [TextFieldWithSubmit] widget.
  ///
  /// The [hintText] parameter is optional and provides hint text for the input field.
  /// The [buttonText] parameter is optional and sets the text on the submit button.
  /// The [buttonColor] parameter is optional and sets the color of the submit button.
  /// The [buttonElevation] parameter is optional and sets the elevation of the submit button.
  /// The [inputDecoration] parameter is optional and provides decoration for the input field.
  /// The [distanceBetweenInputAndButton] parameter is optional and sets the distance between the input field and the submit button.
  /// The [paddingBetweenButtonAndTextField] parameter is optional and sets the padding between the submit button and the input field.
  /// The [borderRadius] parameter is optional and sets the border radius for the input field and submit button.
  /// The [buttonTextStyle] parameter is optional and sets the text style for the submit button.
  /// The [mainAxisAlignment] parameter is optional and sets the main axis alignment for the widget.
  /// The [keyboardType] parameter is optional and sets the keyboard type for the input field.
  /// The [inputFormatter] parameter is optional and sets the input formatters for the input field.
  /// The [padding] parameter is optional and sets the overall padding for the widget.
  /// The [controller] parameter is required and represents the controller for the input field.
  /// The [onPressed] parameter is required and is the function to be executed when the submit button is pressed.
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
    this.padding = const EdgeInsets.all(16.0),
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
