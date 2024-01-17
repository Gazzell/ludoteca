import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'collection_cubit_state.dart';

class CollectionCubit extends Cubit<CollectionCubitState> {
  CollectionCubit()
      : super(const CollectionShowingState());

  void setAddingItem() {
    emit(const CollectionItemAddingState());
  }

  void setShowingState() {
    if(state is! CollectionShowingState) {
      emit(const CollectionShowingState());
    }
  }
}
