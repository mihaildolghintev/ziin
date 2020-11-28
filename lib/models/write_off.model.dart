import 'package:ziin/models/writeoff_item.model.dart';

class WriteOff {
  WriteOff({
    this.id,
    this.createdAt,
    this.items,
    this.creator,
  });
  final String id;
  final DateTime createdAt;
  final List<WriteOffItem> items;
  final String creator;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'items': items.map((item) => item.toJson()).toList(),
      'creator': creator,
    };
  }

  factory WriteOff.fromJson(Map<String, dynamic> json) {
    return WriteOff(
      id: json['id'],
      createdAt: json['createdAt'].toDate(),
      items: ((json['items']) as List)
          .map((item) => WriteOffItem.fromJson(item))
          .toList(),
      creator: json['creator'],
    );
  }
}
