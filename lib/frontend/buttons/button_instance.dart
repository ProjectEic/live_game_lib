import 'package:flutter/material.dart';

class Button {
  final String label;
  final VoidCallback onPressed;

  const Button({
    required this.label,
    required this.onPressed,
  });
}
