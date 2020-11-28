import 'package:flutter/material.dart';
import 'package:ziin/common/colors.dart';
import 'package:ziin/common/date_string.dart';
import 'package:ziin/models/write_off.model.dart';
import 'package:ziin/ui/z_button/z_button.dart';

class WriteOffScreen extends StatefulWidget {
  WriteOffScreen({this.writeOff});
  final WriteOff writeOff;
  @override
  _WriteOffScreenState createState() => _WriteOffScreenState();
}

class _WriteOffScreenState extends State<WriteOffScreen> {
  DateTime _datetime = DateTime.now();
  @override
  void initState() {
    super.initState();
    if (widget.writeOff != null) {
      _datetime = widget.writeOff.createdAt;
    }
  }

  _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _datetime,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null && pickedDate != _datetime) {
      setState(() {
        _datetime = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZColors.yellow,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: ZColors.yellow,
        elevation: 0.0,
        title: Center(
          child: Text(widget.writeOff != null
              ? createDateString(widget.writeOff.createdAt)
              : 'Новый расход'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: ZButton(
                    onPressed: () => _selectDate(context),
                    value: createDateString(_datetime),
                  ),
                ),
                ZButton(
                  onPressed: () {},
                  value: '+',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
