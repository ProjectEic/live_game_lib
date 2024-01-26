import 'package:flutter/material.dart';

class RowCenter extends StatelessWidget {
  final List<Widget> children;

  const RowCenter({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
