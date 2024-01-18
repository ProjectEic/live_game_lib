import 'package:flutter/material.dart';

class TextButtonWidget extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Function? onHover;
  final Function? onHoverExit;
  final Function? onTap;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? borderRadius;
  final String? url;

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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.url!),
          fit: BoxFit.cover,
        ),
      ),
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
              backgroundColor: MaterialStateProperty.all(
                  widget.backgroundColor ?? Colors.transparent),
              foregroundColor: MaterialStateProperty.all(
                  widget.foregroundColor ?? Colors.transparent),
              shape: MaterialStateProperty.all(
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
                    const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
