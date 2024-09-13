import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/use_cases/add_collection_item.dart';
import 'package:ludoteca/1_domain/use_cases/get_bgg_item.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

part 'collection_add_item_cubit_state.dart';

class CollectionAddItemCubit extends Cubit<CollectionAddItemCubitState> {
  final GetBggItem getBggItem;
  final AddCollectionItem addItem;
  CollectionAddItemCubit({required this.getBggItem, required this.addItem})
      : super(const CollectionAddItemEmptyState());

  void readItemDetail(String itemId) async {
    emit(const CollectionAddItemLoadingState());

    final item = await getBggItem(GetBggItemParams(itemId: itemId));

    if (item.isLeft) {
      emit(const CollectionAddItemErrorState());
    } else {
      emit(CollectionAddItemLoadedState(item: item.right));
    }
  }

  void addCollectionItem(Item item) async {
    emit(const CollectionAddItemLoadingState());

    final addedItem = await addItem(AddItemParams(item: item));

    if (addedItem.isLeft) {
      emit(const CollectionAddItemErrorState());
    } else {
      emit(CollectionAddItemAddedState(item: item));
    }
  }
}
