import 'package:flutter/material.dart';

/// A custom widget that creates a row with centered alignment for its children.
class RowCenter extends StatelessWidget {
  /// The list of widgets to be displayed in the row.
  final List<Widget> children;

  /// Constructs a [RowCenter] widget.
  ///
  /// The [children] parameter is required and represents the list of widgets to be displayed in the row.
  const RowCenter({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
