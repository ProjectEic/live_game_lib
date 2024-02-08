import 'package:flutter/material.dart';

/// A custom widget that creates a column with space-around alignment for its children.
class ColumnSpaceAround extends StatelessWidget {
  /// The list of widgets to be displayed in the column.
  final List<Widget> children;

  /// Constructs a [ColumnSpaceAround] widget.
  ///
  /// The [children] parameter is required and represents the list of widgets to be displayed in the column.
  const ColumnSpaceAround({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: children,
    );
  }
}
