import 'package:flutter/material.dart';
import 'package:ziin/screens/home/products/products.page.dart';

class SelectWriteOffItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Text('Выбор продукта'),
        ),
      ),
      body: ProductsPage(
        selectable: true,
      ),
    );
  }
}
