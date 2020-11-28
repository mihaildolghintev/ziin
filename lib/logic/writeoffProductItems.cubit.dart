import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziin/models/writeoff_item.model.dart';

class WriteOffProductItemsCubit extends Cubit<List<WriteOffItem>> {
  WriteOffProductItemsCubit() : super([]);

  void addItemToProductList(WriteOffItem item) {
    final index = state.indexWhere((i) => i.product.id == item.product.id);
    if (index == -1) {
      emit([...state, item]);
    } else {
      final copyItem = WriteOffItem(
        product: item.product,
        quanity: state[index].quanity + item.quanity,
      );
      emit([
        ...state.sublist(0, index),
        copyItem,
        ...state.sublist(index + 1),
      ]);
    }
  }

  void updateItemInProductList(WriteOffItem item) {
    final index = state.indexWhere(
      (itemInList) => item.product.id == itemInList.product.id,
    );

    emit([...state.sublist(0, index), item, ...state.sublist(index + 1)]);
  }

  void removeItemFromProductList(WriteOffItem item) {
    emit(state
        .where((itemInList) => item.product.id != itemInList.product.id)
        .toList());
  }
}
