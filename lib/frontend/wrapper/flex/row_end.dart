import 'package:flutter/material.dart';

/// A custom widget that creates a row with end-aligned children.
class RowEnd extends StatelessWidget {
  /// The list of widgets to be displayed in the row.
  final List<Widget> children;

  /// Constructs a [RowEnd] widget.
  ///
  /// The [children] parameter is required and represents the list of widgets to be displayed in the row.
  const RowEnd({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: children,
    );
  }
}
