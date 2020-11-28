import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziin/logic/writeoffProductItems.cubit.dart';
import 'package:ziin/models/product_item.model.dart';
import 'package:ziin/models/writeoff_item.model.dart';
import 'package:ziin/ui/z_button/z_button.dart';
import 'package:ziin/ui/z_textfield/z_textfield.dart';

class SelectWriteOffItemQuantity extends StatefulWidget {
  SelectWriteOffItemQuantity({@required this.item, this.edit = false});
  final WriteOffItem item;
  final bool edit;
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
        text: widget.edit ? widget.item.quanity.toString() : '1');
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
    final writeoffProvider =
        BlocProvider.of<WriteOffProductItemsCubit>(context);
    final quantity = double.tryParse(_quanitityController.text);
    if (widget.edit) {
      writeoffProvider.updateItemInProductList(
        WriteOffItem(
          product: widget.item.product,
          quanity: quantity,
        ),
      );
    } else {
      writeoffProvider.addItemToProductList(
        WriteOffItem(
          product: widget.item.product,
          quanity: quantity,
        ),
      );
    }
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/writeoff', ModalRoute.withName('/'));
  }

  bool get isWeight => widget.item.product.isWeight;
  ProductItem get product => widget.item.product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text('Колличество'),
        ),
      ),
      body: BlocProvider(
        create: (context) => WriteOffProductItemsCubit(),
        child: Padding(
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
              Text(
                product.barcode,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isWeight ? 'Вес' : 'Колличество',
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
                  value: widget.edit ? 'Обновить' : 'Добавить'),
            ],
          ),
        ),
      ),
    );
  }
}
