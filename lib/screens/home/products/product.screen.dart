import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziin/common/colors.dart';
import 'package:ziin/logic/product.dart';
import 'package:ziin/models/product_item.model.dart';
import 'package:ziin/ui/z_alert_dialog/z_alert_dialog.dart';
import 'package:ziin/ui/z_alert_dialog/z_confirm_dialog.dart';
import 'package:ziin/ui/z_button/z_button.dart';
import 'package:ziin/ui/z_textfield/z_textfield.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({this.productItem});
  final ProductItem productItem;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController _titleController;
  TextEditingController _barcodeController;
  TextEditingController _pluController;
  TextEditingController _cashController;
  TextEditingController _weightController;
  bool _isWeight;

  @override
  void initState() {
    _titleController = TextEditingController(
        text: widget.productItem != null ? widget.productItem.title : '');
    _barcodeController = TextEditingController(
        text: widget.productItem != null ? widget.productItem.barcode : '');
    _pluController = TextEditingController(
        text: widget.productItem != null
            ? widget.productItem.plu.toString()
            : 0.toString());
    _cashController = TextEditingController(
        text: widget.productItem != null
            ? widget.productItem.cash.toString()
            : 0.toString());
    _weightController = TextEditingController(
        text: widget.productItem != null
            ? widget.productItem.weight.toString()
            : 0.toString());
    _isWeight =
        widget.productItem != null ? widget.productItem.isWeight : false;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _barcodeController.dispose();
    _pluController.dispose();
    _cashController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) async {
    final productToCreate = ProductItem(
      id: widget?.productItem?.id,
      title: _titleController.text,
      barcode: _barcodeController.text,
      plu: int.tryParse(_pluController.text),
      cash: int.tryParse(_cashController.text),
      weight: double.tryParse(_weightController.text),
      isWeight: _isWeight,
    );
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => ZConfirmDialog(
              onOK: widget.productItem != null
                  ? () => _update(productToCreate)
                  : () => _create(productToCreate),
              title: 'Подверждение',
            ));
  }

  void _update(ProductItem productToSend) async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    try {
      await productProvider.updateProduct(productToSend);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (_) => ZErrorDialog(
          error: e,
        ),
      );
    }
  }

  void _create(ProductItem productToSend) async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    try {
      await productProvider.createProduct(productToSend);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (_) => ZErrorDialog(
          error: e,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZColors.yellow,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: ZColors.yellow,
        elevation: 0.0,
        title: Center(
          child: Text(
            widget?.productItem?.title?.toUpperCase() ?? 'Создание товара',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _createFormRow(
              controller: _titleController,
              title: 'Имя',
              hintText: 'Product title',
            ),
            SizedBox(height: 12.0),
            _createFormRow(
              controller: _barcodeController,
              title: '#',
              hintText: 'Barcode',
            ),
            SizedBox(height: 12.0),
            _createFormRow(
              controller: _pluController,
              title: 'PLU',
              hintText: 'PLU',
            ),
            SizedBox(height: 12.0),
            _createFormRow(
              controller: _cashController,
              title: 'CASH',
              hintText: 'CASH',
            ),
            SizedBox(height: 12.0),
            _createFormRow(
              controller: _weightController,
              title: 'Вес',
              hintText: 'Weight',
            ),
            SizedBox(height: 12.0),
            CheckboxListTile(
              checkColor: ZColors.yellow,
              activeColor: ZColors.black,
              title: Text(
                'Весовой?',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              value: _isWeight,
              onChanged: (value) {
                setState(() {
                  _isWeight = value;
                });
              },
            ),
            SizedBox(height: 48.0),
            ZButton(
              onPressed: () => _submit(context),
              value: widget.productItem != null ? 'Обновить' : 'Создать',
              isDark: true,
            )
          ],
        ),
      ),
    );
  }

  Row _createFormRow({
    TextEditingController controller,
    String title,
    String hintText,
    TextInputType keyboardType,
  }) {
    return Row(
      children: [
        Text(
          title + ':',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        Flexible(
          child: ZTextField(
            controller: controller,
            hintText: hintText,
            withShadows: true,
            keyboardType: keyboardType,
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }
}