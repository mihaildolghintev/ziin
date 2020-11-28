import 'package:flutter/foundation.dart';
import 'package:ziin/models/product_item.model.dart';

class WriteOffItem {
  WriteOffItem({@required this.product, @required this.quanity});
  final ProductItem product;
  final double quanity;
}
