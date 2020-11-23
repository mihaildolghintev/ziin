import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziin/logic/auth.dart';
import 'package:ziin/screens/reductor.screen.dart';
import 'package:ziin/screens/sign_in/sign_in.screen.dart';
import 'package:ziin/screens/sign_up/sign_up.screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.setLanguageCode('ru');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(value: Auth().userStream),
        Provider<Auth>(create: (_) => Auth()),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => ReductorScreen(),
          '/signin': (context) => SignInScreen(),
          '/signup': (context) => SignUpScreen(),
        },
        title: 'ziIn',
      ),
    );
  }
}
