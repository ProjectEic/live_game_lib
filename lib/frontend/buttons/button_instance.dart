import 'package:flutter/material.dart';

/// A data class representing a button with a label and an onPressed callback.
class Button {
  /// The text label displayed on the button.
  final String label;

  /// A callback function that is executed when the button is pressed.
  final VoidCallback onPressed;

  /// Creates a new instance of the [Button] class.
  ///
  /// The [label] parameter is required and specifies the text label for the button.
  /// The [onPressed] parameter is required and provides a callback function to be executed when the button is pressed.
  const Button({
    required this.label,
    required this.onPressed,
  });
}
