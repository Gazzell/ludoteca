import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludoteca/1_domain/entities/unique_id.dart';

part 'collection_cubit_state.dart';

class CollectionCubit extends Cubit<CollectionCubitState> {
  CollectionCubit()
      : super(const CollectionItemSelectedState(selectedItem: null));

  void selectItem(ItemId? selectedItem) {
    emit(CollectionItemSelectedState(selectedItem: selectedItem));
  }
}
