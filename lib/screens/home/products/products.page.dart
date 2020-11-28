import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:ziin/logic/products.dart';
import 'package:ziin/models/product_item.model.dart';
import 'package:ziin/models/writeoff_item.model.dart';
import 'package:ziin/screens/home/products/product.tile.dart';
import 'package:ziin/screens/home/writeoffs/writeoff_item_quantity.dart';
import 'package:ziin/ui/z_button/z_button.dart';
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

  @override
  void initState() {
    final ProductsProvider goodsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    super.initState();
    _filterController = TextEditingController(text: goodsProvider.filterValue);
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  void _scan() async {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final String barcode = await FlutterBarcodeScanner.scanBarcode(
      '#ffffff',
      'Отмена',
      false,
      ScanMode.BARCODE,
    );
    if (barcode != '-1') {
      productsProvider.setFilter(barcode);
      _filterController.text = barcode;
      _filterController.selection = TextSelection.fromPosition(
        TextPosition(offset: _filterController.text.length),
      );
    } else {
      productsProvider.setFilter('');
      _filterController.text = '';
    }

    setState(() {});
  }

  void _onTapHandler(ProductItem product) {
    if (widget.props.selectable) {
      Navigator.of(context).pushReplacementNamed(
        '/select-quantity-item',
        arguments: SelectWriteOffItemQuantityProps(
          item: WriteOffItem(product: product, quanity: 1),
          onAddProductItem: widget.props.onAddProductItem,
          onUpdateProductItem: widget.props.onUpdateProductItem,
          onRemoveProductItem: widget.props.onRemoveProductItem,
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
    final productsProvider = Provider.of<ProductsProvider>(context);

    return StreamBuilder<List<ProductItem>>(
        stream: productsProvider.filteredProducts,
        initialData: [],
        builder: (context, snapshot) {
          final products = snapshot.data;
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
                        onChanged: (value) {
                          productsProvider.setFilter(value);
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: 12.0),
                    ZButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/product'),
                      value: '+',
                    )
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                ZButton(
                  onPressed: _scan,
                  value: 'Сканировать',
                ),
                SizedBox(height: 12.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductTile(
                        product: products[index],
                        onTap: () => _onTapHandler(products[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
