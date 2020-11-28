import 'package:flutter/material.dart';
import 'package:ziin/common/colors.dart';
import 'package:ziin/models/product_item.model.dart';

class ProductTile extends StatelessWidget {
  ProductTile({@required this.product, this.onTap});
  final ProductItem product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        onTap: onTap,
        title: Text(product.title),
        leading: _createTileImage(product.title),
        subtitle: Row(
          children: [
            Text(
              'PLU:' + product.plu.toString(),
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 4.0,
            ),
            Text(
              'CASH:' + product.cash.toString(),
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        trailing: Text(
          product.weight.toString() + 'гр',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _createTileImage(String title) {
    return Container(
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        color: ZColors.yellow,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Center(
        child: Text(
          title[0],
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
