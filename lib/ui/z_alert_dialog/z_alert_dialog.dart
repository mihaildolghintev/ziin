import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ziin/common/errors.dart';
import 'package:ziin/ui/z_alert_dialog/z_alert_dialog_core.dart';
import 'package:ziin/ui/z_button/z_button.dart';

class ZErrorDialog extends StatelessWidget {
  ZErrorDialog({@required this.error});
  final FirebaseException error;
  @override
  Widget build(BuildContext context) {
    return ZAlertDialogCore(
      title: 'ОШИБКА',
      content: [
        Column(
          children: [
            Text(showError(error)),
            SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: ZButton(
                    onPressed: () => Navigator.of(context).pop(),
                    value: 'OK',
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
