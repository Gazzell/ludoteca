import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/use_cases/get_collection_items.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

part 'collection_list_cubit_state.dart';

class CollectionListCubit extends Cubit<CollectionListCubitState> {
  final GetCollectionItems getCollectionItems;

  CollectionListCubit({
    required this.getCollectionItems,
    CollectionListCubitState? initialState,
  }) : super(initialState ?? const CollectionListLoadingState());

  void readItems() async {
    final items = await getCollectionItems(NoParams());

    if (items.isLeft) {
      emit(const CollectionListErrorState());
    } else {
      emit(CollectionListItemsLoadedState(items: items.right));
    }
  }

  void updateCollection(List<Item> items) {
    emit(CollectionListItemsLoadedState(items: items));
  }
}
