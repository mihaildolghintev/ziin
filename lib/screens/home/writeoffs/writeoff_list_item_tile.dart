import 'package:flutter/material.dart';
import 'package:ziin/models/writeoff_item.model.dart';

class WriteOffListItemTile extends StatefulWidget {
  WriteOffListItemTile({
    @required this.writeoffItem,
    this.onTap,
    this.onLongTap,
  });
  final WriteOffItem writeoffItem;
  final VoidCallback onLongTap;
  final VoidCallback onTap;

  @override
  _WriteOffListItemTileState createState() => _WriteOffListItemTileState();
}

class _WriteOffListItemTileState extends State<WriteOffListItemTile> {
  String _createQuantityString(WriteOffItem productItem) {
    if (productItem.product.isWeight) {
      return "${productItem.quanity} кг";
    }
    return "${productItem.quanity.toStringAsFixed(0)} шт";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        onLongPress: widget.onLongTap,
        onTap: widget.onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Text(
          widget.writeoffItem.product.title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        trailing: Text(
          _createQuantityString(widget.writeoffItem),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
