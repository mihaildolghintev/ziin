import 'package:flutter/foundation.dart';
import 'package:ziin/models/product_item.model.dart';

class WriteOffItem {
  WriteOffItem({@required this.product, @required this.quanity});
  final ProductItem product;
  final double quanity;

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quanity,
    };
  }

  factory WriteOffItem.fromJson(Map<String, dynamic> json) {
    return WriteOffItem(
      product: ProductItem.fromJson(json['product']),
      quanity: json['quantity'],
    );
  }
}
