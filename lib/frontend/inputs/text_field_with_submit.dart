// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class TextFieldWithSubmit extends StatefulWidget {
  final String hintText;
  final String buttonText;
  final Color buttonColor;
  final EdgeInsets paddingBetweenButtonAndTextField;
  final double borderRadius;
  final double buttonElevation;
  final TextStyle buttonTextStyle;
  final InputDecoration? inputDecoration;
  final Function onPressed;

  const TextFieldWithSubmit({
    Key? key,
    this.hintText = 'Enter text',
    this.buttonText = 'Submit',
    this.buttonColor = Colors.blue,
    this.buttonElevation = 4,
    this.inputDecoration,
    this.paddingBetweenButtonAndTextField =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.borderRadius = 8,
    this.buttonTextStyle = const TextStyle(fontSize: 16),
    required this.onPressed,
  }) : super(key: key);

  @override
  _TextFieldWithSubmitState createState() => _TextFieldWithSubmitState();
}

class _TextFieldWithSubmitState extends State<TextFieldWithSubmit> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _textEditingController,
          decoration: widget.inputDecoration ??
              InputDecoration(
                hintText: widget.hintText,
              ),
        ),
        ElevatedButton(
          onPressed: widget.onPressed(),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.buttonColor,
            padding: widget.paddingBetweenButtonAndTextField,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            elevation: widget.buttonElevation,
          ),
          child: Text(
            widget.buttonText,
            style: widget.buttonTextStyle,
          ),
        ),
      ],
    );
  }
}
