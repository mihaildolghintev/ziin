import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziin/models/product_item.model.dart';

class ProductsProvider {
  Future<ProductItem> getProductByBarcode(String barcode) async {
    final querySnap = await FirebaseFirestore.instance
        .collection('products')
        .where('Barcodes', arrayContainsAny: [barcode]).get();

    return ProductItem.fromJson(querySnap.docs.first.data());
  }

  Future<ProductItem> getProductByPlu(String plu) async {
    final querySnap = await FirebaseFirestore.instance
        .collection('products')
        .where('Plu', isEqualTo: plu)
        .get();

    return ProductItem.fromJson(querySnap.docs.first.data());
  }

  Future<ProductItem> getProductByCash(String cash) async {
    final querySnap = await FirebaseFirestore.instance
        .collection('products')
        .where('Cash', isEqualTo: cash)
        .get();

    return ProductItem.fromJson(querySnap.docs.first.data());
  }
}
