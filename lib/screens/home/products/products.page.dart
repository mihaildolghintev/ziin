import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziin/logic/products.dart';
import 'package:ziin/models/product_item.model.dart';
import 'package:ziin/models/writeoff_item.model.dart';
import 'package:ziin/screens/home/products/product.tile.dart';
import 'package:ziin/ui/z_button/z_button.dart';
import 'package:ziin/ui/z_textfield/z_textfield.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({this.selectable = false});
  final bool selectable;
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

  void _scan() {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.setFilter('123456');
    _filterController.text = '123456';
    _filterController.selection = TextSelection.fromPosition(
      TextPosition(offset: _filterController.text.length),
    );
    // _filterController.text = '32323';

    setState(() {});
  }

  void _onTapHandler(ProductItem product) {
    if (widget.selectable) {
      Navigator.of(context).pushReplacementNamed('/select-quantity-item',
          arguments: WriteOffItem(product: product, quanity: 1));
    } else {
      Navigator.of(context).pushNamed('/product', arguments: product);
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
