import 'package:flutter/material.dart';
import 'package:ziin/models/product_item.model.dart';
import 'package:ziin/models/writeoff_item.model.dart';
import 'package:ziin/ui/z_button/z_button.dart';
import 'package:ziin/ui/z_textfield/z_textfield.dart';

class SelectWriteOffItemQuantityProps {
  SelectWriteOffItemQuantityProps({
    this.item,
    this.edit = false,
    this.onAddProductItem,
    this.onUpdateProductItem,
    this.onRemoveProductItem,
  });
  final WriteOffItem item;
  final bool edit;
  void Function(WriteOffItem) onAddProductItem;
  void Function(WriteOffItem) onUpdateProductItem;
  void Function(WriteOffItem) onRemoveProductItem;
}

class SelectWriteOffItemQuantity extends StatefulWidget {
  SelectWriteOffItemQuantity({@required this.props});
  final SelectWriteOffItemQuantityProps props;
  @override
  _SelectWriteOffItemQuantityState createState() =>
      _SelectWriteOffItemQuantityState();
}

class _SelectWriteOffItemQuantityState
    extends State<SelectWriteOffItemQuantity> {
  TextEditingController _quanitityController;

  @override
  void initState() {
    _quanitityController = TextEditingController(
        text: widget.props.edit ? widget.props.item.quanity.toString() : '1');

    if (widget.props.item.product.isWeight && widget.props.item == null) {
      _quanitityController.text = '0';
    }
    super.initState();
  }

  @override
  void dispose() {
    _quanitityController.dispose();
    super.dispose();
  }

  void _add() {
    double num = double.tryParse(_quanitityController.text);
    if (num == null || num < 1) {
      _quanitityController.text = (1).toString();
    } else {
      _quanitityController.text = (num + 1).toString();
    }
  }

  void _sub() {
    double num = double.tryParse(_quanitityController.text);
    if (num == null || num <= 0) {
      _quanitityController.text = (0).toString();
    } else {
      _quanitityController.text = (num - 1).toString();
    }
  }

  void _submit() {
    final quantity = double.tryParse(_quanitityController.text);
    if (widget.props.edit) {
      widget.props.onUpdateProductItem(
        WriteOffItem(
          product: widget.props.item.product,
          quanity: quantity,
        ),
      );
    } else {
      widget.props.onAddProductItem(
        WriteOffItem(
          product: widget.props.item.product,
          quanity: quantity,
        ),
      );
    }
    Navigator.of(context).pop();
  }

  bool get isWeight => widget.props.item.product.isWeight;
  ProductItem get product => widget.props.item.product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Center(
          child: Text('Колличество'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              product.title,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isWeight ? 'Вес (КГ)' : 'Колличество',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ZButton(onPressed: _sub, value: '-'),
                      Container(
                        width: 128.0,
                        child: ZTextField(
                          controller: _quanitityController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      ZButton(onPressed: _add, value: '+'),
                    ],
                  ),
                ],
              ),
            ),
            ZButton(
                onPressed: _submit,
                value: widget.props.edit ? 'Обновить' : 'Добавить'),
          ],
        ),
      ),
    );
  }
}
