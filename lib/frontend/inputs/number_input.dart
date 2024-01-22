import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatelessWidget {
  final double value;

  const NumberInput({super.key, required this.value});

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
