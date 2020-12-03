import 'package:flutter/material.dart';
import 'package:ziin/ui/z_alert_dialog/z_alert_dialog_core.dart';

class ZInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZAlertDialogCore(
      title: '',
      content: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        )
      ],
    );
  }
}
