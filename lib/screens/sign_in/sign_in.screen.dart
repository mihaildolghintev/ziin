import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ziin/common/colors.dart';
import 'package:ziin/logic/auth.dart';
import 'package:ziin/ui/z_alert_dialog/z_alert_dialog.dart';
import 'package:ziin/ui/z_alert_dialog/z_info_dialog.dart';
import 'package:ziin/ui/z_button/z_button.dart';
import 'package:ziin/ui/z_header/z_header.dart';
import 'package:ziin/ui/z_textfield/z_textfield.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  get _email => _emailController.text;
  get _password => _passwordController.text;

  final _authProvider = Provider((ref) => Auth());

  Future<void> _submit(BuildContext context,
      {String email, String password}) async {
    final auth = context.read(_authProvider);
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => ZInfoDialog(),
      );
      await auth.signIn(email, password);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/writeoffs');
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
      body: Consumer(builder: (context, watch, child) {
        return Container(
          color: ZColors.yellow,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 16.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('images/signin.png'),
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
                            value: 'Авторизация',
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
                              email: _email,
                              password: _password,
                            ),
                            value: 'Войти',
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          ZButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacementNamed('/signup'),
                            value: 'Регистрация',
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
        );
      }),
    );
  }
}
