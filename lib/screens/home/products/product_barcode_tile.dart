import 'package:flutter/material.dart';

class ProductBarCodeTile extends StatelessWidget {
  ProductBarCodeTile({this.onTap, @required this.barcode});
  final VoidCallback onTap;
  final String barcode;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      elevation: 0.0,
      child: ListTile(
        onTap: onTap,
        title: Text(
          barcode,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
