import 'package:flutter/material.dart';
import 'package:ziin/common/colors.dart';

class ZAlertDialogCore extends StatelessWidget {
  ZAlertDialogCore({@required this.content, @required this.title});
  final List<Widget> content;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ZColors.yellowLight,
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          width: 2.0,
          color: Colors.black,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: content,
      ),
    );
  }
}
