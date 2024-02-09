import 'package:flutter/material.dart';

/// A custom widget that creates a row with space-around alignment for its children.
class RowSpaceAround extends StatelessWidget {
  /// The list of widgets to be displayed in the row.
  final List<Widget> children;

  /// Constructs a [RowSpaceAround] widget.
  ///
  /// The [children] parameter is required and represents the list of widgets to be displayed in the row.
  const RowSpaceAround({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: children,
    );
  }
}
