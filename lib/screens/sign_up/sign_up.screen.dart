import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziin/common/colors.dart';
import 'package:ziin/logic/auth.dart';
import 'package:ziin/ui/z_alert_dialog/z_alert_dialog.dart';
import 'package:ziin/ui/z_alert_dialog/z_info_dialog.dart';
import 'package:ziin/ui/z_button/z_button.dart';
import 'package:ziin/ui/z_header/z_header.dart';
import 'package:ziin/ui/z_textfield/z_textfield.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dispalyNameController = TextEditingController();

  get _email => _emailController.text;
  get _password => _passwordController.text;
  get _displayName => _dispalyNameController.text;

  Future<void> _submit(BuildContext context) async {
    final auth = Provider.of<Auth>(context, listen: false);
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => ZInfoDialog(),
      );
      await auth.createUser(
          email: _email, password: _password, displayName: _displayName);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (_) => ZErrorDialog(
                error: e,
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ZColors.yellow,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 200.0,
                  child: Image.asset(
                    'images/signup.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ZHeader(
                          value: 'Регистрация',
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        ZTextField(
                          controller: _dispalyNameController,
                          icon: Icons.hearing,
                          hintText: 'Имя',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        ZTextField(
                          controller: _emailController,
                          icon: Icons.email,
                          hintText: 'test@example.com',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        ZTextField(
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          hintText: 'password',
                          obscure: true,
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        ZButton(
                          onPressed: () => _submit(
                            context,
                          ),
                          value: 'Создать',
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        ZButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/signin'),
                          value: 'Авторизация',
                          isDark: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
