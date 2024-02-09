import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget representing a number input field.
///
/// The [NumberInput] widget allows users to input numerical values.
class NumberInput extends StatelessWidget {
  /// The initial value of the number input field.
  final double value;

  /// Constructs a [NumberInput] widget.
  ///
  /// The [value] parameter is required and represents the initial value of the input field.
  const NumberInput({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: value.toString()),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
    );
  }
}
