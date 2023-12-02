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
  _ExpandableTextState createState() =>
      _ExpandableTextState(); // dunno how to fix this => needed because of set state
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
