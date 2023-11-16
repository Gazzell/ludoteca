import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/use_cases/get_collection_item_ids.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

part 'collection_list_cubit_state.dart';

class CollectionListCubit extends Cubit<CollectionListCubitState> {
  final GetCollectionItemIds getCollectionItemIds;

  CollectionListCubit({
    required this.getCollectionItemIds,
    CollectionListCubitState? initialState,
  }) : super(initialState ?? const CollectionListLoadingState());

  Future<void> readItemIds() async {
    final itemIds = await getCollectionItemIds(NoParams());

    if (itemIds.isLeft) {
      emit(const CollectionListErrorState());
    } else {
      emit(CollectionListItemIdsLoadedState(itemIds: itemIds.right));
    }
  }
}
