import 'package:flutter/material.dart';
import 'package:ziin/ui/z_alert_dialog/z_alert_dialog_core.dart';
import 'package:ziin/ui/z_button/z_button.dart';

class ZConfirmDialog extends StatelessWidget {
  ZConfirmDialog({this.title, this.onOK});
  final String title;
  final VoidCallback onOK;
  @override
  Widget build(BuildContext context) {
    return ZAlertDialogCore(
      title: title,
      content: [
        Column(
          children: [
            Text('Подтвердите действие'),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ZButton(
                  onPressed: onOK,
                  value: 'OK',
                ),
                ZButton(
                  onPressed: () => Navigator.of(context).pop(),
                  value: 'Отмена',
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
