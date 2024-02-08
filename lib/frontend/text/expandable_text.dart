import 'package:flutter/material.dart';

/// A widget that displays text and can expand or collapse based on a word limit.
class ExpandableText extends StatefulWidget {
  /// The full text to be displayed.
  final String text;

  /// The word limit for the initial display before expanding.
  final int wordLimit;

  /// The text style for the displayed text.
  final TextStyle textStyle;

  /// Constructs an [ExpandableText] widget.
  ///
  /// The [text] parameter is required and represents the full text to be displayed.
  /// The [wordLimit] parameter is required and sets the word limit for the initial display before expanding.
  /// The [textStyle] parameter is required and represents the text style for the displayed text.
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
    // Determine the text to be displayed based on the word limit
    String displayText = widget.text;
    if (!showFullText && widget.text.split(' ').length > widget.wordLimit) {
      displayText =
          '${widget.text.split(' ').take(widget.wordLimit).join(' ')}...';
    }

    return GestureDetector(
      onTap: () {
        // Toggle between showing full text and truncated text on tap
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
