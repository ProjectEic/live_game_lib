import 'package:flutter/material.dart';

/// A Row that has the main axis alignment set to center
class RowEnd extends StatelessWidget {
  final List<Widget> children;

  const RowEnd({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
