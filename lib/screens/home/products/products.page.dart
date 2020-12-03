import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:ziin/common/colors.dart';
import 'package:ziin/logic/products.dart';
import 'package:ziin/models/product_item.model.dart';
import 'package:ziin/models/writeoff_item.model.dart';
import 'package:ziin/screens/home/products/product.tile.dart';
import 'package:ziin/screens/home/writeoffs/writeoff_item_quantity.dart';
import 'package:ziin/ui/z_button/z_button.dart';
import 'package:ziin/ui/z_drawer/z_drawer.dart';
import 'package:ziin/ui/z_textfield/z_textfield.dart';

class ProductsPageProps {
  ProductsPageProps({
    this.selectable = false,
    this.onAddProductItem,
    this.onUpdateProductItem,
    this.onRemoveProductItem,
  });
  final bool selectable;
  void Function(WriteOffItem) onAddProductItem;
  void Function(WriteOffItem) onUpdateProductItem;
  void Function(WriteOffItem) onRemoveProductItem;
}

class ProductsPage extends StatefulWidget {
  ProductsPage({this.props});
  final ProductsPageProps props;
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  TextEditingController _filterController;

  final _productsStream =
      StreamProvider.autoDispose((ref) => ProductsProvider().productsStream);
  final _productsProvider = Provider((ref) => ProductsProvider());

  @override
  void initState() {
    _filterController = TextEditingController(text: '');
    super.initState();
    _filterController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  void _scan() async {
    final String barcode = await FlutterBarcodeScanner.scanBarcode(
      '#ffffff',
      'Отмена',
      false,
      ScanMode.BARCODE,
    );
    if (barcode != '-1') {
      _filterController.text = barcode;
      _filterController.selection = TextSelection.fromPosition(
        TextPosition(offset: _filterController.text.length),
      );
    } else {
      _filterController.text = '';
    }
  }

  void _onTapHandler(ProductItem product) {
    if (widget.props.selectable) {
      Navigator.of(context).pushReplacementNamed(
        '/select-quantity-item',
        arguments: SelectWriteOffItemQuantityProps(
          item: WriteOffItem(product: product, quanity: 1),
        ),
      );
    } else {
      Navigator.of(context).pushNamed(
        '/product',
        arguments: product,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final productsStream = watch(_productsStream.stream);
        final productsProvider = watch(_productsProvider);
        return Scaffold(
          drawer: ZDrawer(),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Продукты',
              style: TextStyle(color: Colors.black),
            ),
          ),
          floatingActionButton: SizedBox(
            height: 80,
            width: 80,
            child: FloatingActionButton(
              backgroundColor: ZColors.redLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(
                  width: 2.0,
                  color: Colors.black,
                ),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/product'),
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
          body: StreamBuilder<List<ProductItem>>(
              stream: productsStream,
              initialData: [],
              builder: (context, snapshot) {
                final products = productsProvider.filteredProducts(
                    snapshot.data, _filterController.text);
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: ZTextField(
                              controller: _filterController,
                              suffixIcon: Icons.search,
                              withShadows: true,
                            ),
                          ),
                          SizedBox(width: 12.0),
                          ZButton(
                            onPressed: _scan,
                            //TODO: 3232
                            icon: Icons.qr_code_scanner_outlined,
                            value: '',
                          )
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Expanded(
                        child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductTile(
                              product: products[index],
                              onTap: () => _onTapHandler(snapshot.data[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}
