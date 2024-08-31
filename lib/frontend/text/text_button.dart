import 'package:flutter/material.dart';

/// A custom widget representing a text button with various customization options.
class TextButtonWidget extends StatefulWidget {
  /// The text to be displayed on the button.
  final String text;

  /// The function to be executed when the button is pressed.
  final Function onPressed;

  /// The function to be executed when the mouse hovers over the button.
  final Function? onHover;

  /// The function to be executed when the mouse exits the button's hover area.
  final Function? onHoverExit;

  /// The function to be executed when the button is tapped.
  final Function? onTap;

  /// The style to be applied to the text on the button.
  final TextStyle? textStyle;

  /// The background color of the button.
  final Color? backgroundColor;

  /// The foreground color of the button (text color).
  final Color? foregroundColor;

  /// The horizontal padding of the button.
  final double? horizontalPadding;

  /// The vertical padding of the button.
  final double? verticalPadding;

  /// The border radius of the button.
  final double? borderRadius;

  /// The URL of the background image for the button.
  final String? url;

  /// Constructs a [TextButtonWidget] widget.
  ///
  /// The [text] parameter is required and represents the text to be displayed on the button.
  /// The [onPressed] parameter is required and is the function to be executed when the button is pressed.
  /// The other parameters are optional and allow customization of the button's appearance and behavior.
  const TextButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.onHover,
    this.onHoverExit,
    this.onTap,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.borderRadius,
    this.url,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TextButtonWidgetState createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.url != null
          ? BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.url!),
                fit: BoxFit.cover,
              ),
            )
          : null,
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        child: MouseRegion(
          onEnter: (PointerEvent details) {
            if (widget.onHover != null) {
              widget.onHover!();
            }
          },
          onExit: (PointerEvent details) {
            if (widget.onHoverExit != null) {
              widget.onHoverExit!();
            }
          },
          child: TextButton(
            onPressed: () {
              widget.onPressed();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                  widget.backgroundColor ?? Colors.transparent),
              foregroundColor: WidgetStateProperty.all(
                  widget.foregroundColor ?? Colors.transparent),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 25),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.horizontalPadding ?? 10,
                vertical: widget.verticalPadding ?? 10,
              ),
              child: Text(
                widget.text,
                style: widget.textStyle ??
                    TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
