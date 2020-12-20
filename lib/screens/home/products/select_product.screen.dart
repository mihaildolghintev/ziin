import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ziin/logic/products.dart';
import 'package:ziin/models/product_item.model.dart';
import 'package:ziin/models/writeoff_item.model.dart';
import 'package:ziin/screens/home/products/product.tile.dart';
import 'package:ziin/screens/home/writeoffs/writeoff_item_quantity.dart';
import 'package:ziin/ui/z_button/z_button.dart';
import 'package:ziin/ui/z_textfield/z_textfield.dart';

class SelectProductScreen extends StatefulWidget {
  @override
  _SelectProductScreenState createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  final _barcodeController = TextEditingController(text: '');
  final _pluController = TextEditingController();
  final _cashController = TextEditingController();

  final _productsProvider = Provider((ref) => ProductsProvider());
  ProductItem currentProduct;

  void _scan() async {
    final productsProvider = context.read(_productsProvider);
    final String barcode = await FlutterBarcodeScanner.scanBarcode(
      '#ffffff',
      'Отмена',
      false,
      ScanMode.BARCODE,
    );
    if (barcode != '-1') {
      _barcodeController.text = barcode;
      _barcodeController.selection = TextSelection.fromPosition(
        TextPosition(offset: _barcodeController.text.length),
      );
    } else {
      _barcodeController.text = '';
    }
    final f =
        await productsProvider.getProductByBarcode(_barcodeController.text);
    setState(() {
      currentProduct = f;
    });
  }

  Future<ProductItem> _searchByBarcode() async {
    final productsProvider = context.read(_productsProvider);
    return await productsProvider.getProductByBarcode(_barcodeController.text);
  }

  Future<ProductItem> _searchByPlu() async {
    final productsProvider = context.read(_productsProvider);
    return await productsProvider.getProductByPlu(_pluController.text);
  }

  Future<ProductItem> _searchByCash() async {
    final productsProvider = context.read(_productsProvider);
    return await productsProvider.getProductByCash(_cashController.text);
  }

  void _search() async {
    ProductItem curProduct;
    try {
      if (_barcodeController.text.isNotEmpty) {
        curProduct = await _searchByBarcode();
      } else if (_pluController.text.isNotEmpty) {
        curProduct = await _searchByPlu();
      } else if (_cashController.text.isNotEmpty) {
        curProduct = await _searchByCash();
      }

      setState(() {
        currentProduct = curProduct;
      });
    } catch (e) {
      print("Errrr " + e.toString());
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(16.0),
                  side: BorderSide(color: Colors.black, width: 2.0),
                ),
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ошибка',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Text(
                        'Продукт не найден',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Выбор продукта',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: Hero(
        tag: 'button',
        child: SizedBox(
          height: 80,
          width: 80,
          child: ZButton(
            onPressed: _scan,
            value: '',
            icon: Icons.qr_code_scanner,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ZTextField(
              controller: _barcodeController,
              suffixIcon: Icons.qr_code_sharp,
              hintText: 'Штрихкод',
              withShadows: true,
            ),
            SizedBox(height: 24.0),
            Row(
              children: [
                Text('PLU: '),
                Flexible(
                  child: ZTextField(
                    controller: _pluController,
                    keyboardType: TextInputType.number,
                    suffixIcon: Icons.shopping_bag_outlined,
                    withShadows: true,
                  ),
                )
              ],
            ),
            SizedBox(height: 24.0),
            Row(
              children: [
                Text('CASH: '),
                Flexible(
                  child: ZTextField(
                    controller: _cashController,
                    keyboardType: TextInputType.number,
                    suffixIcon: Icons.format_list_numbered_outlined,
                    withShadows: true,
                  ),
                )
              ],
            ),
            SizedBox(height: 24.0),
            ZButton(
              onPressed: _search,
              value: 'Поиск',
            ),
            SizedBox(
              height: 24,
            ),
            if (currentProduct != null)
              ProductTile(
                product: currentProduct,
                onTap: () => Navigator.pushNamed(
                  context,
                  "/select-quantity-item",
                  arguments: SelectWriteOffItemQuantityProps(
                    edit: false,
                    item: WriteOffItem(
                      product: currentProduct,
                      quanity: 1,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
