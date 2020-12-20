import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ziin/common/colors.dart';
import 'package:ziin/logic/auth.dart';
import 'package:ziin/ui/z_alert_dialog/z_confirm_dialog.dart';

class ZDrawer extends StatelessWidget {
  final _authProvider = Provider((ref) => Auth());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4 * 3,
      decoration: BoxDecoration(
        color: ZColors.yellowLight,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          DrawerHeader(
            child: Text(
              'Купи ФиФи',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _createButton(context, to: '/writeoffs', title: 'Списания'),
          Expanded(
            child: TextButton(
              onPressed: () => _signOut(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Icon(
                    Icons.logout,
                    size: 32,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  TextButton _createButton(BuildContext context,
          {String to = '/', String title}) =>
      TextButton(
        onPressed: () => Navigator.of(context).pushReplacementNamed(to),
        child: Text(
          title,
          style: TextStyle(
            color: isActive(context, to) ? ZColors.red : Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      );

  void _signOut(BuildContext context) async {
    final auth = context.read(_authProvider);
    showDialog(
      context: context,
      builder: (_) => ZConfirmDialog(
        onOK: () async {
          await auth.logOut();
          Navigator.of(context).pop();
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/signin', (_) => false);
        },
        title: 'Выход',
      ),
    );
  }

  bool isActive(BuildContext context, String to) {
    return ModalRoute.of(context).settings.name == to;
  }
}
