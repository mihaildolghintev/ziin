import 'package:flutter/material.dart';
import 'package:ziin/screens/home/products/products.page.dart';

class SelectWriteOffItemScreen extends StatelessWidget {
  SelectWriteOffItemScreen({this.props});
  final ProductsPageProps props;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Text(
            'Выбор продукта',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ProductsPage(
        props: ProductsPageProps(
          selectable: true,
          onAddProductItem: props.onAddProductItem,
          onUpdateProductItem: props.onUpdateProductItem,
          onRemoveProductItem: props.onRemoveProductItem,
        ),
      ),
    );
  }
}
