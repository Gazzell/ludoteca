import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/use_cases/get_full_item.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

part 'collection_item_detail_cubit_state.dart';

class CollectionItemDetailCubit extends Cubit<CollectionItemDetailCubitState> {
  final GetFullItem getItemDetail;
  CollectionItemDetailCubit({required this.getItemDetail})
      : super(const CollectionItemDetailLoadingState());

  Future<void> readItemDetail(ItemId itemId) async {
    final itemDetail = await getItemDetail(ItemParams(itemId: itemId));
    if (itemDetail.isLeft) {
      emit(const CollectionItemDetailErrorState());
    } else {
      emit(CollectionItemDetailLoadedState(itemDetail: itemDetail.right));
    }
  }
}
