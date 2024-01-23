import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../1_domain/entities/item.dart';

part 'collection_cubit_state.dart';

class CollectionCubit extends Cubit<CollectionCubitState> {
  CollectionCubit() : super(const CollectionShowingState());

  void setAddingItem() {
    emit(const CollectionItemAddingState());
  }

  void setShowingState() {
    if (state is! CollectionShowingState) {
      emit(const CollectionShowingState());
    }
  }

  void itemAdded(Item item) {
    emit(CollectionItemAddedState(item: item));
  }
}
