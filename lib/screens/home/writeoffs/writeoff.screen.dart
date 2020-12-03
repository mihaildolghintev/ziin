import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ziin/common/colors.dart';
import 'package:ziin/common/date_string.dart';
import 'package:ziin/common/invoice.dart';
import 'package:ziin/logic/auth.dart';
import 'package:ziin/logic/writeoff_products.dart';
import 'package:ziin/logic/writeoffs.dart';
import 'package:ziin/models/write_off.model.dart';
import 'package:ziin/screens/home/products/products.page.dart';
import 'package:ziin/screens/home/writeoffs/writeoff_item_quantity.dart';
import 'package:ziin/screens/home/writeoffs/writeoff_list_item_tile.dart';
import 'package:ziin/ui/z_alert_dialog/z_alert_dialog.dart';
import 'package:ziin/ui/z_alert_dialog/z_confirm_dialog.dart';
import 'package:ziin/ui/z_button/z_button.dart';

class WriteOffScreen extends StatefulWidget {
  WriteOffScreen({this.writeOff});
  final WriteOff writeOff;
  @override
  _WriteOffScreenState createState() => _WriteOffScreenState();
}

class _WriteOffScreenState extends State<WriteOffScreen> {
  DateTime _datetime = DateTime.now();

  final _writeOffsProvider = Provider((ref) => WriteOffsProvider());
  final _authProvider = Provider((ref) => Auth());
  final _writeOffProductItemsProvider = writeoffProductItemsProvider;

  @override
  void initState() {
    final writeoffProductItemsProvider =
        context.read(_writeOffProductItemsProvider);
    super.initState();
    if (widget.writeOff != null) {
      _datetime =
          widget.writeOff != null ? widget.writeOff.createdAt : DateTime.now();
      writeoffProductItemsProvider.setProducts(widget.writeOff.items);
    }
  }

  void _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _datetime,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null && pickedDate != _datetime) {
      setState(() {
        _datetime = pickedDate;
      });
    }
  }

  void _submit(WriteOff writeOff) async {
    final writeoffsProvider = context.read(_writeOffsProvider);
    try {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => ZConfirmDialog(
          onOK: () async {
            if (widget.writeOff != null) {
              await writeoffsProvider.updateWriteOff(writeOff);
            } else {
              await writeoffsProvider.createWriteOff(writeOff);
            }
            Navigator.of(context).pop();
          },
          title: 'Подверждение',
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      rethrow;
    }
  }

  void _createPdf(WriteOff writeOff) async {
    final writeoffsProvider = context.read(_writeOffsProvider);
    try {
      if (widget.writeOff != null) {
        await writeoffsProvider.updateWriteOff(writeOff);
      } else {
        await writeoffsProvider.createWriteOff(writeOff);
      }
      createPdf(writeOff);
    } on FirebaseException catch (e) {
      showDialog(
          context: context,
          builder: (_) => ZErrorDialog(
                error: e,
              ));
    }
  }

  void _onArrowBack() async {
    final products = context.read(_writeOffProductItemsProvider.state);
    if (products.isNotEmpty) {
      await showDialog(
          context: context,
          builder: (_) => ZConfirmDialog(
                onOK: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                content: 'Документ не будет сохранен',
                title: 'Подвертдите действие',
              ));
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final auth = watch(_authProvider);
        final productItemsProvider = watch(_writeOffProductItemsProvider);
        final products = watch(_writeOffProductItemsProvider.state);
        return Scaffold(
            backgroundColor: ZColors.yellow,
            appBar: AppBar(
              leading: IconButton(
                onPressed: _onArrowBack,
                icon: Icon(Icons.arrow_back_rounded),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: ZColors.yellow,
              elevation: 0.0,
              title: Center(
                child: Text(
                  widget.writeOff != null
                      ? createDateString(widget.writeOff.createdAt)
                      : 'Новый расход',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: widget.writeOff != null
                      ? () => _createPdf(widget.writeOff)
                      : () {},
                  icon: Icon(Icons.cloud_download_outlined),
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: ZButton(
                          onPressed: () => _selectDate(context),
                          value: createDateString(_datetime),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      ZButton(
                        onPressed: () => Navigator.of(context).pushNamed(
                            '/select-product-item',
                            arguments: ProductsPageProps(
                              onAddProductItem:
                                  productItemsProvider.addItemToProductList,
                              onUpdateProductItem:
                                  productItemsProvider.updateItemInProductList,
                              onRemoveProductItem: productItemsProvider
                                  .removeItemFromProductList,
                            )),
                        value: '+',
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          'Колличество продуктов: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          products.length.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.0),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (_) => productItemsProvider
                              .removeItemFromProductList(products[index]),
                          child: WriteOffListItemTile(
                            writeoffItem: products[index],
                            onTap: () => Navigator.of(context).pushNamed(
                              '/edit-quantity-item',
                              arguments: SelectWriteOffItemQuantityProps(
                                item: products[index],
                                edit: true,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ZButton(
                    onPressed: () => _submit(WriteOff(
                      id: widget.writeOff != null ? widget.writeOff.id : null,
                      createdAt: _datetime,
                      creator: auth.currentUserDisplayName,
                      items: products,
                    )),
                    value: widget.writeOff != null ? 'Обновить' : 'Создать',
                  )
                ],
              ),
            ));
      },
    );
  }
}
