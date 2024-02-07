import 'package:flutter/material.dart';
import 'button_instance.dart';

/// A widget representing a list of buttons with a consistent style.
class ButtonList extends StatelessWidget {
  /// The list of [Button] instances to be displayed.
  final List<Button> buttons;

  /// The style applied to each button in the list.
  final ButtonStyle buttonStyle;

  /// The alignment of the buttons within the column.
  ///
  /// Defaults to [MainAxisAlignment.spaceBetween].
  final MainAxisAlignment? mainAxisAlignment;

  /// The padding applied to each button in the list.
  ///
  /// Defaults to [EdgeInsets.all(8.0)].
  final EdgeInsets? padding;

  /// Creates a new instance of the [ButtonList] widget.
  ///
  /// The [buttons] parameter is required and specifies the list of [Button] instances to be displayed.
  /// The [buttonStyle] parameter is required and provides the style applied to each button in the list.
  /// The [mainAxisAlignment] parameter determines the alignment of the buttons within the column,
  /// with a default value of [MainAxisAlignment.spaceBetween].
  /// The [padding] parameter specifies the padding applied to each button in the list,
  /// with a default value of [EdgeInsets.all(8.0)].
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
