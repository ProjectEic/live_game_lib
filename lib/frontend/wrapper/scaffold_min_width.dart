import 'package:flutter/material.dart';

class ScaffoldMinWidth extends StatelessWidget {
  final Widget body;
  final double minWidth;
  final Color? backgroundColor;
  final Color? backgroundColorBody;
  final EdgeInsets? padding;
  final Widget? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final AppBar? appBar;

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
