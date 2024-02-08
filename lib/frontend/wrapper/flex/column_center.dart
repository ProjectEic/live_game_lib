import 'package:flutter/material.dart';

/// A custom widget that creates a column with centered alignment for its children.
class ColumnCenter extends StatelessWidget {
  /// The list of widgets to be displayed in the column.
  final List<Widget> children;

  /// Constructs a [ColumnCenter] widget.
  ///
  /// The [children] parameter is required and represents the list of widgets to be displayed in the column.
  const ColumnCenter({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
