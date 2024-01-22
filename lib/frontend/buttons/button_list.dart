import 'package:flutter/material.dart';
import 'button_instance.dart';

class ButtonList extends StatelessWidget {
  final List<Button> buttons;
  final ButtonStyle buttonStyle;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsets? padding;

  const ButtonList({
    Key? key,
    this.mainAxisAlignment,
    this.padding,
    required this.buttons,
    required this.buttonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
      children: buttons.map((button) {
        return Padding(
          padding: padding ?? const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: button.onPressed,
            style: buttonStyle,
            child: Text(button.label),
          ),
        );
      }).toList(),
    );
  }
}
