import 'package:flutter/material.dart';
import 'package:ziin/ui/z_button/z_button.dart';
import 'package:ziin/ui/z_textfield/z_textfield.dart';

class ZAddSubNumber extends StatefulWidget {
  ZAddSubNumber({this.controller});
  final TextEditingController controller;
  @override
  _ZAddSubNumberState createState() => _ZAddSubNumberState();
}

class _ZAddSubNumberState extends State<ZAddSubNumber> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = '0';
  }

  void _onAdd() {
    int num = int.tryParse(widget.controller.text);
    widget.controller.text = (num + 1).toString();
  }

  void _onSub() {
    int num = int.tryParse(widget.controller.text);
    if (num == 0) {
      return;
    }
    widget.controller.text = (num - 1).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64.0,
          child: ZButton(
            onPressed: _onSub,
            value: '-',
          ),
        ),
        Container(
          width: 64.0,
          child: ZTextField(
            controller: widget.controller,
            keyboardType: TextInputType.number,
          ),
        ),
        Container(
          width: 64.0,
          child: ZButton(
            onPressed: _onAdd,
            value: '+',
          ),
        )
      ],
    );
  }
}
