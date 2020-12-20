import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ziin/models/write_off.model.dart';

class WriteOffsProvider {
  Stream<List<WriteOff>> get writeoffs => FirebaseFirestore.instance
      .collection('writeoffs')
      .snapshots()
      .map((list) => list.docs.reversed
          .map((doc) => WriteOff.fromJson({...doc.data(), 'id': doc.id}))
          .toList());

  final _writeoffs = FirebaseFirestore.instance.collection('writeoffs');

  Future<void> createWriteOff(WriteOff writeoff) async {
    try {
      final data = writeoff.toJson();
      final doc = await _writeoffs.add(data);
      await doc.update({'id': doc.id});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeWriteOFf(WriteOff writeOff) async {
    try {
      await _writeoffs.doc(writeOff.id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateWriteOff(WriteOff writeoff) async {
    try {
      final doc = _writeoffs.doc(writeoff.id);
      await doc.update(writeoff.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
