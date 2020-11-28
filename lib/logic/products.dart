import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziin/models/product_item.model.dart';

class ProductsProvider {
  Stream<List<ProductItem>> get _products => FirebaseFirestore.instance
      .collection('products')
      .snapshots()
      .map((list) =>
          list.docs.map((doc) => ProductItem.fromJson(doc.data())).toList());

  String filterValue = '';

  void setFilter(String value) => filterValue = value;

  Stream<List<ProductItem>> get filteredProducts {
    final lcValue = filterValue.toLowerCase();
    return _products.map((list) => list
        .where((ProductItem good) =>
            good.title.toLowerCase().contains(lcValue) ||
            good.barcodes
                .any((barcode) => barcode.toLowerCase().contains(lcValue)) ||
            good.plu.toString().toLowerCase().contains(lcValue) ||
            good.cash.toString().toLowerCase().contains(lcValue))
        .toList());
  }
}
