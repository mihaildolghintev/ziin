import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziin/models/product_item.model.dart';

class ProductsProvider {
  Stream<List<ProductItem>> get productsStream => FirebaseFirestore.instance
      .collection('products')
      .snapshots()
      .map((list) =>
          list.docs.map((doc) => ProductItem.fromJson(doc.data())).toList())
      .asBroadcastStream();

  List<ProductItem> filteredProducts(
      List<ProductItem> products, String filterValue) {
    final lcValue = filterValue.toLowerCase();
    return products
        .where((ProductItem good) =>
            good.title.toLowerCase().contains(lcValue) ||
            good.barcodes
                .any((barcode) => barcode.toLowerCase().contains(lcValue)) ||
            good.plu.toString().toLowerCase().contains(lcValue) ||
            good.cash.toString().toLowerCase().contains(lcValue))
        .toList();
  }
}
