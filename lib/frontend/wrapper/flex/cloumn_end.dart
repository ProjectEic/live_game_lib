import 'package:flutter/material.dart';

/// A Column that has the main axis alignment set to end
class ColumnEnd extends StatelessWidget {
  final List<Widget> children;

  const ColumnEnd({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
