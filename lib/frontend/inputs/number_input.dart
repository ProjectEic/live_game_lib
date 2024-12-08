import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget representing a number input field.
///
/// The [NumberInput] widget allows users to input numerical values with decimal
/// support. It provides callbacks for value changes and submission events.
///
/// Example usage:
/// ```dart
/// NumberInput(
///   initialValue: 0.0,
///   onChanged: (value) => print('New value: $value'),
///   onSubmitted: (value) => print('New value: $value submitted'),
/// )
/// ```
class NumberInput extends StatefulWidget {
  /// The initial value of the number input field.
  final double initialValue;

  /// Callback function when the value changes.
  ///
  /// This function is called with the new value whenever the input changes.
  final ValueChanged<double> onChanged;

  /// Callback function when Enter is pressed.
  ///
  /// This function is called when the user submits the input, typically by
  /// pressing the Enter key.
  final Function onSubmitted;

  /// Creates a [NumberInput] widget.
  ///
  /// All parameters are required:
  /// - [initialValue]: The starting value for the input field.
  /// - [onChanged]: Called when the input value changes.
  /// - [onSubmitted]: Called when the user submits the input.
  const NumberInput({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      onChanged: (value) {
        final doubleValue = double.tryParse(value) ?? widget.initialValue;
        widget.onChanged(doubleValue);
      },
      onSubmitted: (value) => widget.onSubmitted(value),
    );
  }
}
