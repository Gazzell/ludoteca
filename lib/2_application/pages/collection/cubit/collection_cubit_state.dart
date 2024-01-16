part of 'collection_cubit.dart';

sealed class CollectionCubitState extends Equatable {
  const CollectionCubitState();

  @override
  List<Object?> get props => [];
}

final class CollectionShowingState extends CollectionCubitState {
  const CollectionShowingState();
}

final class CollectionItemAddingState extends CollectionCubitState {
  const CollectionItemAddingState();
}
