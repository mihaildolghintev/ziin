import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ziin/models/writeoff_item.model.dart';

class WriteOffProductItems extends StateNotifier<List<WriteOffItem>> {
  WriteOffProductItems() : super([]);

  void setProducts(List<WriteOffItem> items) {
    state = [...items];
  }

  void addItemToProductList(WriteOffItem item) {
    final index = state.indexWhere((i) => i.product.id == item.product.id);
    if (index == -1) {
      state = [...state, item];
    } else {
      final copyItem = WriteOffItem(
        product: item.product,
        quanity: state[index].quanity + item.quanity,
      );
      state = [
        ...state.sublist(0, index),
        copyItem,
        ...state.sublist(index + 1),
      ];
    }
  }

  void updateItemInProductList(WriteOffItem item) {
    final index = state.indexWhere(
      (itemInList) => item.product.id == itemInList.product.id,
    );

    state = [
      ...state.sublist(0, index),
      item,
      ...state.sublist(index + 1),
    ];
  }

  void removeItemFromProductList(WriteOffItem item) {
    state = state
        .where((itemInList) => item.product.id != itemInList.product.id)
        .toList();
  }
}

final writeoffProductItemsProvider = StateNotifierProvider.autoDispose(
    (ref) => WriteOffProductItems());
