import 'package:flutter/material.dart';

class ZHeader extends StatelessWidget {
  ZHeader({
    @required this.value,
    this.fontSize = 36.0,
    this.textAlign = TextAlign.start,
  });
  final String value;
  final double fontSize;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: textAlign,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
