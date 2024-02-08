import 'package:flutter/material.dart';

/// A custom widget that creates a column with space-evenly alignment for its children.
class ColumnSpaceEvenly extends StatelessWidget {
  /// The list of widgets to be displayed in the column.
  final List<Widget> children;

  /// Constructs a [ColumnSpaceEvenly] widget.
  ///
  /// The [children] parameter is required and represents the list of widgets to be displayed in the column.
  const ColumnSpaceEvenly({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }
}
