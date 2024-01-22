import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int wordLimit;
  final TextStyle textStyle;

  const ExpandableText({
    Key? key,
    required this.text,
    required this.wordLimit,
    required this.textStyle,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool showFullText = false;

  @override
  Widget build(BuildContext context) {
    String displayText = widget.text;
    if (!showFullText && widget.text.split(' ').length > widget.wordLimit) {
      displayText =
          '${widget.text.split(' ').take(widget.wordLimit).join(' ')}...';
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          showFullText = !showFullText;
        });
      },
      child: Text(
        displayText,
        style: widget.textStyle,
      ),
    );
  }
}
