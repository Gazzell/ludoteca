import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/1_domain/entities/item.dart';
import 'package:ludoteca/1_domain/entities/item_instance.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';
import 'package:ludoteca/1_domain/use_cases/get_item.dart';
import 'package:ludoteca/1_domain/use_cases/get_item_instances.dart';
import 'package:ludoteca/1_domain/use_cases/use_case.dart';

part 'collection_item_detail_cubit_state.dart';

class CollectionItemDetailCubit extends Cubit<CollectionItemDetailCubitState> {
  final GetItem getItem;
  final GetItemInstances getItemInstances;
  CollectionItemDetailCubit({
    required this.getItem,
    required this.getItemInstances,
  }) : super(const CollectionItemDetailEmptyState());

  void readItemDetail(ItemId? itemId) async {
    if (itemId == null) {
      emit(const CollectionItemDetailEmptyState());
      return;
    }

    emit(const CollectionItemDetailLoadingState());

    final item = await getItem(ItemParams(itemId: itemId));

    if (item.isLeft) {
      emit(const CollectionItemDetailErrorState());
    } else {
      final itemInstances = await getItemInstances(
          GetItemInstancesParams(itemInstanceIds: item.right.instances));
      if (itemInstances.isLeft) {
        emit(const CollectionItemDetailErrorState());
        return;
      }

      emit(CollectionItemDetailLoadedState(item: item.right, itemInstances: itemInstances.right));
    }
  }
}
