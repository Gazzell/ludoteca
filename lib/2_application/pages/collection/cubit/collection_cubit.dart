import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/use_cases/get_collection_item_ids.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

part 'collection_cubit_state.dart';

class CollectionCubit extends Cubit<CollectionCubitState> {
  final GetCollectionItemIds getCollectionItemIds;

  CollectionCubit({
    required this.getCollectionItemIds,
    CollectionCubitState? initialState,
  }) : super(initialState ?? const CollectionInitialState());

  Future<void> readItemIds() async {
    emit(const CollectionLoadingState());
    
    final itemIds = await getCollectionItemIds(NoParams());

    if (itemIds.isLeft) {
      emit(const CollectionErrorState());
    } else {
      emit(CollectionItemIdsLoadedState(itemIds: itemIds.right));
    }
  }
}
