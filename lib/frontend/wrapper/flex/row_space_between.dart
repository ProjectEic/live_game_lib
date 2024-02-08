import 'package:flutter/material.dart';

/// A custom widget that creates a row with space-between alignment for its children.
class RowSpaceBetween extends StatelessWidget {
  /// The list of widgets to be displayed in the row.
  final List<Widget> children;

  /// Constructs a [RowSpaceBetween] widget.
  ///
  /// The [children] parameter is required and represents the list of widgets to be displayed in the row.
  const RowSpaceBetween({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }
}
