import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ziin/common/colors.dart';
import 'package:ziin/screens/home/products/add_barcode.screen.dart';
import 'package:ziin/screens/home/products/product.screen.dart';
import 'package:ziin/screens/home/home.screen.dart';
import 'package:ziin/screens/home/writeoffs/select_writeoff_item.dart';
import 'package:ziin/screens/home/writeoffs/writeoff_item_quantity.dart';
import 'package:ziin/screens/home/writeoffs/writeoff.screen.dart';
import 'package:ziin/screens/reductor.screen.dart';
import 'package:ziin/screens/sign_in/sign_in.screen.dart';
import 'package:ziin/screens/sign_up/sign_up.screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.setLanguageCode('ru');
  Intl.defaultLocale = 'ru_RU';
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: ZColors.red,
        ),
        cursorColor: Colors.black,
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        dialogBackgroundColor: ZColors.yellow,
        highlightColor: ZColors.yellowLight,
        fontFamily: 'Montserrat',
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru', ''),
      ],
      routes: {
        '/': (context) => ReductorScreen(),
        '/home': (context) => HomeScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/product': (context) => ProductScreen(
              productItem: ModalRoute.of(context).settings.arguments,
            ),
        '/add-barcode': (context) => AddBarcodeScreen(
              props: ModalRoute.of(context).settings.arguments,
            ),
        '/writeoff': (context) => WriteOffScreen(
              writeOff: ModalRoute.of(context).settings.arguments,
            ),
        '/select-product-item': (context) => SelectWriteOffItemScreen(
              props: ModalRoute.of(context).settings.arguments,
            ),
        '/select-quantity-item': (context) => SelectWriteOffItemQuantity(
              props: ModalRoute.of(context).settings.arguments,
            ),
        '/edit-quantity-item': (context) => SelectWriteOffItemQuantity(
              props: ModalRoute.of(context).settings.arguments,
            ),
      },
      title: 'ziIn',
    );
  }
}
