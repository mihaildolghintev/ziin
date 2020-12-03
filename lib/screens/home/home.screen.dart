import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ziin/common/colors.dart';
import 'package:ziin/logic/auth.dart';
import 'package:ziin/screens/home/products/products.page.dart';
import 'package:ziin/screens/home/writeoffs/writeoffs.page.dart';
import 'package:ziin/ui/z_alert_dialog/z_confirm_dialog.dart';
import 'package:ziin/ui/z_button/z_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final _authProvider = Provider((ref) => Auth());

  List<Widget> _pages = [
    WriteOffsPage(),
    ProductsPage(
      props: ProductsPageProps(
        selectable: false,
      ),
    ),
  ];

  void _signOut(BuildContext context) async {
    final auth = context.read(_authProvider);
    showDialog(
      context: context,
      builder: (_) => ZConfirmDialog(
        onOK: auth.logOut,
        title: 'Выход',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Center(
          child: Text(
            'MAGAZIN',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Consumer(
            builder: (context, watch, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ZButton(
                  onPressed: () => _signOut(context),
                  value: '',
                  icon: Icons.logout,
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        key: _bottomNavigationKey,
        index: _page,
        color: ZColors.yellow,
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(Icons.receipt_long_rounded, size: 30),
          Icon(Icons.menu_book_rounded, size: 30),
        ],
        onTap: _setPage,
      ),
      body: _pages[_page],
    );
  }

  void _setPage(int index) {
    setState(() {
      _page = index;
    });
  }
}
