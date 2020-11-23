import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziin/screens/sign_in/sign_in.screen.dart';

class ReductorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User currentUser = Provider.of<User>(context);
    return Scaffold(
      body: currentUser == null ? SignInScreen() : Container(),
    );
  }
}
