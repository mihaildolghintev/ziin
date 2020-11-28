import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziin/models/product_item.model.dart';

class ProductProvider {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<void> createProduct(ProductItem product) async {
    try {
      final doc = await products.add(product.toJson());
      await doc.update({'id': doc.id});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(ProductItem product) async {
    try {
      final doc = products.doc(product.id);
      await doc.update(product.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
