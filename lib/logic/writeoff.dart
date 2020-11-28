import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ziin/models/product_item.model.dart';
import 'package:ziin/models/write_off.model.dart';
import 'package:ziin/models/writeoff_item.model.dart';

class WriteOffProvider extends ChangeNotifier {
  final CollectionReference writeoffs =
      FirebaseFirestore.instance.collection('writeoffs');

  Future<void> createWriteOff(WriteOff writeoff) async {
    try {
      final doc = await writeoffs.add(writeoff.toJson());
      await doc.update({'id': doc.id});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateWriteOff(WriteOff writeoff) async {
    try {
      final doc = writeoffs.doc(writeoff.id);
      await doc.update(writeoff.toJson());
    } catch (e) {
      rethrow;
    }
  }

  List<WriteOffItem> items = [];

  void addItemToProductList(WriteOffItem item) {
    items.add(item);
    notifyListeners();
  }

  void updateItemInProductList(WriteOffItem item) {
    final index = items.indexWhere(
      (itemInList) => item.product.id == itemInList.product.id,
    );

    items = [...items.sublist(0, index), item, ...items.sublist(index + 1)];
    notifyListeners();
  }

  void removeItemFromProductList(ProductItem item) {
    items =
        items.where((itemInList) => item.id != itemInList.product.id).toList();
    notifyListeners();
  }
}
