import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ziin/logic/auth.dart';
import 'package:ziin/screens/home/writeoffs/writeoffs.page.dart';
import 'package:ziin/screens/sign_in/sign_in.screen.dart';

final authProvider =
    StreamProvider.autoDispose<User>((ref) => Auth().userStream);

class ReductorScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(authProvider.stream);
    return StreamBuilder(
      stream: user,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.data != null ? WriteOffsPage() : SignInScreen();
      },
    );
  }
}
