import 'package:flutter/material.dart';

class TextWithPadding extends StatelessWidget {
  final double padding;
  final bool bold;
  final String text;

  const TextWithPadding(this.text,
      {Key key, this.padding = 8.0, this.bold = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        text,
        style:
            TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
