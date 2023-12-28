import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/use_cases/get_full_item.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

part 'collection_add_item_cubit_state.dart';

class CollectionAddItemCubit extends Cubit<CollectionAddItemCubitState> {
  final GetFullItem getItemDetail;
  CollectionAddItemCubit({required this.getItemDetail})
      : super(const CollectionAddItemEmptyState());

  Future<void> readItemDetail(ItemId itemId) async {
    emit(const CollectionAddItemLoadingState());
    
    final itemDetail = await getItemDetail(ItemParams(itemId: itemId));
    
    if (itemDetail.isLeft) {
      emit(const CollectionAddItemErrorState());
    } else {
      emit(CollectionAddItemLoadedState(itemDetail: itemDetail.right));
    }
  }
}
