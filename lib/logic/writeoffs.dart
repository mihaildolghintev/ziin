import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziin/logic/auth.dart';
import 'package:ziin/models/product_item.model.dart';
import 'package:ziin/models/write_off.model.dart';
import 'package:ziin/models/writeoff_item.model.dart';

class WriteOffsProvider {
  Stream<List<WriteOff>> get writeoffs => FirebaseFirestore.instance
      .collection('writeoffs')
      .snapshots()
      .map((list) =>
          list.docs.map((doc) => WriteOff.fromJson(doc.data())).toList());

  List<WriteOff> testList = [
    WriteOff(
        createdAt: DateTime.now(),
        id: '1',
        creator: Auth().currentUserDisplayName,
        items: [
          WriteOffItem(
              product: ProductItem(
                id: '1',
                title: 'Soup',
                barcode: '3232392039',
                weight: 300,
              ),
              quanity: 4),
          WriteOffItem(
              product: ProductItem(
                id: '2',
                title: 'Rise',
                barcode: '3232392039',
                weight: 500,
              ),
              quanity: 1),
        ])
  ];
}
