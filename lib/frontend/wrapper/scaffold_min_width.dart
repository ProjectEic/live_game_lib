import 'package:flutter/material.dart';

/// A custom scaffold widget that enforces a minimum width for its body.
class ScaffoldMinWidth extends StatelessWidget {
  /// The main content of the scaffold.
  final Widget body;

  /// The minimum width to be enforced for the scaffold.
  final double minWidth;

  /// The background color of the entire scaffold.
  final Color? backgroundColor;

  /// The background color of the scaffold body.
  final Color? backgroundColorBody;

  /// The padding applied to the scaffold body.
  final EdgeInsets? padding;

  /// The title widget displayed in the app bar.
  final Widget? title;

  /// The widget displayed at the bottom of the scaffold.
  final Widget? bottomNavigationBar;

  /// The widget displayed as the floating action button.
  final Widget? floatingActionButton;

  /// The app bar configuration for the scaffold.
  final AppBar? appBar;

  /// Constructs a [ScaffoldMinWidth] widget.
  ///
  /// The [body] parameter is required and represents the main content of the scaffold.
  /// The [minWidth] parameter sets the minimum width enforced for the scaffold.
  /// The other parameters are optional and allow customization of the scaffold's appearance.
  const ScaffoldMinWidth({
    Key? key,
    required this.body,
    this.minWidth = 600,
    this.backgroundColor,
    this.backgroundColorBody,
    this.padding,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double screenWidth = constraints.maxWidth;

        return Scaffold(
          appBar: appBar ??
              AppBar(
                title: title,
              ),
          body: Container(
            width: screenWidth < minWidth ? minWidth : screenWidth,
            color: backgroundColorBody,
            padding: padding,
            child: body,
          ),
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          backgroundColor: backgroundColor,
        );
      },
    );
  }
}
