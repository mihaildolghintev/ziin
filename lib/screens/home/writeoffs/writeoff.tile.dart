import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ziin/models/write_off.model.dart';

class WriteOffTile extends StatelessWidget {
  WriteOffTile({@required this.writeOff, this.onTap});
  final WriteOff writeOff;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        onTap: onTap,
        title: _createDateString(writeOff.createdAt),
        leading: _createTileImage(writeOff),
        subtitle: Text(
          'Создатель: ' + writeOff.creator,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: Text(
          writeOff.items.length.toString(),
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _createDateString(DateTime date) {
    return Text(
      DateFormat.yMEd().format(date),
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _createTileImage(WriteOff writeOff) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            writeOff.createdAt.day.toString(),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            writeOff.createdAt.month.toString(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
